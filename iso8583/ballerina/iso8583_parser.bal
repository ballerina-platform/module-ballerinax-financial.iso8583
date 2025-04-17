//  Copyright (c) 2024-2025 WSO2 LLC. (https://www.wso2.com).

//  WSO2 LLC. licenses this file to you under the Apache License,
//  Version 2.0 (the "License"); you may not use this file except
//  in compliance with the License.
//  You may obtain a copy of the License at

//  http://www.apache.org/licenses/LICENSE-2.0

//  Unless required by applicable law or agreed to in writing,
//  software distributed under the License is distributed on an
//  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
//  KIND, either express or implied.  See the License for the
//  specific language governing permissions and limitations
//  under the License.

import financial.iso8583.io.ballerinax.iso8583;

import ballerina/data.jsondata;
import ballerina/lang.array;
import ballerina/log;

# Parse ISO 8583 message string and transform to a ISO 8583 record.
#
# + isoMessage - ISO 8583 message
# + return - ISO 8583 record as anydata
public isolated function parse(string isoMessage) returns anydata|ISOError {

    string|iso8583:ISO8583Exception iso8583unpackedMsg = iso8583:ISO8583ParserUtil_unpackISOMessage(isoMessage);

    if iso8583unpackedMsg is string {
        json|error isoJsonMsg = iso8583unpackedMsg.fromJsonString();
        if isoJsonMsg is error {
            return createISOError("Error while converting to json. Caused by: " + isoJsonMsg.message());
        } else {
            anydata|jsondata:Error isoRecord = jsondata:parseAsType(isoJsonMsg);
            if (isoRecord is jsondata:Error) {
                return createISOError("Error while parsing record. Caused by: " + isoRecord.message());
            } else {
                return isoRecord;
            }
        }
    } else {
        return createISOError(iso8583unpackedMsg.message());
    }
}

# Generate ISO 8583 string from json record.
#
# + isoRecord - parameter description
# + return - ISO 8583 message string
public isolated function encode(json isoRecord) returns string|ISOError {

    string|iso8583:ISO8583Exception iso8583String = iso8583:ISO8583ParserUtil_encode(isoRecord.toString());
    if iso8583String is string {
        return iso8583String;
    } else {
        return createISOError("Error while generating ISO message. Caused by: " + iso8583String.message());
    }
}

# Initialize the ISO 8583 parser with the configuration files.
#
# + packagerFilePath - ISO 8583 jpos packager xml file path
# + elementNameFilePath - ISO 8583 data element name csv file path
# + return - error if initialization fails
public function initialize(string packagerFilePath, string elementNameFilePath) returns error? {
    _ = check iso8583:ISO8583ParserUtil_initializeParser(packagerFilePath, elementNameFilePath);
}

# Generate hex encoded bytes for the ISO 8583 message string.
# This function adds the header, MTI, and the bitmaps to the message and produce the encoded byte stream.
#
# + payload - message payload
# + customHeader - custom header to prepend additional metadata (e.g., channel ID, version, etc.) before the MTI
# + addLengthHeader - boolean to indicate whether to add a length header
# + lengthHeaderSize - payload size header length (default is 4 bytes)
# + isLengthHeaderASCII - boolean to indicate whether the length header is ASCII characters (default is false). 
# (e.g. in ASCII characters "0128" means 128 bytes and in binary "0x00 0x80" means 128 bytes)
# + return - hex encoded byte array of the ISO8583 message
public function generateByteStream(string payload, string customHeader = "", boolean addLengthHeader = true,
        int lengthHeaderSize = 4, boolean isLengthHeaderASCII = false) returns byte[]|ISOError {

    byte[] mti = payload.substring(0, 4).toBytes();
    int|error bitmapCount = countBitmapsFromHexString(payload.substring(4));
    if bitmapCount is error {
        return createISOError("Error while counting bitmaps: " + bitmapCount.message());
    }
    log:printDebug(string `[ISO8583] Bitmap count calculated`, bitmapCount = bitmapCount);
    byte[] payloadBytes = payload.substring(4 + 16 * bitmapCount).toBytes();
    byte[]|error bitmaps = array:fromBase16(payload.substring(4, 4 + 16 * bitmapCount));
    if bitmaps is error {
        return createISOError("Error while converting bitmaps to byte array: " + bitmaps.message());
    }
    byte[] customHeaderBytes = customHeader.toBytes();
    byte[]|error payloadSizeHeaderBytes = [];
    if addLengthHeader {
        int payloadSize = mti.length() + bitmaps.length() + payloadBytes.length() + customHeaderBytes.length();
        log:printDebug(string `[ISO8583] Payload size calculated`, payloadSize = payloadSize);

        if isLengthHeaderASCII {
            // Payload size is represented in ASCII characters
            string payloadSizeString = payloadSize.toString().padStart(lengthHeaderSize, "0");
            payloadSizeHeaderBytes = payloadSizeString.toBytes();
        } else {
            // 2 digits represent 1 byte. So, multiply lengthHeaderSize by 2 to get the byte size.
            string payloadSizeString = payloadSize.toHexString().padZero(lengthHeaderSize * 2);
            payloadSizeHeaderBytes = array:fromBase16(payloadSizeString);
        }
    }
    if payloadSizeHeaderBytes is error {
        return createISOError("Error while converting payload size to byte array: " + payloadSizeHeaderBytes.message());
    }
    log:printDebug(string `[ISO8583] Byte stream generation completed`, payloadSizeHeader = payloadSizeHeaderBytes,
            headerContent = customHeaderBytes, mti = mti, bitmaps = bitmaps, payload = payloadBytes);
    return [...payloadSizeHeaderBytes, ...customHeaderBytes, ...mti, ...bitmaps, ...payloadBytes];
}

# Decode the byte stream to extract the MTI, bitmaps, and data string.
#
# + data - byte array to be decoded  
# + mtiLength - number of bytes used to denote MTI (default is 4)  
# + lengthHeaderSize - payload size header length  (default is 4 bytes)
# + isLengthHeaderASCII - boolean to indicate whether the length header is ASCII characters (default is false).
# + customHeaderLength - custom header content length
# + return - decoded MTI, bitmaps, and data string
public function decodeByteStream(byte[] data, int mtiLength = 4, int lengthHeaderSize = 4,
        boolean isLengthHeaderASCII = false, int customHeaderLength = 0) returns [string, string, string]|ISOError {

    // Convert the received data to a string.
    string base16Result = array:toBase16(data);
    // Validate the length of the received data.
    string lengthHeader = base16Result.substring(0, lengthHeaderSize * 2);
    int|error payloadSize = 0;
    if lengthHeaderSize > 0 {
        if isLengthHeaderASCII {
            string|error lengthHeaderString = hexStringToString(lengthHeader);
            if lengthHeaderString is error {
                return createISOError("Error while converting length header to string. Caused by: " + lengthHeaderString.message());
            }
            payloadSize = int:fromString(lengthHeaderString);
        } else {
            payloadSize = int:fromHexString(lengthHeader);
        }
    }
    if payloadSize is error {
        return createISOError("Error while converting length header to int. Caused by: " + payloadSize.message());
    }
    if data.length() - lengthHeaderSize != payloadSize {
        return createISOError("Received data length does not match the expected length. Expected: " +
                payloadSize.toString() + ", Received: " + data.length().toString());
    }
    log:printDebug(string `[ISO8583] Received response from TCP server(base 16)`, response = base16Result);
    int nextIndex = lengthHeaderSize * 2 + customHeaderLength * 2;
    // convert all to the original hex representation. Even though this is a string,
    // it represents the actual hexa decimal encoded byte stream.
    // extract the message type identifier 
    string mtiMsg = base16Result.substring(nextIndex, nextIndex + mtiLength * 2);
    nextIndex = nextIndex + mtiLength * 2;
    // count the number of bitmaps. there can be multiple bitmaps. but the first bit of the bitmap indicates whether 
    // there is another bitmap.
    int|error bitmapCount = countBitmapsFromHexString(base16Result.substring(nextIndex));
    if bitmapCount is error {
        return createISOError("Error while counting bitmaps. Caused by: " + bitmapCount.message());
    }

    // a bitmap in the hex representation is represented in 16 chars.
    int bitmapLastIndex = nextIndex + 16 * bitmapCount;
    string bitmaps = base16Result.substring(nextIndex, bitmapLastIndex);
    string dataString = base16Result.substring(bitmapLastIndex);

    // parse ISO 8583 message
    string|error convertedMti = hexStringToString(mtiMsg.padZero(mtiLength));
    if convertedMti is error {
        return createISOError("Error while converting hex encoded MTI to string. Caused by: " + convertedMti.message());
    }
    string|error convertedDataString = hexStringToString(dataString);
    if convertedDataString is error {
        return createISOError("Error while converting hex encoded data string to string. Caused by: " +
                convertedDataString.message());
    }
    return [
        convertedMti,
        bitmaps,
        convertedDataString
    ];
}

# Converts an ISO 8583 JSON object/ballerina record into a hex-encoded byte stream (byte[]) for transmission.
#
# + isoRecord - ISO 8583 JSON object/ballerina record to be converted
# + customHeader - custom header to prepend additional metadata (e.g., channel ID, version, etc.) before the MTI
# + addLengthHeader - boolean to indicate whether to add a length header
# + lengthHeaderSize - payload size header length (default is 4 bytes)
# + isLengthHeaderASCII - boolean to indicate whether the length header is ASCII characters (default is false).
# + return - hex-encoded byte stream (byte[]) of the ISO 8583 message
public function toBytes(json isoRecord, string customHeader = "", boolean addLengthHeader = true,
        int lengthHeaderSize = 4, boolean isLengthHeaderASCII = false) returns byte[]|ISOError {

    string|ISOError encodedMsg = encode(isoRecord);
    if encodedMsg is string {
        log:printDebug(string `[ISO8583] Encoding completed`, encodedMsg = encodedMsg);
        return generateByteStream(encodedMsg, customHeader, addLengthHeader, lengthHeaderSize, isLengthHeaderASCII);
    }
    return encodedMsg;
}

# Convert an ISO 8583 byte stream to a JSON object/ballerina record.
#
# + data - byte array to be converted
# + mtiLength - number of bytes used to denote MTI (default is 4)
# + lengthHeaderSize - payload size header length (default is 4 bytes)
# + isLengthHeaderASCII - boolean to indicate whether the length header is ASCII characters (default is false).
# + customHeaderLength - custom header content length
# + return - JSON object/ballerina record of the ISO 8583 message
public function toJson(byte[] data, int mtiLength = 4, int lengthHeaderSize = 4, boolean isLengthHeaderASCII = false,
        int customHeaderLength = 0) returns anydata|ISOError {

    [string, string, string]|ISOError decodeByteStreamResult =
            decodeByteStream(data, mtiLength, lengthHeaderSize, isLengthHeaderASCII, customHeaderLength);
    if decodeByteStreamResult is string[] {
        log:printDebug(string `[ISO8583] Decoding completed`, decodeByteStreamContent = decodeByteStreamResult);
        string mti = decodeByteStreamResult[0].padZero(4);
        string bitmaps = decodeByteStreamResult[1];
        string payload = decodeByteStreamResult[2];
        string msgToParse = mti + bitmaps + payload;
        log:printDebug(string `[ISO8583] Parsing the iso 8583 message.`, Message = msgToParse);
        return parse(msgToParse);
    }
    return decodeByteStreamResult;
}

# Count the number of bitmaps in a hex string.
#
# + data - hex string to be parsed
# + return - number of bitmaps
function countBitmapsFromHexString(string data) returns int|error {
    // parse the first character of the bitmap to determine whether there are more bitmaps
    int count = 1;
    int idx = 0;
    int firstChar = check int:fromHexString(data.substring(idx, idx + 2));

    while (hasMoreBitmaps(firstChar)) {
        count += 1;
        idx += 16;
        firstChar = check int:fromHexString(data.substring(idx, idx + 2));
    }
    return count;
}

# Check if there are more bitmaps.
#
# + data - data to be checked
# + return - true if there are more bitmaps, false otherwise
function hasMoreBitmaps(int data) returns boolean {
    int mask = 1 << 7;
    int bitWiseAnd = data & mask;
    if (bitWiseAnd == 0) {
        return false;
    }
    return true;
}

# Convert a hex string to a string.
#
# + hexStr - hex string to be converted
# + return - string
function hexStringToString(string hexStr) returns string|error {
    byte[] byteArray = check array:fromBase16(hexStr);
    return check string:fromBytes(byteArray);
}

# Convert a string to a hex string.
#
# + str - string to be converted
# + return - hex string
function stringToHexString(string str) returns string|error {
    byte[] byteArray = str.toBytes();
    return array:toBase16(byteArray);
}

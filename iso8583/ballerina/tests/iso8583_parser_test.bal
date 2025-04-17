//  Copyright (c) 2025 WSO2 LLC. (https://www.wso2.com).

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

import ballerina/test;

string VALID_ISO8583_MTI0200_MESSAGE = "0200F23AC48108A08000000000000600000012200300006317310000000000001111082807133" +
    "2897953134210082808280828482901100060460004241124280421111509114665372D6538AC109mobileLKA05099144D000014411NTBCL" +
    "KLXXXX11NTBCLKLXXXX";
string ISO8583_MESSAGE_WITH_INCORRECT_BITMAP = "0200F13AC48108A080000000000006000000122003000063173100000000000011110" +
    "828071332897953134210082808280828482901100060460004241124280421111509114665372D6538AC109mobileLKA05099144D000014" +
    "411NTBCLKLXXXX11NTBCLKLXXXX";
MTI_020X mti200Msg = {
    MTI: "0200",
    SystemsTraceAuditNumber: "897953",
    CardAcceptorTerminalIdentification: "11115091",
    ProcessingCode: "310000",
    AmountTransaction: "000000001111",
    PrimaryAccountNumber: "200300006317",
    CardAcceptorNameLocation: "14665372D6538AC109mobileLKA05099144D0000",
    AcquiringInstitutionIdentificationCode: "046000",
    TimeLocalTransaction: "134210",
    DateLocalTransaction: "0828",
    DateAndTimeTransmission: "0828071332",
    RetrievalReferenceNumber: "424112428042",
    CurrencyCodeTransaction: "144",
    PointOfServiceConditionCode: "00",
    DateSettlement: "0828",
    DateCapture: "0828",
    PointOfServiceEntryMode: "011",
    AccountIdentification1: "NTBCLKLXXXX",
    AccountIdentification2: "NTBCLKLXXXX",
    MerchantType: "4829"
};

// custom header: iso8583:1987
byte[] BYTE_STREAM_WITH_CUSTOM_HEADER_AND_WITH_NON_ASCII_LENGTH = [
    0, 0, 0, 204, 105, 115, 111, 56, 53, 56, 51, 58, 49, 57, 56, 55, 48, 50, 48, 48, 242, 58, 196, 129, 8, 160, 128, 0, 
    0, 0, 0, 0, 6, 0, 0, 0, 49, 50, 50, 48, 48, 51, 48, 48, 48, 48, 54, 51, 49, 55, 51, 49, 48, 48, 48, 48, 48, 48, 48, 
    48, 48, 48, 48, 48, 49, 49, 49, 49, 48, 56, 50, 56, 48, 55, 49, 51, 51, 50, 56, 57, 55, 57, 53, 51, 49, 51, 52, 50, 
    49, 48, 48, 56, 50, 56, 48, 56, 50, 56, 48, 56, 50, 56, 52, 56, 50, 57, 48, 49, 49, 48, 48, 48, 54, 48, 52, 54, 48, 
    48, 48, 52, 50, 52, 49, 49, 50, 52, 50, 56, 48, 52, 50, 49, 49, 49, 49, 53, 48, 57, 49, 49, 52, 54, 54, 53, 51, 55, 
    50, 68, 54, 53, 51, 56, 65, 67, 49, 48, 57, 109, 111, 98, 105, 108, 101, 76, 75, 65, 48, 53, 48, 57, 57, 49, 52, 52, 
    68, 48, 48, 48, 48, 49, 52, 52, 49, 49, 78, 84, 66, 67, 76, 75, 76, 88, 88, 88, 88, 49, 49, 78, 84, 66, 67, 76, 75, 
    76, 88, 88, 88, 88
];

byte[] BYTE_STREAM_WITHOUT_CUSTOM_HEADER_AND_WITH_NON_ASCII_LENGTH = [
    0, 0, 0, 192, 48, 50, 48, 48, 242, 58, 196, 129, 8, 160, 128, 0, 0, 0, 0, 0, 6, 0, 0, 0, 49, 50, 50, 48, 48, 51, 48, 
    48, 48, 48, 54, 51, 49, 55, 51, 49, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 49, 49, 49, 49, 48, 56, 50, 56, 
    48, 55, 49, 51, 51, 50, 56, 57, 55, 57, 53, 51, 49, 51, 52, 50, 49, 48, 48, 56, 50, 56, 48, 56, 50, 56, 48, 56, 50, 
    56, 52, 56, 50, 57, 48, 49, 49, 48, 48, 48, 54, 48, 52, 54, 48, 48, 48, 52, 50, 52, 49, 49, 50, 52, 50, 56, 48, 52, 
    50, 49, 49, 49, 49, 53, 48, 57, 49, 49, 52, 54, 54, 53, 51, 55, 50, 68, 54, 53, 51, 56, 65, 67, 49, 48, 57, 109, 
    111, 98, 105, 108, 101, 76, 75, 65, 48, 53, 48, 57, 57, 49, 52, 52, 68, 48, 48, 48, 48, 49, 52, 52, 49, 49, 78, 84, 
    66, 67, 76, 75, 76, 88, 88, 88, 88, 49, 49, 78, 84, 66, 67, 76, 75, 76, 88, 88, 88, 88
];

byte[] BYTE_STREAM_WITHOUT_CUSTOM_HEADER_AND_WITH_NON_ASCII_LENGTH_WITH_MTI_LENGTH_3 = [
    0, 0, 0, 191, 50, 48, 48, 242, 58, 196, 129, 8, 160, 128, 0, 0, 0, 0, 0, 6, 0, 0, 0, 49, 50, 50, 48, 48, 51, 48, 48, 
    48, 48, 54, 51, 49, 55, 51, 49, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 49, 49, 49, 49, 48, 56, 50, 56, 48, 
    55, 49, 51, 51, 50, 56, 57, 55, 57, 53, 51, 49, 51, 52, 50, 49, 48, 48, 56, 50, 56, 48, 56, 50, 56, 48, 56, 50, 56, 
    52, 56, 50, 57, 48, 49, 49, 48, 48, 48, 54, 48, 52, 54, 48, 48, 48, 52, 50, 52, 49, 49, 50, 52, 50, 56, 48, 52, 50, 
    49, 49, 49, 49, 53, 48, 57, 49, 49, 52, 54, 54, 53, 51, 55, 50, 68, 54, 53, 51, 56, 65, 67, 49, 48, 57, 109, 111, 
    98, 105, 108, 101, 76, 75, 65, 48, 53, 48, 57, 57, 49, 52, 52, 68, 48, 48, 48, 48, 49, 52, 52, 49, 49, 78, 84, 66, 
    67, 76, 75, 76, 88, 88, 88, 88, 49, 49, 78, 84, 66, 67, 76, 75, 76, 88, 88, 88, 88
];

byte[] BYTE_STREAM_WITHOUT_CUSTOM_HEADER_AND_WITH_NON_ASCII_LENGTH_3 = [
    0, 0, 192, 48, 50, 48, 48, 242, 58, 196, 129, 8, 160, 128, 0, 0, 0, 0, 0, 6, 0, 0, 0, 49, 50, 50, 48, 48, 51, 48, 
    48, 48, 48, 54, 51, 49, 55, 51, 49, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 49, 49, 49, 49, 48, 56, 50, 56, 
    48, 55, 49, 51, 51, 50, 56, 57, 55, 57, 53, 51, 49, 51, 52, 50, 49, 48, 48, 56, 50, 56, 48, 56, 50, 56, 48, 56, 50, 
    56, 52, 56, 50, 57, 48, 49, 49, 48, 48, 48, 54, 48, 52, 54, 48, 48, 48, 52, 50, 52, 49, 49, 50, 52, 50, 56, 48, 52, 
    50, 49, 49, 49, 49, 53, 48, 57, 49, 49, 52, 54, 54, 53, 51, 55, 50, 68, 54, 53, 51, 56, 65, 67, 49, 48, 57, 109, 
    111, 98, 105, 108, 101, 76, 75, 65, 48, 53, 48, 57, 57, 49, 52, 52, 68, 48, 48, 48, 48, 49, 52, 52, 49, 49, 78, 
    84, 66, 67, 76, 75, 76, 88, 88, 88, 88, 49, 49, 78, 84, 66, 67, 76, 75, 76, 88, 88, 88, 88
];

byte[] BYTE_STREAM_WITHOUT_CUSTOM_HEADER_AND_WITH_ASCII_LENGTH = [
    48, 49, 57, 50, 48, 50, 48, 48, 242, 58, 196, 129, 8, 160, 128, 0, 0, 0, 0, 0, 6, 0, 0, 0, 49, 50, 50, 48, 48, 51, 
    48, 48, 48, 48, 54, 51, 49, 55, 51, 49, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 49, 49, 49, 49, 48, 56, 50, 
    56, 48, 55, 49, 51, 51, 50, 56, 57, 55, 57, 53, 51, 49, 51, 52, 50, 49, 48, 48, 56, 50, 56, 48, 56, 50, 56, 48, 56, 
    50, 56, 52, 56, 50, 57, 48, 49, 49, 48, 48, 48, 54, 48, 52, 54, 48, 48, 48, 52, 50, 52, 49, 49, 50, 52, 50, 56, 48, 
    52, 50, 49, 49, 49, 49, 53, 48, 57, 49, 49, 52, 54, 54, 53, 51, 55, 50, 68, 54, 53, 51, 56, 65, 67, 49, 48, 57, 109, 
    111, 98, 105, 108, 101, 76, 75, 65, 48, 53, 48, 57, 57, 49, 52, 52, 68, 48, 48, 48, 48, 49, 52, 52, 49, 49, 78, 84, 
    66, 67, 76, 75, 76, 88, 88, 88, 88, 49, 49, 78, 84, 66, 67, 76, 75, 76, 88, 88, 88, 88
];

byte[] BYTE_STREAM_WITHOUT_CUSTOM_HEADER_AND_WITH_ASCII_LENGTH_3 = [
    49, 57, 50, 48, 50, 48, 48, 242, 58, 196, 129, 8, 160, 128, 0, 0, 0, 0, 0, 6, 0, 0, 0, 49, 50, 50, 48, 48, 51, 48, 
    48, 48, 48, 54, 51, 49, 55, 51, 49, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 49, 49, 49, 49, 48, 56, 50, 56, 
    48, 55, 49, 51, 51, 50, 56, 57, 55, 57, 53, 51, 49, 51, 52, 50, 49, 48, 48, 56, 50, 56, 48, 56, 50, 56, 48, 56, 50, 
    56, 52, 56, 50, 57, 48, 49, 49, 48, 48, 48, 54, 48, 52, 54, 48, 48, 48, 52, 50, 52, 49, 49, 50, 52, 50, 56, 48, 52, 
    50, 49, 49, 49, 49, 53, 48, 57, 49, 49, 52, 54, 54, 53, 51, 55, 50, 68, 54, 53, 51, 56, 65, 67, 49, 48, 57, 109, 
    111, 98, 105, 108, 101, 76, 75, 65, 48, 53, 48, 57, 57, 49, 52, 52, 68, 48, 48, 48, 48, 49, 52, 52, 49, 49, 78, 84, 
    66, 67, 76, 75, 76, 88, 88, 88, 88, 49, 49, 78, 84, 66, 67, 76, 75, 76, 88, 88, 88, 88
];

byte[] BYTE_STREAM_WITHOUT_CUSTOM_HEADER_AND_WITHOUT_LENGTH_HEADER = [
    48, 50, 48, 48, 242, 58, 196, 129, 8, 160, 128, 0, 0, 0, 0, 0, 6, 0, 0, 0, 49, 50, 50, 48, 48, 51, 48, 48, 48, 48, 
    54, 51, 49, 55, 51, 49, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 49, 49, 49, 49, 48, 56, 50, 56, 48, 55, 49, 
    51, 51, 50, 56, 57, 55, 57, 53, 51, 49, 51, 52, 50, 49, 48, 48, 56, 50, 56, 48, 56, 50, 56, 48, 56, 50, 56, 52, 56, 
    50, 57, 48, 49, 49, 48, 48, 48, 54, 48, 52, 54, 48, 48, 48, 52, 50, 52, 49, 49, 50, 52, 50, 56, 48, 52, 50, 49, 49, 
    49, 49, 53, 48, 57, 49, 49, 52, 54, 54, 53, 51, 55, 50, 68, 54, 53, 51, 56, 65, 67, 49, 48, 57, 109, 111, 98, 105, 
    108, 101, 76, 75, 65, 48, 53, 48, 57, 57, 49, 52, 52, 68, 48, 48, 48, 48, 49, 52, 52, 49, 49, 78, 84, 66, 67, 76, 
    75, 76, 88, 88, 88, 88, 49, 49, 78, 84, 66, 67, 76, 75, 76, 88, 88, 88, 88
];

@test:Config {}
function testParseValidISO8583Message() {
    string validMessage = VALID_ISO8583_MTI0200_MESSAGE;
    anydata|ISOError result = parse(validMessage);

    if result is json {
        test:assertEquals(result.MTI, "0200", msg = "MTI mismatch");
    } else if result is ISOError {
        test:assertFail(msg = "Failed to parse valid ISO8583 message. " + result.message);
    }
}

@test:Config {}
function testParseInvalidISO8583Message() {
    string invalidMessage = ISO8583_MESSAGE_WITH_INCORRECT_BITMAP;
    anydata|ISOError result = parse(invalidMessage);

    if result is ISOError {
        test:assertTrue(result.message.startsWith("Error occurred while unpacking the ISO message."),
                msg = "Error message mismatch for invalid message");
    } else if result is ISOError {
        test:assertFail(msg = "Invalid message parsed successfully. " + result.message);
    }
}

@test:Config {}
function testEncodeValidISO8583Record() {
    string|ISOError result = encode(mti200Msg);

    if result is string {
        test:assertTrue(result.equalsIgnoreCaseAscii(VALID_ISO8583_MTI0200_MESSAGE), msg = "Message encoding mismatch");
    } else {
        test:assertFail(msg = "Failed to encode valid ISO8583 record. " + result.message);
    }
}

@test:Config {}
function testEncodeInvalidISO8583Record() {
    MTI_020X invalidMessage = mti200Msg.clone();
    invalidMessage.CurrencyCodeTransaction = "INVALID";
    anydata|ISOError result = encode(invalidMessage);

    if result is ISOError {
        test:assertTrue(result.message.includes("Couldn't pack ISO8583 Message. Caused by: error packing field 49"),
                msg = "Error message mismatch for invalid message encoding");
    } else if result is ISOError {
        test:assertFail(msg = "Invalid message parsed successfully. " + result.message);
    }
}

@test:Config {}
function testGenerateByteStreamWithCustomHeader() {
    byte[]|ISOError result = generateByteStream(VALID_ISO8583_MTI0200_MESSAGE, "iso8583:1987", true, 4, false);
    if result is byte[] {
        test:assertEquals(result, BYTE_STREAM_WITH_CUSTOM_HEADER_AND_WITH_NON_ASCII_LENGTH,
                msg = "Generated byte stream mismatched");
    } else {
        test:assertFail(msg = "Failed to generate byte stream. " + result.message);
    }
}

@test:Config {}
function testGenerateByteStreamWithoutCustomHeader() {
    byte[]|ISOError result = generateByteStream(VALID_ISO8583_MTI0200_MESSAGE, addLengthHeader = true,
            lengthHeaderSize = 4, isLengthHeaderASCII = false);
    if result is byte[] {

        test:assertEquals(result, BYTE_STREAM_WITHOUT_CUSTOM_HEADER_AND_WITH_NON_ASCII_LENGTH,
                msg = "Generated byte stream mismatched");
    } else {
        test:assertFail(msg = "Failed to generate byte stream. " + result.message);
    }
}

@test:Config {}
function testGenerateByteStreamWithAsciiLengthHeader() {
    byte[]|ISOError result = generateByteStream(VALID_ISO8583_MTI0200_MESSAGE, addLengthHeader = true,
            lengthHeaderSize = 4, isLengthHeaderASCII = true);
    if result is byte[] {

        test:assertEquals(result, BYTE_STREAM_WITHOUT_CUSTOM_HEADER_AND_WITH_ASCII_LENGTH,
                msg = "Generated byte stream mismatched");
    } else {
        test:assertFail(msg = "Failed to generate byte stream. " + result.message);
    }
}

@test:Config {}
function testGenerateByteStreamWithoutLengthHeader() {
    byte[]|ISOError result = generateByteStream(VALID_ISO8583_MTI0200_MESSAGE, addLengthHeader = false);
    if result is byte[] {

        test:assertEquals(result, BYTE_STREAM_WITHOUT_CUSTOM_HEADER_AND_WITHOUT_LENGTH_HEADER,
                msg = "Generated byte stream mismatched");
    } else {
        test:assertFail(msg = "Failed to generate byte stream. " + result.message);
    }
}

@test:Config {}
function testGenerateByteStreamWithCustomSizeLengthHeaderAscii() {
    byte[]|ISOError result = generateByteStream(VALID_ISO8583_MTI0200_MESSAGE, addLengthHeader = true,
            lengthHeaderSize = 3, isLengthHeaderASCII = true);
    if result is byte[] {

        test:assertEquals(result, BYTE_STREAM_WITHOUT_CUSTOM_HEADER_AND_WITH_ASCII_LENGTH_3,
                msg = "Generated byte stream mismatched");
    } else {
        test:assertFail(msg = "Failed to generate byte stream. " + result.message);
    }
}

@test:Config {}
function testGenerateByteStreamWithCustomSizeLengthHeaderBinary() {
    byte[]|ISOError result = generateByteStream(VALID_ISO8583_MTI0200_MESSAGE, addLengthHeader = true,
            lengthHeaderSize = 3);
    if result is byte[] {

        test:assertEquals(result, BYTE_STREAM_WITHOUT_CUSTOM_HEADER_AND_WITH_NON_ASCII_LENGTH_3,
                msg = "Generated byte stream mismatched");
    } else {
        test:assertFail(msg = "Failed to generate byte stream. " + result.message);
    }
}

@test:Config {}
function testDecodeByteStreamWithoutCustomHeader() {
    [string, string, string]|ISOError result =
        decodeByteStream(BYTE_STREAM_WITHOUT_CUSTOM_HEADER_AND_WITH_NON_ASCII_LENGTH);

    if result is [string, string, string] {
        test:assertEquals(result[0], "0200", msg = "MTI mismatch");
        test:assertEquals(result[1], "F23AC48108A080000000000006000000".toLowerAscii(), msg = "Bitmap mismatch");
        test:assertEquals(result[2], "122003000063173100000000000011110828071332897953134210082808280828482901100060" +
                "460004241124280421111509114665372D6538AC109mobileLKA05099144D000014411NTBCLKLXXXX11NTBCLKLXXXX",
                msg = "Payload mismatch");
    } else {
        test:assertFail(msg = "Failed to decode byte stream. " + result.message);
    }
}

@test:Config {}
function testDecodeByteStreamWithMTILength3() {
    [string, string, string]|ISOError result =
        decodeByteStream(BYTE_STREAM_WITHOUT_CUSTOM_HEADER_AND_WITH_NON_ASCII_LENGTH_WITH_MTI_LENGTH_3, mtiLength = 3);

    if result is [string, string, string] {
        test:assertEquals(result[0], "200", msg = "MTI mismatch");
        test:assertEquals(result[1], "F23AC48108A080000000000006000000".toLowerAscii(), msg = "Bitmap mismatch");
        test:assertEquals(result[2], "122003000063173100000000000011110828071332897953134210082808280828482901100060" +
                "460004241124280421111509114665372D6538AC109mobileLKA05099144D000014411NTBCLKLXXXX11NTBCLKLXXXX",
                msg = "Payload mismatch");
    } else {
        test:assertFail(msg = "Failed to decode byte stream. " + result.message);
    }
}

@test:Config {}
function testDecodeByteStreamWithHeaderSize3() {
    [string, string, string]|ISOError result =
        decodeByteStream(BYTE_STREAM_WITHOUT_CUSTOM_HEADER_AND_WITH_NON_ASCII_LENGTH_3, lengthHeaderSize = 3);

    if result is [string, string, string] {
        test:assertEquals(result[0], "0200", msg = "MTI mismatch");
        test:assertEquals(result[1], "F23AC48108A080000000000006000000".toLowerAscii(), msg = "Bitmap mismatch");
        test:assertEquals(result[2], "122003000063173100000000000011110828071332897953134210082808280828482901100060" +
                "460004241124280421111509114665372D6538AC109mobileLKA05099144D000014411NTBCLKLXXXX11NTBCLKLXXXX",
                msg = "Payload mismatch");
    } else {
        test:assertFail(msg = "Failed to decode byte stream. " + result.message);
    }
}

@test:Config {}
function testDecodeByteStreamWithAsciiHeaderLength() {
    [string, string, string]|ISOError result =
        decodeByteStream(BYTE_STREAM_WITHOUT_CUSTOM_HEADER_AND_WITH_ASCII_LENGTH, isLengthHeaderASCII = true);

    if result is [string, string, string] {
        test:assertEquals(result[0], "0200", msg = "MTI mismatch");
        test:assertEquals(result[1], "F23AC48108A080000000000006000000".toLowerAscii(), msg = "Bitmap mismatch");
        test:assertEquals(result[2], "122003000063173100000000000011110828071332897953134210082808280828482901100060" +
                "460004241124280421111509114665372D6538AC109mobileLKA05099144D000014411NTBCLKLXXXX11NTBCLKLXXXX",
                msg = "Payload mismatch");
    } else {
        test:assertFail(msg = "Failed to decode byte stream. " + result.message);
    }
}

@test:Config {}
function testDecodeByteStreamWithCustomHeader() {
    [string, string, string]|ISOError result =
        decodeByteStream(BYTE_STREAM_WITH_CUSTOM_HEADER_AND_WITH_NON_ASCII_LENGTH, customHeaderLength = 12);

    if result is [string, string, string] {
        test:assertEquals(result[0], "0200", msg = "MTI mismatch");
        test:assertEquals(result[1], "F23AC48108A080000000000006000000".toLowerAscii(), msg = "Bitmap mismatch");
        test:assertEquals(result[2], "122003000063173100000000000011110828071332897953134210082808280828482901100060" +
                "460004241124280421111509114665372D6538AC109mobileLKA05099144D000014411NTBCLKLXXXX11NTBCLKLXXXX",
                msg = "Payload mismatch");
    } else {
        test:assertFail(msg = "Failed to decode byte stream. " + result.message);
    }
}

@test:Config {}
function testToBytes() {
    byte[]|ISOError result = toBytes(mti200Msg);

    if result is byte[] {
        test:assertEquals(result, BYTE_STREAM_WITHOUT_CUSTOM_HEADER_AND_WITH_NON_ASCII_LENGTH,
                "Generated byte stream mismatched");
    } else {
        test:assertFail(msg = "Failed to convert record to bytes. " + result.message);
    }
}

@test:Config {}
function testToBytesWithCustomHeader() {
    byte[]|ISOError result = toBytes(mti200Msg, "iso8583:1987");

    if result is byte[] {
        test:assertEquals(result, BYTE_STREAM_WITH_CUSTOM_HEADER_AND_WITH_NON_ASCII_LENGTH,
                "Generated byte stream mismatched");
    } else {
        test:assertFail(msg = "Failed to convert record to bytes. " + result.message);
    }
}

@test:Config {}
function testToJson() {
    anydata|ISOError result = toJson(BYTE_STREAM_WITHOUT_CUSTOM_HEADER_AND_WITH_NON_ASCII_LENGTH);

    if result is json {
        test:assertEquals(result, mti200Msg, msg = "Generated JSON mismatched");
    } else if result is ISOError {
        test:assertFail(msg = "Failed to convert byte stream to JSON. " + result.message);
    }
}

@test:Config {}
function testToJsonWithCustomHeader() {
    anydata|ISOError result = toJson(BYTE_STREAM_WITH_CUSTOM_HEADER_AND_WITH_NON_ASCII_LENGTH, customHeaderLength = 12);

    if result is json {
        test:assertEquals(result, mti200Msg, msg = "Generated JSON mismatched");
    } else if result is ISOError {
        test:assertFail(msg = "Failed to convert byte stream to JSON. " + result.message);
    }
}

@test:Config {}
function testToJsonWithMTIlength3() {
    anydata|ISOError result = toJson(BYTE_STREAM_WITHOUT_CUSTOM_HEADER_AND_WITH_NON_ASCII_LENGTH_WITH_MTI_LENGTH_3,
            mtiLength = 3);

    if result is json {
        test:assertEquals(result, mti200Msg, msg = "Generated JSON mismatched");
    } else if result is ISOError {
        test:assertFail(msg = "Failed to convert byte stream to JSON. " + result.message);
    }
}

@test:Config {}
// MTI 0200
function testFinancialMsgDecoding() {
    // Simulator example. Length header size = 2
    byte[] data = [0, 229, 48, 50, 48, 48, 50, 60, 70, 209, 40, 224, 176, 0, 48, 49, 48, 48, 48, 48, 48, 48, 48, 48, 48, 
        48, 48, 48, 53, 48, 48, 48, 48, 52, 49, 48, 49, 53, 50, 57, 48, 52, 48, 48, 48, 49, 52, 54, 50, 53, 48, 52, 49, 
        48, 48, 52, 49, 48, 51, 48, 49, 50, 53, 57, 54, 49, 48, 50, 48, 48, 48, 48, 48, 48, 53, 51, 48, 48, 48, 48, 48, 
        48, 48, 48, 48, 49, 49, 50, 55, 54, 49, 48, 48, 48, 48, 48, 48, 49, 51, 52, 57, 56, 55, 54, 53, 48, 48, 48, 48, 
        48, 51, 48, 54, 48, 56, 52, 61, 51, 48, 49, 50, 49, 48, 49, 49, 49, 50, 51, 49, 50, 51, 48, 48, 48, 50, 57, 48, 
        53, 56, 53, 48, 48, 48, 48, 48, 48, 50, 48, 51, 57, 48, 48, 53, 57, 49, 49, 49, 49, 50, 48, 48, 48, 48, 48, 49, 
        50, 48, 48, 48, 99, 111, 110, 116, 97, 99, 116, 64, 110, 101, 97, 80, 97, 121, 46, 99, 111, 109, 92, 65, 108, 
        109, 101, 114, 101, 45, 65, 109, 115, 116, 101, 114, 100, 97, 109, 92, 78, 101, 116, 104, 53, 54, 54, 53, 54, 
        54, 70, 69, 69, 56, 67, 65, 54, 65, 54, 48, 52, 70, 48, 57, 70, 48];
    anydata|ISOError result = toJson(data, lengthHeaderSize = 2);
    json expectedJson = {"AmountTransactionFee": "000000000", "MTI": "0200", "SystemsTraceAuditNumber": "000146", 
        "DateLocalTransaction": "0410", "CardAcceptorTerminalIdentification": "20390059", "MerchantType": "5961", 
        "ProcessingCode": "010000", "CardAcceptorIdentificationCode": "111120000012000", 
        "CurrencyCodeCardholderBilling": "566", "DateExpiration": "3012", "CardSequenceNumber": "000", 
        "PersonalIdentificationNumberData": "FEE8CA6A604F09F0", "AmountTransaction": "000000005000", 
        "TimeLocalTransaction": "250410", "PointOfServiceEntryMode": "020", "Track2Data": 
        "9876500000306084=30121011123123000", "DateAndTimeTransmission": "0410152904", 
        "RetrievalReferenceNumber": "290585000000", 
        "CardAcceptorNameLocation": "contact@neaPay.com\\\\Almere-Amsterdam\\\\Neth", 
        "CurrencyCodeTransaction": "566", "PointOfServicePinCaptureCode": "53", 
        "AcquiringInstitutionIdentificationCode": "27610000001", "PointOfServiceConditionCode": "00"};
    if result is json {
        test:assertEquals(result, expectedJson, msg = "Generated JSON mismatched");
    } else if result is ISOError {
        test:assertFail(msg = "Failed to convert byte stream to JSON. " + result.message);
    }
}

@test:Config {}
// MTI 0210
function testFinancialMsgResponseencoding() {
    // Simulator example. Length header size = 2
    json data = {"AmountTransactionFee": "000000000", "MTI": "210", "SystemsTraceAuditNumber": "000146", 
        "DateLocalTransaction": "0410", "CardAcceptorTerminalIdentification": "20390059", "MerchantType": "5961", 
        "ProcessingCode": "010000", "CardAcceptorIdentificationCode": "111120000012000", 
        "CurrencyCodeCardholderBilling": "566", "DateExpiration": "3012", "CardSequenceNumber": "000", 
        "PersonalIdentificationNumberData": "FEE8CA6A604F09F0", "AmountTransaction": "000000005000", 
        "TimeLocalTransaction": "250410", "PointOfServiceEntryMode": "020", 
        "Track2Data": "9876500000306084=30121011123123000", "DateAndTimeTransmission": "0410152904", 
        "RetrievalReferenceNumber": "290585000000", 
        "CardAcceptorNameLocation": "contact@neaPay.com\\\\Almere-Amsterdam\\\\Neth", "CurrencyCodeTransaction": "566", 
        "PointOfServicePinCaptureCode": "53", "AcquiringInstitutionIdentificationCode": "27610000001", 
        "PointOfServiceConditionCode": "00", "ResponseCode": "00"};
    anydata|ISOError result = toBytes(data, lengthHeaderSize = 2);
    byte[] expectedBytes = [0, 231, 48, 50, 49, 48, 50, 60, 70, 209, 42, 224, 176, 0, 48, 49, 48, 48, 48, 48, 48, 48, 
        48, 48, 48, 48, 48, 48, 53, 48, 48, 48, 48, 52, 49, 48, 49, 53, 50, 57, 48, 52, 48, 48, 48, 49, 52, 54, 50, 53, 
        48, 52, 49, 48, 48, 52, 49, 48, 51, 48, 49, 50, 53, 57, 54, 49, 48, 50, 48, 48, 48, 48, 48, 48, 53, 51, 48, 48, 
        48, 48, 48, 48, 48, 48, 48, 49, 49, 50, 55, 54, 49, 48, 48, 48, 48, 48, 48, 49, 51, 52, 57, 56, 55, 54, 53, 48, 
        48, 48, 48, 48, 51, 48, 54, 48, 56, 52, 61, 51, 48, 49, 50, 49, 48, 49, 49, 49, 50, 51, 49, 50, 51, 48, 48, 48, 
        50, 57, 48, 53, 56, 53, 48, 48, 48, 48, 48, 48, 48, 48, 50, 48, 51, 57, 48, 48, 53, 57, 49, 49, 49, 49, 50, 48, 
        48, 48, 48, 48, 49, 50, 48, 48, 48, 99, 111, 110, 116, 97, 99, 116, 64, 110, 101, 97, 80, 97, 121, 46, 99, 111, 
        109, 65, 108, 109, 101, 114, 101, 45, 65, 109, 115, 116, 101, 114, 100, 97, 109, 78, 101, 116, 104, 32, 32, 53, 
        54, 54, 53, 54, 54, 70, 69, 69, 56, 67, 65, 54, 65, 54, 48, 52, 70, 48, 57, 70, 48];
    if result is json {
        test:assertEquals(result, expectedBytes, msg = "Generated bytes mismatched");
    } else if result is ISOError {
        test:assertFail(msg = "Failed to convert byte stream to JSON. " + result.message);
    }
}

@test:Config {}
// MTI 0800
function testNetworkMgtMsgDecoding() {
    // Simulator example. Length header size = 2
    byte[] data = [0, 63, 48, 56, 48, 48, 162, 56, 0, 0, 0, 128, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 48, 48, 48, 48, 48, 48, 
        48, 52, 49, 48, 49, 53, 51, 56, 52, 49, 48, 48, 48, 49, 52, 55, 50, 53, 48, 52, 49, 48, 48, 52, 49, 48, 50, 48, 
        51, 57, 48, 48, 53, 57, 48, 48, 48];
    anydata|ISOError result = toJson(data, lengthHeaderSize = 2);
    json expectedJson = {"MTI": "0800", "SystemsTraceAuditNumber": "000147", "DateLocalTransaction": "0410", 
        "CardAcceptorTerminalIdentification": "20390059", "TimeLocalTransaction": "250410", 
        "NetworkManagementInformationCode": "000", "DateAndTimeTransmission": "0410153841", "ProcessingCode": "000000"};
    if result is json {
        test:assertEquals(result, expectedJson, msg = "Generated JSON mismatched");
    } else if result is ISOError {
        test:assertFail(msg = "Failed to convert byte stream to JSON. " + result.message);
    }
}

@test:Config {}
// MTI 0810
function testNetworkMgtMsgResponseencoding() {
    // Simulator example. Length header size = 2
    json data = {"MTI": "810", "SystemsTraceAuditNumber": "000147", "DateLocalTransaction": "0410", 
        "CardAcceptorTerminalIdentification": "20390059", "TimeLocalTransaction": "250410", 
        "NetworkManagementInformationCode": "000", "DateAndTimeTransmission": "0410153841", "ProcessingCode": "000000", 
        "ResponseCode": "00"};
    anydata|ISOError result = toBytes(data, lengthHeaderSize = 2);
    byte[] expectedBytes = [0, 65, 48, 56, 49, 48, 162, 56, 0, 0, 2, 128, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 48, 48, 48, 48, 
        48, 48, 48, 52, 49, 48, 49, 53, 51, 56, 52, 49, 48, 48, 48, 49, 52, 55, 50, 53, 48, 52, 49, 48, 48, 52, 49, 48, 
        48, 48, 50, 48, 51, 57, 48, 48, 53, 57, 48, 48, 48];
    if result is json {
        test:assertEquals(result, expectedBytes, msg = "Generated bytes mismatched");
    } else if result is ISOError {
        test:assertFail(msg = "Failed to convert byte stream to JSON. " + result.message);
    }
}

@test:Config {}
// MTI 0100
function testAuthorizationMsgDecoding() {
    // Simulator example. Length header size = 2
    byte[] data = [0, 229, 48, 49, 48, 48, 50, 60, 70, 209, 40, 224, 176, 0, 48, 49, 48, 48, 48, 48, 48, 48, 48, 48, 48, 
        48, 48, 48, 53, 48, 48, 48, 48, 52, 49, 48, 49, 53, 52, 49, 49, 52, 48, 48, 48, 49, 52, 56, 50, 53, 48, 52, 49, 
        48, 48, 52, 49, 48, 51, 48, 49, 50, 53, 57, 54, 49, 48, 50, 48, 48, 48, 48, 48, 48, 53, 51, 48, 48, 48, 48, 48, 
        48, 48, 48, 48, 49, 49, 50, 55, 54, 49, 48, 48, 48, 48, 48, 48, 49, 51, 52, 57, 56, 55, 54, 53, 48, 48, 48, 48, 
        48, 51, 48, 54, 48, 56, 52, 61, 51, 48, 49, 50, 49, 48, 49, 49, 49, 50, 51, 49, 50, 51, 48, 48, 48, 52, 49, 49, 
        52, 56, 54, 48, 48, 48, 48, 48, 48, 50, 48, 51, 57, 48, 48, 53, 57, 49, 49, 49, 49, 50, 48, 48, 48, 48, 48, 49, 
        50, 48, 48, 48, 99, 111, 110, 116, 97, 99, 116, 64, 110, 101, 97, 80, 97, 121, 46, 99, 111, 109, 92, 65, 108, 
        109, 101, 114, 101, 45, 65, 109, 115, 116, 101, 114, 100, 97, 109, 92, 78, 101, 116, 104, 53, 54, 54, 53, 54,
        54, 70, 69, 69, 56, 67, 65, 54, 65, 54, 48, 52, 70, 48, 57, 70, 48];
    anydata|ISOError result = toJson(data, lengthHeaderSize = 2);
    json expectedJson = {"AmountTransactionFee": "000000000", "MTI": "0100", "SystemsTraceAuditNumber": "000148", 
        "DateLocalTransaction": "0410", "CardAcceptorTerminalIdentification": "20390059", "MerchantType": "5961", 
        "ProcessingCode": "010000", "CardAcceptorIdentificationCode": "111120000012000", 
        "CurrencyCodeCardholderBilling": "566", "DateExpiration": "3012", "CardSequenceNumber": "000", 
        "PersonalIdentificationNumberData": "FEE8CA6A604F09F0", "AmountTransaction": "000000005000", 
        "TimeLocalTransaction": "250410", "PointOfServiceEntryMode": "020", 
        "Track2Data": "9876500000306084=30121011123123000", "DateAndTimeTransmission": "0410154114", 
        "RetrievalReferenceNumber": "411486000000", 
        "CardAcceptorNameLocation": "contact@neaPay.com\\\\Almere-Amsterdam\\\\Neth", "CurrencyCodeTransaction": "566", 
        "PointOfServicePinCaptureCode": "53", "AcquiringInstitutionIdentificationCode": "27610000001", 
        "PointOfServiceConditionCode": "00"};
    if result is json {
        test:assertEquals(result, expectedJson, msg = "Generated JSON mismatched");
    } else if result is ISOError {
        test:assertFail(msg = "Failed to convert byte stream to JSON. " + result.message);
    }
}

@test:Config {}
// MTI 0110
function testAuthorizationMsgResponseencoding() {
    // Simulator example. Length header size = 2
    json data = {"AmountTransactionFee": "000000000", "MTI": "110", "SystemsTraceAuditNumber": "000148", 
        "DateLocalTransaction": "0410", "CardAcceptorTerminalIdentification": "20390059", "MerchantType": "5961", 
        "ProcessingCode": "010000", "CardAcceptorIdentificationCode": "111120000012000", 
        "CurrencyCodeCardholderBilling": "566", "DateExpiration": "3012", "CardSequenceNumber": "000", 
        "PersonalIdentificationNumberData": "FEE8CA6A604F09F0", "AmountTransaction": "000000005000", 
        "TimeLocalTransaction": "250410", "PointOfServiceEntryMode": "020", 
        "Track2Data": "9876500000306084=30121011123123000", "DateAndTimeTransmission": "0410154114", 
        "RetrievalReferenceNumber": "411486000000", 
        "CardAcceptorNameLocation": "contact@neaPay.com\\\\Almere-Amsterdam\\\\Neth", "CurrencyCodeTransaction": "566",
        "PointOfServicePinCaptureCode": "53", "AcquiringInstitutionIdentificationCode": "27610000001", 
        "PointOfServiceConditionCode": "00", "ResponseCode": "00"};
    anydata|ISOError result = toBytes(data, lengthHeaderSize = 2);
    byte[] expectedBytes = [0, 231, 48, 49, 49, 48, 50, 60, 70, 209, 42, 224, 176, 0, 48, 49, 48, 48, 48, 48, 48, 48, 
        48, 48, 48, 48, 48, 48, 53, 48, 48, 48, 48, 52, 49, 48, 49, 53, 52, 49, 49, 52, 48, 48, 48, 49, 52, 56, 50, 53, 
        48, 52, 49, 48, 48, 52, 49, 48, 51, 48, 49, 50, 53, 57, 54, 49, 48, 50, 48, 48, 48, 48, 48, 48, 53, 51, 48, 48, 
        48, 48, 48, 48, 48, 48, 48, 49, 49, 50, 55, 54, 49, 48, 48, 48, 48, 48, 48, 49, 51, 52, 57, 56, 55, 54, 53, 48, 
        48, 48, 48, 48, 51, 48, 54, 48, 56, 52, 61, 51, 48, 49, 50, 49, 48, 49, 49, 49, 50, 51, 49, 50, 51, 48, 48, 48, 
        52, 49, 49, 52, 56, 54, 48, 48, 48, 48, 48, 48, 48, 48, 50, 48, 51, 57, 48, 48, 53, 57, 49, 49, 49, 49, 50, 48, 
        48, 48, 48, 48, 49, 50, 48, 48, 48, 99, 111, 110, 116, 97, 99, 116, 64, 110, 101, 97, 80, 97, 121, 46, 99, 111, 
        109, 65, 108, 109, 101, 114, 101, 45, 65, 109, 115, 116, 101, 114, 100, 97, 109, 78, 101, 116, 104, 32, 32, 53, 
        54, 54, 53, 54, 54, 70, 69, 69, 56, 67, 65, 54, 65, 54, 48, 52, 70, 48, 57, 70, 48];
    if result is json {
        test:assertEquals(result, expectedBytes, msg = "Generated bytes mismatched");
    } else if result is ISOError {
        test:assertFail(msg = "Failed to convert byte stream to JSON. " + result.message);
    }
}

@test:Config {}
// MTI 0420
function testReversalMsgDecoding() {
    // Simulator example. Length header size = 2
    byte[] data = [0, 242, 48, 52, 50, 48, 50, 60, 70, 209, 168, 224, 176, 0, 48, 49, 48, 48, 48, 48, 48, 48, 48, 48, 
        48, 48, 48, 48, 53, 48, 48, 48, 48, 52, 49, 48, 49, 53, 52, 54, 50, 48, 48, 48, 48, 49, 52, 57, 50, 53, 48, 52, 
        49, 48, 48, 52, 49, 48, 51, 48, 49, 50, 53, 57, 54, 49, 48, 50, 48, 48, 48, 48, 48, 48, 53, 51, 48, 48, 48, 48, 
        48, 48, 48, 48, 48, 49, 49, 50, 55, 54, 49, 48, 48, 48, 48, 48, 48, 49, 49, 49, 50, 55, 54, 49, 48, 48, 48, 48, 
        48, 48, 51, 51, 52, 57, 56, 55, 54, 53, 48, 48, 48, 48, 48, 51, 48, 54, 48, 56, 52, 61, 51, 48, 49, 50, 49, 48, 
        49, 49, 49, 50, 51, 49, 50, 51, 48, 48, 48, 52, 49, 49, 52, 56, 54, 48, 48, 48, 48, 48, 48, 50, 48, 51, 57, 48, 
        48, 53, 57, 49, 49, 49, 49, 50, 48, 48, 48, 48, 48, 49, 50, 48, 48, 48, 99, 111, 110, 116, 97, 99, 116, 64, 110, 
        101, 97, 80, 97, 121, 46, 99, 111, 109, 92, 65, 108, 109, 101, 114, 101, 45, 65, 109, 115, 116, 101, 114, 100, 
        97, 109, 92, 78, 101, 116, 104, 53, 54, 54, 53, 54, 54, 70, 69, 69, 56, 67, 65, 54, 65, 54, 48, 52, 70, 48, 57, 
        70, 48];
    anydata|ISOError result = toJson(data, lengthHeaderSize = 2);
    json expectedJson = {"AmountTransactionFee": "000000000", "MTI": "0420", "SystemsTraceAuditNumber": "000149", 
        "DateLocalTransaction": "0410", "CardAcceptorTerminalIdentification": "20390059", "MerchantType": "5961", 
        "ProcessingCode": "010000", "CardAcceptorIdentificationCode": "111120000012000", 
        "CurrencyCodeCardholderBilling": "566", "DateExpiration": "3012", "CardSequenceNumber": "000", 
        "PersonalIdentificationNumberData": "FEE8CA6A604F09F0", "AmountTransaction": "000000005000", 
        "TimeLocalTransaction": "250410", "PointOfServiceEntryMode": "020", 
        "Track2Data": "9876500000306084=30121011123123000", "DateAndTimeTransmission": "0410154620", 
        "RetrievalReferenceNumber": "411486000000", 
        "CardAcceptorNameLocation": "contact@neaPay.com\\\\Almere-Amsterdam\\\\Neth", "CurrencyCodeTransaction": "566", 
        "PointOfServicePinCaptureCode": "53", "AcquiringInstitutionIdentificationCode": "27610000001", 
        "ForwardingInstitutionIdentificationCode": "27610000003", "PointOfServiceConditionCode": "00"};
    if result is json {
        test:assertEquals(result, expectedJson, msg = "Generated JSON mismatched");
    } else if result is ISOError {
        test:assertFail(msg = "Failed to convert byte stream to JSON. " + result.message);
    }
}

@test:Config {}
// MTI 0430
function testReversalMsgResponseencoding() {
    // Simulator example. Length header size = 2
    json data = {"AmountTransactionFee": "000000000", "MTI": "430", "SystemsTraceAuditNumber": "000149", 
        "DateLocalTransaction": "0410", "CardAcceptorTerminalIdentification": "20390059", "MerchantType": "5961", 
        "ProcessingCode": "010000", "CardAcceptorIdentificationCode": "111120000012000", 
        "CurrencyCodeCardholderBilling": "566", "DateExpiration": "3012", "CardSequenceNumber": "000", 
        "PersonalIdentificationNumberData": "FEE8CA6A604F09F0", "AmountTransaction": "000000005000", 
        "TimeLocalTransaction": "250410", "PointOfServiceEntryMode": "020", 
        "Track2Data": "9876500000306084=30121011123123000", "DateAndTimeTransmission": "0410154620", 
        "RetrievalReferenceNumber": "411486000000", 
        "CardAcceptorNameLocation": "contact@neaPay.com\\\\Almere-Amsterdam\\\\Neth", 
        "CurrencyCodeTransaction": "566", "PointOfServicePinCaptureCode": "53", 
        "AcquiringInstitutionIdentificationCode": "27610000001", 
        "ForwardingInstitutionIdentificationCode": "27610000003", "PointOfServiceConditionCode": "00", 
        "ResponseCode": "00"};
    anydata|ISOError result = toBytes(data, lengthHeaderSize = 2);
    byte[] expectedBytes = [0, 244, 48, 52, 51, 48, 50, 60, 70, 209, 170, 224, 176, 0, 48, 49, 48, 48, 48, 48, 48, 48,
        48, 48, 48, 48, 48, 48, 53, 48, 48, 48, 48, 52, 49, 48, 49, 53, 52, 54, 50, 48, 48, 48, 48, 49, 52, 57, 50, 53, 
        48, 52, 49, 48, 48, 52, 49, 48, 51, 48, 49, 50, 53, 57, 54, 49, 48, 50, 48, 48, 48, 48, 48, 48, 53, 51, 48, 48, 
        48, 48, 48, 48, 48, 48, 48, 49, 49, 50, 55, 54, 49, 48, 48, 48, 48, 48, 48, 49, 49, 49, 50, 55, 54, 49, 48, 48, 
        48, 48, 48, 48, 51, 51, 52, 57, 56, 55, 54, 53, 48, 48, 48, 48, 48, 51, 48, 54, 48, 56, 52, 61, 51, 48, 49, 50, 
        49, 48, 49, 49, 49, 50, 51, 49, 50, 51, 48, 48, 48, 52, 49, 49, 52, 56, 54, 48, 48, 48, 48, 48, 48, 48, 48, 50, 
        48, 51, 57, 48, 48, 53, 57, 49, 49, 49, 49, 50, 48, 48, 48, 48, 48, 49, 50, 48, 48, 48, 99, 111, 110, 116, 97, 
        99, 116, 64, 110, 101, 97, 80, 97, 121, 46, 99, 111, 109, 65, 108, 109, 101, 114, 101, 45, 65, 109, 115, 116, 
        101, 114, 100, 97, 109, 78, 101, 116, 104, 32, 32, 53, 54, 54, 53, 54, 54, 70, 69, 69, 56, 67, 65, 54, 65, 54, 
        48, 52, 70, 48, 57, 70, 48];
    if result is json {
        test:assertEquals(result, expectedBytes, msg = "Generated bytes mismatched");
    } else if result is ISOError {
        test:assertFail(msg = "Failed to convert byte stream to JSON. " + result.message);
    }
}

@test:Config {}
// MTI 0300
function testFileUpdateMsgDecoding() {
    // Simulator example. Length header size = 2
    byte[] data = [0, 242, 48, 51, 48, 48, 50, 60, 70, 209, 168, 224, 176, 0, 48, 48, 49, 48, 48, 48, 48, 48, 48, 48, 
        48, 48, 48, 48, 49, 48, 48, 48, 48, 52, 49, 48, 49, 53, 53, 48, 53, 55, 48, 48, 48, 49, 54, 54, 50, 53, 48, 52, 
        49, 48, 48, 52, 49, 48, 51, 48, 49, 50, 53, 57, 54, 49, 48, 50, 48, 48, 48, 48, 48, 48, 53, 51, 48, 48, 48, 48, 
        48, 48, 48, 48, 48, 49, 49, 50, 55, 54, 49, 48, 48, 48, 48, 48, 48, 49, 49, 49, 50, 55, 54, 49, 48, 48, 48, 48, 
        48, 48, 51, 51, 52, 57, 56, 55, 54, 53, 48, 48, 48, 48, 48, 51, 48, 54, 48, 56, 52, 61, 51, 48, 49, 50, 49, 48, 
        49, 49, 49, 50, 51, 49, 50, 51, 48, 48, 48, 53, 48, 53, 55, 49, 48, 49, 48, 48, 48, 48, 48, 50, 48, 51, 57, 48, 
        48, 53, 57, 49, 49, 49, 49, 50, 48, 48, 48, 48, 48, 49, 50, 48, 48, 48, 99, 111, 110, 116, 97, 99, 116, 64, 110, 
        101, 97, 80, 97, 121, 46, 99, 111, 109, 92, 65, 108, 109, 101, 114, 101, 45, 65, 109, 115, 116, 101, 114, 100, 
        97, 109, 92, 78, 101, 116, 104, 53, 54, 54, 53, 54, 54, 70, 69, 69, 56, 67, 65, 54, 65, 54, 48, 52, 70, 48, 57, 
        70, 48];
    anydata|ISOError result = toJson(data, lengthHeaderSize = 2);
    json expectedJson = {"AmountTransactionFee": "000000000", "MTI": "0300", "SystemsTraceAuditNumber": "000166", 
        "DateLocalTransaction": "0410", "CardAcceptorTerminalIdentification": "20390059", "MerchantType": "5961", 
        "ProcessingCode": "001000", "CardAcceptorIdentificationCode": "111120000012000", 
        "CurrencyCodeCardholderBilling": "566", "DateExpiration": "3012", "CardSequenceNumber": "000", 
        "PersonalIdentificationNumberData": "FEE8CA6A604F09F0", "AmountTransaction": "000000001000", 
        "TimeLocalTransaction": "250410", "PointOfServiceEntryMode": "020", 
        "Track2Data": "9876500000306084=30121011123123000", "DateAndTimeTransmission": "0410155057", 
        "RetrievalReferenceNumber": "505710100000",
         "CardAcceptorNameLocation": "contact@neaPay.com\\\\Almere-Amsterdam\\\\Neth", "CurrencyCodeTransaction": "566", 
         "PointOfServicePinCaptureCode": "53", "AcquiringInstitutionIdentificationCode": "27610000001", 
         "ForwardingInstitutionIdentificationCode": "27610000003", "PointOfServiceConditionCode": "00"};
    if result is json {
        test:assertEquals(result, expectedJson, msg = "Generated JSON mismatched");
    } else if result is ISOError {
        test:assertFail(msg = "Failed to convert byte stream to JSON. " + result.message);
    }
}

@test:Config {}
// MTI 0310
function testFileUpdateMsgResponseencoding() {
    // Simulator example. Length header size = 2
    json data = {"AmountTransactionFee": "000000000", "MTI": "310", "SystemsTraceAuditNumber": "000166", 
        "DateLocalTransaction": "0410", "CardAcceptorTerminalIdentification": "20390059", "MerchantType": "5961", 
        "ProcessingCode": "001000", "CardAcceptorIdentificationCode": "111120000012000", 
        "CurrencyCodeCardholderBilling": "566", "DateExpiration": "3012", "CardSequenceNumber": "000", 
        "PersonalIdentificationNumberData": "FEE8CA6A604F09F0", "AmountTransaction": "000000001000", 
        "TimeLocalTransaction": "250410", "PointOfServiceEntryMode": "020", 
        "Track2Data": "9876500000306084=30121011123123000", "DateAndTimeTransmission": "0410155057", 
        "RetrievalReferenceNumber": "505710100000", 
        "CardAcceptorNameLocation": "contact@neaPay.com\\\\Almere-Amsterdam\\\\Neth", "CurrencyCodeTransaction": "566", 
        "PointOfServicePinCaptureCode": "53", "AcquiringInstitutionIdentificationCode": "27610000001", 
        "ForwardingInstitutionIdentificationCode": "27610000003", "PointOfServiceConditionCode": "00", 
        "ResponseCode": "00"};
    anydata|ISOError result = toBytes(data, lengthHeaderSize = 2);
    byte[] expectedBytes = [0, 244, 48, 51, 49, 48, 50, 60, 70, 209, 170, 224, 176, 0, 48, 48, 49, 48, 48, 48, 48, 48, 
        48, 48, 48, 48, 48, 48, 49, 48, 48, 48, 48, 52, 49, 48, 49, 53, 53, 48, 53, 55, 48, 48, 48, 49, 54, 54, 50, 53, 
        48, 52, 49, 48, 48, 52, 49, 48, 51, 48, 49, 50, 53, 57, 54, 49, 48, 50, 48, 48, 48, 48, 48, 48, 53, 51, 48, 48, 
        48, 48, 48, 48, 48, 48, 48, 49, 49, 50, 55, 54, 49, 48, 48, 48, 48, 48, 48, 49, 49, 49, 50, 55, 54, 49, 48, 48, 
        48, 48, 48, 48, 51, 51, 52, 57, 56, 55, 54, 53, 48, 48, 48, 48, 48, 51, 48, 54, 48, 56, 52, 61, 51, 48, 49, 50, 
        49, 48, 49, 49, 49, 50, 51, 49, 50, 51, 48, 48, 48, 53, 48, 53, 55, 49, 48, 49, 48, 48, 48, 48, 48, 48, 48, 50, 
        48, 51, 57, 48, 48, 53, 57, 49, 49, 49, 49, 50, 48, 48, 48, 48, 48, 49, 50, 48, 48, 48, 99, 111, 110, 116, 97, 
        99, 116, 64, 110, 101, 97, 80, 97, 121, 46, 99, 111, 109, 65, 108, 109, 101, 114, 101, 45, 65, 109, 115, 116, 
        101, 114, 100, 97, 109, 78, 101, 116, 104, 32, 32, 53, 54, 54, 53, 54, 54, 70, 69, 69, 56, 67, 65, 54, 65, 54, 
        48, 52, 70, 48, 57, 70, 48];
    if result is json {
        test:assertEquals(result, expectedBytes, msg = "Generated bytes mismatched");
    } else if result is ISOError {
        test:assertFail(msg = "Failed to convert byte stream to JSON. " + result.message);
    }
}

@test:Config {}
// MTI 0320
function testFileUpdateAdviceMsgDecoding() {
    // Simulator example. Length header size = 2
    byte[] data = [0, 242, 48, 51, 50, 48, 50, 60, 70, 209, 168, 224, 176, 0, 48, 48, 49, 48, 48, 48, 48, 48, 48, 48, 
        48, 48, 48, 48, 49, 48, 48, 48, 48, 52, 49, 48, 49, 53, 53, 54, 50, 55, 48, 48, 48, 49, 54, 57, 50, 53, 48, 52, 
        49, 48, 48, 52, 49, 48, 51, 48, 49, 50, 53, 57, 54, 49, 48, 50, 48, 48, 48, 48, 48, 48, 53, 51, 48, 48, 48, 48, 
        48, 48, 48, 48, 48, 49, 49, 50, 55, 54, 49, 48, 48, 48, 48, 48, 48, 49, 49, 49, 50, 55, 54, 49, 48, 48, 48, 48, 
        48, 48, 51, 51, 52, 57, 56, 55, 54, 53, 48, 48, 48, 48, 48, 51, 48, 54, 48, 56, 52, 61, 51, 48, 49, 50, 49, 48, 
        49, 49, 49, 50, 51, 49, 50, 51, 48, 48, 48, 53, 54, 50, 55, 49, 48, 52, 48, 48, 48, 48, 48, 50, 48, 51, 57, 48, 
        48, 53, 57, 49, 49, 49, 49, 50, 48, 48, 48, 48, 48, 49, 50, 48, 48, 48, 99, 111, 110, 116, 97, 99, 116, 64, 110, 
        101, 97, 80, 97, 121, 46, 99, 111, 109, 92, 65, 108, 109, 101, 114, 101, 45, 65, 109, 115, 116, 101, 114, 100, 
        97, 109, 92, 78, 101, 116, 104, 53, 54, 54, 53, 54, 54, 70, 69, 69, 56, 67, 65, 54, 65, 54, 48, 52, 70, 48, 57, 
        70, 48];
    anydata|ISOError result = toJson(data, lengthHeaderSize = 2);
    json expectedJson = {"AmountTransactionFee": "000000000", "MTI": "0320", "SystemsTraceAuditNumber": "000169", 
        "DateLocalTransaction": "0410", "CardAcceptorTerminalIdentification": "20390059", "MerchantType": "5961", 
        "ProcessingCode": "001000", "CardAcceptorIdentificationCode": "111120000012000", 
        "CurrencyCodeCardholderBilling": "566", "DateExpiration": "3012", "CardSequenceNumber": "000", 
        "PersonalIdentificationNumberData": "FEE8CA6A604F09F0", "AmountTransaction": "000000001000", 
        "TimeLocalTransaction": "250410", "PointOfServiceEntryMode": "020", 
        "Track2Data": "9876500000306084=30121011123123000", "DateAndTimeTransmission": "0410155627", 
        "RetrievalReferenceNumber": "562710400000", 
        "CardAcceptorNameLocation": "contact@neaPay.com\\\\Almere-Amsterdam\\\\Neth", 
        "CurrencyCodeTransaction": "566", "PointOfServicePinCaptureCode": "53", 
        "AcquiringInstitutionIdentificationCode": "27610000001", 
        "ForwardingInstitutionIdentificationCode": "27610000003", "PointOfServiceConditionCode": "00"};
    if result is json {
        test:assertEquals(result, expectedJson, msg = "Generated JSON mismatched");
    } else if result is ISOError {
        test:assertFail(msg = "Failed to convert byte stream to JSON. " + result.message);
    }
}

@test:Config {}
// MTI 0330
function testFileUpdateAdviceMsgResponseencoding() {
    // Simulator example. Length header size = 2
    json data = {"AmountTransactionFee": "000000000", "MTI": "330", "SystemsTraceAuditNumber": "000170", 
        "DateLocalTransaction": "0410", "CardAcceptorTerminalIdentification": "20390059", "MerchantType": "5961",
         "ProcessingCode": "001000", "CardAcceptorIdentificationCode": "111120000012000", 
         "CurrencyCodeCardholderBilling": "566", "DateExpiration": "3012", "CardSequenceNumber": "000", 
         "PersonalIdentificationNumberData": "FEE8CA6A604F09F0", "AmountTransaction": "000000001000", 
         "TimeLocalTransaction": "250410", "PointOfServiceEntryMode": "020", 
         "Track2Data": "9876500000306084=30121011123123000", "DateAndTimeTransmission": "0410160211", 
         "RetrievalReferenceNumber": "021110500000", 
         "CardAcceptorNameLocation": "contact@neaPay.com\\\\Almere-Amsterdam\\\\Neth", 
         "CurrencyCodeTransaction": "566", "PointOfServicePinCaptureCode": "53", 
         "AcquiringInstitutionIdentificationCode": "27610000001", 
         "ForwardingInstitutionIdentificationCode": "27610000003", "PointOfServiceConditionCode": "00", 
         "ResponseCode": "00"};
    anydata|ISOError result = toBytes(data, lengthHeaderSize = 2);
    byte[] expectedBytes = [0, 244, 48, 51, 51, 48, 50, 60, 70, 209, 170, 224, 176, 0, 48, 48, 49, 48, 48, 48, 48, 48, 
        48, 48, 48, 48, 48, 48, 49, 48, 48, 48, 48, 52, 49, 48, 49, 54, 48, 50, 49, 49, 48, 48, 48, 49, 55, 48, 50, 53, 
        48, 52, 49, 48, 48, 52, 49, 48, 51, 48, 49, 50, 53, 57, 54, 49, 48, 50, 48, 48, 48, 48, 48, 48, 53, 51, 48, 48, 
        48, 48, 48, 48, 48, 48, 48, 49, 49, 50, 55, 54, 49, 48, 48, 48, 48, 48, 48, 49, 49, 49, 50, 55, 54, 49, 48, 48, 
        48, 48, 48, 48, 51, 51, 52, 57, 56, 55, 54, 53, 48, 48, 48, 48, 48, 51, 48, 54, 48, 56, 52, 61, 51, 48, 49, 50, 
        49, 48, 49, 49, 49, 50, 51, 49, 50, 51, 48, 48, 48, 48, 50, 49, 49, 49, 48, 53, 48, 48, 48, 48, 48, 48, 48, 50, 
        48, 51, 57, 48, 48, 53, 57, 49, 49, 49, 49, 50, 48, 48, 48, 48, 48, 49, 50, 48, 48, 48, 99, 111, 110, 116, 97, 
        99, 116, 64, 110, 101, 97, 80, 97, 121, 46, 99, 111, 109, 65, 108, 109, 101, 114, 101, 45, 65, 109, 115, 116, 
        101, 114, 100, 97, 109, 78, 101, 116, 104, 32, 32, 53, 54, 54, 53, 54, 54, 70, 69, 69, 56, 67, 65, 54, 65, 54, 
        48, 52, 70, 48, 57, 70, 48];
    if result is json {
        test:assertEquals(result, expectedBytes, msg = "Generated bytes mismatched");
    } else if result is ISOError {
        test:assertFail(msg = "Failed to convert byte stream to JSON. " + result.message);
    }
}

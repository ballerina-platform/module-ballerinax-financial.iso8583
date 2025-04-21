# ISO 8583 Library

ISO 8583 is a standard for systems that exchange electronic transaction messages, commonly used in financial transaction processing such as ATM, POS, and payment gateway systems. It defines the message format and communication flow for request and response transactions, including fields like the Message Type Indicator (MTI), bitmaps, and data elements.

This library provides a lightweight and configurable implementation for working with ISO 8583 messages in Ballerina. It allows developers to parse raw ISO 8583 message strings into structured records, encode structured data into ISO 8583-compliant messages, and handle byte stream encoding/decoding for network communication. The library is highly extensible, supporting customizable message structures via external packager and element definition files. It also includes convenient utility functions for full message processing workflows.

## Usage

### Initialize the ISO 8583 Library with custom configurations (Optional)

The ISO 8583 library can be optionally initialized with custom configuration files to define the message structure and element formats. This is a one-time setup that should be done during application startup if you need to override the default behavior.

```
import ballerinax/financial.iso8583;

function init() returns error? {
    check iso8583:initialize("path/to/packager.xml", "path/to/element-definitions.csv");
}
```

packager.xml: Defines the structure, bitmap configuration, field types, and encoding.

element-definitions.csv: (Optional) Provides metadata and labels for the data elements.

If this step is not performed, the library will fall back to its default configuration:

- **Default packager()**: [jposdefv87.xml](https://github.com/ballerina-platform/module-ballerinax-financial.iso8583/blob/main/iso8583/native/src/main/resources/jposdefv87.xml)

- **Default element name IDs**: Defined in code at [ISO8583ParserUtil.java](https://github.com/ballerina-platform/module-ballerinax-financial.iso8583/blob/main/iso8583/native/src/main/java/io/ballerinax/iso8583/ISO8583ParserUtil.java#L195)

This default setup is compatible with the standard ISO 8583:1987 version.

### Parse an ISO 8583 Message String

The parse function takes a raw ISO 8583 string and transforms it into a structured JSON record based on the active configuration. The ISO 8583 message consists of three primary components: MTI (Message Type Indicator), bitmaps, and payload.

1. **MTI (Message Type Indicator)**: The first 4 characters of the message that define the type of transaction (e.g., 0200 for a financial request or 0210 for a financial response).

2. **Bitmaps**: The bitmap section follows the MTI and indicates which data fields are present in the message. Each bit in the bitmap corresponds to a specific data field (e.g., field 2, field 3, etc.).

3. **Payload**: The actual data fields, which are parsed based on the bitmap. The payload includes fields like account number, transaction amount, date, etc.

```
import ballerina/constraint;
import ballerina/log;
import ballerinax/financial.iso8583;

public function main() returns error? {
    string iso8583String = "0200F23AC48108A080000000000006000000122003000063173100000000000011110828071332897953134210082808280828482901100060460004241124280421111509114665372D6538AC109mobileLKA05099144D000014411NTBCLKLXXXX11NTBCLKLXXXX";
    // Parse ISO 8583 raw string to ballerina record/structured json
    anydata|iso8583:ISOError parsedISO8583Msg = iso8583:parse(iso8583String);
    if parsedISO8583Msg is iso8583:ISOError {
        log:printError(string `Error while parsing message`, errorMsg = parsedISO8583Msg.message);
    } else {
        // Clone the parsed message to a specific type
        iso8583:MTI_020X mti200Msg = check parsedISO8583Msg.cloneWithType();
        // Validate the parsed message
        iso8583:MTI_020X validatedMsg = check constraint:validate(mti200Msg);
        log:printInfo(string `Parsed ISO 8583 record validated successfully.`, validatedMsg = validatedMsg.toJsonString());
    }
}

```

**Output of successful parse operation**

A structured JSON representation similar to:

```
{
    "MTI": "0200",
    "PrimaryAccountNumber": "200300006317",
    "ProcessingCode": "310000",
    "AmountTransaction": "000000001111",
    "DateAndTimeTransmission": "0828071332",
    "SystemsTraceAuditNumber": "897953",
    "TimeLocalTransaction": "134210",
    "DateLocalTransaction": "0828",
    "DateSettlement": "0828",
    "DateCapture": "0828",
    "MerchantType": "4829",
    "PointOfServiceEntryMode": "011",
    "PointOfServiceConditionCode": "00",
    "AcquiringInstitutionIdentificationCode": "046000",
    "RetrievalReferenceNumber": "424112428042",
    "CardAcceptorTerminalIdentification": "11115091",
    "CardAcceptorNameLocation": "14665372D6538AC109mobileLKA05099144D0000",
    "CurrencyCodeTransaction": "144",
    "AccountIdentification1": "NTBCLKLXXXX",
    "AccountIdentification2": "NTBCLKLXXXX"
}
```

_Note: Actual field values may vary depending on the packager definition you're using._

### Encode an ISO 8583 Message String

The encode function takes a structured JSON record (or a Ballerina record) representing the contents of an ISO 8583 message and generates a raw ISO 8583 string. The generated message will follow the standard structure of MTI, bitmaps, and the payload, encoded as a compact string.

```
import ballerina/log;
import ballerinax/financial.iso8583;

public function main() returns error? {

    iso8583:MTI_020X mti200Msg = {
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
    // Encode ballerina record or json to ISO 8583 structured message
    string|iso8583:ISOError encodedMessage = iso8583:encode(mti200Msg);
    if encodedMessage is string {
        log:printInfo(string `Encoded ISO 8583 message: ${encodedMessage}`);
    } else {
        log:printError("Error occurred while encoding", errorMsg = encodedMessage.message);
    }
}
```

**Output of successful encode operation**

A compact ISO 8583 string message similar to:

```
0200F23AC48108A080000000000006000000122003000063173100000000000011110828071332897953134210082808280828482901100060460004241124280421111509114665372D6538AC109mobileLKA05099144D000014411NTBCLKLXXXX11NTBCLKLXXXX
```

### Generate ISO 8583 Byte Stream

The generateByteStream function takes a raw ISO 8583 string (produced using encode) and converts it into a hex-encoded byte stream (byte[]) suitable for transmission over a network, particularly in TCP-based financial messaging systems. This byte stream matches the expected format used in real-world ISO 8583 communication between systems like ATMs, POS terminals, and host processors.


#### Optional parameters:

`customHeader` (default: empty):  Custom header to prepend additional metadata (e.g., channel ID, version, etc.) before the MTI

`addLengthHeader` (default: true): Boolean to indicate whether to add a payload length header

`lengthHeaderSize` (default: 4): Byte size used to denote payload length header

`isLengthHeaderASCII` (default: false): Boolean to indicate whether the length header is ASCII characters (default is false). 
(e.g. in ASCII characters "0128" means 128 bytes and in binary "0x00 0x80" means 128 bytes)

```
import ballerina/log;
import ballerinax/financial.iso8583;
import ballerina/lang.array;

public function main() returns error? {

    string iso8583Message = "0200F23AC48108A080000000000006000000122003000063173100000000000011110828071332897953134210082808280828482901100060460004241124280421111509114665372D6538AC109mobileLKA05099144D000014411NTBCLKLXXXX11NTBCLKLXXXX";

    byte[]|iso8583:ISOError byteStream = iso8583:generateByteStream(iso8583Message, "iso8583:1987", true, 4, false);
    if byteStream is byte[] {
        log:printInfo("Generated ISO 8583 byte stream", content = byteStream.toString());
        // Convert the byte stream to Base16 representation
        string base16Result = array:toBase16(byteStream);
        log:printInfo("Base16 representation of the byte stream", content = base16Result);
    } else {
        log:printError("Error while generating byte stream", errorMsg = byteStream.message);
    }
}

```

**Output of a successful byte stream generation**

An array of byte values representing the ISO 8583 message, for example:

```
[0,0,0,204,105,115,111,56,53,56,51,58,49,57,56,55,48,50,48,48,242,58,196,129,8,160,128,0,0,0,0,0,6,0,0,0,49,50,50,48,48,51,48,48,48,48,54,51,49,55,51,49,48,48,48,48,48,48,48,48,48,48,48,48,49,49,49,49,48,56,50,56,48,55,49,51,51,50,56,57,55,57,53,51,49,51,52,50,49,48,48,56,50,56,48,56,50,56,48,56,50,56,52,56,50,57,48,49,49,48,48,48,54,48,52,54,48,48,48,52,50,52,49,49,50,52,50,56,48,52,50,49,49,49,49,53,48,57,49,49,52,54,54,53,51,55,50,68,54,53,51,56,65,67,49,48,57,109,111,98,105,108,101,76,75,65,48,53,48,57,57,49,52,52,68,48,48,48,48,49,52,52,49,49,78,84,66,67,76,75,76,88,88,88,88,49,49,78,84,66,67,76,75,76,88,88,88,88]

Byte array as a hex string:
000000cc69736f383538333a3139383730323030f23ac48108a080000000000006000000313232303033303030303633313733313030303030303030303030303131313130383238303731333332383937393533313334323130303832383038323830383238343832393031313030303630343630303034323431313234323830343231313131353039313134363635333732443635333841433130396d6f62696c654c4b413035303939313434443030303031343431314e5442434c4b4c5858585831314e5442434c4b4c58585858
```
*Note: The byte array corresponds to the ASCII values of the encoded message string. This format can be directly written to a socket for transmission.*

### Decode ISO 8583 Byte Stream

The decodeByteStream function takes a byte array representation of an ISO 8583 message (typically received over a network) and extracts its components — including the MTI (Message Type Indicator), primary/secondary bitmaps, and the raw ISO 8583 payload string. This is the reverse of generateByteStream, helping to decode binary transmissions for further parsing or analysis.

#### Optional parameters:

`mtiLength` (default: 4): The length of the MTI string in bytes.

`lengthHeaderSize` (deafult:4): Byte size used to denote payload length header

`isLengthHeaderASCII` (default: false): Boolean to indicate whether the length header is ASCII characters (default is false). 

`customHeaderLength` (default: 0): The length of any custom message header present before the MTI.

```
import ballerina/lang.array;
import ballerina/log;
import ballerinax/financial.iso8583;

public function main() returns error? {
    string base16Result = "000000cc69736f383538333a3139383730323030f23ac48108a080000000000006000000313232303033303030303633313733313030303030303030303030303131313130383238303731333332383937393533313334323130303832383038323830383238343832393031313030303630343630303034323431313234323830343231313131353039313134363635333732443635333841433130396d6f62696c654c4b413035303939313434443030303031343431314e5442434c4b4c5858585831314e5442434c4b4c58585858";
    byte[] byteStream = check array:fromBase16(base16Result);
    log:printInfo("Hex encoded byte stream to be decoded.", content = byteStream);
    [string, string, string]|iso8583:ISOError decodedByteStream = iso8583:decodeByteStream(byteStream, 4, 4, false, 12);
    if decodedByteStream is [string, string, string] {
        string mti = decodedByteStream[0];
        string bitmaps = decodedByteStream[1];
        string payload = decodedByteStream[2];
        log:printInfo("Decoded ISO 8583 byte stream", mti = mti, bitmaps = bitmaps, payload = payload);
    } else {
        log:printError("Error while decoding byte stream", errorMsg = decodedByteStream.message);
    }
}
```

**Output of a successful decode operation**

A tuple of three string values: MTI string, Bitmap string (in hex), Raw ISO 8583 payload string (data elements)

```
["0200","f23ac48108a080000000000006000000","122003000063173100000000000011110828071332897953134210082808280828482901100060460004241124280421111509114665372D6538AC109mobileLKA05099144D000014411NTBCLKLXXXX11NTBCLKLXXXX"]
```

### Generate ISO 8583 Byte Stream from JSON Record

The toBytes function takes a parsed ISO 8583 message (as a JSON object), encodes it into a valid ISO 8583 string, and then converts it into a hex-encoded byte stream (byte[]). This stream is suitable for network transmission—especially over TCP sockets in environments like ATMs, POS terminals, and financial switches.

This function combines the behavior of `encode` and `generateByteStream` into a single utility, ideal for scenarios where you already have an ISO 8583 message in structured JSON format and need to send it over the wire.

```
import ballerina/lang.array;
import ballerina/log;
import ballerinax/financial.iso8583;

public function main() returns error? {

    iso8583:MTI_020X mti200Msg = {
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

    // Generate byte stream from the ISO8583 json/ballerina record
    byte[]|iso8583:ISOError bytes = iso8583:toBytes(mti200Msg, "iso8583:1987", true, 4, false);
    if bytes is byte[] {
        log:printInfo(string `ISO8583 message in byte stream generated.`, base16hex = array:toBase16(bytes));
        log:printInfo(string `ISO8583 message in byte stream generated.`, byteStream = bytes);
    } else {
        log:printError(string `Error while generating byte stream`, errorMsg = bytes.message);
    }
}
```

**Output of a successful toBytes operation**

```
[0,0,0,204,105,115,111,56,53,56,51,58,49,57,56,55,48,50,48,48,242,58,196,129,8,160,128,0,0,0,0,0,6,0,0,0,49,50,50,48,48,51,48,48,48,48,54,51,49,55,51,49,48,48,48,48,48,48,48,48,48,48,48,48,49,49,49,49,48,56,50,56,48,55,49,51,51,50,56,57,55,57,53,51,49,51,52,50,49,48,48,56,50,56,48,56,50,56,48,56,50,56,52,56,50,57,48,49,49,48,48,48,54,48,52,54,48,48,48,52,50,52,49,49,50,52,50,56,48,52,50,49,49,49,49,53,48,57,49,49,52,54,54,53,51,55,50,68,54,53,51,56,65,67,49,48,57,109,111,98,105,108,101,76,75,65,48,53,48,57,57,49,52,52,68,48,48,48,48,49,52,52,49,49,78,84,66,67,76,75,76,88,88,88,88,49,49,78,84,66,67,76,75,76,88,88,88,88]

Byte array as a hex string:
000000cc69736f383538333a3139383730323030f23ac48108a080000000000006000000313232303033303030303633313733313030303030303030303030303131313130383238303731333332383937393533313334323130303832383038323830383238343832393031313030303630343630303034323431313234323830343231313131353039313134363635333732443635333841433130396d6f62696c654c4b413035303939313434443030303031343431314e5442434c4b4c5858585831314e5442434c4b4c58585858
```

### Convert ISO 8583 Byte Stream to JSON

The toJson function accepts a raw ISO 8583 byte stream (as received from a network socket) and converts it into a structured JSON object or Ballerina record. It internally decodes the byte stream, extracts the MTI, bitmap(s), and data elements, then parses them into a structured format for easier consumption.

This function is useful when you need to deserialize ISO 8583 messages directly from TCP payloads into structured application-friendly formats.

```
import ballerina/constraint;
import ballerina/log;
import ballerinax/financial.iso8583;

public function main() returns error? {
    byte[] byteStream = [0, 0, 0, 204, 105, 115, 111, 56, 53, 56, 51, 58, 49, 57, 56, 55, 48, 50, 48, 48, 242, 58, 196, 129, 8, 160, 128, 0, 0, 0, 0, 0, 6, 0, 0, 0, 49, 50, 50, 48, 48, 51, 48, 48, 48, 48, 54, 51, 49, 55, 51, 49, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 49, 49, 49, 49, 48, 56, 50, 56, 48, 55, 49, 51, 51, 50, 56, 57, 55, 57, 53, 51, 49, 51, 52, 50, 49, 48, 48, 56, 50, 56, 48, 56, 50, 56, 48, 56, 50, 56, 52, 56, 50, 57, 48, 49, 49, 48, 48, 48, 54, 48, 52, 54, 48, 48, 48, 52, 50, 52, 49, 49, 50, 52, 50, 56, 48, 52, 50, 49, 49, 49, 49, 53, 48, 57, 49, 49, 52, 54, 54, 53, 51, 55, 50, 68, 54, 53, 51, 56, 65, 67, 49, 48, 57, 109, 111, 98, 105, 108, 101, 76, 75, 65, 48, 53, 48, 57, 57, 49, 52, 52, 68, 48, 48, 48, 48, 49, 52, 52, 49, 49, 78, 84, 66, 67, 76, 75, 76, 88, 88, 88, 88, 49, 49, 78, 84, 66, 67, 76, 75, 76, 88, 88, 88, 88];
    anydata|iso8583:ISOError jsonResult = iso8583:toJson(byteStream, 4, 4, false, 12);
    if jsonResult is iso8583:ISOError {
        log:printError(string `Error while converting to JSON`, errorMsg = jsonResult.message);
    } else {
        // Validate the JSON result against the MTI_020X model
        iso8583:MTI_020X mti200Model = check constraint:validate(jsonResult);
        log:printInfo("Validated ISO 8583 record : " + mti200Model.toBalString());
    }
}
```

**Output of a successful toJson operation**

```
{
    "MTI": "0200",
    "PrimaryAccountNumber": "200300006317",
    "ProcessingCode": "310000",
    "AmountTransaction": "000000001111",
    "DateAndTimeTransmission": "0828071332",
    "SystemsTraceAuditNumber": "897953",
    "TimeLocalTransaction": "134210",
    "DateLocalTransaction": "0828",
    "DateSettlement": "0828",
    "DateCapture": "0828",
    "MerchantType": "4829",
    "PointOfServiceEntryMode": "011",
    "PointOfServiceConditionCode": "00",
    "AcquiringInstitutionIdentificationCode": "046000",
    "RetrievalReferenceNumber": "424112428042",
    "CardAcceptorTerminalIdentification": "11115091",
    "CardAcceptorNameLocation": "14665372D6538AC109mobileLKA05099144D0000",
    "CurrencyCodeTransaction": "144",
    "AccountIdentification1": "NTBCLKLXXXX",
    "AccountIdentification2": "NTBCLKLXXXX"
}
```

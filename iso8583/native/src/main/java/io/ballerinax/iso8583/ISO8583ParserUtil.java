/*
 * Copyright (c) 2024 WSO2 LLC. (https://www.wso2.com).
 *
 * WSO2 LLC. licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

package io.ballerinax.iso8583;

import com.google.common.collect.BiMap;
import com.google.common.collect.HashBiMap;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.commons.text.StringEscapeUtils;
import org.jpos.iso.ISOException;
import org.jpos.iso.ISOMsg;
import org.jpos.iso.packager.GenericPackager;
import org.json.JSONObject;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;

/**
 * ISO8583 Parser Util.
 * <p>
 * This class contains the methods to parse and generate ISO 8583 messages.
 */
public class ISO8583ParserUtil {

    private static volatile GenericPackager packager;
    private static final String PACKAGER_V_87 = "jposdefv87.xml";
    private static final Log log = LogFactory.getLog(ISO8583ParserUtil.class);
    private static BiMap<Integer, String> biMap = HashBiMap.create();

    /**
     * Initialize the ISO8583 parser.
     *
     * @param packagerFilePath    ISO8583 packager file path. This is used to initialize the ISO8583 JPOS packager.
     * @param elementNameFilePath ISO8583 element name file path. This is used to map the data element names with ids.
     */
    public static void initializeParser(String packagerFilePath, String elementNameFilePath) throws ISO8583Exception {
        if (StringUtils.isNotBlank(packagerFilePath)) {
            getIsoPackager(packagerFilePath);
            log.debug(String.format("ISO8583 packager file loaded from %s file path.", packagerFilePath));
        }
        if (StringUtils.isNotBlank(elementNameFilePath)) {
            setIso8583NameIds(elementNameFilePath);
            log.debug(String.format("ISO8583 data element name file loaded from %s file path.", elementNameFilePath));
        }
    }

    /**
     * Unpack the ISO message and transform to an XML.
     *
     * @param message ISO 8583 message.
     * @return Json string of the iso message.
     */
    public static String unpackISOMessage(String message) throws ISO8583Exception {

        ISOMsg isoMsg = new ISOMsg();
        isoMsg.setPackager(getIsoPackager(null));
        try {
            isoMsg.unpack(message.getBytes(StandardCharsets.UTF_8));
        } catch (ISOException e) {
            throw new ISO8583Exception("Error occurred while unpacking the ISO message", e);
        }
        return messageBuilder(isoMsg);
    }

    /**
     * Generate ISO message from the given JSON payload.
     *
     * @param jsonPayload JSON payload.
     * @return ISO 8583 message.
     */
    public static String encode(String jsonPayload) throws ISO8583Exception {

        JSONObject isoJson = new JSONObject(jsonPayload);
        byte[] responseMessage;
        ISOMsg isoMsg = new ISOMsg();
        isoMsg.setPackager(getIsoPackager(null));

        for (String key : isoJson.keySet()) {
            String elementValue = isoJson.getString(key);
            int fieldID = getIsoFieldId(key);
            isoMsg.set(fieldID, StringEscapeUtils.unescapeJson(elementValue));
        }
        try {
            responseMessage = isoMsg.pack();
        } catch (ISOException e) {
            throw new ISO8583Exception("Couldn't pack ISO8583 Message. " + e.getMessage(), e);
        }
        return new String(responseMessage, StandardCharsets.UTF_8);
    }

    /**
     * messageBuilder is used to build the json iso messages.
     *
     * @param isoMsg iso fields.
     * @return Json string of the iso message.
     * @throws ISO8583Exception if an unknown field id is found.
     */
    private static String messageBuilder(ISOMsg isoMsg) throws ISO8583Exception {

        JSONObject payloadJson = new JSONObject();
        for (int i = 0; i <= isoMsg.getMaxField(); i++) {
            if (isoMsg.hasField(i)) {
                String dataElement = getIsoFieldName(i);
                String value = isoMsg.getString(i);
                if (dataElement != null) {
                    payloadJson.put(dataElement, StringEscapeUtils.escapeJson(value));
                } else {
                    throw new ISO8583Exception("Unknown ISO8583 field id: " + i);
                }
            }
        }
        return payloadJson.toString();
    }

    private static GenericPackager getIsoPackager(String filePath) throws ISO8583Exception {

        if (packager == null) {
            try {
                InputStream inputStream = loadInputStream(filePath);
                packager = new GenericPackager(inputStream);
            } catch (ISOException | FileNotFoundException e) {
                throw new ISO8583Exception("Error occurred while loading the packager file", e);
            }
        }
        return packager;
    }

    private static InputStream loadInputStream(String filePath) throws FileNotFoundException {
        if (filePath == null) {
            ClassLoader loader = Thread.currentThread().getContextClassLoader();
            return loader.getResourceAsStream(PACKAGER_V_87);
        } else {
            return new FileInputStream(filePath);
        }
    }

    private static BiMap<Integer, String> getIso8583IdNames() {
        if (biMap.isEmpty()) {
            setIso8583NameIds();
        }
        return biMap;
    }

    /**
     * Set the ISO8583 field names and ids from a file.
     *
     * @param filePath File path to read the ISO8583 field names and ids. Expected format is CSV.
     * @throws ISO8583Exception if an error occurs while reading the file.
     */
    private static void setIso8583NameIds(String filePath) throws ISO8583Exception {
        try {
            List<String> lines = Files.readAllLines(Paths.get(filePath));
            for (String line : lines) {
                // Assuming the file is a CSV with key-value pairs separated by commas
                String[] parts = line.split(",");
                if (parts.length == 2) {
                    Integer key = Integer.parseInt(parts[0].trim());
                    String value = parts[1].trim();

                    // Update the BiMap with the new key-value pair
                    biMap.put(key, value);
                }
            }
        } catch (IOException e) {
            throw new ISO8583Exception("Error while reading file: " + filePath, e);
        }
    }

    // ISO 8583:1987 data elements
    // https://standards.iso.org/iso/8583/ed-3/en/ISO_8583_2021_Annex%20J_Informative_Prior%20Versions%20of%20ISO%
    // 208583.docx
    private static void setIso8583NameIds() {
        biMap.put(0, "MTI");
        biMap.put(1, "BitmapIndicator");
        biMap.put(2, "PrimaryAccountNumber");
        biMap.put(3, "ProcessingCode");
        biMap.put(4, "AmountTransaction");
        biMap.put(5, "AmountReconciliation");
        biMap.put(6, "AmountCardholderBilling");
        biMap.put(7, "DateAndTimeTransmission");
        biMap.put(8, "AmountCardholderBillingFee");
        biMap.put(9, "ConversionRateReconciliation");
        biMap.put(10, "ConversionRateCardholderBilling");
        biMap.put(11, "SystemsTraceAuditNumber");
        biMap.put(12, "DateAndTimeLocalTransaction");
        biMap.put(13, "DateEffective");
        biMap.put(14, "DateExpiration");
        biMap.put(15, "DateSettlement");
        biMap.put(16, "DateConversion");
        biMap.put(17, "DateCapture");
        biMap.put(18, "MessageErrorIndicator");
        biMap.put(19, "CountryCodeAcquiringInstitution");
        biMap.put(20, "CountryCodePrimaryAccountNumber");
        biMap.put(21, "TransactionLifeCycleIdentificationData");
        biMap.put(22, "POSDataCode");
        biMap.put(23, "CardSequenceNumber");
        biMap.put(24, "FunctionCode");
        biMap.put(25, "MessageReasonCode");
        biMap.put(26, "MerchantCategoryCode");
        biMap.put(27, "POSCapability");
        biMap.put(28, "DateReconciliation");
        biMap.put(29, "ReconciliationIndicator");
        biMap.put(30, "AmountsOriginal");
        biMap.put(31, "AcquirerReferenceNumber");
        biMap.put(32, "AcquiringInstitutionIdentificationCode");
        biMap.put(33, "ForwardingInstitutionIdentificationCode");
        biMap.put(34, "ElectronicCommerceData");
        biMap.put(35, "Track2Data");
        biMap.put(36, "Track3Data");
        biMap.put(37, "RetrievalReferenceNumber");
        biMap.put(38, "ApprovalCode");
        biMap.put(39, "ActionCode");
        biMap.put(40, "ServiceCode");
        biMap.put(41, "CardAcceptorTerminalIdentification");
        biMap.put(42, "CardAcceptorIdentificationCode");
        biMap.put(43, "CardAcceptorNameLocation");
        biMap.put(44, "AdditionalResponseData");
        biMap.put(45, "Track1Data");
        biMap.put(46, "AmountsFees");
        biMap.put(47, "AdditionalDataNational");
        biMap.put(48, "AdditionalDataPrivate");
        biMap.put(49, "VerificationData");
        biMap.put(50, "ReservedISOData50");
        biMap.put(51, "CustomerRelatedData");
        biMap.put(52, "PersonalIdentificationNumberData");
        biMap.put(53, "SecurityRelatedControlInformation");
        biMap.put(54, "AmountsAdditional");
        biMap.put(55, "IntegratedCircuitCardSystemRelatedData");
        biMap.put(56, "OriginalDataElements");
        biMap.put(57, "AuthorizationLifeCycleCode");
        biMap.put(58, "AuthorizingAgentInstitutionIdentificationCode");
        biMap.put(59, "TransportData");
        biMap.put(60, "ReservedNationalData60");
        biMap.put(61, "ReservedNationalData61");
        biMap.put(62, "ReservedPrivateData62");
        biMap.put(63, "ReservedPrivateData63");
        biMap.put(64, "MessageAuthenticationCode");
        biMap.put(65, "ReservedISOData65");
        biMap.put(66, "AmountsOriginalFees");
        biMap.put(67, "ExtendedPaymentData");
        biMap.put(68, "FileTransferMessageControl");
        biMap.put(69, "FileTransferControlData");
        biMap.put(70, "FileTransferDescriptionData");
        biMap.put(71, "AdditionalTransactionSpecificData");
        biMap.put(72, "DataRecord");
        biMap.put(73, "DateAction");
        biMap.put(74, "ReconciliationDataPrimary");
        biMap.put(75, "ReconciliationDataSecondary");
        biMap.put(76, "ReservedISOData76");
        biMap.put(77, "ReservedISOData77");
        biMap.put(78, "ReservedISOData78");
        biMap.put(79, "ReservedISOData79");
        biMap.put(80, "ReservedISOData80");
        biMap.put(81, "ReservedISOData81");
        biMap.put(82, "ReservedISOData82");
        biMap.put(83, "ReservedISOData83");
        biMap.put(84, "ReservedISOData84");
        biMap.put(85, "ReservedISOData85");
        biMap.put(86, "ReservedISOData86");
        biMap.put(87, "ReservedISOData87");
        biMap.put(88, "ReservedISOData88");
        biMap.put(89, "ReservedISOData89");
        biMap.put(90, "ReservedISOData90");
        biMap.put(91, "ReservedISOData91");
        biMap.put(92, "ReservedISOData92");
        biMap.put(93, "TransactionDestinationInstitutionIdentificationCode");
        biMap.put(94, "TransactionOriginatorInstitutionIdentificationCode");
        biMap.put(95, "CardIssuersReferenceData");
        biMap.put(96, "KeyManagementData");
        biMap.put(97, "AmountNetReconciliation");
        biMap.put(98, "Payee");
        biMap.put(99, "SettlementInstitutionIdentificationCode");
        biMap.put(100, "ReceivingInstitutionIdentificationCode");
        biMap.put(101, "FileName");
        biMap.put(102, "AccountIdentification1");
        biMap.put(103, "AccountIdentification2");
        biMap.put(104, "TransactionSpecificData");
        biMap.put(105, "ReservedISOData105");
        biMap.put(106, "ReservedISOData106");
        biMap.put(107, "ReservedISOData107");
        biMap.put(108, "ReservedISOData108");
        biMap.put(109, "ReconciliationFeeAmountsCredit");
        biMap.put(110, "ReconciliationFeeAmountsDebit");
        biMap.put(111, "ReservedPrivateData111");
        biMap.put(112, "ReservedPrivateData112");
        biMap.put(113, "ReservedPrivateData113");
        biMap.put(114, "ReservedNationalData114");
        biMap.put(115, "ReservedNationalData115");
        biMap.put(116, "ReservedNationalData116");
        biMap.put(117, "ReservedNationalData117");
        biMap.put(118, "ReservedNationalData118");
        biMap.put(119, "ReservedNationalData119");
        biMap.put(120, "ReservedNationalData120");
        biMap.put(121, "ReservedNationalData121");
        biMap.put(122, "ReservedNationalData122");
        biMap.put(123, "ReservedPrivateData123");
        biMap.put(124, "ReservedPrivateData124");
        biMap.put(125, "ReservedPrivateData125");
        biMap.put(126, "ReservedPrivateData126");
        biMap.put(127, "ReservedPrivateData127");
        biMap.put(128, "MessageAuthenticationCode2");
    }

    /**
     * Get the ISO8583 field name for the given field id.
     *
     * @param fieldId ISO8583 field id.
     * @return ISO8583 field name.
     * @throws ISO8583Exception if the field id is unknown.
     */
    private static String getIsoFieldName(int fieldId) throws ISO8583Exception {
        if (getIso8583IdNames().containsKey(fieldId)) {
            return getIso8583IdNames().get(fieldId);
        } else {
            throw new ISO8583Exception("Unknown ISO8583 field id: " + fieldId);
        }
    }

    /**
     * Get the ISO8583 field id for the given field name.
     *
     * @param fieldName ISO8583 field name.
     * @return ISO8583 field id.
     * @throws ISO8583Exception if the field name is unknown.
     */
    private static int getIsoFieldId(String fieldName) throws ISO8583Exception {
        if (getIso8583IdNames().containsValue(fieldName)) {
            return getIso8583IdNames().inverse().get(fieldName);
        } else {
            throw new ISO8583Exception("Unknown ISO8583 field name: " + fieldName);
        }
    }
}

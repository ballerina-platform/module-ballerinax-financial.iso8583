package io.ballerinax.iso8583.util;

import com.google.common.collect.BiMap;
import com.google.common.collect.HashBiMap;
import io.ballerinax.iso8583.ISO8583Exception;

/**
 * ISO8583 Common Util.
 * <p>
 * This class contains the common utility methods for the ISO8583 parser.
 */
public class ISO8583CommonUtil {

    private static BiMap<Integer, String> biMap;

    private static BiMap<Integer, String> getIso8583IdNames() {
        if (biMap == null) {
            setIso8583NameIds();
        }
        return biMap;
    }

    private static void setIso8583NameIds() {
        biMap = HashBiMap.create();
        biMap.put(0, "MTI");
        biMap.put(1, "Bitmap");
        biMap.put(2, "PrimaryAccountNumber");
        biMap.put(3, "ProcessingCode");
        biMap.put(4, "AmountTransaction");
        biMap.put(5, "AmountSettlement");
        biMap.put(6, "AmountCardholderBilling");
        biMap.put(7, "TransmissionDateTime");
        biMap.put(8, "AmountCardholderBillingFee");
        biMap.put(9, "ConversionRateSettlement");
        biMap.put(10, "ConversionRateCardholderBilling");
        biMap.put(11, "SystemTraceAuditNumber");
        biMap.put(12, "LocalTransactionTime");
        biMap.put(13, "LocalTransactionDate");
        biMap.put(14, "ExpirationDate");
        biMap.put(15, "SettlementDate");
        biMap.put(16, "CurrencyConversionDate");
        biMap.put(17, "DateCapture");
        biMap.put(18, "MerchantType");
        biMap.put(19, "AcquiringInstitutionCountryCode");
        biMap.put(20, "PANCountryCode");
        biMap.put(21, "ForwardingInstitutionCountryCode");
        biMap.put(22, "PointOfServiceEntryMode");
        biMap.put(23, "ApplicationPANSequenceNumber");
        biMap.put(24, "FunctionCode");
        biMap.put(25, "PointOfServiceConditionCode");
        biMap.put(26, "PointOfServiceCaptureCode");
        biMap.put(27, "AuthorizingIdentificationResponseLength");
        biMap.put(28, "AmountTransactionFee");
        biMap.put(29, "AmountSettlementFee");
        biMap.put(30, "AmountTransactionProcessingFee");
        biMap.put(31, "AmountSettlementProcessingFee");
        biMap.put(32, "AcquiringInstitutionIdentificationCode");
        biMap.put(33, "ForwardingInstitutionIdentificationCode");
        biMap.put(34, "PrimaryAccountNumberExtended");
        biMap.put(35, "Track2Data");
        biMap.put(36, "Track3Data");
        biMap.put(37, "RetrievalReferenceNumber");
        biMap.put(38, "AuthorizationNumber");
        biMap.put(39, "ResponseCode");
        biMap.put(40, "ServiceRestrictionCode");
        biMap.put(41, "CardAcceptorTerminalID");
        biMap.put(42, "CardAcceptorIDCode");
        biMap.put(43, "CardAcceptorNameLocation");
        biMap.put(44, "AdditionalResponseData");
        biMap.put(45, "Track1Data");
        biMap.put(46, "AdditionalDataISO");
        biMap.put(47, "AdditionalDataNational");
        biMap.put(48, "AdditionalDataPrivate");
        biMap.put(49, "CurrencyCodeTransaction");
        biMap.put(50, "CurrencyCodeSettlement");
        biMap.put(51, "CurrencyCodeCardholderBilling");
        biMap.put(52, "PersonalIdentificationNumberData");
        biMap.put(53, "SecurityRelatedControlInformation");
        biMap.put(54, "AdditionalAmounts");
        biMap.put(60, "AdditionalTerminalDetails");
        biMap.put(65, "ExtendedBitmapIndicator");
        biMap.put(66, "SettlementCode");
        biMap.put(67, "ExtendedPaymentCode");
        biMap.put(68, "ReceivingInstitutionCountryCode");
        biMap.put(69, "SettlementInstitutionCountryCode");
        biMap.put(70, "NetworkManagementInformationCode");
        biMap.put(71, "MessageNumber");
        biMap.put(72, "MessageNumberLast");
        biMap.put(73, "DateAction");
        biMap.put(74, "CreditsNumber");
        biMap.put(75, "CreditsReversalNumber");
        biMap.put(76, "DebitsNumber");
        biMap.put(77, "DebitsReversalNumber");
        biMap.put(78, "TransferNumber");
        biMap.put(79, "TransferReversalNumber");
        biMap.put(80, "InquiriesNumber");
        biMap.put(81, "AuthorizationsNumber");
        biMap.put(82, "CreditsProcessingFeeAmount");
        biMap.put(83, "CreditsTransactionFeeAmount");
        biMap.put(84, "DebitsProcessingFeeAmount");
        biMap.put(85, "DebitsTransactionFeeAmount");
        biMap.put(86, "CreditsAmount");
        biMap.put(87, "CreditsReversalAmount");
        biMap.put(88, "DebitsAmount");
        biMap.put(89, "DebitsReversalAmount");
        biMap.put(90, "OriginalDataElements");
        biMap.put(91, "FileUpdateCode");
        biMap.put(92, "FileSecurityCode");
        biMap.put(93, "ResponseIndicator");
        biMap.put(94, "ServiceIndicator");
        biMap.put(95, "ReplacementAmounts");
        biMap.put(96, "MessageSecurityCode");
        biMap.put(97, "AmountNetSettlement");
        biMap.put(98, "Payee");
        biMap.put(99, "SettlementInstitutionIdentificationCode");
        biMap.put(100, "ReceivingInstitutionIdentificationCode");
        biMap.put(101, "FileName");
        biMap.put(102, "AccountIdentification1");
        biMap.put(103, "AccountIdentification2");
        biMap.put(104, "TransactionDescription");
        biMap.put(111, "AuthorisationIdentificationCode");
        biMap.put(120, "EftTlvData");
        biMap.put(128, "MAC");
    }

    public static String getIsoFieldName(int fieldId) throws ISO8583Exception {
        if (getIso8583IdNames().containsKey(fieldId)) {
            return getIso8583IdNames().get(fieldId);
        } else {
            throw new ISO8583Exception("Unknown ISO8583 field id: " + fieldId);
        }

    }

    public static int getIsoFieldId(String fieldName) throws ISO8583Exception {
        if (getIso8583IdNames().containsValue(fieldName)) {
            return getIso8583IdNames().inverse().get(fieldName);
        } else {
            throw new ISO8583Exception("Unknown ISO8583 field name: " + fieldName);
        }
    }
}

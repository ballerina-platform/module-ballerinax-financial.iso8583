//  Copyright (c) 2024 WSO2 LLC. (https://www.wso2.com).

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

import ballerina/constraint;

# MTI 020X - Financial Request.
# The `MTI_020X` record represents a financial presentment request in the ISO 8583 standard.
# This can be used to represent message types 200 and 201
#
# + MTI - The message type indicator (MTI) of the transaction.  
# + PrimaryAccountNumber - The primary account number (PAN) of the cardholder.  
# + ProcessingCode - A code indicating the type of transaction being performed.  
# + AmountTransaction - The amount of the transaction.  
# + DateAndTimeTransmission - The date and time when the transaction was initiated.  
# + SystemsTraceAuditNumber - A unique number assigned to the transaction for tracking purposes.  
# + TimeLocalTransaction - The local time at the point of transaction.  
# + DateLocalTransaction - The effective date of the transaction.  
# + DateSettlement - The date when the transaction is settled.
# + DateCapture - The date when the transaction was captured.
# + MerchantType - The merchant type of the transaction.
# + PointOfServiceEntryMode - The point of service (POS) data code.  
# + PointOfServiceConditionCode - The condition code of the transaction.
# + AmountTransactionFee - The amount of the transaction fee.
# + AcquiringInstitutionIdentificationCode - The identification code of the acquiring institution.  
# + Track2Data - The track 2 data of the card.  
# + RetrievalReferenceNumber - The reference number for retrieving the transaction.
# + CardAcceptorTerminalIdentification - The identification code of the terminal where the card was accepted.  
# + CardAcceptorIdentificationCode - The identification code of the card accepter.  
# + CardAcceptorNameLocation - The name and location of the card accepter.  
# + CurrencyCodeTransaction - The currency code of the transaction.
# + PersonalIdentificationNumberData - The personal identification number data.
# + IntegratedCircuitCardSystemRelatedData - The integrated circuit card system related data.
# + ReceivingInstitutionIdentificationCode - The identification code of the receiving institution.  
# + AccountIdentification1 - The account identification number of the cardholder.
# + AccountIdentification2 - The account identification number of the cardholder.
# + MessageAuthenticationCode2 - field description

public type MTI_020X record {|
    string MTI = "200"; //can support 200 and 201
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for PrimaryAccountNumber"
        }
    }
    string PrimaryAccountNumber?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for ProcessingCode"
        }
    }
    string ProcessingCode;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for AmountTransaction"
        }
    }
    string AmountTransaction;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for DateAndTimeTransmission"
        }
    }
    string DateAndTimeTransmission;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for SystemsTraceAuditNumber"
        }
    }
    string SystemsTraceAuditNumber;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for TimeLocalTransaction"
        }
    }
    string TimeLocalTransaction;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for DateLocalTransaction"
        }
    }
    string DateLocalTransaction;
    string DateSettlement?;
    string DateCapture?;
    string MerchantType?;
    string PointOfServiceEntryMode?;
    string PointOfServiceConditionCode;
    string AmountTransactionFee?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for AcquiringInstitutionIdentificationCode"
        }
    }
    string AcquiringInstitutionIdentificationCode;
    string Track2Data?;
    string RetrievalReferenceNumber;
    string CardAcceptorTerminalIdentification?;
    string CardAcceptorIdentificationCode?;
    string CardAcceptorNameLocation?;
    string CurrencyCodeTransaction;
    string PersonalIdentificationNumberData?;
    string IntegratedCircuitCardSystemRelatedData?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for ReceivingInstitutionIdentificationCode"
        }
    }
    string ReceivingInstitutionIdentificationCode?;
    string AccountIdentification1?;
    string AccountIdentification2?;
    string MessageAuthenticationCode2?;
|};

# MTI 0210 - Financial Request.
# The `MTI_0210` record represents a financial presentment request response in the ISO 8583 standard.
#
# + MTI - The message type indicator (MTI) of the transaction.  
# + PrimaryAccountNumber - The primary account number (PAN) of the cardholder.  
# + ProcessingCode - A code indicating the type of transaction being performed.  
# + AmountTransaction - The amount of the transaction.  
# + DateAndTimeTransmission - The date and time when the transaction was initiated.  
# + SystemsTraceAuditNumber - A unique number assigned to the transaction for tracking purposes.  
# + TimeLocalTransaction - The local time at the point of transaction.  
# + DateLocalTransaction - The effective date of the transaction.
# + DateSettlement - The date when the transaction is settled.
# + DateCapture - The date when the transaction was captured.
# + MerchantType - The merchant type of the transaction.  
# + PointOfServiceEntryMode - The point of service (POS) data code.
# + PointOfServiceConditionCode - The condition code of the transaction.
# + AmountTransactionFee - The amount of the transaction fee.  
# + AcquiringInstitutionIdentificationCode - The identification code of the acquiring institution.  
# + RetrievalReferenceNumber - The reference number for retrieving the transaction.
# + AuthorisationIdentificationResponse - The authorization identification response.  
# + ResponseCode - The response code of the transaction.  
# + CardAcceptorTerminalIdentification - The identification code of the terminal where the card was accepted.  
# + CardAcceptorIdentificationCode - The identification code of the card accepter.  
# + CardAcceptorNameLocation - The name and location of the card accepter.
# + CurrencyCodeTransaction - The currency code of the transaction.
# + IntegratedCircuitCardSystemRelatedData - The integrated circuit card system related data.
# + ReceivingInstitutionIdentificationCode - The identification code of the receiving institution.  
# + AccountIdentification1 - the account identification number of the cardholder.
# + AccountIdentification2 - the account identification number of the cardholder.
# + MessageAuthenticationCode2 - field description

public type MTI_0210 record {|
    string MTI = "210";
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for PrimaryAccountNumber"
        }
    }
    string PrimaryAccountNumber?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for ProcessingCode"
        }
    }
    string ProcessingCode;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for AmountTransaction"
        }
    }
    string AmountTransaction;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for DateAndTimeTransmission"
        }
    }
    string DateAndTimeTransmission;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for SystemsTraceAuditNumber"
        }
    }
    string SystemsTraceAuditNumber;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for TimeLocalTransaction"
        }
    }
    string TimeLocalTransaction;
    string DateLocalTransaction;
    string DateSettlement;
    string DateCapture;
    string MerchantType;
    string PointOfServiceEntryMode?;
    string PointOfServiceConditionCode;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for AmountTransactionFee"
        }
    }
    string AmountTransactionFee?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for AcquiringInstitutionIdentificationCode"
        }
    }
    string AcquiringInstitutionIdentificationCode;
    string RetrievalReferenceNumber;
    string AuthorisationIdentificationResponse?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for ResponseCode"
        }
    }
    string ResponseCode;
    string CardAcceptorTerminalIdentification?;
    string CardAcceptorIdentificationCode?;
    string CardAcceptorNameLocation?;
    string CurrencyCodeTransaction;
    string IntegratedCircuitCardSystemRelatedData?;
    string ReceivingInstitutionIdentificationCode;
    string AccountIdentification1?;
    string AccountIdentification2?;
    string MessageAuthenticationCode2?;
|};

# MTI 022X - Financial Presentment Advice.
# The `MTI_022X` record represents a financial presentment advice in the ISO 8583 standard.
# This can be used to represent message types 220 and 221
#
# + MTI - The message type indicator (MTI) of the transaction.  
# + PrimaryAccountNumber - The primary account number (PAN) of the cardholder.  
# + ProcessingCode - A code indicating the type of transaction being performed.  
# + AmountTransaction - The amount of the transaction.  
# + DateAndTimeTransmission - The date and time when the transaction was initiated.  
# + ConversionRateCardholderBilling - The conversion rate for cardholder billing.  
# + SystemsTraceAuditNumber - A unique number assigned to the transaction for tracking purposes.  
# + TimeLocalTransaction - The local time at the point of transaction.  
# + DateLocalTransaction - The effective date of the transaction.  
# + DateExpiration - The expiration date of the transaction.  
# + DateCapture - The date when the transaction was captured.
# + CountryCodeForwardingInstitution - The country code of the forwarding institution.
# + PointOfServiceEntryMode - The point of service (POS) data code.  
# + CardSequenceNumber - The sequence number of the card.  
# + NetworkInternationalIdentifier - The network international identifier.
# + PointOfServiceConditionCode - The condition code of the transaction.
# + PointOfServicePinCaptureCode - The point of service (POS) pin capture code.
# + AmountTransactionProcessingFee - The amount of the transaction processing fee.
# + AcquiringInstitutionIdentificationCode - The identification code of the acquiring institution.  
# + ForwardingInstitutionIdentificationCode - The identification code of the forwarding institution.  
# + Track2Data - The track 2 data of the card.  
# + Track3Data - The track 3 data of the card.  
# + AuthorisationIdentificationResponse - The authorization identification response.
# + ResponseCode - The response code of the transaction.
# + ServiceRestrictionCode - The service restriction code of the transaction.
# + CardAcceptorTerminalIdentification - The identification code of the terminal where the card was accepted.  
# + CardAcceptorIdentificationCode - The identification code of the card accepter.  
# + CardAcceptorNameLocation - The name and location of the card accepter.  
# + Track1Data - The track 1 data of the card.  
# + ReceivingInstitutionIdentificationCode - The identification code of the receiving institution.

public type MTI_022X record {|
    string MTI = "220"; //can support 220 and 221
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for PrimaryAccountNumber"
        }
    }
    string PrimaryAccountNumber?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for ProcessingCode"
        }
    }
    string ProcessingCode;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for AmountTransaction"
        }
    }
    string AmountTransaction;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for DateAndTimeTransmission"
        }
    }
    string DateAndTimeTransmission?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for ConversionRateCardholderBilling"
        }
    }
    string ConversionRateCardholderBilling?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for SystemsTraceAuditNumber"
        }
    }
    string SystemsTraceAuditNumber;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for TimeLocalTransaction"
        }
    }
    string TimeLocalTransaction;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for DateLocalTransaction"
        }
    }
    string DateLocalTransaction?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for DateExpiration"
        }
    }
    string DateExpiration?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for DateCapture"
        }
    }
    string DateCapture?;
    string CountryCodeForwardingInstitution?;
    string PointOfServiceEntryMode;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for CardSequenceNumber"
        }
    }
    string CardSequenceNumber?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for NetworkInternationalIdentifier"
        }
    }
    string NetworkInternationalIdentifier;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for PointOfServiceConditionCode"
        }
    }
    string PointOfServiceConditionCode;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for PointOfServicePinCaptureCode"
        }
    }
    string PointOfServicePinCaptureCode?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for AmountTransactionProcessingFee"
        }
    }
    string AmountTransactionProcessingFee?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for AcquiringInstitutionIdentificationCode"
        }
    }
    string AcquiringInstitutionIdentificationCode?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for ForwardingInstitutionIdentificationCode"
        }
    }
    string ForwardingInstitutionIdentificationCode?;
    string Track2Data?;
    string Track3Data?;
    string AuthorisationIdentificationResponse?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for ResponseCode"
        }
    }
    string ResponseCode;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for ServiceRestrictionCode"
        }
    }
    string ServiceRestrictionCode?;
    string CardAcceptorTerminalIdentification?;
    string CardAcceptorIdentificationCode?;
    string CardAcceptorNameLocation;
    string Track1Data?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for ReceivingInstitutionIdentificationCode"
        }
    }
    string ReceivingInstitutionIdentificationCode?;
|};

# MTI 0230 - Financial Presentment Advice Response.
# The `MTI_0230` record represents a financial presentment advice response in the ISO 8583 standard.
#
# + MTI - The message type indicator (MTI) of the transaction.  
# + PrimaryAccountNumber - The primary account number (PAN) of the cardholder.  
# + ProcessingCode - A code indicating the type of transaction being performed.  
# + AmountTransaction - The amount of the transaction.  
# + AmountSettlement - The amount of the settlement.
# + DateAndTimeTransmission - The date and time when the transaction was initiated.  
# + ConversionRateSettlement - The conversion rate for settlement.
# + ConversionRateCardholderBilling - The conversion rate for cardholder billing.  
# + SystemsTraceAuditNumber - A unique number assigned to the transaction for tracking purposes.  
# + TimeLocalTransaction - The local time at the point of transaction.  
# + DateConversion - The date of the conversion.
# + MerchantType - The merchant type of the transaction.
# + CountryCodeForwardingInstitution - The country code of the forwarding institution.
# + AmountTransactionFee - The amount of the transaction fee.
# + AmountSettlementFee - The amount of the settlement fee.
# + AcquiringInstitutionIdentificationCode - The identification code of the acquiring institution.  
# + ForwardingInstitutionIdentificationCode - The identification code of the forwarding institution.  
# + AuthorisationIdentificationResponse - The authorization identification response.
# + ResponseCode - The response code of the transaction.
# + CardAcceptorTerminalIdentification - The identification code of the terminal where the card was accepted.  
# + CardAcceptorIdentificationCode - The identification code of the card accepter.  
# + ReceivingInstitutionIdentificationCode - The identification code of the receiving institution.

public type MTI_0230 record {|
    string MTI = "230";
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for PrimaryAccountNumber"
        }
    }
    string PrimaryAccountNumber?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for ProcessingCode"
        }
    }
    string ProcessingCode;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for AmountTransaction"
        }
    }
    string AmountTransaction;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for AmountSettlement"
        }
    }
    string AmountSettlement?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for DateAndTimeTransmission"
        }
    }
    string DateAndTimeTransmission?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for ConversionRateSettlement"
        }
    }
    string ConversionRateSettlement?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for ConversionRateCardholderBilling"
        }
    }
    string ConversionRateCardholderBilling?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for SystemsTraceAuditNumber"
        }
    }
    string SystemsTraceAuditNumber;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for TimeLocalTransaction"
        }
    }
    string TimeLocalTransaction;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for DateConversion"
        }
    }
    string DateConversion?;
    string MerchantType?;
    string CountryCodeForwardingInstitution?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for AmountTransactionFee"
        }
    }
    string AmountTransactionFee?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for AmountSettlementFee"
        }
    }
    string AmountSettlementFee?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for AcquiringInstitutionIdentificationCode"
        }
    }
    string AcquiringInstitutionIdentificationCode?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for ForwardingInstitutionIdentificationCode"
        }
    }
    string ForwardingInstitutionIdentificationCode?;
    string AuthorisationIdentificationResponse?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for ResponseCode"
        }
    }
    string ResponseCode;
    string CardAcceptorTerminalIdentification?;
    string CardAcceptorIdentificationCode?;
    string ReceivingInstitutionIdentificationCode?;
|};

# MTI 0240 - Financial Presentment Notification Request.
# The `MTI_0240` record represents a financial presentment notification in the ISO 8583 standard.
#
# + MTI - The message type indicator (MTI) of the transaction.  
# + PrimaryAccountNumber - The primary account number (PAN) of the cardholder.  
# + ProcessingCode - A code indicating the type of transaction being performed.  
# + AmountTransaction - The amount of the transaction.  
# + AmountSettlement - The amount of the settlement.
# + DateAndTimeTransmission - The date and time when the transaction was initiated.  
# + ConversionRateSettlement - The conversion rate for settlement.
# + ConversionRateCardholderBilling - The conversion rate for cardholder billing.  
# + SystemsTraceAuditNumber - A unique number assigned to the transaction for tracking purposes.  
# + TimeLocalTransaction - The local time at the point of transaction.  
# + DateLocalTransaction - The effective date of the transaction.  
# + DateExpiration - The expiration date of the transaction.  
# + DateConversion - The date of the conversion.
# + DateCapture - The date when the transaction was captured.  
# + CountryCodeForwardingInstitution - The country code of the forwarding institution.
# + PointOfServiceEntryMode - The point of service (POS) data code.  
# + CardSequenceNumber - The sequence number of the card.  
# + NetworkInternationalIdentifier - The network international identifier.
# + PointOfServiceConditionCode - The condition code of the transaction.
# + PointOfServicePinCaptureCode - The point of service (POS) pin capture code.
# + AmountTransactionFee - The amount of the transaction fee.
# + AmountSettlementFee - The amount of the settlement fee.
# + AmountTransactionProcessingFee - The amount of the transaction processing fee.
# + AcquiringInstitutionIdentificationCode - The identification code of the acquiring institution.  
# + ForwardingInstitutionIdentificationCode - The identification code of the forwarding institution.  
# + Track2Data - The track 2 data of the card.  
# + Track3Data - The track 3 data of the card.  
# + AuthorisationIdentificationResponse - The authorization identification response.
# + ResponseCode - The response code of the transaction.
# + ServiceRestrictionCode - The service restriction code of the transaction.
# + CardAcceptorTerminalIdentification - The identification code of the terminal where the card was accepted.  
# + CardAcceptorIdentificationCode - The identification code of the card accepter.  
# + CardAcceptorNameLocation - The name and location of the card accepter.  
# + Track1Data - The track 1 data of the card.  
# + ReceivingInstitutionCountryCode - The country code of the receiving institution.
# + ReceivingInstitutionIdentificationCode - The identification code of the receiving institution.

public type MTI_0240 record {|
    string MTI = "240";
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for PrimaryAccountNumber"
        }
    }
    string PrimaryAccountNumber?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for ProcessingCode"
        }
    }
    string ProcessingCode;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for AmountTransaction"
        }
    }
    string AmountTransaction;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for AmountSettlement"
        }
    }
    string AmountSettlement?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for DateAndTimeTransmission"
        }
    }
    string DateAndTimeTransmission?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for ConversionRateSettlement"
        }
    }
    string ConversionRateSettlement?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for ConversionRateCardholderBilling"
        }
    }
    string ConversionRateCardholderBilling?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for SystemsTraceAuditNumber"
        }
    }
    string SystemsTraceAuditNumber;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for TimeLocalTransaction"
        }
    }
    string TimeLocalTransaction;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for DateLocalTransaction"
        }
    }
    string DateLocalTransaction?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for DateExpiration"
        }
    }
    string DateExpiration?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for DateConversion"
        }
    }
    string DateConversion?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for DateCapture"
        }
    }
    string DateCapture?;
    string CountryCodeForwardingInstitution?;
    string PointOfServiceEntryMode?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for CardSequenceNumber"
        }
    }
    string CardSequenceNumber?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for NetworkInternationalIdentifier"
        }
    }
    string NetworkInternationalIdentifier;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for PointOfServiceConditionCode"
        }
    }
    string PointOfServiceConditionCode;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for PointOfServicePinCaptureCode"
        }
    }
    string PointOfServicePinCaptureCode?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for AmountTransactionFee"
        }
    }
    string AmountTransactionFee?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for AmountSettlementFee"
        }
    }
    string AmountSettlementFee?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for AmountTransactionProcessingFee"
        }
    }
    string AmountTransactionProcessingFee?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for AcquiringInstitutionIdentificationCode"
        }
    }
    string AcquiringInstitutionIdentificationCode;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for ForwardingInstitutionIdentificationCode"
        }
    }
    string ForwardingInstitutionIdentificationCode?;
    string Track2Data?;
    string Track3Data?;
    string AuthorisationIdentificationResponse?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for ResponseCode"
        }
    }
    string ResponseCode;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for ServiceRestrictionCode"
        }
    }
    string ServiceRestrictionCode?;
    string CardAcceptorTerminalIdentification?;
    string CardAcceptorIdentificationCode?;
    string CardAcceptorNameLocation?;
    string Track1Data?;
    string ReceivingInstitutionCountryCode?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for ReceivingInstitutionIdentificationCode"
        }
    }
    string ReceivingInstitutionIdentificationCode?;
|};

# MTI 0250 - Financial Presentment Notification Acknowledgement Request.
# The `MTI_0250` record represents a financial presentment notification acknowledgement in the ISO 8583 standard.
#
# + MTI - The message type indicator (MTI) of the transaction.  
# + SystemsTraceAuditNumber - A unique number assigned to the transaction for tracking purposes.  
# + CountryCodeForwardingInstitution - The country code of the forwarding institution.
# + ReceivingInstitutionCountryCode - The country code of the receiving institution.

public type MTI_0250 record {|
    string MTI = "250";
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for SystemsTraceAuditNumber"
        }
    }
    string SystemsTraceAuditNumber;
    string CountryCodeForwardingInstitution?;
    string ReceivingInstitutionCountryCode?;
|};

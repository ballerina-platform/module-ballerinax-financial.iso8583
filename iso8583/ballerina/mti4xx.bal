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

# MTI 042X - Reversal Advice.
# The `MTI_042X` record represents a reversal advice in the ISO 8583 standard.
# This can be used to represent message types 420 and 421
#
# + MTI - The message type indicator (MTI) of the transaction.  
# + PrimaryAccountNumber - The primary account number (PAN) of the cardholder.  
# + ProcessingCode - A code indicating the type of transaction being performed.  
# + AmountTransaction - The amount of the transaction.  
# + DateAndTimeTransmission - The date and time when the transaction was initiated.  
# + ConversionRateCardholderBilling - The conversion rate for cardholder billing.  
# + SystemsTraceAuditNumber - A unique number assigned to the transaction for tracking purposes.  
# + TimeLocalTransaction - The local time at the point of transaction.  
# + CountryCodeForwardingInstitution - The country code of the forwarding institution.
# + NetworkInternationalIdentifier - The network international identifier.
# + PointOfServiceConditionCode - The point of sale condition code.
# + AmountTransactionProcessingFee - The transaction processing fee.
# + AcquiringInstitutionIdentificationCode - The identification code of the acquiring institution.  
# + ForwardingInstitutionIdentificationCode - The identification code of the forwarding institution.  
# + CardAcceptorTerminalIdentification - The identification code of the terminal where the card was accepted.  
# + CardAcceptorIdentificationCode - The identification code of the card accepter. 
# + CustomerRelatedData - The customer related data.
# + ReceivingInstitutionIdentificationCode - The identification code of the receiving institution.

public type MTI_042X record {|
    string MTI = "420";
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
    string ProcessingCode?;
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
    string CountryCodeForwardingInstitution?;
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
    string CardAcceptorTerminalIdentification?;
    string CardAcceptorIdentificationCode?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for CustomerRelatedData"
        }
    }
    string CustomerRelatedData;
    string ReceivingInstitutionIdentificationCode?;
|};

# MTI 0430 - Reversal Advice Response.
# The `MTI_0430` record represents a reversal advice response in the ISO 8583 standard.
#
# + MTI - The message type indicator (MTI) of the transaction.  
# + PrimaryAccountNumber - The primary account number (PAN) of the cardholder.  
# + ProcessingCode - A code indicating the type of transaction being performed.  
# + AmountTransaction - The amount of the transaction.  
# + AmountSettlement - The amount for settlement.
# + DateAndTimeTransmission - The date and time when the transaction was initiated.  
# + ConversionRateSettlement - The conversion rate for settlement.
# + ConversionRateCardholderBilling - The conversion rate for cardholder billing.  
# + SystemsTraceAuditNumber - A unique number assigned to the transaction for tracking purposes.  
# + TimeLocalTransaction - The local time at the point of transaction.  
# + DateConversion - The date of conversion.
# + MerchantType - The merchant type code.
# + CountryCodeForwardingInstitution - The country code of the forwarding institution.
# + AmountTransactionFee - The transaction fee.
# + AmountSettlementFee - The settlement fee.
# + AcquiringInstitutionIdentificationCode - The identification code of the acquiring institution.  
# + ForwardingInstitutionIdentificationCode - The identification code of the forwarding institution.  
# + ResponseCode - The response code of the transaction.
# + CardAcceptorTerminalIdentification - The identification code of the terminal where the card was accepted.  
# + CardAcceptorIdentificationCode - The identification code of the card accepter.  
# + ReceivingInstitutionIdentificationCode - The identification code of the receiving institution.

public type MTI_0430 record {|
    string MTI = "430";
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
    string ProcessingCode?;
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
    string AcquiringInstitutionIdentificationCode;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for ForwardingInstitutionIdentificationCode"
        }
    }
    string ForwardingInstitutionIdentificationCode?;
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

# MTI 0440 - Reversal Notification.
# The `MTI_0440` record represents a reversal notification in the ISO 8583 standard.
#
# + MTI - The message type indicator (MTI) of the transaction.  
# + PrimaryAccountNumber - The primary account number (PAN) of the cardholder.  
# + ProcessingCode - A code indicating the type of transaction being performed.  
# + AmountTransaction - The amount of the transaction.  
# + AmountSettlement - The amount for settlement.
# + DateAndTimeTransmission - The date and time when the transaction was initiated.  
# + ConversionRateSettlement - The conversion rate for settlement.
# + ConversionRateCardholderBilling - The conversion rate for cardholder billing.  
# + SystemsTraceAuditNumber - A unique number assigned to the transaction for tracking purposes.  
# + TimeLocalTransaction - The local time at the point of transaction.  
# + DateConversion - The date of conversion.
# + CountryCodeForwardingInstitution - The country code of the forwarding institution.
# + NetworkInternationalIdentifier - The network international identifier.
# + PointOfServiceConditionCode - The point of sale condition code.
# + AmountTransactionFee - The transaction fee.
# + AmountSettlementFee - The settlement fee.
# + AmountTransactionProcessingFee - The transaction processing fee.
# + AcquiringInstitutionIdentificationCode - The identification code of the acquiring institution.  
# + ForwardingInstitutionIdentificationCode - The identification code of the forwarding institution.  
# + ResponseCode - The response code of the transaction.
# + CardAcceptorTerminalIdentification - The identification code of the terminal where the card was accepted.  
# + CardAcceptorIdentificationCode - The identification code of the card accepter.  
# + CustomerRelatedData - The customer related data.
# + ReservedNationalData58 - The reserved national data.  
# + ReceivingInstitutionCountryCode - The country code of the receiving institution.
# + ReceivingInstitutionIdentificationCode - The identification code of the receiving institution.

public type MTI_0440 record {|
    string MTI = "440";
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
    string ProcessingCode?;
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
    string CountryCodeForwardingInstitution?;
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
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for ResponseCode"
        }
    }
    string ResponseCode;
    string CardAcceptorTerminalIdentification?;
    string CardAcceptorIdentificationCode?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for CustomerRelatedData"
        }
    }
    string CustomerRelatedData;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for ReservedNationalData58"
        }
    }
    string ReservedNationalData58?;
    string ReceivingInstitutionCountryCode?;
    string ReceivingInstitutionIdentificationCode?;
|};

# MTI 0450 - Reversal Notification Acknowledgement Request.
# The `MTI_0450` record represents a reversal notification acknowledgement in the ISO 8583 standard.
#
# + MTI - The message type indicator (MTI) of the transaction.  
# + SystemsTraceAuditNumber - A unique number assigned to the transaction for tracking purposes.  
# + CountryCodeForwardingInstitution - The country code of the forwarding institution.
# + ReceivingInstitutionCountryCode - The country code of the receiving institution.

public type MTI_0450 record {|
    string MTI = "450";
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

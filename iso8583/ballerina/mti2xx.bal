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

# MTI 20X - Financial Request.
# The `MTI_20X` record represents a financial presentment request in the ISO 8583 standard.
# This can be used to represent message types 200 and 201
#
# + MTI - The message type indicator (MTI) of the transaction.  
# + PrimaryAccountNumber - The primary account number (PAN) of the cardholder.  
# + ProcessingCode - A code indicating the type of transaction being performed.  
# + AmountTransaction - The amount of the transaction.  
# + DateAndTimeTransmission - The date and time when the transaction was initiated.  
# + ConversionRateCardholderBilling - The conversion rate for cardholder billing.  
# + SystemsTraceAuditNumber - A unique number assigned to the transaction for tracking purposes.  
# + DateAndTimeLocalTransaction - The local date and time at the point of transaction.  
# + DateEffective - The effective date of the transaction.  
# + DateExpiration - The expiration date of the transaction.  
# + TransactionLifeCycleIdentificationData - The transaction life cycle identification data.  
# + POSDataCode - The point of service (POS) data code.  
# + CardSequenceNumber - The sequence number of the card.  
# + FunctionCode - The function code of the transaction.  
# + MerchantCategoryCode - The category code of the merchant.
# + POSCapability - The point of service (POS) capability.  
# + AmountsOriginal - The original amount of the transaction.  
# + AcquiringInstitutionIdentificationCode - The identification code of the acquiring institution.  
# + ForwardingInstitutionIdentificationCode - The identification code of the forwarding institution.  
# + Track2Data - The track 2 data of the card.  
# + Track3Data - The track 3 data of the card.  
# + ServiceCode - The service code of the transaction.  
# + CardAcceptorTerminalIdentification - The identification code of the terminal where the card was accepted.  
# + CardAcceptorIdentificationCode - The identification code of the card accepter.  
# + CardAcceptorNameLocation - The name and location of the card accepter.  
# + Track1Data - The track 1 data of the card.  
# + AmountsFees - The amount of the transaction fees. 
# + ReceivingInstitutionIdentificationCode - The identification code of the receiving institution.

public type MTI_20X record {|
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
            message: "Only numeric values allowed for DateAndTimeLocalTransaction"
        }
    }
    string DateAndTimeLocalTransaction;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for DateEffective"
        }
    }
    string DateEffective?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for DateExpiration"
        }
    }
    string DateExpiration?;
    string TransactionLifeCycleIdentificationData?;
    string POSDataCode;
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
            message: "Only numeric values allowed for FunctionCode"
        }
    }
    string FunctionCode;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for MerchantCategoryCode"
        }
    }
    string MerchantCategoryCode;
    string POSCapability?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for AmountsOriginal"
        }
    }
    string AmountsOriginal?;
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
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for ServiceCode"
        }
    }
    string ServiceCode?;
    string CardAcceptorTerminalIdentification?;
    string CardAcceptorIdentificationCode?;
    string CardAcceptorNameLocation;
    string Track1Data?;
    string AmountsFees?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for ReceivingInstitutionIdentificationCode"
        }
    }
    string ReceivingInstitutionIdentificationCode?;
|};

# MTI 210 - Financial Request.
# The `MTI_210` record represents a financial presentment request response in the ISO 8583 standard.
#
# + MTI - The message type indicator (MTI) of the transaction.  
# + PrimaryAccountNumber - The primary account number (PAN) of the cardholder.  
# + ProcessingCode - A code indicating the type of transaction being performed.  
# + AmountTransaction - The amount of the transaction.  
# + AmountReconciliation - The amount of the reconciliation.
# + DateAndTimeTransmission - The date and time when the transaction was initiated.  
# + ConversionRateReconciliation - The conversion rate for reconciliation.
# + ConversionRateCardholderBilling - The conversion rate for cardholder billing.  
# + SystemsTraceAuditNumber - A unique number assigned to the transaction for tracking purposes.  
# + DateAndTimeLocalTransaction - The local date and time at the point of transaction.  
# + DateConversion - The date of the conversion.
# + MessageErrorIndicator - The message error indicator of the transaction.
# + TransactionLifeCycleIdentificationData - The transaction life cycle identification data.  
# + DateReconciliation - The date of the reconciliation.
# + ReconciliationIndicator - The reconciliation indicator of the transaction.
# + AmountsOriginal - The original amount of the transaction.  
# + AcquiringInstitutionIdentificationCode - The identification code of the acquiring institution.  
# + ForwardingInstitutionIdentificationCode - The identification code of the forwarding institution.  
# + ApprovalCode - The approval code of the transaction.
# + ActionCode - The action code of the transaction.
# + CardAcceptorTerminalIdentification - The identification code of the terminal where the card was accepted.  
# + CardAcceptorIdentificationCode - The identification code of the card accepter.  
# + AmountsFees - The amount of the transaction fees.  
# + AuthorizingAgentInstitutionIdentificationCode - The identification code of the authorizing agent.
# + TransportData - The transport data of the transaction.
# + ReceivingInstitutionIdentificationCode - The identification code of the receiving institution.

public type MTI_210 record {|
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
            message: "Only numeric values allowed for AmountReconciliation"
        }
    }
    string AmountReconciliation?;
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
            message: "Only numeric values allowed for ConversionRateReconciliation"
        }
    }
    string ConversionRateReconciliation?;
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
            message: "Only numeric values allowed for DateAndTimeLocalTransaction"
        }
    }
    string DateAndTimeLocalTransaction;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for DateConversion"
        }
    }
    string DateConversion?;
    string MessageErrorIndicator?;
    string TransactionLifeCycleIdentificationData?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for DateReconciliation"
        }
    }
    string DateReconciliation?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for ReconciliationIndicator"
        }
    }
    string ReconciliationIndicator?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for AmountsOriginal"
        }
    }
    string AmountsOriginal?;
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
    string ApprovalCode?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for ActionCode"
        }
    }
    string ActionCode;
    string CardAcceptorTerminalIdentification?;
    string CardAcceptorIdentificationCode?;
    string AmountsFees?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for AuthorizingAgentInstitutionIdentificationCode"
        }
    }
    string AuthorizingAgentInstitutionIdentificationCode?;
    string TransportData?;
    string ReceivingInstitutionIdentificationCode?;
|};

# MTI 22X - Financial Presentment Advice.
# The `MTI_22X` record represents a financial presentment advice in the ISO 8583 standard.
# This can be used to represent message types 220 and 221
#
# + MTI - The message type indicator (MTI) of the transaction.  
# + PrimaryAccountNumber - The primary account number (PAN) of the cardholder.  
# + ProcessingCode - A code indicating the type of transaction being performed.  
# + AmountTransaction - The amount of the transaction.  
# + DateAndTimeTransmission - The date and time when the transaction was initiated.  
# + ConversionRateCardholderBilling - The conversion rate for cardholder billing.  
# + SystemsTraceAuditNumber - A unique number assigned to the transaction for tracking purposes.  
# + DateAndTimeLocalTransaction - The local date and time at the point of transaction.  
# + DateEffective - The effective date of the transaction.  
# + DateExpiration - The expiration date of the transaction.  
# + DateCapture - The date when the transaction was captured.
# + TransactionLifeCycleIdentificationData - The transaction life cycle identification data.  
# + POSDataCode - The point of service (POS) data code.  
# + CardSequenceNumber - The sequence number of the card.  
# + FunctionCode - The function code of the transaction.  
# + MessageReasonCode - The reason code of the message.
# + MerchantCategoryCode - The category code of the merchant.  
# + AmountsOriginal - The original amount of the transaction.  
# + AcquiringInstitutionIdentificationCode - The identification code of the acquiring institution.  
# + ForwardingInstitutionIdentificationCode - The identification code of the forwarding institution.  
# + Track2Data - The track 2 data of the card.  
# + Track3Data - The track 3 data of the card.  
# + ApprovalCode - The approval code of the transaction.
# + ActionCode - The action code of the transaction.
# + ServiceCode - The service code of the transaction.  
# + CardAcceptorTerminalIdentification - The identification code of the terminal where the card was accepted.  
# + CardAcceptorIdentificationCode - The identification code of the card accepter.  
# + CardAcceptorNameLocation - The name and location of the card accepter.  
# + Track1Data - The track 1 data of the card.  
# + AmountsFees - The amount of the transaction fees.  
# + AuthorizingAgentInstitutionIdentificationCode - The identification code of the authorizing agent.
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
            message: "Only numeric values allowed for DateAndTimeLocalTransaction"
        }
    }
    string DateAndTimeLocalTransaction;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for DateEffective"
        }
    }
    string DateEffective?;
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
    string TransactionLifeCycleIdentificationData?;
    string POSDataCode;
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
            message: "Only numeric values allowed for FunctionCode"
        }
    }
    string FunctionCode;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for MessageReasonCode"
        }
    }
    string MessageReasonCode;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for MerchantCategoryCode"
        }
    }
    string MerchantCategoryCode?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for AmountsOriginal"
        }
    }
    string AmountsOriginal?;
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
    string ApprovalCode?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for ActionCode"
        }
    }
    string ActionCode;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for ServiceCode"
        }
    }
    string ServiceCode?;
    string CardAcceptorTerminalIdentification?;
    string CardAcceptorIdentificationCode?;
    string CardAcceptorNameLocation;
    string Track1Data?;
    string AmountsFees?;
    string AuthorizingAgentInstitutionIdentificationCode?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for ReceivingInstitutionIdentificationCode"
        }
    }
    string ReceivingInstitutionIdentificationCode?;
|};

# MTI 230 - Financial Presentment Advice Response.
# The `MTI_230` record represents a financial presentment advice response in the ISO 8583 standard.
#
# + MTI - The message type indicator (MTI) of the transaction.  
# + PrimaryAccountNumber - The primary account number (PAN) of the cardholder.  
# + ProcessingCode - A code indicating the type of transaction being performed.  
# + AmountTransaction - The amount of the transaction.  
# + AmountReconciliation - The amount of the reconciliation.
# + DateAndTimeTransmission - The date and time when the transaction was initiated.  
# + ConversionRateReconciliation - The conversion rate for reconciliation.
# + ConversionRateCardholderBilling - The conversion rate for cardholder billing.  
# + SystemsTraceAuditNumber - A unique number assigned to the transaction for tracking purposes.  
# + DateAndTimeLocalTransaction - The local date and time at the point of transaction.  
# + DateConversion - The date of the conversion.
# + MessageErrorIndicator - The message error indicator of the transaction.
# + TransactionLifeCycleIdentificationData - The transaction life cycle identification data.  
# + DateReconciliation - The date of the reconciliation.
# + ReconciliationIndicator - The reconciliation indicator of the transaction.
# + AcquiringInstitutionIdentificationCode - The identification code of the acquiring institution.  
# + ForwardingInstitutionIdentificationCode - The identification code of the forwarding institution.  
# + ApprovalCode - The approval code of the transaction.
# + ActionCode - The action code of the transaction.
# + CardAcceptorTerminalIdentification - The identification code of the terminal where the card was accepted.  
# + CardAcceptorIdentificationCode - The identification code of the card accepter.  
# + AmountsFees - The amount of the transaction fees.
# + TransportData - The transport data of the transaction.
# + ReceivingInstitutionIdentificationCode - The identification code of the receiving institution.

public type MTI_230 record {|
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
            message: "Only numeric values allowed for AmountReconciliation"
        }
    }
    string AmountReconciliation?;
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
            message: "Only numeric values allowed for ConversionRateReconciliation"
        }
    }
    string ConversionRateReconciliation?;
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
            message: "Only numeric values allowed for DateAndTimeLocalTransaction"
        }
    }
    string DateAndTimeLocalTransaction;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for DateConversion"
        }
    }
    string DateConversion?;
    string MessageErrorIndicator?;
    string TransactionLifeCycleIdentificationData?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for DateReconciliation"
        }
    }
    string DateReconciliation?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for ReconciliationIndicator"
        }
    }
    string ReconciliationIndicator?;
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
    string RetrievalReferenceNumber?;
    string ApprovalCode?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for ActionCode"
        }
    }
    string ActionCode;
    string CardAcceptorTerminalIdentification?;
    string CardAcceptorIdentificationCode?;
    string AmountsFees?;
    string TransportData?;
    string ReceivingInstitutionIdentificationCode?;
|};

# MTI 240 - Financial Presentment Notification Request.
# The `MTI_240` record represents a financial presentment notification in the ISO 8583 standard.
#
# + MTI - The message type indicator (MTI) of the transaction.  
# + PrimaryAccountNumber - The primary account number (PAN) of the cardholder.  
# + ProcessingCode - A code indicating the type of transaction being performed.  
# + AmountTransaction - The amount of the transaction.  
# + AmountReconciliation - The amount of the reconciliation.
# + DateAndTimeTransmission - The date and time when the transaction was initiated.  
# + ConversionRateReconciliation - The conversion rate for reconciliation.
# + ConversionRateCardholderBilling - The conversion rate for cardholder billing.  
# + SystemsTraceAuditNumber - A unique number assigned to the transaction for tracking purposes.  
# + DateAndTimeLocalTransaction - The local date and time at the point of transaction.  
# + DateEffective - The effective date of the transaction.  
# + DateExpiration - The expiration date of the transaction.  
# + DateConversion - The date of the conversion.
# + DateCapture - The date when the transaction was captured.  
# + TransactionLifeCycleIdentificationData - The transaction life cycle identification data.  
# + POSDataCode - The point of service (POS) data code.  
# + CardSequenceNumber - The sequence number of the card.  
# + FunctionCode - The function code of the transaction.  
# + MessageReasonCode - The reason code of the message.  
# + MerchantCategoryCode - The category code of the merchant.  
# + DateReconciliation - The date of the reconciliation.
# + ReconciliationIndicator - The reconciliation indicator of the transaction.
# + AmountsOriginal - The original amount of the transaction.  
# + AcquiringInstitutionIdentificationCode - The identification code of the acquiring institution.  
# + ForwardingInstitutionIdentificationCode - The identification code of the forwarding institution.  
# + Track2Data - The track 2 data of the card.  
# + Track3Data - The track 3 data of the card.  
# + ApprovalCode - The approval code of the transaction.  
# + ActionCode - The action code of the transaction.  
# + ServiceCode - The service code of the transaction.  
# + CardAcceptorTerminalIdentification - The identification code of the terminal where the card was accepted.  
# + CardAcceptorIdentificationCode - The identification code of the card accepter.  
# + CardAcceptorNameLocation - The name and location of the card accepter.  
# + Track1Data - The track 1 data of the card.  
# + AmountsFees - The amount of the transaction fees.  
# + AuthorizingAgentInstitutionIdentificationCode - The identification code of the authorizing agent.  
# + FileTransferMessageControl - The file transfer message control.
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
            message: "Only numeric values allowed for AmountReconciliation"
        }
    }
    string AmountReconciliation?;
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
            message: "Only numeric values allowed for ConversionRateReconciliation"
        }
    }
    string ConversionRateReconciliation?;
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
            message: "Only numeric values allowed for DateAndTimeLocalTransaction"
        }
    }
    string DateAndTimeLocalTransaction;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for DateEffective"
        }
    }
    string DateEffective?;
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
    string TransactionLifeCycleIdentificationData?;
    string POSDataCode?;
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
            message: "Only numeric values allowed for FunctionCode"
        }
    }
    string FunctionCode;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for MessageReasonCode"
        }
    }
    string MessageReasonCode;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for MerchantCategoryCode"
        }
    }
    string MerchantCategoryCode?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for DateReconciliation"
        }
    }
    string DateReconciliation?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for ReconciliationIndicator"
        }
    }
    string ReconciliationIndicator?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for AmountsOriginal"
        }
    }
    string AmountsOriginal?;
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
    string ApprovalCode?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for ActionCode"
        }
    }
    string ActionCode;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for ServiceCode"
        }
    }
    string ServiceCode?;
    string CardAcceptorTerminalIdentification?;
    string CardAcceptorIdentificationCode?;
    string CardAcceptorNameLocation?;
    string Track1Data?;
    string AmountsFees?;
    string AuthorizingAgentInstitutionIdentificationCode?;
    string FileTransferMessageControl?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for ReceivingInstitutionIdentificationCode"
        }
    }
    string ReceivingInstitutionIdentificationCode?;
|};

# MTI 250 - Financial Presentment Notification Acknowledgement Request.
# The `MTI_250` record represents a financial presentment notification acknowledgement in the ISO 8583 standard.
#
# + MTI - The message type indicator (MTI) of the transaction.  
# + SystemsTraceAuditNumber - A unique number assigned to the transaction for tracking purposes.  
# + TransactionLifeCycleIdentificationData - The transaction life cycle identification data.  
# + FileTransferMessageControl - The file transfer message control.

public type MTI_0250 record {|
    string MTI = "250";
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for SystemsTraceAuditNumber"
        }
    }
    string SystemsTraceAuditNumber;
    string TransactionLifeCycleIdentificationData?;
    string FileTransferMessageControl?;
|};

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

# Create ISO Error.
#
# + message - error message
# + errorCode - error code
# + return - return isoError
public isolated function createISOError(string message, string? errorCode = ()) returns ISOError {
    ISOError isoError = {
        message: message,
        errorCode: errorCode
    };
    return isoError;
}

# ISO Error model.
#
# + message - error message
# + errorCode - error code
public type ISOError record {
    string message;
    string? errorCode = ();
};

// Copyright 2024 [name of copyright owner]

// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at

//     http://www.apache.org/licenses/LICENSE-2.0

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// Ballerina error type for `io.ballerinax.iso8583.ISO8583Exception`.

public const ISO8583EXCEPTION = "ISO8583Exception";

type ISO8583ExceptionData record {
    string message;
};

public type ISO8583Exception distinct error<ISO8583ExceptionData>;


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

import financial.iso8583.java.lang as javalang;

import ballerina/jballerina.java;

# Ballerina class mapping for the Java `io.ballerinax.iso8583.ISO8583ParserUtil` class.
@java:Binding {'class: "io.ballerinax.iso8583.ISO8583ParserUtil"}
public distinct class ISO8583ParserUtil {

    *java:JObject;
    *javalang:Object;

    # The `handle` field that stores the reference to the `io.ballerinax.iso8583.ISO8583ParserUtil` object.
    public handle jObj;

    # The init function of the Ballerina class mapping the `io.ballerinax.iso8583.ISO8583ParserUtil` Java class.
    #
    # + obj - The `handle` value containing the Java reference of the object.
    public function init(handle obj) {
        self.jObj = obj;
    }

    # The function to retrieve the string representation of the Ballerina class mapping the `io.ballerinax.iso8583.ISO8583ParserUtil` Java class.
    #
    # + return - The `string` form of the Java object instance.
    public function toString() returns string {
        return java:toString(self.jObj) ?: "";
    }

    # The function that maps to the `equals` method of `io.ballerinax.iso8583.ISO8583ParserUtil`.
    #
    # + arg0 - The `javalang:Object` value required to map with the Java method parameter.
    # + return - The `boolean` value returning from the Java mapping.
    public function 'equals(javalang:Object arg0) returns boolean {
        return io_ballerinax_iso8583_ISO8583ParserUtil_equals(self.jObj, arg0.jObj);
    }

    # The function that maps to the `getClass` method of `io.ballerinax.iso8583.ISO8583ParserUtil`.
    #
    # + return - The `javalang:Class` value returning from the Java mapping.
    public function getClass() returns javalang:Class {
        handle externalObj = io_ballerinax_iso8583_ISO8583ParserUtil_getClass(self.jObj);
        javalang:Class newObj = new (externalObj);
        return newObj;
    }

    # The function that maps to the `hashCode` method of `io.ballerinax.iso8583.ISO8583ParserUtil`.
    #
    # + return - The `int` value returning from the Java mapping.
    public function hashCode() returns int {
        return io_ballerinax_iso8583_ISO8583ParserUtil_hashCode(self.jObj);
    }

    # The function that maps to the `notify` method of `io.ballerinax.iso8583.ISO8583ParserUtil`.
    public function notify() {
        io_ballerinax_iso8583_ISO8583ParserUtil_notify(self.jObj);
    }

    # The function that maps to the `notifyAll` method of `io.ballerinax.iso8583.ISO8583ParserUtil`.
    public function notifyAll() {
        io_ballerinax_iso8583_ISO8583ParserUtil_notifyAll(self.jObj);
    }

    # The function that maps to the `wait` method of `io.ballerinax.iso8583.ISO8583ParserUtil`.
    #
    # + return - The `javalang:InterruptedException` value returning from the Java mapping.
    public function 'wait() returns javalang:InterruptedException? {
        error|() externalObj = io_ballerinax_iso8583_ISO8583ParserUtil_wait(self.jObj);
        if (externalObj is error) {
            javalang:InterruptedException e = error javalang:InterruptedException(javalang:INTERRUPTEDEXCEPTION, externalObj, message = externalObj.message());
            return e;
        }
    }

    # The function that maps to the `wait` method of `io.ballerinax.iso8583.ISO8583ParserUtil`.
    #
    # + arg0 - The `int` value required to map with the Java method parameter.
    # + return - The `javalang:InterruptedException` value returning from the Java mapping.
    public function wait2(int arg0) returns javalang:InterruptedException? {
        error|() externalObj = io_ballerinax_iso8583_ISO8583ParserUtil_wait2(self.jObj, arg0);
        if (externalObj is error) {
            javalang:InterruptedException e = error javalang:InterruptedException(javalang:INTERRUPTEDEXCEPTION, externalObj, message = externalObj.message());
            return e;
        }
    }

    # The function that maps to the `wait` method of `io.ballerinax.iso8583.ISO8583ParserUtil`.
    #
    # + arg0 - The `int` value required to map with the Java method parameter.
    # + arg1 - The `int` value required to map with the Java method parameter.
    # + return - The `javalang:InterruptedException` value returning from the Java mapping.
    public function wait3(int arg0, int arg1) returns javalang:InterruptedException? {
        error|() externalObj = io_ballerinax_iso8583_ISO8583ParserUtil_wait3(self.jObj, arg0, arg1);
        if (externalObj is error) {
            javalang:InterruptedException e = error javalang:InterruptedException(javalang:INTERRUPTEDEXCEPTION, externalObj, message = externalObj.message());
            return e;
        }
    }

}

# The constructor function to generate an object of `io.ballerinax.iso8583.ISO8583ParserUtil`.
#
# + return - The new `ISO8583ParserUtil` class generated.
public function newISO8583ParserUtil1() returns ISO8583ParserUtil {
    handle externalObj = io_ballerinax_iso8583_ISO8583ParserUtil_newISO8583ParserUtil1();
    ISO8583ParserUtil newObj = new (externalObj);
    return newObj;
}

# The function that maps to the `generateISOMessage` method of `io.ballerinax.iso8583.ISO8583ParserUtil`.
#
# + arg0 - The `string` value required to map with the Java method parameter.
# + return - The `string` or the `ISO8583Exception` value returning from the Java mapping.
public isolated function ISO8583ParserUtil_generateISOMessage(string arg0) returns string|ISO8583Exception {
    handle|error externalObj = io_ballerinax_iso8583_ISO8583ParserUtil_generateISOMessage(java:fromString(arg0));
    if (externalObj is error) {
        ISO8583Exception e = error ISO8583Exception(ISO8583EXCEPTION, externalObj, message = externalObj.message());
        return e;
    } else {
        return java:toString(externalObj) ?: "";
    }
}

# The function that maps to the `unpackISOMessage` method of `io.ballerinax.iso8583.ISO8583ParserUtil`.
#
# + arg0 - The `string` value required to map with the Java method parameter.
# + return - The `string` or the `ISO8583Exception` value returning from the Java mapping.
public isolated function ISO8583ParserUtil_unpackISOMessage(string arg0) returns string|ISO8583Exception {
    handle|error externalObj = io_ballerinax_iso8583_ISO8583ParserUtil_unpackISOMessage(java:fromString(arg0));
    if (externalObj is error) {
        ISO8583Exception e = error ISO8583Exception(ISO8583EXCEPTION, externalObj, message = externalObj.message());
        return e;
    } else {
        return java:toString(externalObj) ?: "";
    }
}

function io_ballerinax_iso8583_ISO8583ParserUtil_equals(handle receiver, handle arg0) returns boolean = @java:Method {
    name: "equals",
    'class: "io.ballerinax.iso8583.ISO8583ParserUtil",
    paramTypes: ["java.lang.Object"]
} external;

isolated function io_ballerinax_iso8583_ISO8583ParserUtil_generateISOMessage(handle arg0) returns handle|error = @java:Method {
    name: "generateISOMessage",
    'class: "io.ballerinax.iso8583.ISO8583ParserUtil",
    paramTypes: ["java.lang.String"]
} external;

function io_ballerinax_iso8583_ISO8583ParserUtil_getClass(handle receiver) returns handle = @java:Method {
    name: "getClass",
    'class: "io.ballerinax.iso8583.ISO8583ParserUtil",
    paramTypes: []
} external;

function io_ballerinax_iso8583_ISO8583ParserUtil_hashCode(handle receiver) returns int = @java:Method {
    name: "hashCode",
    'class: "io.ballerinax.iso8583.ISO8583ParserUtil",
    paramTypes: []
} external;

function io_ballerinax_iso8583_ISO8583ParserUtil_notify(handle receiver) = @java:Method {
    name: "notify",
    'class: "io.ballerinax.iso8583.ISO8583ParserUtil",
    paramTypes: []
} external;

function io_ballerinax_iso8583_ISO8583ParserUtil_notifyAll(handle receiver) = @java:Method {
    name: "notifyAll",
    'class: "io.ballerinax.iso8583.ISO8583ParserUtil",
    paramTypes: []
} external;

isolated function io_ballerinax_iso8583_ISO8583ParserUtil_unpackISOMessage(handle arg0) returns handle|error = @java:Method {
    name: "unpackISOMessage",
    'class: "io.ballerinax.iso8583.ISO8583ParserUtil",
    paramTypes: ["java.lang.String"]
} external;

function io_ballerinax_iso8583_ISO8583ParserUtil_wait(handle receiver) returns error? = @java:Method {
    name: "wait",
    'class: "io.ballerinax.iso8583.ISO8583ParserUtil",
    paramTypes: []
} external;

function io_ballerinax_iso8583_ISO8583ParserUtil_wait2(handle receiver, int arg0) returns error? = @java:Method {
    name: "wait",
    'class: "io.ballerinax.iso8583.ISO8583ParserUtil",
    paramTypes: ["long"]
} external;

function io_ballerinax_iso8583_ISO8583ParserUtil_wait3(handle receiver, int arg0, int arg1) returns error? = @java:Method {
    name: "wait",
    'class: "io.ballerinax.iso8583.ISO8583ParserUtil",
    paramTypes: ["long", "int"]
} external;

function io_ballerinax_iso8583_ISO8583ParserUtil_newISO8583ParserUtil1() returns handle = @java:Constructor {
    'class: "io.ballerinax.iso8583.ISO8583ParserUtil",
    paramTypes: []
} external;


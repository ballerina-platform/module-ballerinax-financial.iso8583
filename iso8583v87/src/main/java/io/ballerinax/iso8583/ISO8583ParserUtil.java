/*
 * Copyright 2024 [name of copyright owner]
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package io.ballerinax.iso8583;

import io.ballerinax.iso8583.util.ISO8583Constant;
import org.jpos.iso.ISOException;
import org.jpos.iso.ISOMsg;
import org.jpos.iso.packager.GenericPackager;
import org.json.JSONObject;

import java.nio.charset.StandardCharsets;

/**
 * ISO8583 Parser Util.
 * <p>
 * This class contains the methods to parse and generate ISO 8583 messages.
 */
public class ISO8583ParserUtil {

    private static volatile GenericPackager packager;

    /**
     * Unpack the ISO message and transform to an XML.
     *
     * @param message ISO message.
     * @return Json string of the iso message.
     */
    public static String unpackISOMessage(String message) throws ISO8583Exception {

        ISOMsg isoMsg = new ISOMsg();
        isoMsg.setPackager(getIsoPackager());
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
     * @return ISO message.
     */
    public static String generateISOMessage(String jsonPayload) throws ISO8583Exception {

        JSONObject isoJson = new JSONObject(jsonPayload);
        byte[] responseMessage;
        ISOMsg isoMsg = new ISOMsg();
        isoMsg.setPackager(getIsoPackager());

        try {
            isoJson.keySet().forEach(key -> {
                String elementValue = isoJson.getString(key);
                int fieldID = Integer.parseInt(ISO8583Constant.ISO8583_NAME_IDS.get(key));
                isoMsg.set(fieldID, elementValue);
            });
            responseMessage = isoMsg.pack();
            return new String(responseMessage, StandardCharsets.UTF_8);
        } catch (NumberFormatException e) {
            throw new ISO8583Exception("The fieldID does not contain a parsable integer" + e.getMessage(), e);
        } catch (ISOException e) {
            throw new ISO8583Exception("Couldn't pack ISO8583 Message. " + e.getMessage(), e);
        }
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
                String dataElement = ISO8583Constant.ISO8583_ID_NAMES.get(String.valueOf(i));
                String value = isoMsg.getString(i);
                if (dataElement != null) {
                    payloadJson.put(dataElement, value);
                } else {
                    throw new ISO8583Exception("Unknown ISO8583 field id: " + i);
                }
            }
        }
        return payloadJson.toString();
    }

    private static GenericPackager getIsoPackager() throws ISO8583Exception {

        if (packager == null) {
            try {
                ClassLoader loader = Thread.currentThread().getContextClassLoader();
                packager = new GenericPackager(loader.getResourceAsStream(ISO8583Constant.PACKAGER_V_87));
            } catch (ISOException e) {
                throw new ISO8583Exception("Error occurred while loading the packager file", e);
            }
        }
        return packager;
    }
}

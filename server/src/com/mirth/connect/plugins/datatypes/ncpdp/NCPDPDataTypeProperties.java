/*
 * Copyright (c) Mirth Corporation. All rights reserved.
 * 
 * http://www.mirthcorp.com
 * 
 * The software in this package is published under the terms of the MPL license a copy of which has
 * been included with this distribution in the LICENSE.txt file.
 */

package com.mirth.connect.plugins.datatypes.ncpdp;

import java.util.HashMap;
import java.util.Map;

import com.mirth.connect.donkey.util.DonkeyElement;
import com.mirth.connect.model.datatype.DataTypeProperties;

public class NCPDPDataTypeProperties extends DataTypeProperties {

    public NCPDPDataTypeProperties() {
        serializationProperties = new NCPDPSerializationProperties();
        deserializationProperties = new NCPDPDeserializationProperties();
        batchProperties = new NCPDPBatchProperties();
    }

    // @formatter:off
    @Override public void migrate3_0_1(DonkeyElement element) {}
    @Override public void migrate3_0_2(DonkeyElement element) {} // @formatter:on

    @Override
    public void migrate3_1_0(DonkeyElement element) {
        DonkeyElement batchElement = element.addChildElementIfNotExists("batchProperties");

        batchElement.setAttribute("class", "com.mirth.connect.plugins.datatypes.ncpdp.NCPDPBatchProperties");
        batchElement.addChildElementIfNotExists("splitType", "JavaScript");
        batchElement.addChildElementIfNotExists("batchScript");
    }

    // @formatter:off
    @Override public void migrate3_2_0(DonkeyElement element) {}
    @Override public void migrate3_3_0(DonkeyElement element) {}
    @Override public void migrate3_4_0(DonkeyElement element) {}
    @Override public void migrate3_5_0(DonkeyElement element) {}
    @Override public void migrate3_6_0(DonkeyElement element) {}
    @Override public void migrate3_7_0(DonkeyElement element) {}
    @Override public void migrate3_9_0(DonkeyElement element) {}
    @Override public void migrate3_11_0(DonkeyElement element) {}
    @Override public void migrate3_11_1(DonkeyElement element) {} // @formatter:on

    @Override
    public Map<String, Object> getPurgedProperties() {
        Map<String, Object> purgedProperties = new HashMap<String, Object>();
        purgedProperties.put("serializationProperties", serializationProperties.getPurgedProperties());
        purgedProperties.put("deserializationProperties", deserializationProperties.getPurgedProperties());
        purgedProperties.put("batchProperties", batchProperties.getPurgedProperties());
        return purgedProperties;
    }
}

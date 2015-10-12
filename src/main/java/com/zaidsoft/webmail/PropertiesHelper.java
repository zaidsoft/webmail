/*
 * Copyright 2015 ZAIDSOFT. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
/*
 * Initially Created on July 29, 2003, 6:13 PM
 */
package com.zaidsoft.webmail;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 *
 * @author DevTeam Zaidsoft <info@zaidsoft.com>
 *
 */
public class PropertiesHelper {

    static final String fileName = "webmail.properties";
    static final Properties props = new Properties();

    static {
        try {
            InputStream in = PropertiesHelper.class.getResourceAsStream("../../../" + fileName);
            props.load(in);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * Creates new PropertiesHelper
     */
    public PropertiesHelper() {

    }

    public static String getProperty(String key) {
        return props.getProperty(key);
    }

    public static int getIntProperty(String key) {
        return Integer.parseInt(getProperty(key));
    }

    public static boolean getBooleanProperty(String key) {
        return Boolean.valueOf(getProperty(key));
    }

    public static void main(String[] s) {
        System.out.println(getBooleanProperty("useLocalStore"));
    }

}

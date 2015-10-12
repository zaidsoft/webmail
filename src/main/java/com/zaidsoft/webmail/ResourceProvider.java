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

package com.zaidsoft.webmail;

import java.io.File;
import java.net.URL;

/**
 *
 * @author DevTeam Zaidsoft <info@zaidsoft.com>
 */
public class ResourceProvider {

    static String sep = File.separator;

    public static URL getResource(String dir, String file) {
        String name = ".." + sep + "WEBMAIL-DATA" + sep + dir + sep + file;
        URL u = ResourceProvider.class.getResource(name);
        return u;
    }

    public static String getResourceFilePath(String dir, String file) {
        return getResourceFilePath("WEBMAIL-DATA", dir, file);
    }

    public static String getResourceFilePath(String masterDir, String dir, String file) {
        String name = getDocumentRootPath() + sep + masterDir + sep + dir + sep + file;
        return name;
    }

    /**
     * returns the document root path of the application.
     *
     * @return document root path
     */
    public static String getDocumentRootPath() {
        String className = "ResourceProvider.class";
        String path;
        URL u = ResourceProvider.class.getResource(className);

        String p = u.getPath();
        // remove the className from the path and add name
        path = p.substring(0, p.lastIndexOf(className));
        if (sep.equals("\\")) {
            path = path.replace('/', '\\');
        }
        int k = path.lastIndexOf(sep + "classes");
        path = path.substring(0, k);
        return path;
    }

}

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
package com.zaidsoft.net;

import java.net.MalformedURLException;
import java.net.URL;
import java.util.StringTokenizer;

/**
 *
 * @author DevTeam Zaidsoft <info@zaidsoft.com>
 *
 */
public class MiscUtils {

    /**
     * Relativize the child url w.r.t. the base url.
     */
    public static String relativize(String base, String child) {
        String cd = child.trim().toLowerCase();
        try {
            URL b = new URL(base);
            if (cd.startsWith("http://")) {
                URL c = new URL(child);
                // If the hosts are different simply return child

                if (!b.getProtocol().equalsIgnoreCase(c.getProtocol())
                        || !b.getAuthority().equals(c.getAuthority())) {
                    return child;
                }

                // modify the child and base for further processing
                int d = child.indexOf("/", 8);
                if (d == -1) {
                    child = "/";
                } else {
                    child = child.substring(d);
                }
                //child = c.getPath() + "?" + c.getQuery() + "#" + c.getRef();
            }

            // if the second url starts with 
            if (child.startsWith("/")) {
                base = b.getPath();
                System.out.println(base + " : " + child);
                StringTokenizer stBase = new StringTokenizer(base, "/");
                StringTokenizer stChild = new StringTokenizer(child, "/");
                int nBase = stBase.countTokens() - 1; // excld the leading '/'
                int nMatched = 0;
                boolean bb = false;
                StringBuilder relChild = new StringBuilder();
                while (stChild.hasMoreTokens()) {
                    String tC = stChild.nextToken();
                    if (stBase.hasMoreTokens()) {
                        String tB = stBase.nextToken();
                        //System.out.println( ">>" + tB + "<<>>" + tC + "<<");
                        if (tB.equals(tC)) {
                            nMatched++;
                            continue;
                        }
                    }
                    // insert a "/" except first Time
                    if (bb) {
                        relChild.append("/");
                    } else {
                        bb = true;
                    }

                    relChild.append(tC);
                }
                //System.out.println( nBase + " >> " + nMatched);
                for (int i = 0; i < nBase - nMatched; i++) {
                    relChild.insert(0, "../");
                }

                return relChild.toString();
            }
        } catch (MalformedURLException e) {
            return child;
        }
        // otherwise simply return the child
        return child;
    }

    public String relativizeAllURLs(String htmlPage, String baseURL) {
        return "";
    }

    public static void main(String[] s) throws Exception {
        String ss = relativize("http://z.com/services/webBased2/ms/home.html?hi=fi", "http://z.com/index.html?q=XYZ#21");
        System.out.println(ss);
    }

}

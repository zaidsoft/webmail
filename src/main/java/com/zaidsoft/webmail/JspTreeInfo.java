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
 * Initially Created on December 1, 2001, 12:11 AM
 */
package com.zaidsoft.webmail;

/**
 * Implementor of this interface may be represented as collapsible list on a
 * page that includes the given jsp content.The content is available as a div
 * tag. The jsp page can be included in any web/jsp page. The implementor of
 * this interface is called to provide tree information.
 *
 * This provides a mechanism to quickly ad tree like functionality in any web
 * page which extracts data from some server side java object. An example tree
 * is
 *
 * World USA CA 
 *
 * Now, the root that is World may be represented by a simple char i.e., "/" the
 * new Delhi will be :- "/India/New Delhi" and USA will be "/USA".
 */
public interface JspTreeInfo {

    /**
     * The String which is to be displayed for Root Node.
     *
     * @return root name
     */
    public String rootName();

    public char getSeperator();

    /**
     * When called, this method returns the list of the nodes under given node.
     * Only nodes one level deep are listed. May be called with separator to get
     * children under root.
     */
    public String[] list(String nodeFulName);

}

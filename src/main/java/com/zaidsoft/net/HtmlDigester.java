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
 * Initially Created on August 19, 2003, 2:04 PM
 */
package com.zaidsoft.net;

import java.io.IOException;
import java.io.InputStream;
import java.io.StringReader;
import java.net.URL;
import javax.swing.text.html.parser.ParserDelegator;
import javax.swing.text.html.HTMLEditorKit;
import javax.swing.text.html.HTML;
import javax.swing.text.MutableAttributeSet;

/**
 *
 * @author DevTeam Zaidsoft <info@zaidsoft.com>
 *
 */
public class HtmlDigester {

    String html;

    StringReader reader;

    String title;
    String body;
    String head;
    String text = "";

    public HtmlDigester(URL url) {
        StringBuilder buf = new StringBuilder();
        // print the Heder of the HTML page of the current portal
        try {
            // open the stream
            InputStream in = url.openStream();
            int ch;
            while ((ch = in.read()) != -1) {
                buf.append((char) ch);
            }
            in.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        html = buf.toString();
        parse();
    }

    public HtmlDigester(String html) {
        this.html = html;
        parse();
    }

    public String getHtml() {
        return html;
    }

    public String getBody() {
        return body;
    }

    public String getTitle() {
        return title;
    }

    public String getText() {
        return text;
    }

    private void parse() {
        reader = new StringReader(html);
        // parse the reader to get title
        HTMLEditorKit.ParserCallback callback
                = new HTMLEditorKit.ParserCallback() {

                    boolean titleFound = false;
                    int headInit = 0;
                    int headEnd = 0;
                    int bodyInit = 0;
                    int bodyEnd = 0;
                    boolean bodyFound = false;

                    public void handleText(char[] data, int pos) {
                        String t = String.valueOf(data);
                        if (titleFound) {
                            title = t;
                            titleFound = false;
                        }
                        if (bodyFound && t != null) {
                            text = text + "\r\n" + String.valueOf(data);
                        }
                    }

                    public void handleStartTag(HTML.Tag tag,
                            MutableAttributeSet attrSet, int pos) {
                        if (tag == HTML.Tag.TITLE) {
                            titleFound = true;
                        }
                        if (tag == HTML.Tag.HEAD) {
                            headInit = pos;
                        }
                        if (tag == HTML.Tag.BODY) {
                            bodyFound = true;
                            bodyInit = pos;
                        }

                    }

                    public void handleEndTag(HTML.Tag tag,
                            int pos) {
                        //System.out.println("end of " + tag + " found");
                        if (tag == HTML.Tag.HEAD) {
                            headEnd = pos;
                            head = html.substring(headInit, headEnd);
                        }
                        if (tag == HTML.Tag.BODY) {
                            bodyEnd = pos;
                            body = html.substring(bodyInit, bodyEnd);
                        }
                    }

                };

        try {
            new ParserDelegator().parse(reader, callback, true);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] s) throws Exception {
        String url = "http://oss.zaidsoft.com/index.html";
        HtmlDigester d = new HtmlDigester(new URL(url));
        System.out.println("text: " + d.getText());
        System.out.println("body: " + d.getBody());

    }
}

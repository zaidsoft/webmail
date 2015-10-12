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
 * Initially Created on March 9, 2003, 5:35 PM
 */
package com.zaidsoft.net;

import java.io.IOException;
import java.io.Reader;
import java.util.Vector;
import javax.swing.text.html.parser.ParserDelegator;
import javax.swing.text.html.HTMLEditorKit;
import javax.swing.text.html.HTML;
import javax.swing.text.MutableAttributeSet;

/**
 * Relativizes all links in the page with respect to the base URl given
 *
 * @author DevTeam Zaidsoft <info@zaidsoft.com>
 *
 */
public class HTMLPageRelativizer {

    final Vector v = new Vector();
    String html = null;
    String baseURL = null;

    public HTMLPageRelativizer(String html, String baseURL) {
        this.html = html;
        this.baseURL = baseURL;
    }

    public class PosWrapper {

        int pos;
        String url;

        PosWrapper(int p, String s) {
            //System.out.println("New creation " + p + " " + s);
            pos = p;
            url = s;
        }
    }

    public String relativize() {
        doParse((java.io.Reader) new java.io.StringReader(html));
        return html;
    }

    private void doParse(Reader reader) {
        HTMLEditorKit.ParserCallback callback
                = new HTMLEditorKit.ParserCallback() {
                    @Override
                    public void handleText(char[] data, int pos) {
                        //System.out.println("Handling Text" + newFormFound + String.valueOf(data));
                        // do nothing...
                    }

                    @Override
                    public void handleStartTag(HTML.Tag tag,
                            MutableAttributeSet attrSet, int pos) {
                        if (tag == HTML.Tag.A) {
                            String tAc = (String) attrSet.getAttribute(HTML.Attribute.HREF);
                            // call to relativize...
                            v.add(new PosWrapper(pos, tAc));
                        }
                    }

                    @Override
                    public void handleSimpleTag(HTML.Tag tag,
                            MutableAttributeSet attrSet, int pos) {
                        if (tag == HTML.Tag.IMG) {
                            String tAc = (String) (attrSet.getAttribute(HTML.Attribute.SRC));
                            // call to relativize...
                            v.add(new PosWrapper(pos, tAc));
                        }
                    }

                    @Override
                    public void handleEndTag(HTML.Tag tag, int pos) {
                        if (tag == HTML.Tag.A) {
                            // do nothing...
                        }
                    }
                };

        try {
            new ParserDelegator().parse(reader, callback, true);
        } catch (javax.swing.text.ChangedCharSetException ce) {
            System.err.println(ce.getCharSetSpec());
        } catch (IOException e) {
            e.printStackTrace();
        }

        substitute();
    }

    private void substitute() {
        StringBuffer b = new StringBuffer(html);
        int n = v.size();
        // replace from the last (largest pos to lowest ) so that
        // the pos remains valid thru out 
        for (int i = n - 1; i >= 0; i--) {
            PosWrapper pw = (PosWrapper) v.get(i);
            //System.out.println("Replacing..." + pw.url);
            replace(b, pw.pos, pw.url, MiscUtils.relativize(baseURL, pw.url));
        }
        html = b.toString();
    }

    /**
     * Call this method after calling relativize() to get the relativized
     * version
     *
     */
    public String getHTML() {
        return html;
    }

    /**
     * String replace Method.
     *
     * @param buff the string buffer in which replacement has to be made
     * @param pos the position (index) after which the first occurance has to be
     * replaced
     * @param f the string which will be replaced
     * @param s this is the replacing string
     *
     */
    public void replace(StringBuffer buff, int pos, String f, String s) {
        int n = buff.toString().indexOf(f, pos);
        if (n == -1) {
            return;
        }
        buff.delete(n, n + f.length());
        buff.insert(n, s);
    }

    public static void main(String[] s) throws Exception {
        String page = ""
                + "<html> <head> </head>"
                + "<body>"
                + "<p> Hi there; how are you?"
                + "<a href=http://example.com/index.jsp#mybook>Click Here</a>"
                + "<h2>Hi this is my heading ver nice"
                + "<img src=/jiro>"
                + "<h3>Hi this is my heading ver nice"
                + "<img src=/some/path/parrot.gif?tota_id=1025>"
                + "OK"
                + "Nice</body>"
                + "</html>";
        String ss = new HTMLPageRelativizer(page, "http://example.com/index.jsp/home.html?hi=fi").relativize();
        System.out.println(ss);
    }

}

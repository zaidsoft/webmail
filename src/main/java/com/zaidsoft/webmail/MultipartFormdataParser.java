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
 * Initially Created on July 17, 2001, 10:33 AM
 */
package com.zaidsoft.webmail;

/**
 *
 * @author DevTeam Zaidsoft <info@zaidsoft.com>
 *
 */
import java.io.BufferedInputStream;
import java.io.IOException;
import java.util.Vector;

/**
 * Parses the MIME content of type <b>multipart/form-data</b> and returns the
 * contents of various parts and other attributes of the contents. The class is
 * extended for use with a servlet/jsp, taking data of type
 * "multipart/form-data" from user in POST request. The class provides methods
 * to query about the various parts and also gives info about other header
 * parameters of parts. Since the data is coming from a HTML form, every part's
 * content-desposition is supposed to contain name parameter. The class provides
 * an inner class "Part" to encapsulate a part. This inner class can be queried
 * for file name, name, etc.
 */
public class MultipartFormdataParser {

    // The boundary string as found in content-type header
    String boundaryString;
    // used to strore different feilds
    Vector fields = new Vector();

    // 
    String contentType = null;
    BufferedInputStream contentReader;

    public Vector getParts() {
        return fields;
    }

    public Part getPart(String name) {
        Part p;
        for (int i = 0; i < fields.size(); i++) {
            p = (Part) fields.get(i);
            if (p.getName().equals(name)) {
                return p;
            }
        }
        return null;
    }

    public String getBoundary() {
        return boundaryString;
    }

    /**
     * Creates new MultipartFormdataParser from a Servlet Request. This is the
     * convenient method for a web application based upon servelt / jsp
     * technology.
     *
     * @param request Servlet request object
     * @throws IOException if there is poblem while io.
     */
    public MultipartFormdataParser(javax.servlet.http.HttpServletRequest request) throws IOException {
        contentType = request.getContentType();
        contentReader = new BufferedInputStream(request.getInputStream());
        parse();
    }

    /**
     * Creates new MultipartFormdataParser from a reader The reader may be from
     * the input stream of a web browser or obtained from getReader() of servlet
     * request.
     */
    public MultipartFormdataParser(String contentTypeHeader, BufferedInputStream reader) {
        contentType = contentTypeHeader;
        contentReader = reader;
    }

    /**
     * Creates new MultipartFormdataParser from a String containing
     * multipart/form-data.
     *
     * public MultipartFormdataParser(String data) { }
     */
    /**
     * An inner class encapsulating a simple MIME part. This part has the
     * outlook to provide html form specific details.
     */
    public class Part {

        String name;
        String contentType;
        String fileName;
        boolean isBinary = true;

        String value;
        private String cdString;

        Part(String name, String cT, String fName) {
            this.name = name;
            this.contentType = cT;
            this.fileName = fName;
        }

        Part(String contentDespositionLine) {
            cdString = contentDespositionLine;
            name = getParameter("name");
            fileName = getParameter("filename");
            // Content-Disposition headers
            int p = cdString.indexOf("Content-Disposition");

            if (p == -1) {
                throw new RuntimeException("Multipart Form-data Parser >> No Content-Desposition Header");
            }

            setIfBinary();
        }

        /**
         * Set the content ( value ) of the part. It may be a Form field value
         * or a file content.
         */
        public void setValue(String v) {
            value = v;
        }

        public void setContentTypeLine(String ln) {
            int p = ln.indexOf("Content-Type:");
            if (p != -1) {
                p += "Content-Type:".length();
                contentType = ln.substring(p).trim();
            }

        }

        /**
         * Returns the file name if file parameter is present, null otherwise.
         */
        public String getFileName() {
            return fileName;
        }

        public String getFileNameNoPath() {
            String fName = fileName.replace('\\', '/');
            int k = fName.lastIndexOf('/');
            String f_name = fName;
            if (k != -1) {
                f_name = fName.substring(k + 1);
            }
            return f_name;
        }

        /**
         * Returns the name attribute.
         */
        public String getName() {
            return name;
        }

        /**
         * returns the MIME content-type.
         */
        public String getContentType() {
            return contentType;
        }

        /**
         * Returns the value of the paramter or the contets of the file in the
         * form of a String.
         */
        public String getContent() {
            return value;
        }

        public String getValue() {
            return value;
        }

        /**
         * returns the contents of the file as array of bytes.
         */
        public byte[] getBytes() {
            try {
                return value.getBytes("ISO-8859-1");
            } catch (Exception e) {
            }
            return null;
        }

        /**
         * Returns false if the file parameter exists and the file appears to be
         * non-binary file. Will always return true if file parameter does not
         * exists. The binary file is supposed to be a file that has
         * content-desposition application/octet-stream, or application/whatever
         * or it doesn't have a known ascii file extension e.g., .html, .cgi.
         */
        public boolean isBinaryFile() {
            return isBinary;
        }

        /**
         * Returns if the part doesn't contains anything. A part is considered
         * to be empty if the value is null or the value contains whitespace(s).
         */
        public boolean isEmpty() {
            if (value == null) {
                return true;
            }
            return value.trim().equals("");
        }

        /**
         * Extracts the parameters of a MIME Header content-disposition.
         */
        private String getParameter(String parName) {
            String par = parName + "=\"";
            // Get the field name
            int p = cdString.indexOf(par);
            if (p == -1) {
                return null;
            }
            p += par.length();

            // ... up to the closing quote.
            int q = cdString.indexOf("\"", p);
            if (q == -1) {
                return null;
            }
            return cdString.substring(p, q);
        }

        private void setIfBinary() {
            if (fileName == null) {
                return;
            }
            String[] asciiExt
                    = {".htm", ".html", ".xml", ".csv", ".txt", ".java",
                        ".cpp", ".c", ".pl", ".cgi", ".log", ".css", ".js"
                    };
            ////////////////
            for (int i = 0; i < asciiExt.length; i++) {
                if (fileName.toLowerCase().endsWith(asciiExt[i])) {
                    isBinary = false;
                    return;
                }
            }

        }

        public String toString() {
            String s = "";
            s += "name= " + getName() + "->";
            s += "value= " + getValue() + "->";
            s += "fileName= " + getFileName();
            return s;
        }

    }

    private void parse() throws IOException {
        // Verify the content type
        String ct = contentType;
        if (!ct.startsWith("multipart/form-data")) {
            throw new RuntimeException("Multipart Form-data Parser >> Invalid content-type");
        }

        // Get the boundary string
        int p = ct.indexOf("boundary=");
        if (p == -1) {
            throw new RuntimeException("Multipart Form-data Parser >> No boundary string found");
        }

        p += "boundary=".length();

        boundaryString = ct.substring(p);
        String boundary = "--" + ct.substring(p);
        String finalBoundary = boundary + "--";

         // We'll parse the multipart/form-data
        // with a finite state machine
         // Define names for the parser states
        final int INIT = 0;
        final int READING_HEADERS = 1;
        final int READING_DATA = 2;

        int state = INIT;

        // Read and extract the fields
        String name = null;
        Part part = null;
        String value = null;
        String lineTerminator = "\n";
        String prevLineTerminator = "";
        StringBuffer b;
        boolean crHeld = false; // '\r' is found but has not been added to b
        main:
        for (;;) {
            /* We want to read a line,
             * but we can't use readLine() method of reader since it returns a line 
             * in cases when the terminating chars are '\r', '\n', or a combination of these.
             * And once u read the line, there is no way to find what the line terminating char was.
             * We need line term. char(s) since we have to reconstruct the "binay files" ( if it is so ) and everything should be
             * kept intact for it.
             * Hence we are going to read a line in generic way..
             * For simplicity we will terminate our lines only on finding "\n";
             */
            b = new StringBuffer();
            char c;
            int i = 0;
            while (true) {
                c = (char) contentReader.read();
                //System.out.println(">> :" + c+ " " + i);
                if (c == '\r') {
                    // if we have already held ad a '\r'
                    if (crHeld) {
                        b.append('\r');
                    }
                    crHeld = true;
                    continue;
                }
                if (c == '\n') {
                    if (crHeld) {
                        lineTerminator = "\r\n";
                        crHeld = false;
                        break;
                    } else {
                        lineTerminator = "\n";
                        break;
                    }
                } else {
                    // we are not goint ot break so if CR is held add it 
                    if (crHeld) {
                        b.append('\r');
                    }
                }
                b.append(c);
                crHeld = false;
            }

            String line = b.toString();
            if (line == null) {
                break;
            }

            switch (state) {
               // State 0: Ignoring everything before
                // the first boundary
                case INIT:
                    if (line.startsWith(finalBoundary)) {
                        break main;
                    }
                    if (line.startsWith(boundary)) {
                        state = READING_HEADERS;
                        part = null;
                        value = "";
                    }
                    break;

                // State 1: Parsing the headers
                case READING_HEADERS:
                    if (line.length() == 0) {
                        state = READING_DATA;
                    } else {
                     // We are only interested in the
                        // Content-Disposition and content-type headers
                        p = line.indexOf("Content-Disposition");
                        if (p != -1) {
                            p += "Content-Disposition".length();
                            part = new Part(line);
                        } else {
                            // now for Content-type
                            p = line.indexOf("Content-Type");
                            if (p == -1) {
                                break;
                            }
                            p += "Content-Type".length();
                            part.setContentTypeLine(line);
                        }

                        prevLineTerminator = "";
                        value = "";
                    }
                    break;

                // State 2: Reading the data
                case READING_DATA:
                    if (line.startsWith(finalBoundary)) {
                        part.setValue(value);
                        fields.add(part);
                        break main;
                    }
                    if (line.startsWith(boundary)) {
                        part.setValue(value);
                        fields.add(part);
                        state = READING_HEADERS;
                    } else {
                     // we are using prev line terminator since browser would have added
                        // a '\n' in the last line of the part ( natural ) but this is not part of the
                        // part value. So this should not be added
                        line += prevLineTerminator;
                        prevLineTerminator = lineTerminator;
                        value += line;
                        //System.out.println("Adding line : " + lineTerminator.length() + " LINE>" + line + "<" );
                    }
                    break;
            }
        }

    }
}

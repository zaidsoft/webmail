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

import java.io.IOException;
import java.io.OutputStream;
import javax.mail.MessagingException;
import javax.mail.internet.ContentType;
import javax.servlet.ServletConfig; 
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author DevTeam Zaidsoft <info@zaidsoft.com>
 */
public class AttachmentProviderServlet extends HttpServlet {

    public void init(ServletConfig config) throws ServletException {
        super.init(config);
    }

    //Process the HTTP Get request
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String msgID = request.getParameter("msgID");
        String partIndex = request.getParameter("partIndex");
        //int index  = Integer.parseInt(msgIndex);
        int pIndex = Integer.parseInt(partIndex);

        HttpSession session = request.getSession(false);

        try {

            MimeMessageHandler msgHandler = (MimeMessageHandler) session.getAttribute("msgHandler" + msgID);
            if (msgHandler == null) {
                return;
            }

            javax.mail.Part part = msgHandler.getAttachment(pIndex);
            ContentType ct = new ContentType(part.getContentType());

            //System.err.println("AA: " + part.getContentType());
            response.setContentType(ct.getBaseType());

            String partFileName = part.getFileName();
            if (partFileName != null) {
                response.setHeader("Content-Disposition", "attachment; filename=\"" + partFileName + "\"");
            }

            java.io.InputStream is = part.getInputStream();
            //PrintWriter out = new PrintWriter (response.getOutputStream());
            OutputStream out = response.getOutputStream();
            int i;
            while ((i = is.read()) != -1) {
                out.write(i);
            }
            out.flush();
            out.close();
        } catch (MessagingException me) {
            // Handle messaging exception
            // TODO: Properly handle this exception.
            // It is bad practice to eat it.
        }
    }

}

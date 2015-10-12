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
 * Initially Created on December 1, 2001, 5:58 PM
 */
package com.zaidsoft.webmail;

import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Part;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

/**
 *
 * @author DevTeam Zaidsoft <info@zaidsoft.com>
 *
 */
public class SMTPBean {

    Session session;
    String server = null;

    /**
     * Holds value of property fromAddress.
     */
    private String fromAddress;

    /**
     * Creates new SMTPBean
     */
    public SMTPBean() {
        setServerInfo();
    }

    private void setServerInfo() {
        server = PropertiesHelper.getProperty("smtp.host");
        // now create a session obj
        Properties props = new Properties();
        props.put("mail.smtp.host", server);
        session = Session.getDefaultInstance(props, null);
        session.setDebug(true);
    }

    public void sendMail(String from, String to, String cc, String sub, String text, MultipartFormdataParser.Part attach)
            throws MessagingException {
        if (attach != null) {
            if (attach.getValue().trim().equals("")) {
                attach = null;
            }
        }
        //System.out.println("from: " + from + " to: " + to + " cc: " + cc + "  part: " + attach);
        MimeMessage msg = new MimeMessage(session);
        msg.setFrom(new InternetAddress(from));
        InternetAddress[] toAdd = InternetAddress.parse(to);
        msg.setRecipients(Message.RecipientType.TO, toAdd);

        if (cc != null) {
            InternetAddress[] ccAdd = InternetAddress.parse(cc);
            if (ccAdd != null) {
                msg.setRecipients(Message.RecipientType.CC, ccAdd);
            }
        }

        msg.setSubject(sub);
        msg.setSentDate(new java.util.Date());
        // create the main part of the message
        if (attach != null) {
            MimeBodyPart p1 = new MimeBodyPart();
            p1.setText(text);

            // set text of the main part
            MimeBodyPart p2 = new MimeBodyPart();
            //p2.setText(attach.getValue());
            p2.setDisposition(Part.ATTACHMENT);
            p2.setFileName(attach.getFileNameNoPath());
            p2.setContent(attach.getValue(), attach.getContentType());

            // create multipart
            Multipart mp = new MimeMultipart();
            mp.addBodyPart(p1);
            mp.addBodyPart(p2);
            // add to message
            msg.setContent(mp);
        } else {
            // create a plain message
            msg.setText(text);
        }
        // now send the message
        Transport.send(msg);
    }

    /**
     * Getter for property fromAddress.
     *
     * @return Value of property fromAddress.
     */
    public String getFromAddress() {
        return fromAddress;
    }

    /**
     * Setter for property fromAddress.
     *
     * @param fromAddress New value of property fromAddress.
     */
    public void setFromAddress(String fromAddress) {
        this.fromAddress = fromAddress;
    }

}

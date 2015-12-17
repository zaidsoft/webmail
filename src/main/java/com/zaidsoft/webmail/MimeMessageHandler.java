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
 * Initially Created on March 14, 2002, 5:57 PM
 */
package com.zaidsoft.webmail;

/**
 *
 * @author DevTeam Zaidsoft <info@zaidsoft.com>
 *
 */
import com.zaidsoft.net.HtmlDigester;
import static com.zaidsoft.webmail.IMAPBean.Use_UID_as_MsgID;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Vector;
import javax.mail.Address;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Part;
import javax.mail.UIDFolder;
import javax.mail.internet.ContentType;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.ParseException;

public class MimeMessageHandler extends java.lang.Object {

    Multipart multipart = null;
    Vector attachements = new Vector();

    // a number for referencing purpose only
    // has no special meaning in this class
    MimeMessage message = null;
    String msgID = "0";
    // this url provides the attachement
    // when called from a web browser
    String attachProviderURL = "../../webmail/attachview";

    String browserHTML = "";
    String replyText = null;
    String replyHTML = null;
    // used to track if reply proc has been completed
    boolean pReply = true;

    public MimeMessageHandler(MimeMessage message) throws IOException, MessagingException {
        this.message = message;
        this.msgID = getMessageID();
        try {
            handleUnknown(message);
        } catch (UnsupportedEncodingException useex) {
            // BAD but eating ehre
            useex.printStackTrace();
        }
    }

    private void handleUnknown(Object obj) throws IOException, MessagingException {
        if (obj instanceof BodyPart) {
            BodyPart bp = (BodyPart) obj;
            Object o = bp.getContent();
            if (o instanceof Multipart) {
                obj = o;
            } else if (o instanceof Part) {
                obj = o;
            }
        }
        if (obj instanceof Multipart) {
            handleMultipart((Multipart) obj);
        } else if (obj instanceof Part) {
            handlePart((Part) obj);
        }
    }

    private void handleMultipart(Multipart mp) throws IOException, MessagingException {
        ContentType ct = new ContentType(mp.getContentType());
        /*
         * if the content type is alternative, choose the lastest one
         */
        if (ct.match(new ContentType("multipart/alternative"))) {
            int cnt = mp.getCount();
            //attempt to display the last
            handleUnknown(mp.getBodyPart(cnt - 1));
        }
        // If it is mixed handle one by one
        if (ct.match(new ContentType("multipart/mixed"))) {
            int cnt = mp.getCount();
            //attempt to handle all the parts
            for (int i = 0; i < cnt; i++) {
                handleUnknown(mp.getBodyPart(i));
            }
        }
    }

    private void handlePart(Part part) throws IOException, MessagingException {
        ContentType ct = null;
        String s = part.getContentType();
        System.out.println("Handle Part Called.." + s);
        try {
            ct = new ContentType(s);
        } catch (ParseException e) {
            // there may be a trailing ";" without charset etc remove it
            if (s.endsWith(";")) {
                s = s.substring(0, s.length() - 1);
            }
            try {
                ct = new ContentType(s);
            } catch (ParseException ee) {
                // Everything failed try to view as octect-stream (generic)
                System.out.println("Special:" + s);
                ct = new ContentType("application/octet-stream");
            }
        }

        if (isAttachment(part)) {
            attachements.add(part);
        }
        if (ct.match("multipart/*")) {
            handleUnknown(part.getContent());
            return;
        }
        /*
         * If the content type can be viewd in browser extract it
         */
        if (ct.match("text/plain")) {
            String p = (String) part.getContent();
            browserHTML += "<pre>";
            browserHTML += p;
            browserHTML += "</pre>";
            if (pReply) {
                //System.out.println("creating text reply");
                replyText = (String) part.getContent();
                pReply = false;
            }
        } else if (ct.match("text/html")) {
            String p = part.getContent().toString();
            browserHTML += (p + "<br><hr><br>");
            // have a frame to write the html part
            if (pReply) {
                //System.out.println("creating html reply");
                replyHTML = p;
                pReply = false;
            }
        } else {
            /**
             * When sending mails from OutlookExpress it attaches image/jpg as
             * application/octet-stream so we need to rely on filename
             *
             */
            String fileName = part.getFileName();
            if (fileName == null) {
                fileName = "Unknown";
            }
            String t = fileName.toLowerCase();
            if (ct.match("image/gif") || ct.match("image/jpg") || ct.match("image/png")
                    || t.endsWith(".jpg") || t.endsWith(".gif") || t.endsWith(".png")) {
                // send a image url so it can viewd
                String a = "<img "
                        + " src=\"" + attachProviderURL + "?msgID=" + msgID + "&partIndex=" + (attachements.size() - 1) + "\""
                        + " alt=\"" + fileName + "\"> <br><hr><br>";
                browserHTML += a;
            }

        }
    }

    public String getBrowserHTML() {
        return browserHTML;
    }

    public String getReplyText() {
        if (replyText == null) {
            if (replyHTML == null) {
                return "";
            }
            replyText = new HtmlDigester(replyHTML).getText();
        }
        return replyText;
    }

    // only return the body content
    public String getReplyHtml() {
        if (replyHTML == null) {
            if (replyText == null) {
                return "";
            }
            replyHTML = replyText;
        } else {
            replyHTML = new HtmlDigester(replyHTML).getBody();
        }
        // now add block quote and return
        replyHTML = "<BLOCKQUOTE dir=ltr style=\"PADDING-RIGHT: 0px; PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #000000 2px solid; MARGIN-RIGHT: 0px\">"
                + replyHTML + "</BLOCKQUOTE>";
        return replyHTML;
    }

    public int getAttachmentCount() {
        return attachements.size();
    }

    // off by one
    public Part getAttachment(int index) {
        return (Part) attachements.get(index);
    }

    private boolean isAttachment(Part part) throws IOException, MessagingException {
        String disp = part.getDisposition();
        if (disp == null) {
            return false;
        } else {
            return (disp.equalsIgnoreCase(Part.ATTACHMENT));
        }
    }

    ////////////////////////////////////////////////////////////////////
    //////////// UTILITY METHODS ///////////////////////////////////////
    ////////////////////////////////////////////////////////////////////
    public String getFromAddress() throws MessagingException {
        Address[] o = message.getFrom();
        if (o == null) {
            return "";
        }
        return o[0].toString();
        //return (folder.getMessage(index).getFrom()[0]).toString();  
    }

    public String getToAddress() throws MessagingException {
        Address[] to = message.getRecipients(Message.RecipientType.TO);
        if (to == null) {
            return "";
        }
        return pack(to);
    }

    public String getSubject() throws MessagingException {
        if (message.getSubject() == null) {
            return "";
        }
        return message.getSubject();
    }

    // get the size in Kbytes
    public String getSizeK() throws MessagingException {
        if (message.getSize() == -1) {
            return "0";
        }
        return String.valueOf(message.getSize() / 1024);
    }

    public String getSentDateShort() throws MessagingException {
        if (message.getSentDate() == null) {
            return "";
        }
        return (new SimpleDateFormat("MMM d, ''yy")).format(message.getSentDate());
    }

    public String getSentDateLong() throws MessagingException {
        if (message.getSentDate() == null) {
            return "";
        }
        return (new SimpleDateFormat("EEE, MMM d, yyyy h:mm a")).format(message.getSentDate());
    }

    public String getMessageID() throws MessagingException {
        if (Use_UID_as_MsgID) {
            UIDFolder folder = (UIDFolder) message.getFolder();
            return String.valueOf(folder.getUID(message));
        } else {
            return ((javax.mail.internet.MimeMessage) message).getMessageID();
        }
    }

    public boolean containsAttachment() throws MessagingException, IOException {
        return getAttachmentCount() > 0;
    }

    private String pack(Address[] a) {
        String aa = "";
        for (int i = 0; i < a.length; i++) {
            aa += a[i];
        }
        return aa;
    }
}

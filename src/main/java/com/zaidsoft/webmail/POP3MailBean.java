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
 * Initially Created on November 25, 2001, 11:37 AM
 */
package com.zaidsoft.webmail;


import java.io.IOException;
import java.util.Properties;
import javax.mail.Flags;
import javax.mail.Folder;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.NoSuchProviderException;
import javax.mail.Session;
import javax.mail.Store;
import javax.mail.internet.MimeMessage;
import javax.mail.search.MessageIDTerm;

/**
 *
 * @author DevTeam Zaidsoft <info@zaidsoft.com>
 *
 */
public class POP3MailBean implements java.io.Serializable, JspTreeInfo {

    public boolean DEBUG = true;

    // POP3 Accound (Server) details
    private String mailServer;
    private String username;
    private String password;

    //public void msgCache = new Hashtable(h);
    char seperator;
    Folder defaultFolder = null, folder = null;

    // the location on local filesystem where 
    // the mails are stored
    String storeLocation = null;

    // this method method should be called just ones and 
    // before all method calls
    public void setStoreLocation(String storeLoc) {
        storeLocation = storeLoc;
    }

    public void setServerInfo(String mailServer, String username, String password) throws NoSuchProviderException, MessagingException {
        this.mailServer = mailServer;
        this.username = username;
        this.password = password;
        init();
    }

    ////////////////////////////////////////////////////////////////////////////    
    public String getFolderName() {
        return folder.getName();
    }

    public void setFolder(String folderName) throws MessagingException {
        if (defaultFolder == null) {
            init();
        }

        // close the prev folder
        if (null != folder && folder.isOpen()) {
            folder.close(false);
        }
        folder = defaultFolder.getFolder(folderName);
        if (!folder.exists()) {
            throw new MessagingException("Folder doesn't exists.");
        }
        if (!folder.isOpen()) {
            folder.open(Folder.READ_WRITE);
        }
    }

    public void refresh() throws MessagingException {
        if (folder.getName().equals("INBOX")) {
            folder.close(true);
            setFolder("INBOX");
        }
        folder.hasNewMessages();

    }

    public void createNewFolder(String folderName) {

    }

    public void deleteFolder(String folderName) throws MessagingException {
        //defaultFolder.getFolder(folderName).delete();
    }

    public void renameFolder(String oldName, String newName) throws MessagingException {
        //defaultFolder.getFolder(oldName).renameTo(newName);
    }

    ////////////////////////////////////////////////////////////////////////////
    public int getMessageCount() throws MessagingException {
        return folder.getMessageCount();
    }

    // index from 1
    public MimeMessage getMessage(int index) throws MessagingException {
        return (MimeMessage) folder.getMessage(index);
    }

    public MimeMessage getMessage(String msgID) throws MessagingException {
        return (MimeMessage) folder.search(new MessageIDTerm(msgID))[0];
    }

    public void deleteMessage(int index) throws MessagingException {
        if (DEBUG) {
            System.out.println("WebmailBean: Message " + index + " deleted");
        }
        getMsg(index);
        message.setFlag(Flags.Flag.DELETED, true);
        folder.expunge();
    }

    public void deleteMessages(int[] m) throws MessagingException {
        if (DEBUG) {
            System.out.println("WebmailBean: Message " + m + " deleted");
        }
        folder.setFlags(m, new Flags(Flags.Flag.DELETED), true);
        folder.expunge();
    }

    Message message = null;
    int lastNumber = 0;

    private void getMsg(int no) throws MessagingException {
        if (lastNumber == 0 || lastNumber != no) {
            message = (MimeMessage) folder.getMessage(no);
        }
    }

    // connects to POP3 Server to
    // download Mail 
    private void init() throws NoSuchProviderException, MessagingException {
        String provider = null;
        Properties props = new Properties();
        props.setProperty("mail.store.protocol", "imaps");
        Session session = null;

        if (PropertiesHelper.getBooleanProperty("useLocalStore")) {
            // In csae POP3 is to be used as per configuration (unusual)
            if (storeLocation != null) {
                props.put("jp.gr.java_conf.roadster.net.pop.rootDirectory", storeLocation);
            }
            session = Session.getInstance(props);
        } else { 
            // Use IMAP 
            provider = "imaps"; // we need it instead of imap for ssl to work
            session = Session.getDefaultInstance(props, null);
        }

        //session.setDebug(true);
        Store store = session.getStore(provider);
        store.connect(mailServer, username, password);

        defaultFolder = store.getDefaultFolder();
        seperator = defaultFolder.getSeparator();
        setFolder("INBOX");

        boolean dumpMsg = false;
        // For debug Only
        if (DEBUG && dumpMsg) {
            Message[] messages = folder.getMessages();
            for (int i = 0; i < messages.length; i++) {
                System.out.println("------------ Message " + (i + 1)
                        + " ------------");
                try {
                    messages[i].writeTo(System.out);
                } catch (IOException e) {
                    e.printStackTrace();
                } catch (MessagingException e) {
                    e.printStackTrace();
                }
            }
        }
        //Close the connection 
        //but don't remove the messages from the server
        //inbox.close(false);
        //store.close();
    }

    /**
     * The String which is to be displayed for Root Node.
     */
    public String rootName() {
        return "Folders";
    }

    /**
     * The String ( usually of just one char) used as seperator while describing
     * a node.
     */
    public char getSeperator() {
        return seperator;
    }

    /**
     * When called this method returns the list of the nodes under given node.
     * Only nodes one level deep are listed. may be called with separator to get
     * children under root.
     */
    public String[] list(String nodeFullName) {
        Folder fol = null;
        try {
            fol = defaultFolder.getFolder(nodeFullName);
            if (!fol.exists()) {
                return null;
            }
            Folder[] f = fol.list();
            return folNames(f);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
        return null;
    }

    private String[] folNames(Folder[] f) {
        String[] s = new String[f.length];
        for (int i = 0; i < f.length; i++) {
            s[i] = f[i].getName();
        }
        return s;
    }

}

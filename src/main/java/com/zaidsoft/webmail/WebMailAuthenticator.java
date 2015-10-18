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

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Responsible for authenticating the user.
 *
 * @author DevTeam Zaidsoft <info@zaidsoft.com>
 */
public class WebMailAuthenticator {

    // Process the HTTP POST request
    public static void authenticate(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession ses = request.getSession(true);
        POP3MailBean b = new POP3MailBean();
        SMTPBean s = new SMTPBean();

        boolean advMode = request.getParameter("host") != null;

        String email = request.getParameter("email");
        String pass = request.getParameter("pass");
        String host = request.getParameter("host");
        String user = request.getParameter("user");
        // whatever is before @ in email address
        String id = null;

        int nTry = 4;
        String[] users = new String[nTry];

        if (advMode) {
            System.out.println("Trying  ADVANCED MODE");
            nTry = 1;
            users[0] = user;
        } else {
            System.out.println("Trying  INTELLIGENT MODE");
            int k = email.indexOf("@");
            if (k == -1) {
                return;
            }
            id = email.substring(0, k);
            host = email.substring(k + 1);
            if (host.equals("gmail.com")){
                host = "imap.gmail.com";
            }
            
            users[0] = email;
            users[1] = id + "." + host;
            users[2] = id + "-" + host;
            users[3] = id;
        }

        String errMsg = null;
        b.setStoreLocation(ResourceProvider.getResourceFilePath("mail", email));
        s.setFromAddress(email);
        for (int i = 0; i < nTry; i++) {
            try {
                user = users[i];
                System.out.println("Mail Server: " + host + " User: " + user + " Pass: " + pass);
                b.setServerInfo(host, user, pass);
                //login is successfull return
                ses.setAttribute("b", b);
                ses.setAttribute("s", s);
                ses.setAttribute("zaidsoft.webmail.UserLoggedIn", "true");
                return;
            } catch (javax.mail.AuthenticationFailedException e) {
                //e.printStackTrace(); // remove later 
                errMsg = e.getMessage();
                errMsg = "Authentication Failed. " + e.getMessage();
                //continue so that we can retry using altered data
            } catch (MessagingException e) {
                //e.printStackTrace(); // remove later
                errMsg = "Could NOT connect to your mail server. " + e.getMessage();
                //continue so that we can retry using altered data
            }
        }
        throw new Exception(errMsg);
    }

}

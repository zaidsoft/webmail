<%@page contentType="text/html"%>
<%@ page import="com.zaidsoft.webmail.*"%>
<%@ include file="checkLogin.jsp"%>
<html>
<head><title>Performer</title>
</head>
<jsp:useBean id="b" scope="session" class="com.zaidsoft.webmail.IMAPBean" />
<jsp:useBean id="s" scope="session" class="com.zaidsoft.webmail.SMTPBean"/>
<body>
<% 
    String folder = request.getParameter("folder");
    String msgNoS = request.getParameter("msgNo");
    int msgNo = 0;
    if( msgNoS != null )
    msgNo = Integer.parseInt(msgNoS);
    
    String act = request.getParameter("act");

    int msgCount = b.getMessageCount();

    if ( "send".equals(act)){
        MultipartFormdataParser parser = new MultipartFormdataParser(request);
        String from = s.getFromAddress();
        try{
            s.sendMail( from, parser.getPart("to").getValue(), parser.getPart("cc").getValue(),
                        parser.getPart("sub").getValue(), parser.getPart("messageText").getValue(), 
                        parser.getPart("attach"));
        }
        catch ( Exception e ) { 
            response.sendRedirect("error.jsp?msg=" + e.getMessage());
            return;
        }
        response.sendRedirect("list.jsp");
        return;
    }

    if ( "del".equals(act)){
        // fi msg no is given del that one 
        if ( msgNo != 0 ){
            b.deleteMessage(msgNo);
        }
        else { //  user has selected using check boxes
            // identify those they have names one two three ....
            int k = 0;
            for ( int i=1; i <= msgCount; i++){
                if ( "on".equals(request.getParameter(String.valueOf(i))))
                k ++;
            }
            if ( k == 0 ) response.sendRedirect("list.jsp");
            int[] delMsg = new int[k];
            k = 0;
            for ( int i=1; i <= msgCount; i++){
                if ( "on".equals(request.getParameter(String.valueOf(i)))){
                    delMsg[k] = i;
                    k++;
                }
            }
            b.deleteMessages(delMsg);
        }
        response.sendRedirect("list.jsp");
        return;
    }

    if ( "view".equals(act)){
        // identify those they have names one two three ....
        for ( int i=1; i <= msgCount; i++){
            if ( "on".equals(request.getParameter(String.valueOf(i)))) {
                response.sendRedirect("show.jsp?msgNo=" + i);
                return;
            }
            response.sendRedirect("list.jsp");
        }
    }
    
%>
</body>
</html>

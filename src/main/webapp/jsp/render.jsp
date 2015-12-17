<%@page contentType="text/html"%>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*"%>
<%@ page import="javax.activation.*" %>
<%@page import="com.zaidsoft.webmail.*" %>
<%@ include file="checkLogin.jsp"%>
<html>
<head><title>Mail Content</title>
<link rel=stylesheet type="text/css" href="skins/normal-default.css">
</head>
<jsp:useBean id="b" scope="session" class="com.zaidsoft.webmail.IMAPBean" />
<body style="background-color: white">
<% 
    // if message number is given find the message id 
    String msgNo = request.getParameter("msgNo");
    String msgID = request.getParameter("msgID");
    MimeMessageHandler msgHandler = (MimeMessageHandler) session.getAttribute("msgHandler" + msgID);
%>
<%=msgHandler.getBrowserHTML()%>
</body>
</html>

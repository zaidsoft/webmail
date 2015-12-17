<%@page contentType="text/html"%>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*"%>
<%@ page import="javax.activation.*" %>
<%@page import="com.zaidsoft.webmail.*" %>
<%@ include file="checkLogin.jsp"%>
<jsp:useBean id="b" scope="session" class="com.zaidsoft.webmail.IMAPBean" />
<%  long st = System.currentTimeMillis();
    String folder = request.getParameter("folder");

    // if message number is given find the message id 
    String msgNo = request.getParameter("msgNo");
    String msgID = request.getParameter("msgID");

    // this is the message we are talking about
    MimeMessage msg = null;

    if ( msgNo != null ){
        msg =  b.getMessage(Integer.parseInt(msgNo));
    } 
    else {
        msg =  b.getMessage(msgID);
    }

    int index = msg.getMessageNumber();
    msgID = b.getMessageID(msg);
    MimeMessageHandler msgHandler = (MimeMessageHandler) session.getAttribute("msgHandler" + msgID);
    if ( msgHandler == null ) {
        msgHandler = new MimeMessageHandler((MimeMessage)msg); 
        session.setAttribute("msgHandler"+msgID, msgHandler);
    }
%>
<html>
<head><title><%=msgHandler.getSubject()%></title>
<script>
<!--
function checkDel(target){
    if ( confirm("Are you sure, you want to DELETE this message?" ) ){
        document.location.href = target;
        return true;
    }
    return false;
}
// -->
</script>
<link rel=stylesheet type="text/css" href="skins/normal-default.css">
</head>

<body>
<%----------- Include the Header --------------%>
<jsp:include page="header.jsp?depth=../" flush="true"/> 

<jsp:include page="sidebar.jsp" flush="true"/>
<br>
<table width="80%" height="50%" cellspacing="1" cellpadding="1" border="0">
<tr>
	<td colspan="3">
		<button class="mail-link" onClick="document.location.href='compose.jsp?act=reply&msgID=<%=msgID%>'">Reply</button>
                <button class="mail-link" onClick="document.location.href='compose.jsp?act=forward&msgID=<%=msgID%>'">Forward</button>
                <button <%= ( index <= 1 ) ? "disabled=\"true\"" : "" %> class="mail-link" onClick="document.location.href='show_mail_msg.jsp?folder=<%=folder%>&msgNo=<%=index-1%>'">Prev</button>
                <button <%= ( index == b.getMessageCount()) ? "disabled=\"true\"" : "" %> class="mail-link" onClick="document.location.href='show_mail_msg.jsp?folder=<%=folder%>&msgNo=<%=index+1%>'">Next</button>
                <button class="mail-link" onClick="return checkDel('perform.jsp?act=del&msgNo=<%=index%>')">Delete</button>
                <br><br><br>
        </td>
</tr>
<tr>
    <td class="ask">From:</td>
    <td class="caption"><%=msgHandler.getFromAddress()%></td>
    <td rowspan="3" align="left" class="ask">
            <%  
                if (msgHandler.containsAttachment()){
                    String fileName="";
                    int count = msgHandler.getAttachmentCount();
                    for ( int i=0; i < count; i++){
                        javax.mail.Part attach = msgHandler.getAttachment(i);
                        fileName = attach.getFileName();
                        if ( fileName == null ) fileName="Unkonwn";
                        %>
                        &nbsp;&raquo;&nbsp;
                        <a href="../../webmail/attachview?msgID=<%=msgID%>&partIndex=<%=i%>"><%=fileName%></a>
                        (<%= (attach.getSize()/1024)%>k)<br>
                    <% } 
                }
                else { %>
                No Attachment
            <% } %>
    </td>
</tr>
<tr>
    <td class="ask">To:</td>
    <td class="caption"><%=msgHandler.getToAddress()%></td>
</tr> 
<tr>
    <td class="ask">Date:</td>
    <td class="caption"><%=msgHandler.getSentDateLong()%></td>
</tr>
<tr>
    <td class="ask">Subject:</td>
    <td colspan="2" class="caption"><%=msgHandler.getSubject()%></td>
</tr>
<tr>
    <td colspan="3" class="caption">
        &nbsp;
    </td>
</tr>
<tr>
    <td colspan="3" class="ask">
        <iframe src="render.jsp?msgID=<%=msgID%>" width="600px" height="1000" frameborder="0" sandbox> 
            <%---=msgHandler.getBrowserHTML()--%>
            Your browser doesn't support iframe! Please upgrade your browser and retry.
        </iframe>
    </td>
</tr>
</table><% System.out.println(System.currentTimeMillis() - st ); %>
<%----------- Include the Footer --------------%>
<jsp:include page="footer.jsp?depth=../" flush="true"/>
</body>
</html>

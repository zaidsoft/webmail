<%@page contentType="text/html"%>
<%@page import="com.zaidsoft.webmail.*" %>
<%@page import="javax.mail.internet.*" %>
<%@ include file="checkLogin.jsp"%>
<html>
<head><title>List of Mails</title>
<script>
<!--
function checkDel(target){
    if ( confirm("Are you sure, you want to DELETE ALL SELECTED messages?" ) ){
        document.performer.submit();
        return true;
    }
    return false;
} 
// -->
</script>
<link rel=stylesheet type="text/css" href="skins/normal-default.css">
</head>
<jsp:useBean id="b" scope="session" class="com.zaidsoft.webmail.POP3MailBean" />
<body>
<% 
    String folder = request.getParameter("folder");
    if ( folder != null )
    b.setFolder(folder);
    else folder = b.getFolderName();
    b.refresh();
    session.setAttribute("jspTreeImpl", b);
%>
<%----------- Include the Header --------------%>
<jsp:include page="header.jsp?depth=../" flush="true"/> 
<jsp:include page="left_side_bar.jsp" flush="true"/>
<br>
<table cellspacing="2" cellpadding="0" border="0" rules="rows" width='92%'>
<tr>
	<td colspan="5">You Have <strong> <%=b.getMessageCount()%></strong> Mails in Folder: <strong><%=folder%><br><br></td>
</tr>
<tr>
	<td colspan="5">
		<button class="mail-link" onClick="document.location.href='compose.jsp'">Compose</button>
                <!--button class="mail-link" onClick="document.performer.action = 'perform.jsp?act=view'; document.performer.submit()">View Selected</button-->
                <button class="mail-link" onClick="document.performer.action = 'perform.jsp?act=del';  checkDel()">Delete Selected</button>
                <br><br><br>
        </td>
</tr>
<tr>
    <td align="center" class="caption"> Select </td>
    <!--td align="center"> Attrib </td-->
    <td align="center" class="caption"> Attach </td>
    <td align="center" class="caption"> From </td>
    <td align="center" class="caption"> Subject </td>
    <td align="center" class="caption"> Received </td>
    <td align="center" class="caption"> Size </td>
</tr>
<form name="performer" method="post">
<% 
 int count = b.getMessageCount();
 for (int i=count; i > 0; i--){ 
    //javax.mail.internet.MimeMessage msg = b.getMessage(i);
    MimeMessageHandler m = new MimeMessageHandler(b.getMessage(i));
%>
<tr bgcolor="#ffffcc">
    <td class="ask"><INPUT class = "on-ask" name="<%=i%>" type="checkbox"></td>
    <td class="ask">&nbsp;<%=m.containsAttachment() ? "A" : ""%>&nbsp;</td>
    <td class="ask">&nbsp;<%=m.getFromAddress()%>&nbsp;</td>
    <td class="ask"><a href="show_mail_msg.jsp?folder=<%=folder%>&msgID=<%=m.getMessageID()%>">
        &nbsp;<%=m.getSubject()%>&nbsp;</a>
    </td>
    <td class="ask"><%=m.getSentDateShort()%></td>
    <td class="ask" align="right"><%=m.getSizeK()%>k&nbsp;</td>
</tr>
<% } %>
</from>
<tr>
    <td colspan="6" class="caption"><small>Click on a message subject to View the message</small></td>
</tr>
</table>
<%----------- Include the Footer --------------%>
<jsp:include page="footer.jsp?depth=../" flush="true"/>
</body>
</html>

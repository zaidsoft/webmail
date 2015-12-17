<%@page contentType="text/html"%>
<%@page import="com.zaidsoft.webmail.*" %>
<%@ include file="checkLogin.jsp"%>
<html>
<head><title>Compose a New Message</title>
<script>
<!--
function checkEmpty(){
	if (document.compose.to.value == "" || document.compose.sub.value == "" || document.compose.messageText.value == "" ){
		alert("Please enter all required data.\n_____________________________\n\nYou can't leave 'to' & 'subject', fields blank. \nYou can't send a Blank Message.");
		return false;
	}
        document.compose.send.value='... please wait';
        document.compose.send.disabled = true;

        //document.compose.submit();
	return true;
}
// -->
</script>
<link rel=stylesheet type="text/css" href="skins/normal-default.css">
</head>
<jsp:useBean id="b" scope="session" class="com.zaidsoft.webmail.POP3MailBean" />
<body>
<%----------- Include the Header --------------%>
<jsp:include page="header.jsp?depth=../" flush="true"/> 
<% 
    String folder = request.getParameter("folder");
    String msgID = request.getParameter("msgID");
    MimeMessageHandler m = null;
    if (msgID != null ){
        m = (MimeMessageHandler) session.getAttribute("msgHandler" + msgID);
        if ( m == null ) return;
    }
    String toValue="";
    String ccValue="";
    String subjValue="";
    String textAreaValue="";
    
    String act = request.getParameter("act");

    if ( "reply".equals(act)){
        toValue= m.getFromAddress();
        subjValue= "Re: " + m.getSubject();
        textAreaValue="\n\n\n-------------------------- Original Message------------------\r\n" +
                      "Sent By: " + toValue + "          on: " + m.getSentDateShort() + "\n"+
                       m.getReplyText();
    }

    if ( "forward".equals(act)){
        subjValue= "Fw: " + m.getSubject();
        textAreaValue="\n\n\n-------------------------- Original Message------------------\r\n" +
                      "Sent By: " + m.getFromAddress() + "          on: " + m.getSentDateShort() + "\n"+
                       m.getReplyText();
    }
%>
<jsp:include page="sidebar.jsp" flush="true"/>
<BR>
<form name="compose" action="perform.jsp?act=send" enctype="multipart/form-data" method="post" onSubmit="return checkEmpty();">
<table cellspacing="1" cellpadding="1" border="1" rules="rows" frame="below">
<tr>
	<td colspan="5">
		<input name="send" type="submit" class="mail-link" value="Send">
                <!--a class="mail-link" href="compose.jsp">Save</a-->
                <br><br>
        </td>
</tr>
<tr>

    <td class="ask">To:</td>
    <td class="caption"><input type="text" size="60" name="to" value="<%=toValue%>"></td>
    
</tr>
<tr>
    <td class="ask">cc:</td>
    <td class="caption"><input type="text" name="cc" size="60" value="<%=ccValue%>"></td>
</tr>
<tr>
    <td class="ask">Attach:</td>
    <td class="caption"><input type="file" name="attach" size="48"></td>
</tr>
<tr>
    <td class="ask">Subject:</td>
    <td colspan="2" class="caption"><input type="text" name="sub" size="80" maxlength="200" value="<%=subjValue%>"></td>
</tr>
<tr>
    <td colspan="3" class="ask">
	<textarea cols=80 rows=30 name="messageText"><%=textAreaValue%></textarea>
    </td>
</tr>
</form>
</table>
<%----------- Include the Footer --------------%>
<jsp:include page="footer.jsp" flush="true"/>
</body>
</html>

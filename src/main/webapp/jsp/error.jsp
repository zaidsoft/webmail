<%@page contentType="text/html"%>
<html>
<head><title>Error Occurred</title>
<%@ page import="com.zaidsoft.webmail.*" %>
<%@ page import="java.util.*" %>
<script language="javascript" src="include/app.js"></script>
<%-- Asks the user an string and envocks the caller with that string as a parameter.
    Params:
    >>  msg         >> the prompt that the user will be shown.
    >>  buttonText  >> the Text that will appear on the Submit buttom (def. "OK")
    >>  param       >> the parameter name that will be given user's resp. string
 -----------------------------------------------------------------------------------%>
<%  
     String msg = request.getParameter("msg");
     if ( msg == null ) msg = "Unkonwn Error.";
     String returnURL = request.getParameter("returnURL");
     String buttonText = request.getParameter("adviceURL");
     String param = request.getParameter("param");
%>
<script>
</script>
<link rel=stylesheet type="text/css" href="skins/normal-default.css">
</head>
<body topmargin="0" leftmargin="0" rightmargin="0">
<%----------- Include the Header --------------%>
<jsp:include page="banner.jsp" flush="true"/>
<br><br><br><br>
<table align="center" width="60%" cellpadding="5" cellspacing="0" border="1">
<tr>
	<td class="caption" colspan="2" align="center" valign="center">
            <h3>Error</h3>
            <small style="font-family:sans-serif; font-size:xx-small;">The following error occurred while performing the requested Task:-</small>
        </td>
</tr>
<tr>
	<td class="ask" colspan="2" height="200"><strong><%=msg%></strong></td>
</tr>
<tr>
	<td class="caption"></td>
</tr>
<tr>
	<td class="ask" colspan="2" >
        <div align="center" style="font-family:sans-serif; font-size:xx-small;">
        You may Hit the back button of your browser to correct input / try Again.<br><br>
        Alternatively, you may click on any of the links given at the bottom of the page to go to a different page/task.
        </div></td>
</tr>
<tr>
	<td class="caption" colspan="2">If you think that the system is reporting wrong errors, please report at <a href="mailto:info@zaidsoft.com">info@zaidsoft.com</td>
</tr>
</table>
<%----------- Include the Footer --------------%>
<jsp:include page="footer.jsp" flush="true"/>
</body>
</html>

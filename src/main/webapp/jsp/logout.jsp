<%@page contentType="text/html"%>
<html>
<head><title>Logged Out</title>
<%@ page import="com.zaidsoft.webmail.*" %>
<%
     session.invalidate();
%>
<script>
<!--
function finish(){ 
    window.close();
}
// -->
</script>
<link rel=stylesheet type="text/css" href="skins/normal-default.css">
</head>
<body>
<table align="center" width="100%">
<tr>
<td bgcolor="silver" height="100px" align=right><h4>&nbsp;&nbsp;&nbsp;&nbsp;</h4>
</td>
</tr>
<tr>
<td>
<div style="text-align: center">
<br><br><br>
<h3> You have successfully logged out. </h3>
<br><br><br>
If you wish, you may login again by going to <a target=_self href="login.jsp">Login Page</a>
</div>
<br><br><br><br>
<br><br><br><br><br>
</td>
</tr>
<tr>
<td bgcolor="silver" height="300">&nbsp;&copy;Zaidsoft. All Rights Reserved.
</td>
</tr>
</table>
</body>
</html>

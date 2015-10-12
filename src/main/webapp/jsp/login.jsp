<%@page contentType="text/html"%> 
<%@ page import="com.zaidsoft.webmail.*" %>
<%
    boolean adv = request.getParameter("advMode") != null;
    String email = request.getParameter("email");
    if (email == null ) email = "";
    String pass = request.getParameter("pass");
    if (pass == null ) pass = "";
    String host = request.getParameter("host");
    if (host == null ) host = "";
    String user = request.getParameter("user");
    if (user == null ) user = "";
    String submit = request.getParameter("ok");
    String msg = "";
    if (submit != null ) {
        try{
          WebMailAuthenticator.authenticate(request, response);
          response.sendRedirect("view_mail_list.jsp");
          return;
       }
       catch (Exception e){ 
            msg = e.getMessage();
       }
    } 

%>
<html>
<head>
	<title>Login to Web Mail</title>
<link rel=stylesheet type="text/css" href="skins/normal-default.css">
<script language="javascript">
<!--
       function checkEmpty(){
                //alert("dfgdfdfdf");
		if (document.login.email.value == "" || !validateEmailAddress(document.login.email.value)){
			alert('Please enter your E-mail Address.');
			document.login.email.focus();
			return false;				
		} 		
                <% if ( adv) { %>
		if (document.login.host.value == ""){
			alert("Please enter your mail Server.");
			document.login.host.focus();
			return false;				
		}
		if (document.login.user.value == ""){
			alert("Please enter your mail user-ID.");
			document.login.user.focus();
			return false;				
		}
                <% } %>
		if (document.login.pass.value == ""){
			alert("Please enter your mail Password.");
			document.login.pass.focus();
			return false;				
		}
                document.login.submit.disabled = true;
                document.login.submit.value = "...please wait";
                return true;
        }
	/////////////////////////////////////////////////
	// 	returns False if the email is not valid
		// The rule of checking of email is as follows
		// 1. No space should be present
		// 2. Exactly one @ shold be present
		// 3. At least one dot should be present
		// 4. dot can not be preseant at the beg or end
		
	function validateEmailAddress (inEmail) {
                return true ; // TEMP REMOVE LATER
		var okEmail;
		var locAt = inEmail.indexOf("@"); 
		var emailsize=inEmail.length;
		var locPeriod = inEmail.lastIndexOf(".");
		var firstdot=inEmail.indexOf(".");
	
		if ( ( firstdot == -1) || (firstdot == locAt-1) || (firstdot == locAt+1) || (firstdot == 0)) {
	 		return false;
		}
 	
	  	var prevdot = firstdot;
		for (var i=(firstdot+1);i < (inEmail.length -1);i++) {
			var curchar =inEmail.charAt(i);
			if ( (curchar == ".") && (i == prevdot+1) ) {
				return false;
			}
		
			if ( curchar == "." ) {
				prevdot = i;
			}
		}
	
		okEmail = ((locAt != -1) && (locAt != 0) && (locAt != (inEmail.length - 1)) &&
    	         (inEmail.indexOf("@", (locAt + 1)) == -1) &&
        	     ( (locPeriod == (inEmail.length - 3)) || 
				 (locPeriod == (inEmail.length - 4))) && 
	             (locPeriod > locAt) 
		); 

		return okEmail; 				
	}
//-->			
</script>	
</head>
<body >
<jsp:include page="banner.jsp" flush="true"/>
<table align="center" width="100%" border="0"  cellspacing=0 cellpadding=0>
<tr>
<td height="50" colspan="2" >&nbsp;
</td>

<tr> 
<td align='left' width="10%">
&nbsp;
</td>
<td valign=center>
<h4 style="color:red">&nbsp;&nbsp;<%=msg%></h4>
<!-- LOGIN TABLE -->
<% if ( adv) { %>
<h4>&nbsp;&raquo;&nbsp;Advanced Login:</h4>
<% } else { %>
<h4>&nbsp;&raquo;&nbsp;Intelligent Login:</h4>
<% } %>
<form name="login" action="login.jsp" method="post" onsubmit='return checkEmpty();' >
<table align="left" border="1" cellpadding="4" cellspacing="4" bgcolor="#ffffff" width="40%" rules="rows" bordercolor=silver>
 <tr>
	<td valign="middle"   align="left" class="ask"><small><font color="#000000" face="Arial"><small><strong><span style="font-family: Verdana, Arial">E-Mail Address:</span></strong></small></font></small></td>
 </tr>
 <tr>
 		<td valign="middle" align="left" class="ask"><input name="email" value="<%=email%>" size="40"><font face="Arial"></td>
</tr>
<% if ( adv ) { %>
 <tr>
	<td valign="middle"   align="left" class="ask"><small><font color="#000000" face="Arial"><small><strong><span style="font-family: Verdana, Arial">Mail Server:</span></strong></small></font></small></td>
 </tr>
 <tr>
 		<td valign="middle" align="left" class="ask"><input name="host" value="<%=host%>" size="40"><font face="Arial"></td>
</tr>
 <tr>
	<td valign="middle"   align="left" class="ask"><small><font color="#000000" face="Arial"><small><strong><span style="font-family: Verdana, Arial">Username:</span></strong></small></font></small></td>
 </tr>
 <tr>
 		<td valign="middle" align="left" class="ask"><input name="user" value="<%=user%>" size="40"><font face="Arial"></td>
</tr>
<% } %>
<tr>
		<td valign="middle"  align="left" class="ask"><strong><small><font color="#000000" face="Arial"><small><span style="font-family: Verdana, Arial">Password:</span></small></font></small></strong></td>
</tr>
<tr>
		<td valign="middle"  align="left" class="ask"><input type="password" name="pass" value="<%=pass%>" size="40"></td>
</tr>
<tr>
		<td valign="middle" class="submit-bg">
		<input type="submit" align="right" class="sbmt"  name="submit" value=":: Login ::"></td>
</tr>
</table>
<input type="hidden" name="ok" value="true">
</form>
<br clear=all><br>
<% if ( adv) { %>
Go Back to  <a href="login.jsp">Intelligent Login</a> 
<% } else { %>
If Intelligent Login Fails Try <a href="login.jsp?advMode=true">Advanced Login</a> 
<% } %>
<!--a href="trouble_logging.jsp">Trouble Logging-In?</a> | &nbsp;
<a href="forgot_password.jsp">Forgot Password?</a-->
</ul>
<!-- END LOGIN TABLE -->
</td>
</tr>

<tr>
<td height="50" colspan="2">&nbsp;
</td>

<tr>
<td bgcolor="silver" height="250" colspan="2">&nbsp;&copy; Zaidsoft. All Rights Reserved.
</td>
</tr>
</table>

</body>
</html>

<%@page import="java.util.List"%>
<%@page import="com.zaidsoft.webmail.IMAPBean.ListRow"%>
<%@page contentType="text/html"%>
<%@page import="com.zaidsoft.webmail.*" %>
<%@page import="javax.mail.internet.*" %>
<%@ include file="checkLogin.jsp"%>

<jsp:useBean id="b" scope="session" class="com.zaidsoft.webmail.IMAPBean" />
<% 
    String folder = request.getParameter("folder");
    if ( folder != null )
    b.setFolder(folder);
    else folder = b.getFolderName();
    b.refresh();
    session.setAttribute("jspTreeImpl", b);
    
 String s = request.getParameter("page");
 if (s == null) s = "1";
 int p = Integer.parseInt(s);    
%>
<html>
<head><title>Page <%= p %> List of Mails </title>
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

<body>

<%----------- Include the Header --------------%>
<jsp:include page="header.jsp?depth=../" flush="true"/> 
<jsp:include page="sidebar.jsp" flush="true"/>
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
                <button <%= ( p <= 1 ) ? "disabled=\"true\"" : "" %> class="mail-link" onClick="document.location.href='list.jsp?folder=<%=folder%>&page=<%=p-1%>'">Prev</button>
                <button <%= ( p == b.getMessageCount()) ? "disabled=\"true\"" : "" %> class="mail-link" onClick="document.location.href='list.jsp?folder=<%=folder%>&page=<%=p+1%>'">Next</button>
                
                <br><br><br>
        </td>
</tr>
<tr>
    <td align="center" class="caption"> Select </td>
    <!--td align="center"> Attrib </td-->
    <td align="center" class="caption"> Attach </td>
    <td align="center" class="caption"> From </td>
    <td align="center" class="caption"> Subject </td>
    <td align="center" class="caption"> Content </td>
    <td align="center" class="caption"> Received </td>
    <td align="center" class="caption"> Size </td>
</tr>
<form name="performer" method="post">
<%

 List<ListRow> mrows = b.buildPageSummary(p);
 for (int i = mrows.size() -1; i >= 0; i--){ 
    ListRow m = mrows.get(i);
%>
<tr bgcolor="#ffffcc">
    <td class="ask"><INPUT class = "on-ask" name="<%=i%>" type="checkbox"></td>
    <td class="ask">&nbsp;<%= m.isAttachment() ? "A" : ""%>&nbsp;</td>
    <td class="ask">&nbsp;<%=m.getFrom()%>&nbsp;</td>
    <td class="ask"><a href="show.jsp?folder=<%=folder%>&msgID=<%=m.getMessageID()%>">
        &nbsp;<%=m.getSubject()%>&nbsp;</a>
    </td>
    <td class="ask"><%=m.getDate() %></td> 
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

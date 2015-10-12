<% 
if ( session.getAttribute("zaidsoft.webmail.UserLoggedIn") == null ){
    response.sendRedirect("login.jsp");
    return;
}
%>
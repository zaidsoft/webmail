<% 
if ( session.getAttribute("zaidsoft.webmail.UserLoggedIn") == null ){
    response.sendRedirect("../index.jsp");
    return;
}
%>
<%@page contentType="text/html"%>
<html>
<head>
<%@ page import="com.zaidsoft.webmail.*" %>
<%
     session.invalidate();
%>
      
    <title>WebMail :: Logout</title>
    
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>WebMail :: Login</title>

<link rel=stylesheet type="text/css" href="ui-resources/css/login.css">
<link rel=stylesheet type="text/css" href="ui-resources/css/webmail.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous">




</head>
  <body class="hold-transition default-skin sidebar-mini">
    <div class="container">

		
		<div class="jumbotron">
        <h1>WebMail</h1>
        <p class="lead">You have successfully logged out.</p>
        <p><a class="btn btn-lg btn-success" href="../index.jsp" role="button">Log in again</a></p>
      </div>
      
    </div><!-- ./wrapper -->
    <div class="footer navbar-default">
<jsp:include page="footer.jsp"></jsp:include>
</div>
    

    <!-- jQuery -->
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
    <!-- Bootstrap -->
   <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>



  </body>
</html>


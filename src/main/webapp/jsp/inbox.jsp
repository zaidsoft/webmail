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
 String uname= b.getUsername();
 int unreadMsg = b.getTotalUnreadMessages();
%>

<!DOCTYPE html>
<html>
  <head>
    <title>WebMail :: Inbox</title>
    
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    
    <!--Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous">
    
    <!-- NanoScroller -- scrollbar jqury based MIT-->
    <link rel="stylesheet" href="ui-resources/scroll-bar/css/nanoscroller.css"> 
    
       
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    
    <!-- Default Theme -->
    <link rel="stylesheet" href="ui-resources/css/webmail.css">
    
   	<!-- Default Skin -->
     <link rel="stylesheet" href="ui-resources/css/skins/default-skin.css"> 
    
      
  </head>
  <body class="hold-transition default-skin sidebar-mini">
    <div class="wrapper">

      <header class="main-header">
        <!-- Logo -->
        <a href="#" class="logo">
          
          <!-- mini logo -->
          <span class="logo-mini"><b>W</b>M</span>
          
          <!--Normal Logo -->
          <span class="logo-lg"><b>W</b>eb<b>M</b>ail</span>
        </a>
        
        <nav class="navbar navbar-static-top" role="navigation">
          <!-- Sidebar toggle button-->
          <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </a>
          
          
          
          
          <div class="navbar-custom-menu">
            <ul class="nav navbar-nav">
             
              <li class="dropdown user user-menu">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                  <img data-name="<%=uname %>" class="demo user-image" alt="User Image">
                  
                  
                  <span class="hidden-xs"><%=uname %></span>
                </a>
                <ul class="dropdown-menu">
                  <!-- User image -->
                  <li class="user-header">
                    <img data-name= "<%=uname%>" class="demo user-image" alt="User Image">
                    <p>
                      <%=uname %>
                      <small><%=uname %></small>
                    </p>
                  </li>
                  
                  <!-- Menu Footer-->
                  <li class="user-footer">
                    <div class="pull-left">
                      <a href="#" class="btn btn-default btn-flat">Profile</a>
                    </div>
                    <div class="pull-right">
                      <a href="logout.jsp" class="btn btn-default btn-flat">Sign out</a>
                    </div>
                  </li>
                </ul>
              </li>
            </ul>
          </div>
        </nav>
      </header>
      <!-- Left side column. contains the logo and sidebar -->
      <aside class="main-sidebar">
       
        <section class="sidebar">
        
	
         
          <!-- sidebar menu  -->
         
         
          <ul class="sidebar-menu">
	          <li  class="comp-button">   <!-- not visible in mini sidebar -->
	           <button type="button" class="btn btn-primary" onClick="document.location.href='compose.jsp'"><i class="fa fa-pencil-square-o"></i> <span>COMPOSE</span></button>
	          </li>        
            
	           <li class="c-button hello">    <!-- this is small iconic button for compose in mini sidebar.  visible only in mini side bar -->
	              <a href="#">
	                <i class="fa fa-pencil-square-o"></i> <span>Compose</span> 
	              </a>
	           </li>
            
	           <li class="hello">
	              <a href="#">
	                <i class="fa fa-envelope-o"></i> <span>Inbox</span> <small class="label pull-right bg-green"><%=unreadMsg %> unread</small>
	              </a>
	           </li>
            
	            <li class="hello">
	              <a href="#">
	                <i class="fa fa-paper-plane-o"></i> <span>Sent Items</span> 
	              </a>
	            </li>
	            
	            <li class="hello">
	              <a href="#">
	                <i class="fa fa-folder-open-o"></i> <span>Drafts</span> 
	              </a>
	            </li>
	            
	            <li class="hello">
	              <a href="#">
	  				<i class="fa fa-ban"></i>
	  				<span>Spams</span>
	              </a>
	            </li>
            
	            <li class="hello">
	              <a href="#">
	                <i class="fa fa-trash-o"></i> <span>Trash</span>
	              </a>
	            </li>
	             
            </ul>
           <ul class="mc"><li> My Contacts</li></ul> 
           <!-- contact List Starts -->  
           <!-- <div id="nan"> -->
           <div class="nano">
          <jsp:include page="conList.jsp"/> 
           </div>
           
           
           
           
           
           
           <!-- </div> -->
             
         <!--  ./contact list ends -->
         
       <!--   <ul>
         <li>
         	i
         </li>
         </ul> -->
       
        </section>
        <!-- /.sidebar -->
      </aside>
      
      <!-- Inbox content that is list of emails starts -->
      <div class= "main-content">
     	<div class="container-fluid">
     	
     		<div class="row">
     			<div class="col-md-12">
     			<div class="content">
     			<div class="page-info">
     			<h3>Inbox</h3> &nbsp;&nbsp;&nbsp; <small> You have <%=b.getMessageCount()%> messages</small>
     			
     			
     			
     			<div class="pull-right">
                      1-20/<%=b.getMessageCount()%>
                      <div class="btn-group">
                        <button class="btn btn-default btn-sm"  <%= ( p <= 1 ) ? "disabled=\"true\"" : "" %> onClick="document.location.href='list.jsp?folder=<%=folder%>&page=<%=p-1%>'"><i class="fa fa-chevron-left"></i></button>
                        <button class="btn btn-default btn-sm"  <%= ( p == b.getMessageCount()) ? "disabled=\"true\"" : "" %> onClick="document.location.href='list.jsp?folder=<%=folder%>&page=<%=p+1%>'"> <i class="fa fa-chevron-right"></i></button>
                      </div>
                    </div>
     			
     			</div>
     			<div class ="alert-on-select">
	     			<div class="alert alert-danger alert-dabba" role="alert"> 
	     				All <b>20 conversations</b> on this page are selected 
	     			</div>
     			</div>
     			<div class="controll-buttons">
     				<input type="checkbox" class="select-all" value="" data-toggle="tooltip" data-placement="bottom" title="Select All">
     				
     				<button type="button" class="btn btn-default con-but" data-toggle="tooltip" data-placement="bottom" title="Refresh">
  					<i class="fa fa-refresh"></i>
					</button>
					
					<div class="controll-btn-group">
						<button type="button" class="btn btn-default con-but" data-toggle="tooltip" data-placement="bottom" title="Delete">
  						<i class="fa fa-trash"></i>
						</button>
					
						<button type="button" class="btn btn-default con-but" data-toggle="tooltip" data-placement="bottom" title="Report as Spam">
  						<i class="fa fa-exclamation-circle"></i>
						</button>
					
						<button type="button" class="btn btn-default con-but" data-toggle="tooltip" data-placement="bottom" title="Archieve">
  						<i class="fa fa-download"></i>
						</button>
						
					</div>
					
					<div class="controll-btn-group-single-select">
						<button type="button" class="btn btn-default con-but" aria-label="Left Align" data-toggle="tooltip" data-placement="bottom" title="Reply">
  						<i class="fa fa-reply"></i>
						</button>
					
						<button type="button" class="btn btn-default con-but" data-toggle="tooltip" data-placement="bottom" title="Forward">
  						<i class="fa fa-share"></i>
						</button>						
					</div>
     				
     			
     			</div>   	<!-- control button ends -->	
  <div class="email-table">          
  <table class="table">
    <tbody>
    <%
 		List<ListRow> mrows = b.buildPageSummary(p);
 		for (int i = mrows.size() -1; i >= 0; i--){ 
    		ListRow m = mrows.get(i);
    		String paperClip = "";
    		String seen="";
    			if(m.isAttachment())
    				paperClip = "fa fa-paperclip";
    			if(m.isSeenflag())
    				seen = "seen";
    			else 
    				seen = "unseen";
    
	%>
    <tr class="<%=seen%>" href="show.jsp?folder=<%=folder%>&msgID=<%=m.getMessageID()%>" >
        <td><input type="checkbox" value="" name="<%=i%>"></td>
        <td> <%=m.getFrom()%> </td>
        <td><b><%=m.getSubject()%></b>    </td>
        <td><i class="<%=paperClip%>"></i></td>
        <td><%=m.getDate() %></td>
    </tr>
    <% } %>
      
    </tbody>
  </table>
  </div>
     			
     		</div>    <!-- content ends -->
    	</div>    <!--col-md-12  ends  -->
      </div>   <!--row ends  -->
     </div>  <!--container-fluid ends  -->
      
    </div><!-- ./main-content ends --> 

    </div><!-- ./wrapper ends -->
	<!-- footer starts -->

   <!--  <footer class="main-footer">
    
    	
        <div class="pull-right hidden-xs">
          <b>Version</b> 1.0
        </div>
        <strong>Copyright &copy; 2015 <a href="#">luqman quadri</a>.</strong> All rights reserved.
      </footer> ./footer ends    --> 
    
<jsp:include page="footer.jsp"></jsp:include>
    
    <!-- jQuery -->
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>  
    <!-- WebMailBST JS -->
     <script src="ui-resources/js/webmail.js"></script> 
     
     <!-- initial JS based on jquery -->
     <script src="ui-resources/js/initial.js"></script> 
   
    <!-- this function is used to make the menu from sidebar active/selected untill any other menu is selected on the page -->
   <script>
   $('li.hello').click(function() {
	    $('li.hello').removeClass('activate-menu');
	    $(this).addClass('activate-menu');
	});
   
   </script> 
   
   <script>			/* this script is used to toggle compose button and mini-side-bar compose icon */
   $(document).ready(function(){
    $('.c-button').hide();
    $('.comp-button').show();
    $('.sidebar-toggle').click(function(){
        $('.c-button').toggle();
        $('.comp-button').toggle();
        $('.nano').toggle();
        $('.mc').toggle();
        
    });        
});
   </script>
 <script type="text/javascript">
   $(document).ready(function(){
   $('.demo').initial({
   	name: 'Name', // Name of the user
   	charCount: 1, // Number of characherts to be shown in the picture.
   	textColor: '#ffffff', // Color of the text
   	seed: 0, // randomize background color
   	height: 100,
   	width: 100,
   	fontSize: 60,
   	fontWeight: 400,
   	fontFamily: 'HelveticaNeue-Light,Helvetica Neue Light,Helvetica Neue,Helvetica, Arial,Lucida Grande, sans-serif',
   	radius: 1
   	})
   });

</script>
  </body>

</html>

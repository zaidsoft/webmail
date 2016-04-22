<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

</head>
<body>
	
           	<!-- <div class="nano-content">    -->        
          <ul class="nano-content"> 
             
        	  
          
			 <!--  <li class="list-con pop" data-toggle="popover" data-placement="right" data-html="true" data-container="body"><a href="#"><img data-name="luqman quadri" class="demo user-image" alt="User Image">luqman Quadri</a></li>
          	  <li class="list-con pop" data-toggle="popover" data-placement="right" data-html="true" data-container="body"><a href="#"><img data-name="David Warner" class="demo user-image" alt="User Image">David warner</a></li>
          	  <li class="list-con pop" data-toggle="popover" data-placement="right" data-html="true" data-container="body"><a href="#"><img data-name="sultan" class="demo user-image" alt="User Image">Sultan mirza</a></li>
          	  <li class="list-con pop" data-toggle="popover" data-placement="right" data-html="true" data-container="body"><a href="#"><img data-name="quadri" class="demo user-image" alt="User Image">Quadri abdul </a></li>
          	  <li class="list-con pop" data-toggle="popover" data-placement="right" data-html="true" data-container="body"><a href="#"><img data-name="Tom Cruze" class="demo user-image" alt="User Image">tom Cruze</a></li>
          	  <li class="list-con pop" data-toggle="popover" data-placement="right" data-html="true" data-container="body"><a href="#"><img data-name="Shubhra" class="demo user-image" alt="User Image">Shubhra Yadav</a></li>
          	  <li class="list-con pop" data-toggle="popover" data-placement="right" data-html="true" data-container="body"><a href="#"><img data-name="Naim" class="demo user-image" alt="User Image">naim ahmad</a></li>
          	  <li class="list-con pop" data-toggle="popover" data-placement="right" data-html="true" data-container="body"><a href="#"><img data-name="virat" class="demo user-image" alt="User Image">virat kohli</a></li>
          	  <li class="list-con pop" data-toggle="popover" data-placement="right" data-html="true" data-container="body"><a href="#"><img data-name="maxwell" class="demo user-image" alt="User Image">Maxwell</a></li>
          	  <li class="list-con pop" data-toggle="popover" data-placement="right" data-html="true" data-container="body"><a href="#"><img data-name="shane" class="demo user-image" alt="User Image">Shane Watson</a></li>
          	  <li class="list-con pop" data-toggle="popover" data-placement="right" data-html="true" data-container="body"><a href="#"><img data-name="sonalika" class="demo user-image" alt="User Image">Sonalika</a></li> -->
          	  
          	  
    
         </ul> 
        
       <!--  <div id="popover-content" class="hide">
       
         <ul class="contact-popover-box">
				<li class="user-img-name">
                    <img src="WM-Resources/img/profile.png" class="img-circle" alt="User Image">
                    <p>
                      Syed Luqman Quadri
                      <small>luqman.quadri@gmail.com</small>
                    </p>
                  </li>
					<li class="user-footer">
                    <div class="pull-left">
                      <a href="#" class="btn btn-default btn-flat">Send Email</a>
                    </div>
                    <div class="pull-right">
                      <a href="#" class="btn btn-default btn-flat">View Conversation</a>
                    </div>
                  </li>
                </ul>  
               
    </div>  -->
        
        
        
        
        
       
        
         <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
         
        
        <script type="text/javascript">
  
$(document).ready(function(){   	// calling servlet and retrieving ajax response
	var flag=0;
	$.ajax({
		  type: 'POST',
		  url: '../ConListGenerator',
		  dataType: 'text',
		  success: function(ajaxData) {
			 // alert(ajaxData);
		    var data = ajaxData.replace(/\[/g , "");
		    //alert(data);
		    		 
		    var array = data.split(', ');
		   // alert(array);
		    var count = array.length;
		    //alert(count);
		    	var cl = '';
		    	 for(var i=0;i<count; i++)
		    		{	 
			    		cl = '<li class="list-con pop" data-toggle="popover" data-placement="right" data-html="true" data-container="body"><a href="#"><img data-name= '+array[i]+' class="demo user-image" alt="User Image">'+array[i]+'</a></li>';
			    		$(".nano-content").append(cl);
		    		}
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
		    		   	});

		    	   
		    	   var url = "ui-resources/scroll-bar/js/jquery.nanoscroller.js";
		    	   $.getScript( url, function() {
		    		  alert("nano"); 
		    	   });
		    	  /* var url = "ui-resources/scroll-bar/js/main.js";
		    	   $.getScript( url, function() {
		    		  alert("main"); 
		    	   });  */
		    	   var url = "ui-resources/js/conlistjs.js";
		    	   $.getScript( url, function() {
			    		  alert("wmbst"); 
			    	   });  
		    	   $.getScript( "ui-resources/scroll-bar/js/main.js" )
		    	   .done(function() {
		    	     alert( "main" );
		    	   })
		    	   .fail(function( jqxhr, settings, exception ) {
		    	     alert( "Triggered ajaxError handler." );
		    	 });
		    	   
		    	   /* var tem="<script type=\"text/javascript\" src=\"ui-resources/scroll-bar/js/jquery.nanoscroller.js\"><\/script>";
					var mm ="<script type=\"text/javascript\" src=\"ui-resources/scroll-bar/js/main.js\"><\/script>";
						  
				    $(".nano").append(tem+mem); */
		    	   
		    	   
		  },
		  error: function() {
		    alert('Error loading data');
		  }
		});
			
	
		    
	
		    /* var theScript = document.createElement("script");
			theScript.setAttribute("type","text/javascript");
			theScript.setAttribute("src", "ui-resources/scroll-bar/js/jquery.nanoscroller.js");
			document.getElementsByTagName("head")[0].appendChild(theScript);
			
			var theScript2 = document.createElement("script");
			theScript2.setAttribute("type","text/javascript");
			theScript2.setAttribute("src", "ui-resources/scroll-bar/js/main.js");
			document.getElementsByTagName("head")[0].appendChild(theScript2); */
		   

});
</script>




 <!-- <script src="ui-resources/js/webmail.js"></script> 
  <script src="ui-resources/scroll-bar/js/jquery.nanoscroller.js"></script> 
   <script src="ui-resources/scroll-bar/js/main.js"></script>  -->

</body>
</html>
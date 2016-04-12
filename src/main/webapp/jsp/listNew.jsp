
 <%@page import="java.util.List"%>
<%@page import="com.zaidsoft.webmail.IMAPBean.ListRow"%>
<%@page contentType="text/html"%>
<%@page import="com.zaidsoft.webmail.*" %>
<%@page import="javax.mail.internet.*" %>
<%@ include file="checkLogin.jsp"%>

<jsp:useBean id="genPurposeImapObj" scope="session" class="com.zaidsoft.webmail.IMAPBean" />
<% 
    String folder = request.getParameter("folder");
    if ( folder != null )
    genPurposeImapObj.setFolder(folder);
    else folder = genPurposeImapObj.getFolderName();
    genPurposeImapObj.refresh();
    session.setAttribute("jspTreeImpl", genPurposeImapObj);
    
    
 String s = request.getParameter("page");
 if (s == null) s = "1";
 int p = Integer.parseInt(s);  
 String uname= genPurposeImapObj.getUsername();
 int unreadMsg = genPurposeImapObj.getTotalUnreadMessages();
 int totalMsg = genPurposeImapObj.getMessageCount();
 int x=0; int y =0; int z =0;     // showing paginator as -- x to y of z
 z= totalMsg;
 if(z<20)
 	 {
	 y = totalMsg;
	 }
 
%>

      <div class= "main-content">
     	<div class="container-fluid">
     	
     		<div class="row">
     			<div class="col-md-12">
     			<div class="content">
     			<div class="page-info">
     			<h3>Inbox</h3> &nbsp;&nbsp;&nbsp; <small> You have <%=genPurposeImapObj.getMessageCount()%> messages</small>
     			
     			
     			
     			<div class="pull-right">
                      1-20/<%=genPurposeImapObj.getMessageCount()%>
                      <div class="btn-group">
                        <button class="btn btn-default btn-sm"  <%= ( p <= 1 ) ? "disabled=\"true\"" : "" %> onClick="document.location.href='list.jsp?folder=<%=folder%>&page=<%=p-1%>'"><i class="fa fa-chevron-left"></i></button>
                        <button class="btn btn-default btn-sm"  <%= ( p == genPurposeImapObj.getMessageCount()) ? "disabled=\"true\"" : "" %> onClick="document.location.href='list.jsp?folder=<%=folder%>&page=<%=p+1%>'"> <i class="fa fa-chevron-right"></i></button>
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
     				
     			
     			</div>
     			
   <div class="email-table">          
  <table class="table">


<%-- <tr bgcolor="#ffffcc">
    <td class="ask"><INPUT class = "on-ask" name="<%=i%>" type="checkbox"></td>
    <td class="ask">&nbsp;<%= m.isAttachment() ? "A" : ""%>&nbsp;</td>
    <td class="ask">&nbsp;<%=m.getFrom()%>&nbsp;</td>
    <td class="ask"><a href="show.jsp?folder=<%=folder%>&msgID=<%=m.getMessageID()%>">
        &nbsp;<%=m.getSubject()%>&nbsp;</a>
    </td>
    <td class="ask"><%=m.getDate() %></td> 
    <td class="ask" align="right"><%=m.getSizeK()%>k&nbsp;</td>
</tr> --%>

    <tbody>
    <%
 List<ListRow> mrows = genPurposeImapObj.buildPageSummary(p);
 for (int i = mrows.size() -1; i >= 0; i--){ 
    ListRow m = mrows.get(i);
    String paperClip = "";
    String seen="";
    if(m.isAttachment()){
    	paperClip = "fa fa-paperclip";
    	System.out.println("-=-==-=-Attatchment =-=-=-=- "+paperClip);}
    if(m.isSeenflag())
    	seen = "seen";
    else seen = "unseen";
    
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
     			
     		</div>
    	</div> 
      </div>
     </div>
      
      
      
     <!-- /.  Inbox messages ends -->
         
      
      <!-- Add the sidebar's background. This div must be placed
           immediately after the control sidebar -->
      <div class="control-sidebar-bg"></div>
    </div><!-- ./main content -->


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@page import="com.gen.cms.assets.beans.*"%> 
<%@page import="java.util.ArrayList"%> 
<%@page import="java.sql.ResultSet"%>
<%@ page import = "java.io.*,java.util.*" %>
<%@ page import = "javax.servlet.*,java.text.*" %>

<HTML>
<HEAD>
<%@ page 
language="java"
contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"
%>
<%@ page import="com.gen.cms.assets.beans.*"%>
<%@ page import="java.util.*"%>
<%@ page errorPage="../../error.jsp" %>
<%@ include file="../cookieTracker/CookieTrackerTop.jsp" %> 
<%String browserType=(String)request.getHeader("User-Agent");
	System.out.println("Browser Type "+browserType); 
	Assets_DBQueries dbVer=new Assets_DBQueries();
	String version=dbVer.BrowserVersion(browserType);
	float ver=11;
	if(!version.isEmpty())
	{
	ver=Float.parseFloat(version);
	}
	System.out.println("Version of IE "+ver);
	if(ver<11.0){%>
		<!-- Code Comes here -->
	<%}else if(version.isEmpty()){%>
		 <meta http-equiv="X-UA-Compatible" content="IE=edge">
		 <meta name="viewport" content="width=device-width, initial-scale=1">
		 <meta name="robots" content="noindex, nofollow">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.1/css/bootstrap-select.css" />
	    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.1/js/bootstrap-select.js"></script>
	<%} %>
<META http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<META name="GENERATOR" content="IBM WebSphere Studio" />
<META http-equiv="Content-Style-Type" content="text/css" />
<LINK href="../../stylesheet/main.css" rel="stylesheet" type="text/css" />
<SCRIPT language="javascript" src="../../javascript/AssetsJS/Assets_Sub_Cate.js"> </SCRIPT>
<SCRIPT language="javascript" src="../../javascript/Validate.js"></SCRIPT>
<script language="javascript" src="../../javascript/popcalendar.js"></script>
<jsp:useBean id="assetManager" class="com.gen.cms.assets.beans.Assets_DBQueries"></jsp:useBean>

<TITLE>Assets Transfer</TITLE>
<script>
function display(id)
		{
			document.Assets_transfer.req_id.value=id;
			var val=document.Assets_transfer.req_id.value;
			document.Assets_transfer.action="../../AssetsServlet";
			document.Assets_transfer.submit();		
		}
function ReSend(id)
		{
			document.Assets_transfer.req_id.value=id;
			document.Assets_transfer.swap.value=1;
			var val=document.Assets_transfer.req_id.value;
			document.Assets_transfer.action="../../AssetsServlet";
			document.Assets_transfer.submit(); 		
		}
</script>
<style>
#tbl{
  border-collapse: collapse;
   border: 1px solid black;
   width: 100%;
}
td, th{
 border-collapse: collapse;
   border: 1px solid black;
}
</style>
</HEAD>
<%
	String Edate=request.getParameter("entry_date");
	String mCat=request.getParameter("main_cat");
	String sCat=request.getParameter("sub_cat");
	System.out.println("Value of sub cat="+mCat);
	System.out.println("Value of a sub category "+sCat);
	ResultSet res1=null;
	String msg=(String)session.getAttribute("error"); 
 	session.removeAttribute("error");
 	System.out.println("message "+msg);
    Date dNow = new Date( );
    SimpleDateFormat ft = new SimpleDateFormat ("M-dd-yyyy");
    String dta=ft.format(dNow);     
   	int count=1;
   	String main_name="";
   	String sub_name="";	
   	String status="";
   	ArrayList set=new ArrayList();	
	ArrayList cool=assetManager.selectAssetTransfer(6, email,"","");
	
	System.out.println("Status "+cool);
 %>		
<body>
<form name="Assets_transfer"  method="post" action="">
<input type="hidden" name="ActionId" value="AssetsTransfer">
<input type="hidden" name="email" value="<%=email%>">
<input type="hidden" name="Task" value="Add">
<input type="hidden" name="op" value="4">
<input type="hidden" class="btn" value="" name="req_id" id="req_id">
<input type="hidden" name="swap" value="">
<div class="container-fluid">
	<h5>Asset Transfer Status</h5>
	<hr/>
	<table class="table" id="tbl" >
		<tr>
			<th>Sl No</th>
			<th>Asset Name</th>
			<th>Asset Reference Number</th>
			<th>Current Hod Status</th>											
			<th>Transfer Hod Status</th>
			<th>MT Status</th>
			<th>Final Step</th>
		 </tr>
			<% 
					for(int i=0;i<cool.size();i++)
						{
						ArrayList ar=(ArrayList)cool.get(i);
						ArrayList ar2=assetManager.AssetTransferRefAname(ar.get(0).toString());
						System.out.println("");
						String ref="";
						String name="";			
						for(int r=0;r<ar2.size();r++)
						{
							ArrayList refN=(ArrayList)ar2.get(r);
							name=""+refN.get(0);
							ref=""+refN.get(1);
						}	
			%>
			<TR>	
					
					
						<td>
						<input type="hidden" value="<%=ar.get(20)%>" name="tr_sh_name">
						<%=count %></td>
						<td><%=name %></td>
						<td><%=ref %></td>
						<td><%if(ar.get(7).equals("0"))
							{%>
							<font size="2" color="black">Pending</font><br/>
							<%=ar.get(19)%> <br/>
							<%=ar.get(8)%>
							
							<% }else if(ar.get(7).equals("1")){ %>
							<font size="2" color="green">Approve</font><br/>
							<%=ar.get(19)%> <br/>
							<%=ar.get(8) %>
							<%  }else if(ar.get(7).equals("2")){ %>
							<font size="2" color="red">Transfer Cancel</a></font><br/>
							<%=ar.get(19)%> <br/>
							<%=ar.get(8) %>
							<%} %>
							
							</td> 
							
						<td><%if(ar.get(9).equals("0"))
							{%>
							<font size="2" color="black">Pending</font><br/>
							<%=ar.get(20)%> <br/>
							<%=ar.get(10) %>
							<%}else if(ar.get(9).equals("1")){ %>
							<font size="2" color="green">Approve</font><br/>
							<%=ar.get(20)%> <br/>
							<%=ar.get(10) %>
							<%}else if(ar.get(9).equals("2")){ %>	
							<font size="2" color="red">Transfer Cancel</a></font><br/>
							<%=ar.get(20)%> <br/>
							<%=ar.get(10) %>
							<%} %>
							
							</td> 
						<td><%if(ar.get(11).equals("0"))
							{%>
							<font size="2" color="black">Pending</font><br/>
							MT <br/>
							<%=ar.get(12) %>
							<%}else if(ar.get(11).equals("1")){ %>
							<font size="2" color="green">Approve</font><br/>
								MT <br/>
							<%=ar.get(12) %>
							<%}else if(ar.get(11).equals("3")){ %>	
							<font size="2" color="red">Rejected</a></font><br/>
							MT <br/>
							<input type="button" value="Re-Send" onclick="ReSend(<%=ar.get(0)%>)">
							<%=ar.get(12) %>
							<%} %>
							
							</td> 
							<td>
							<%if(ar.get(7).equals("1") && ar.get(9).equals("1") && ar.get(11).equals("1")){ %>
								<%-- <a href="AssetsServlet.java?assetId=<%=ar.get(0)%>&assetno=<%=ar.get(1)%>">Click Here</a> --%>
								 <input type="button" value="Submit" onclick="display(<%=ar.get(0)%>)">
							</td>
			
					</TR>
		<%} %>
		<%count=count+1; %>
		<%}%>
	</table>
	

<div align="left" style="font-size:15px">
		<font color="#FF0000"><%if(msg!=null){%>&nbsp;<%=msg%><%} %></font>	
	</div>
</div>
</form>
</body>

  <%}else{ %>
<%@include file="../cookieTracker/CookieTrackerBottom.jsp" %>
<%} %>
</HTML>
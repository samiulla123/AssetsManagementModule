<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@page import="com.gen.cms.assets.beans.*"%> 
<%@page import="java.util.ArrayList"%> 
<%@page import="java.sql.ResultSet"%>
<%@ page import = "java.io.*,java.util.*" %>
<%@ page import = "javax.servlet.*,java.text.*" %>

<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
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

<TITLE>AdminCreateNation.jsp</TITLE>

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
	HttpSession s1=request.getSession();
	Assets_DBQueries db=new Assets_DBQueries();
	ArrayList sub_names=db.getStatusVal(email);
	ArrayList arrL= new ArrayList();
	ArrayList res1=new ArrayList();	
	ArrayList fetch=new ArrayList();
	String msg1=(String)session.getAttribute("msg");
	session.removeAttribute("msg");
	int count=0;
 %>		
<body><br/>
<form name="AssetsStatus" method="post">
<input type="hidden"  name="ActionId" value="UpdateAssetsReg">
<input type="hidden" name="Task" value="Add">
<div class="container-fluid">
<h5>Assets Register Status</h5>
<hr/>
<table class="table table-hover" id="tblfdsf" style="width:100%;">
	<tr>
		<th>S.No</th>
		<th>Sub Category</th>
		<th>Date</th>
		<th>Status</th>
		<th>Comments</th>
		</tr>
		<%for (int i=0;i<sub_names.size();i++){ %>
		<%ArrayList ar=(ArrayList)sub_names.get(i); %>
		<%ArrayList str=new ArrayList(); %>
		<tr>
		 <td>
		 <%count=count+1; %>
		 	
		 	<%=count %>
		 </td>
		 <td>
		 	<%=ar.get(20) %>
		 </td>
		<td>
			<%
			 String date=""+ar.get(17);
	         Date dNow = new SimpleDateFormat("yyyy-MM-dd").parse(date); 
	         SimpleDateFormat ft =new SimpleDateFormat ("dd-MM-yyyy");  
	      
      %>
		 	<%=ft.format(dNow) %>
		 </td>
		  <td>
		  <%if(ar.get(18).equals("0")) {%>
		 	
		 		<label>Pending</label>
		 		<%} %>
		  <%
		  if(ar.get(23)!=null){
		  
				 String date2=""+ar.get(23);
		         Date dNow2 = new SimpleDateFormat("yyyy-MM-dd").parse(date2); 
		         SimpleDateFormat ft2 =new SimpleDateFormat ("dd-MM-yyyy");
		         System.out.println("Equals to zero "+ar.get(18).equals("0")+" vale "+ar.get(18)+" notes "+ar.get(19));
     		 %>
		 		<%if(ar.get(18).equals("2")){ %>
		 		<a href="Assets_Update_Register.jsp?userId=<%=ar.get(0)%>" ><font color="red"> Reject</font></a>
		 		<br/><label><%=ar.get(22)%></label><br/>	
		 		<label><%=ft2.format(dNow2) %></label><br/>
		 		<label><%=ar.get(24) %></label>
		 		<%}else if(ar.get(18).equals("1")){ %>
		 		<label><font color="green">Approved</font></label>
		 		<br/><label><%=ar.get(22)%></label><br/>	
		 		<label><%=ft2.format(dNow2) %></label><br/>
		 		<label><%=ar.get(24) %></label>
		 		<%}else if(ar.get(18).equals("3")){ %>
		 		<label><font color="orange">Discard</font></label>
		 		<br/><label><%=ar.get(22)%></label><br/>	
		 		<label><%=ft2.format(dNow2) %></label><br/>
		 		<label><%=ar.get(24) %></label>
		 		<%} }%>
		 </td>
		  <td>
		 	<ol>
		 	<% 
		 			String id=""+ar.get(0);
					arrL=db.selectAssetsStstusData(id);
					for(int j=0;j<arrL.size();j++){
		 			ArrayList arr=(ArrayList)arrL.get(j);
		 		%><%if(ar.get(18).equals("0")) {%>
		 			
		 		<%}else if(ar.get(18).equals("2")){ %>
		 			<%
				 String date1=""+arr.get(0);
		         Date dNow1 = new SimpleDateFormat("yyyy-MM-dd").parse(date1);   
		         SimpleDateFormat ft1 =new SimpleDateFormat ("dd-MM-yyyy");
     		 %>
  			   	<li><%=arr.get(2) %><br/>Status_On (<%=ft1.format(dNow1) %>)</li>
		 		<%}else if(!arr.get(2).toString().isEmpty()){ %>
		 				<%
				 String date1=""+arr.get(0);
		         Date dNow3 = new SimpleDateFormat("yyyy-MM-dd").parse(date1); 
		         SimpleDateFormat ft1 =new SimpleDateFormat ("dd-MM-yyyy");
     		 %>	
		 		<li><%=arr.get(2) %><br/>Status_On (<%=ft1.format(dNow3) %>)
		 	<%} }%>
		 	</ol>
		 </td>
	</tr>
<%} %>
</table>
</div>
<div>
	<font color="#FF0000" size="2px"><%if(msg1!=null){ %><%=msg1 %><%} %></font><br/>
</div>
</form>
</body>
  <%}else{ %>
<%@include file="../cookieTracker/CookieTrackerBottom.jsp" %>
<%} %>
</HTML>
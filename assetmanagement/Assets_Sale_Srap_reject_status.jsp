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
}
td, th{
 border-collapse: collapse;
   border: 1px solid black;
}
</style>
<script>
	function resend(id)
	{
		document.AssetsStatus.option.value=2;
		document.AssetsStatus.req_id.value=id;
		var v=document.AssetsStatus.option.value;
		document.AssetsStatus.action="../../AssetsServlet";
		document.AssetsStatus.submit();
	}
	function resendMT(id)
	{
		document.AssetsStatus.option.value=3;
		document.AssetsStatus.req_id.value=id;
		var v=document.AssetsStatus.option.value;
		document.AssetsStatus.action="../../AssetsServlet";
		document.AssetsStatus.submit();
	}
	function Scrap(id)
	{
		document.AssetsStatus.option.value=1;
		document.AssetsStatus.req_id.value=id;
		document.AssetsStatus.action="../../AssetsServlet";
		document.AssetsStatus.submit();
	}
</script>
</HEAD>
<%
	HttpSession s1=request.getSession();
	Assets_DBQueries db=new Assets_DBQueries();
	ArrayList sub_names=db.getSaleScrapStatusVal(email);
	System.out.println("Data fetch "+sub_names);
	String sub_id="";
	ArrayList arrL= new ArrayList();
	ArrayList res1=new ArrayList();	 
	ArrayList fetch=new ArrayList();
	String msg1=(String)session.getAttribute("error");
	session.removeAttribute("error");
	int count=0;
 %>		
<body><br/>
<form name="AssetsStatus" method="post">
<input type="hidden"  name="ActionId" value="ScrapSale">
<input type="hidden" name="Task" value="Add">
<input type="hidden" name="option" value="">
<input type="hidden" name="req_id" value="">
<input type="hidden" name="op" value="4">
<div class="container-fluid">
<h5>Assets Scrap/Sale Status</h5>
<hr/>
<table class="table" id="tbl" style="width:100%;">
	<tr>
		<th>S.No</th>
		<th>Asset Name</th>
		<th>Asset Reference Number</th>
		<th>HOD Status</th>
		<th>MT Status</th>
		<th>Click On Below Button</th>
		</tr>
		<%for (int i=0;i<sub_names.size();i++)
		{ %>
			<%ArrayList ar=(ArrayList)sub_names.get(i); 
				ArrayList result=db.AssetSaleScrapRefAname(ar.get(0).toString());
				System.out.println("Reference Number "+result);
				String name="";
				String ref="";
				for(int r=0;r<result.size();r++){
				ArrayList d=(ArrayList)result.get(r);
					name=""+d.get(0);
					ref=""+d.get(1);
				}
				System.out.println("Reference number== "+name+" ===reference== "+ref);%>
			<%ArrayList str=new ArrayList();
			 %>
			<tr>
			 <td>
			 <%count=count+1; %> 	
			 	<%=count %>
			 </td>
			 <td><%=name %></td>
			 <td><%=ref %></td>
			  <td>
			 	<%if(ar.get(4).equals("0")) {%>
			 	
			 		<label>Pending</label>
			 		
			 		<%}else if(ar.get(4).equals("2")){ %>
			 		<font color="red"> Reject</font>
			 		<input type="submit" name="" value="Re-Send" class="btn-success" style="background-color: White; color: black; border: 2px solid #4CAF50; border-radius: 12px;" onclick="resend(<%=ar.get(0)%>)">
			 		<br/><label><%=ar.get(5)%></label><br/>
			 		<label><%=ar.get(10) %></label>
			 		<%}else if(ar.get(4).equals("1")){ %>
			 		<label><font color="green">Approved</font></label>
			 		<%}else if(ar.get(4).equals("3")){ %>
			 		<label><font color="blue">Scrap/Sale</font></label>
			 		<%} %>
			 </td>
			 <td>
			 	<%if(ar.get(6).equals("0")) {%>
			 	
			 		<label>Pending</label>
			 		
			 		<%}else if(ar.get(6).equals("2")){ %>
			 		<font color="red"> Reject</font>
			 		<input type="submit" name="" value="Re-Send" class="btn-success" style="background-color: White; color: black; border: 2px solid #4CAF50; border-radius: 12px;" onclick="resendMT(<%=ar.get(0)%>)">
			 		<br/><label><%=ar.get(7)%></label><br/>
			 		<label>MT</label>
			 		<%}else if(ar.get(6).equals("1")){ %>
			 		<label><font color="green">Approved</font></label>
			 		<%}else if(ar.get(6).equals("3")){ %>
			 		<label><font color="blue">Scrap/Sale</font></label>
			 		<%} %>
			 </td>
			  <td colspan="1" style="text-align: center;">
			 <%if(ar.get(6).equals("1") && ar.get(4).equals("1")){%>
				 	<input type="submit" name="" value="Scrap/Sale" class="btn-success" style="background-color: white; color: black; border: 5px solid #4CAF50; border-radius: 12px;" onclick="Scrap(<%=ar.get(0)%>)">
				 	</td>
			 <%} %>
			<%--   <td>
			 	<ol>
			 	<% 
			 			String id=""+ar.get(0);
			 			System.out.println("Assets status reg number "+id);
						arrL=db.selectAssetsSS_StstusData(id);
						System.out.println("Array list assets sal scrap status "+arrL);
						for(int j=0;j<arrL.size();j++){
			 			ArrayList arr=(ArrayList)arrL.get(j);
			 		%><%if(ar.get(20).equals("6")){ %>
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
		 </td> --%>
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
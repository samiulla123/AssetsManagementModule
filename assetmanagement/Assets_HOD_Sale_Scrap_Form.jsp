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

<TITLE>AdminCreateNation.jsp</TITLE>
<script>
	function reload()
	{
		
		document.hod_hoi.action="";
		document.hod_hoi.submit();
	}
	
	function display()
	{
		if(document.getElementById("cmnt").style.visibility==="hidden")
		{
			document.getElementById("cmnt").style.visibility="visible";
		}
		else if(document.getElementById("cmnt").style.visibility==="visible")
		{
			document.getElementById("cmnt").style.visibility="hidden";
		}
	}	
	function transfer()
	{
		document.hod_hoi.status123.value=1;		
		document.hod_hoi.action="../../AssetsServlet";
		document.hod_hoi.submit(); 
	}
	function validate()
	{
		var cmn=document.hod_hoi.txtMsg.value;
		document.hod_hoi.status123.value=0;
		if(cmn=="")
			{
			alert("Please Enter Reason For Regection");
			document.hod_hoi.txtMsg.focus();
			return false;
			}
		else
		{
			document.hod_hoi.action="../../AssetsServlet";
			document.hod_hoi.submit();
		}
	}

	
</script>
<style>
td{
	text-align: center;
}
</style>
</HEAD>
<%
	String sub_id=request.getParameter("userId");
	System.out.println("In Assets update register "+sub_id);
	Assets_DBQueries db=new Assets_DBQueries();
	String user_name=email;
	ArrayList res=db.saleScrapTableFetch(sub_id);
	String cret_by="";
	String reason="";
	
	for(int n=0;n<res.size();n++)
	{
		ArrayList data=(ArrayList)res.get(n);
		cret_by=data.get(10).toString();
		reason=data.get(8).toString();	
	}
	ArrayList res23=db.selectAssetsSaleScrapData(sub_id);
	System.out.println("Sub register numbers"+res23);
	System.out.println("Proc MSI id "+res23.size() );
	
 %>		
<body>
<form name="hod_hoi"  method="post" >

<input type="hidden" name="ActionId" value="ScrapSale">
<input type="hidden" name="email" value="<%=email%>">
<input type="hidden" name="op" value="3">
<input type="hidden" name="Task" value="Add">
<input type="hidden" name="status123" value="">
<input type="hidden" name="reg_id" value="<%=sub_id%>">
	<div class="container-fluid">
<table class="table table-striped"  border=2 style="border-collapse: collapse; width:100%">
	<h5>Update Assets</h5>
	
	<tr>
		<th>Asset Name</th>
		<th>Assets Number</th>
		<th>Detail Of Assets</th>
		<th>Purchase Amount</th>
		<th>Scrap/Sale Request Raise By</th>
		<th>Reason</th>
	</tr>
	
	<%for (int i=0;i<res23.size();i++) 
	{%>
		<%ArrayList arr=(ArrayList)res23.get(i); %>
		<%
		for(int j=0;j<arr.size();j++)
		{
			  System.out.println("Array List Value "+arr); 
			  System.out.println("Array fetch "+arr.get(0));
			  String reg_id=arr.get(0).toString().replace("[","").replace("]","");
			  System.out.println("String "+arr.get(0));
			  ArrayList Str1=db.saleScrapAssetRegisterData(reg_id);
			  for(int k=0;k<Str1.size();k++)
			  {
				  	ArrayList ar=(ArrayList)Str1.get(k);
	
				 %>
				<tr>
					<td>
						<label><%=ar.get(20) %></label>
						<input type="hidden" name="SName" value="<%=ar.get(1)%>">
					</td>
					<td>
						<label><%=ar.get(11)%></label>
					</td>
					<td>
						<label><%=ar.get(4)%></label>
					</td>
					<td>
						<label><%=ar.get(9)%></label>
					</td>
					<td>
						<label><%=cret_by%></label>
					</td>
					<td>
						<label><%=reason%></label>
					</td>
				</tr>
			<%} %>
		<%} %>
	<%} %>	
</table>

<center>
		<input type="hidden" value="1" name="AppStatus">
		<center><input class="btn" id="btn" type="button" name="approve" value="Approve" onclick="transfer()"/> 
		<input class="btn" id="btn"  type="button"  name="approve" value="Reject" onclick="display()"/></center><br/>
</center>
		<div class="form-group">
				<div style="">
					<p id="cmnt" style="visibility:hidden;">
					<label>Enter Your Message Here<font color="red">(Its Mandatory)</font></label>
			
						<textarea id="txtArea" class="form-control" id="cmnt" name="txtMsg" style="background-color:#FFECEC ; size:50; width:70%; height:40%" onkeypress="return (event.keyCode!=39)"></textarea>
						<input class="btn" type="button" value="submit" name="rej_submit" style="" onclick="validate()">
					</p>
				</div>
				</div>
	</div>
</form>
</body>
  <%}else{ %>
<%@include file="../cookieTracker/CookieTrackerBottom.jsp" %>
<%} %>
</HTML>
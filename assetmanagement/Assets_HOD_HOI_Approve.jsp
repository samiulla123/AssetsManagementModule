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
	
			document.hod_hoi.status123.value=0;		
			document.hod_hoi.action="../../AssetsServlet";
			document.hod_hoi.submit(); 
	}
	
</script>
<style>
.btd{
	text-align: center;
}
</style>
</HEAD>
<%
	String sub_id=request.getParameter("userId");
	System.out.println("In Assets update register "+sub_id);
	Assets_DBQueries db=new Assets_DBQueries();
	String user_name=email;
	ArrayList res23=db.selectAssetsRegisterData2(sub_id);
	String msci_id=""+res23.get(0).toString().replace("[","").replace("]","");
	System.out.println("MSCI Id "+msci_id);
	System.out.println("Array value of "+res23.get(0));
	System.out.println("Proc MSI id "+res23 );
 %>		
<body>
<form name="hod_hoi"  method="post" >

<input type="hidden" name="ActionId" value="UpdateAssets">
<input type="hidden" name="email" value="<%=email%>">
<input type="hidden" name="Task" value="Add">
<input type="hidden" name="status123" value="">
	<div class="container-fluid">
		<table class="table table-striped"  border=4 style="border-collapse: collapse; width:100%">
	<h5>New Asset Requests</h5>
	<%for (int i=0;i<res23.size();i++) {%>
	<%ArrayList ar=(ArrayList)res23.get(i); %>
	<%System.out.println("Array List Value "+ar); %>
	<% %>
	<tr>
		<td>
			<input type="hidden" id="as_id" name="Sub_id" value="<%=sub_id%>">
			<% System.out.println("sub cat name "+sub_id);%>
			Main Category 
		</td>
		<td>
			<label><%=ar.get(19) %></label>
		</td>
	</tr>
	<tr>
		<td>
			Sub Category 
		</td>
		<td>
			<input type="hidden" name="sub_name" value="<%=ar.get(20)%>">
			<label><%=ar.get(20) %></label>
		</td>
	</tr>
	<tr>
		<td>
			Description
		</td>
		<td>
			<label><%=ar.get(4)%></label>
		</td>
	</tr>
	<tr>
		<td>
			Bill No
		</td>
		<td>
			<label><%=ar.get(5)%></label>
		</td>
	</tr>
	<tr>
		<td>
			Supplier Name
		</td>
		<td>
			<label><%=ar.get(7)%></label>
		</td>
	</tr>
	<tr>
		<td>
			Quantity
		</td>
		<td>
			<label><%=ar.get(8)%></label>
		</td>
	</tr>
	<tr>
		<td>
			Amount
		</td>
		<td>
			<label><%=ar.get(9)%></label>
		</td>
	</tr>
	<tr>
		<td>
			Department
		</td>
		<td>
			<label><%=ar.get(13)%></label>
		</td>
	</tr>
	<tr>
		<td>
			Created By
		</td>
		<td>
			<label><%=ar.get(15)%></label>
		</td>
	</tr>
	<tr>
		<td>
			Created At
		</td>
		<td>
			<label><%=ar.get(16)%></label>
		</td>
	</tr>
	<tr>
	<td>
			Reference Number 
		</td>
		<td>
			<label><%=ar.get(11)%></label>
		</td>
	</tr>
	<%} %>	
	<tr>
				<td class="btd">
					<input type="hidden" value="1" name="AppStatus">
					<input class="btn" type="button" name="approve" value="Approve" onclick="transfer()"/>
				</td>
				<td class="btd">
					<input class="btn" type="button" name="approve" value="Reject" onclick="display()"/><br/>
				</td>
			</tr>
</table>
		<div class="form-group">
				<div style="">
					<p id="cmnt" style="visibility:hidden;">
					<label>Enter Your Message Here<font color="red">(Its Mandatory)</font></label>
			
						<textarea id="txtArea" class="form-control" id="cmnt" name="txtMsg" style="background-color:#FFECEC ; size:50; width:70%; height:40%"  onkeypress="return (event.keyCode!=39)"></textarea>
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



<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@page import="com.gen.cms.assets.beans.*"%> 
<%@page import="java.util.ArrayList"%> 
<%@page import="java.sql.ResultSet"%>
<%@page import = "java.io.*,java.util.*" %>
<%@page import = "javax.servlet.*,java.text.*" %>

<HTML>
<HEAD>
<%@ page 
language="java"
contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"
%>
<%@ page import="java.util.*"%>
<%@ page import java.text.SimpleDateFormat;%>
<%@ page import java.util.Date; %>

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
</script>

</HEAD>
<%
	System.out.println("In html page");
	String arr=request.getParameter("assetId");
	String id=request.getParameter("assetno");
	System.out.println("Found value 1 id "+arr);
	System.out.println("Found value 2 value "+id);
	/* int dep_id=Integer.parseInt(id); */
	//id=department id
	//arr=assets register number
	Assets_DBQueries db=new Assets_DBQueries();
	
	ArrayList ar=db.selectAssetTransfer(7, email, arr, "");
	System.out.println("Data fetched is "+ar);
 %>		
<body>

<form name="Assets_transfer"  method="post" action="../../AssetsServlet">
<input type="hidden" name="ActionId" value="AssetsTransfer">
<input type="hidden" name="email" value="<%=email%>">
<input type="hidden" name="Task" value="Add">
<input type="hidden" name="op" value="4">
<div class="container-fluid">
	<div>
		<table>
		<tr>
			<td>
				<label>Click below button to finish final process and generate new reference number</label>
			</td>
		</tr>
		</table>
		<%for(int i=0;i<ar.size();i++){
		ArrayList arb=(ArrayList)ar.get(i);
		System.out.println("Id = "+arb.get(0)); 
		System.out.println("5S owner = "+arb.get(1));%>
			<input type="hidden" name="reg_no" value=<%=arb.get(0)%>>
			<input type="hidden" name="new_ref" value="<%=arb.get(1)%>">
			<input type="hidden" name="email" value="<%=email%>">
		<% } %>
		<input type="submit" value="Send" class="btn">
	</div>
</div>
</form>
</body>
  <%}else{ %>
<%@include file="../cookieTracker/CookieTrackerBottom.jsp" %>
<%} %>
</HTML>



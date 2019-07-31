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
<%
	String wdt="100";
	String browserType=(String)request.getHeader("User-Agent");
	System.out.println("Browser Type "+browserType); 
	Assets_DBQueries dbVer=new Assets_DBQueries();
	String version=dbVer.BrowserVersion(browserType);
	float ver=11;
	if(!version.isEmpty())
	{
	ver=Float.parseFloat(version);
	}
	System.out.println("Version of IE "+ver);
	if(ver<11.0){
	wdt="30";%>
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

<style>
.center {
    margin: auto;
  width: 50%;
  border: 3px solid green;
  padding: 10px;
  text-align: center;
    font-size: 150%;
}
.center2 {
  width: 20%;
   border: 1px solid;
  padding: 5px;
  font-size: 100%;
  text-align: center;
}
/* table, th, td {  
  border: 1px solid #ddd;
  text-align: left;
}

table {
  border-collapse: collapse;
  width: 100%;
} */

th, td {
  padding: 10px;
}
.center2 {
  width: 20%;
   border: 1px solid;
  padding: 5px;
  font-size: 100%;
  text-align: center;
}
</style>
<script type="text/javascript">
function displ(id)
{
	document.data.search.value=id;
	alert(document.data.search.value);
}
</script>
		<%/* AssetsDAO ad=new AssetsDAO(); */
		Assets_DBQueries db=new Assets_DBQueries();
		String data=request.getParameter("sub_id");
		String depar=request.getParameter("sub_name");
		String prog_id=request.getParameter("prog_id");
		System.out.println("Main Category "+data);
		System.out.println("Department "+depar);
		System.out.println("prog Id "+prog_id);%>
</HEAD>
	 <body>
	<form name="data" action="" method="post">
		<br>
		<br>
		<div class="container">
		<div class="">
			<div class="form-group">
				<div class="col-sm-5">
					<div class="input-group">
						
					<table style="width:<%=wdt%>%">
					<center><h3><b>Main Category</b>:<%=depar %></h3></center>
					<hr>	<tr>
							<th>Main Category</th>
							<th>Number Of<br/> Assets</th>
						</tr>
						<%	ArrayList Depart=assetManager.selectSubCategory(data);
							System.out.println("Department "+Depart);
							for(int a=0;a<Depart.size();a++)
							{
								ArrayList dep=(ArrayList)Depart.get(a);

									int numb=assetManager.sumAssetInSubCat(data, dep.get(0).toString(), prog_id);
									System.out.println("Data fetch is "+dep.get(1));
									String dep1=""+dep.get(1);
									%>
									<tr>
									<td><%=dep1%></td>
									<td><%=numb %></td>
									</tr>
							<% }%>
					</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
	</body> 
  <%}else{ %>
<%@include file="../cookieTracker/CookieTrackerBottom.jsp" %>
<%} %>
</HTML>
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
   text-align: center;
}


</style>
</HEAD>
<%
	Assets_DBQueries db=new Assets_DBQueries();
	ArrayList main_cat=db.selectMainCat();
	System.out.println("Assets Main Category "+main_cat);
	System.out.println("Report Generation ");
	
 %>		
<body>
<form name="hod_hoi"  method="post">
<div class="container-fluid">
<h5>Asset Report</h5>
 <%for(int i=0;i<main_cat.size();i++)
	{ 
		int count=1;
		ArrayList m_det=(ArrayList)main_cat.get(i);
		System.out.println("Main Category is "+m_det);
		ArrayList ass=db.AssetRegisterReporterMainCategory(email,m_det.get(0).toString());
		System.out.println("Main cat exists "+ass+" Is Empty "+ass.isEmpty());
		if(ass.isEmpty()){%>
			
		<%}else if(!ass.isEmpty())
		{ %>
			<br><font color="red" size="2px"><%=m_det.get(1).toString().toUpperCase() %></font>
			<table class="table" id="tbl">
				<tr class="Danger">
					<th>Sl.No</th>
					<th>Asset Name</th>
					<th>Description Of Assets</th>
					<th>Bill No</th>
					<th>Bill Date</th>
					<th>Reference Number</th>
					<th>Quantity</th>
					<th>Amount</th>
					<th>Register Date</th>
					<th>Bill Download</th>
				</tr>
				<%
				long in=0;
				try{
				 in=Integer.parseInt(m_det.get(0).toString());
				 }catch (NumberFormatException e)
				 {
				 	in=0;
				 }
				 ArrayList sub_cat=db.selectSubName(in);
				 System.out.println("_______Sub category_________ "+sub_cat); 
				for(int j=0;j<sub_cat.size();j++)
				{
					ArrayList s_cat = (ArrayList)sub_cat.get(j);
					System.out.println("Sub category id="+s_cat.get(0)+" Main category "+s_cat.get(1));
					System.out.println("Sub category id="+s_cat);
					ArrayList asset=db.AssetRegisterReporter(email,s_cat.get(0).toString());
					System.out.println("Result found for register "+asset);
					for(int k=0;k<asset.size();k++)
					{
						System.out.println("For loop");
						 ArrayList AR=(ArrayList)asset.get(k);
	     		 %>
						<tr class="Active">
							<td><%=count %></td>
							<td><%=AR.get(20)%></td>
							<td><%=AR.get(4) %></td>
							<td><%=AR.get(5) %></td>
							<%String date2=""+AR.get(6);
				         		Date dNow2 = new SimpleDateFormat("yyyy-MM-dd").parse(date2); 
				         		SimpleDateFormat ft1 =new SimpleDateFormat ("dd-MM-yyyy"); %>
							<td><%=ft1.format(dNow2) %></td>
							<td><%=AR.get(11) %></td>
							<td><%=AR.get(8) %></td>
							<td><%=AR.get(29) %></td>
							<%String date3=""+AR.get(17);
				         		Date dNow3 = new SimpleDateFormat("yyyy-MM-dd").parse(date3); 
				         		SimpleDateFormat ft2 =new SimpleDateFormat ("dd-MM-yyyy"); %>
							<td><%=ft2.format(dNow3)%></td>
							<%String file=""+AR.get(36);
							File fl=new File(file); 
							String name=fl.getName();
							String filePath=AR.get(34)+"/"+name;%>
							<td><a href="<%=filePath%>">Download</a></td>
						</tr>
						<%count=count+1; %>
					<%}%>
				<%} %>
			</table>
		<%} %>
  <%} %>	
</form>
</body>
  <%}else{ %>
<%@include file="../cookieTracker/CookieTrackerBottom.jsp" %>
<%} %>
</HTML>
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
function display()
{

	document.Assets_transfer.action="";
	document.Assets_transfer.submit();		
}
function validate()
{
	window.close();
}
function sendData()
{
	document.Assets_transfer.action="../../AssetsServlet";
	document.Assets_transfer.submit();
	window.opener.location.reload();		
	window.close();		
	window.close();
}
</script>
<style>
/* #tbl{
	border: 1px solid red;
	width: 80%;
	border-collapse: collapse;
	background-color:#DB9796;
}
#tbl, td{
	height: 50px;
  vertical-align: bottom;
} */
.center {
  width: 50%;
  border: 3px solid red;
  padding: 10px;
  text-align: center;
    font-size: 150%;
}
td{
	text-align: center;
}
</style>
</HEAD>
<%
	int i=1;
	String em=email;
	ArrayList ar3=new ArrayList();
	String str="";
	ArrayList res2=assetManager.selectAssetTransfer(i, email, str, "");
	System.out.println("Fetch transfer Data in jsp page "+res2+ " size "+res2.size());
	ArrayList trData=new ArrayList();	
	String msg=(String)session.getAttribute("error"); 
 	session.removeAttribute("error");
    Date dNow = new Date();
	ArrayList ar=new ArrayList();
 	int count=1;
	int sum=0;
	boolean flag=false;
 %>		
<body>

<form name="Assets_transfer"  method="post" action="">
<input type="hidden" name="ActionId" value="AssetsTransfer">
<input type="hidden" name="email" value="<%=email%>">
<input type="hidden" name="Task" value="Add">
<input type="hidden" name="op" value="1">
<div class="container-fluid">

	<div class="container-fluid">
	<h5>Assets Transfer Requests</h5>
	<%for(int k=0;k<res2.size();k++)
	 {
		ArrayList ar4=(ArrayList)res2.get(k);
		str=""+ar4;
		ArrayList res3=assetManager.selectAssetTransfer(2, email, str, ""); 
		System.out.println("Value  "+res3);
		if(!res3.isEmpty())
		{
			flag=true;
		}
	}
	System.out.println("Flag IS "+flag);
	if(flag==true){%>
		<table id="tbl" class="table" border=2 style="border-collapse: collapse; width:100%">
			<tr style="border-radius: 50px 20px;">
				<th>Sl No</th>
				<th>Click Below</th>
				<th>Transfer Department To</th>
				<th>Transfer Unit To</th>
			</tr>
			<%
			for(int k=0;k<res2.size();k++)
				{
					System.out.println("In for loop ");
					ArrayList ar4=(ArrayList)res2.get(k);
					str=""+ar4;
					System.out.println("assets Value is tr "+str+" fetch data "+ar4);
					ArrayList res3=assetManager.selectAssetTransfer(2, email, str, "");
					System.out.println("transfer data "+res3);		
			 %>
					<%if(!res3.isEmpty())
					{ %>
					
						<%
							for(int j=0;j<res3.size();j++)
							{
							    System.out.println("array list found "+res3.get(j));
								ar=(ArrayList)res3.get(j);
							    System.out.println("Size "+ar.size()); 
									
								 %>
								 <tr>
								<td>
									<%=count %>
								</td>
								<td>
									<a href="Assets_Transfer_Appr_Form.jsp?assetId=<%=ar.get(0)%>">View Details</a>
								</td>
								<td>
									<%=ar.get(4) %>
								</td>
								<td>
									<%=ar.get(5) %>
								</td>
								<%count=count+1; 
								sum=sum+1;%>
						<%}%>
					<%}%>
						</tr>
				<%}%>
		</table>
	<%}else{ %>
		<%System.out.println("Sum total of "+sum);
		if(sum==0){%><center><div id="rect" class="center"><p>No Request is Found &#128522;</p></div></center>
	 <%} %>
	<%} %>
</div>
	</div>
	<div <%if(msg!=null) {%>>
		<h4><%=msg %></h4>
		<%} %>
	</div>
</form>
</body>
  <%}else{ %>
<%@include file="../cookieTracker/CookieTrackerBottom.jsp" %>
<%} %>
</HTML>


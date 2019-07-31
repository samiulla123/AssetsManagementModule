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

<TITLE>HOD/HOI </TITLE>
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
</script>
<style>
.center {
  width: 50%;
  border: 2px solid black;
  padding: 10px;
  text-align: center;
    font-size: 150%;
    margin-top:10%;
  background: linear-gradient(35deg, #ff99dd, #99b3ff, #ccffcc);
}
td, th{
	text-align: center;
}
</style>
</HEAD>
<%
	String msg1=(String)session.getAttribute("msg");
	session.removeAttribute("msg");
	String msg2=(String)session.getAttribute("error");
	session.removeAttribute("error");
	Assets_DBQueries db=new Assets_DBQueries();
	String user_name=email;
	ArrayList ar2=new ArrayList();
	ArrayList list=new ArrayList();
	String proc_id="";
	String reg_id="";
	int count=1;
	int sum=0;
 %>		
<body>
<form name="hod_hoi"  method="post" action="../../AssetsServlet">

<input type="hidden" name="ActionId" value="UpdateSaleScrap">
<input type="hidden" name="email" value="<%=email%>">
<input type="hidden" name="Task" value="Add">
	 <div class="container-fluid">
	 <h5>Asset Scrap Request</h5>
		<%list=db.AssetsScrapMTDeisp();
		System.out.println("Fetch Data "+list); 
		if(!list.isEmpty()){%>
		<table class="table" border=2 style="border-collapse: collapse; width:100%">
		<tr style="border-radius: 50px 20px;">
				<th>S.No</th>
				<th>Created By</th>
				<th>Department</th>
				<th>Previous Comments</th>
				</tr>
				<%
					list=db.AssetsScrapMTDeisp();
					System.out.println("Fetch Data "+list);
				if(!list.isEmpty())
				{
					for(int i=0;i<list.size();i++)
					{
						String[] str=new String[list.size()];
						ArrayList sub_cat=new ArrayList();
						int	length = 0;
				 %>
						<%ArrayList arr12=(ArrayList)list.get(i);%>
							<tr>
								<td>
									<%=count %>
								</td>
								<td>
									<a href="ManageMent_Sale_Scrap_form.jsp?userId=<%=arr12.get(0)%>"><%=arr12.get(9) %></a>
								</td>
								<td>
									<%=arr12.get(1) %>
								</td>
								<%
								System.out.println("True or false "+arr12.get(7)!=null);
								if(arr12.get(7)!=null){ %>
								<td>
									<%=arr12.get(7)%>
								</td>
								<%}else {%>
									<td>No Previous Comments</td>
								<%} %>
							</tr>
							<%count=count+1;
							sum=sum+1;
					}	
				}
	%>
	</table>
	<%}else{ %>
		<%System.out.println("Sum of value "+sum);
	 if(sum==0){%><center><div id="rect" class="center"><b>No Request is Found &#128522;</b></div></center>
	 <%} %>
	 <%} %>
		<div>
			<font color="#FF0000" size="2px"><%if(msg1!=null){ %><%=msg1 %><%} %></font><br/>
					<font color="black" size="3px"><%if(msg2!=null){ %><%=msg2 %><%} %></font>
		</div>
	</div> 
</form>
</body>
  <%}else{ %>
<%@include file="../cookieTracker/CookieTrackerBottom.jsp" %>
<%} %>
</HTML>
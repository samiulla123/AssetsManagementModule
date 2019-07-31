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
	ArrayList result=new ArrayList();
	result=db.selectAssetsRegisterData(email);
	System.out.println("HOD details "+result);
	String str1[]=new String[result.size()];
	int sum=0;
	if(!result.isEmpty())
	{
	int count=1;
	boolean flag=false;
 %>		
<body>
<form name="hod_hoi"  method="post" action="../../AssetsServlet">

<input type="hidden" name="ActionId" value="UpdateSaleScrap">
<input type="hidden" name="email" value="<%=email%>">
<input type="hidden" name="Task" value="Add">
<div class="container-fluid">
<h5>Assets Scrap Requests</h5>
<%for (int i=0;i<result.size();i++)
 {
	str1[i]=""+result.get(i).toString().replace("[","").replace("]","");
	list=db.selectSaleScrapHODHOIDATA(str1[i]);
	if(!list.isEmpty())
	{
		flag=true;
	}
} if(flag==true){%>	
		<table class="table" border=2 style="border-collapse: collapse; width:100%">
		
				
		<tr style="border-radius: 50px 20px;">
				<th>S.No</th>
				<th>Created By</th>
				<th>Department</th>
				<th>Previous Comments</th>
				</tr>
				<%
					for (int i=0;i<result.size();i++)
					{
						str1[i]=""+result.get(i).toString().replace("[","").replace("]","");
						System.out.println("Prog IDs "+str1[i]);
						list=db.selectSaleScrapHODHOIDATA(str1[i]);
						System.out.println("Fetch Data "+list+" IS Empty "+list.isEmpty());
						String[] str=new String[list.size()];
						ArrayList sub_cat=new ArrayList();
						int	length = 0;
					if(!list.isEmpty())
					{
				 %>
						<%for (int k=0;k<list.size();k++) 
						{%>
						<%ArrayList arr12=(ArrayList)list.get(k);%>
							<tr>
								<td>
									<%=count %>
								</td>
								<td>
									<a href="Assets_HOD_Sale_Scrap_Form.jsp?userId=<%=arr12.get(0)%>"><%=arr12.get(9) %></a>
								</td>
								<td>
									<%=arr12.get(1) %>
								</td>
							<%if(arr12.get(5)!=null){ %>
								<td>
									<%=arr12.get(5)%>
								</td>
								<%} else {%>
								<td>
									No Previous Comments
								</td>
								<%} %>
							</tr>
							<%count=count+1;
							sum=sum+1;
					  }
				list=null;
				}
				else
				{%>
				<%}
		}
	%>
	</table>
	<%}else{ %>
	<%System.out.println("Sum of value "+sum);
	 if(sum==0){%><center><div id="rect" class="center"><p>No Request is Found &#128522;</p></div></center>
	 <%} %>
	 <%} %>
		<div>
			<font color="#FF0000" size="2px"><%if(msg1!=null){ %><%=msg1 %><%} %></font><br/>
					<font color="black" size="3px"><%if(msg2!=null){ %><%=msg2 %><%} %></font>
		</div>
	</div> 

	<%}else {%>
 	<% String str4="No Request Found"; %>
		<h4><%=str4 %></h4>	
		<%} %>  
</form>
</body>
  <%}else{ %>
<%@include file="../cookieTracker/CookieTrackerBottom.jsp" %>
<%} %>
</HTML>
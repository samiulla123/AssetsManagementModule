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
	String sub_id=request.getParameter("sel_data");
	System.out.print("Assets value id : "+sub_id);
	String msg1=(String)session.getAttribute("msg");
	session.removeAttribute("msg");
	String msg2=(String)session.getAttribute("status_msg");
	session.removeAttribute("status_msg");
	Assets_DBQueries db=new Assets_DBQueries();
	String user_name=email;
	ArrayList ar2=new ArrayList();
	ArrayList list=new ArrayList();
	String proc_id="";
	String reg_id="";
	ArrayList result=new ArrayList();
	result=db.selectAssetsRegisterData(email);
	System.out.println("Result Found is "+result.size());
	String str1[]=new String[result.size()];
	int sum=0;
	if(!result.isEmpty())
	{
	int count=1;
	boolean flag=false;
 %>		
<body>
<form name="hod_hoi"  method="post" action="../../AssetsServlet">
<input type="hidden" name="ActionId" value="UpdateAssets">
<input type="hidden" name="email" value="<%=email%>">
<input type="hidden" name="Task" value="Add">
<div class="container-fluid">
	<h5>Assets Requests For New Asset Registration</h5>
	<%for (int i=0;i<result.size();i++)
	{
		str1[i]=""+result.get(i).toString().replace("[","").replace("]","");
		list=db.selectHODHOIDATA(str1[i]); 
		if(!list.isEmpty())
		{
			flag=true;
		}
		System.out.println("--------DATA_____"+list);
	}
	System.out.println("-------------------------List Array "+flag); 
	if(flag==true){%>
		<table class="table" border=2 style="border-collapse: collapse; width:100%">
		<tr style="border-radius: 50px 20px;">
				<th>S.No</th>
				<th>Register Assets</th>
				<th>Created By</th>
				<th>Created On</th>
				<th>Department</th>
				</tr>
				<%
					for (int i=0;i<result.size();i++)
					{
						str1[i]=""+result.get(i).toString().replace("[","").replace("]","");
						list=db.selectHODHOIDATA(str1[i]);
						System.out.println("Number Data Found "+list.isEmpty());
						String[] str=new String[list.size()];
						ArrayList sub_cat=new ArrayList();
						int	length = 0;
					if(!list.isEmpty())
					{
				 %>
						<%for (int k=0;k<list.size();k++) {%>
						<%ArrayList arr12=(ArrayList)list.get(k);
							System.out.println("Assets_ register status 0 data "+arr12.get(20)+" Assets Register Id "+arr12.get(0)+" Department "+arr12.get(13)); %>
					<tr>
						<td>
							<%=count %>
						</td>
						<td>
							<a href="Assets_HOD_HOI_Approve.jsp?userId=<%=arr12.get(0)%>"><%=arr12.get(20) %></a>
						</td>
						<td>
						<%ArrayList sh_name=db.FiveSOwnShName(arr12.get(15).toString());
								String SshName=sh_name.toString().replace("[","").replace("]",""); %>
							<%=SshName.toUpperCase() %>
						</td>
						<td>
						 <%
							 String date=""+arr12.get(17);
					         Date dNow = new SimpleDateFormat("yyyy-MM-dd").parse(date); 
					         SimpleDateFormat ft =new SimpleDateFormat ("dd-MM-yyyy");
	    				  %>
							<%=ft.format(dNow)%>
						</td>
						<td>
							<%=arr12.get(13) %>
						</td>
					</tr>
					<%sum=sum+1;%>
				
	<%count=count+1;
	 	}
	 	}else {
	 		
				} 
		list=null;
		}
	%>
	</table>
	<%}else{ %>
	<%System.out.println("Sum total of "+sum);
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
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
#tbl{
	border: 1px solid red;
	width: 80%;
	border-collapse: collapse;
	background-color:#DB9796;
}
#tbl, td{
	height: 50px;
  vertical-align: bottom;
}

</style>
</HEAD>
<%
	String id=request.getParameter("userId");
	String mCat=request.getParameter("main_cat");
	System.out.println("Input value "+mCat+" Ture/False ");
	System.out.println("Id fetchfrom form ="+id);
	ArrayList res2=assetManager.selectAssetsRegisterData2(id);
	System.out.println("Data fetch= "+res2);
	ArrayList trData=new ArrayList();
	
	String msg=(String)session.getAttribute("error"); 
 	session.removeAttribute("error");
    Date dNow = new Date();
   /*  SimpleDateFormat ft = new SimpleDateFormat ("M-dd-yyyy");
    String dta=ft.format(dNow); */ 
   
     
    ArrayList Depart=assetManager.selectDepartment();
    System.out.println("Deaprtment value "+Depart);
    System.out.println("Department "+Depart);
   	String main_name="";
   	String sub_name="";		
   	
   	ArrayList fet=new ArrayList();
   	
   	String mc=""+mCat;
	System.out.println("Value of mCat "+mc );
		System.out.println("True false "+mc.equals("null"));
		
		
 %>		
<body>

<form name="Assets_transfer"  method="post" action="">
<input type="hidden" name="ActionId" value="AssetsTransfer">
<input type="hidden" name="email" value="<%=email%>">
<input type="hidden" name="Task" value="Add">
<input type="hidden" name="op" value="1">
<div class="container-fluid">
<center>
	<table id="tbl" class="table">
	<tr> 
		<td><table class="table table-striped">

		<h5>Transfer Form</h5>
		<tr>
			<td>
				Department 
			</td>
			<td>
			<select name="main_cat" data-live-search="true" data-live-search-style="startsWith" class="selectpicker"  data-size="10"  data-width="60%" data-height="3%"  onchange="display()">
			<option></option>
			<%
	          		Iterator itr=Depart.iterator();
	          		System.out.println("Iterator = "+itr);
					while(itr.hasNext()){
					ArrayList arr=(ArrayList)itr.next();
					String cid=""+arr.get(0);
					String name=""+arr.get(1);
					System.out.println("department id "+cid+" and name "+name); 
	       		 %>
			<option value="<%=cid%>" <%if(cid.equals(mCat)){ %> selected <%} %>><%=name %></option>
				<%} %>
		</select>
		
			</td>
		<%if(!res2.isEmpty()){ %>
			<%for (int i=0;i<res2.size();i++){ %>
			<%ArrayList data=(ArrayList)res2.get(i); %>
			
		</tr>
		<tr>
			<td>
				Register Number:
			</td>
			<td>
				<input type="hidden" name="name" value="<%=data.get(0)%>">
				<font color="red"><%=data.get(0) %></font>
			</td>
		</tr>
		<tr>
			<td>
				Main Category:
			</td>
			<td>
				<input type="hidden" name="name" value="<%=data.get(1)%>">
				<input type="hidden" name="name" value="<%=data.get(19)%>">
				<font color="red" ><%=data.get(19) %></font>
			</td>
		</tr>
		<tr>
			<td>
				Sub Category:
			</td>
			<td>
				<input type="hidden" name="name" value="<%=data.get(2)%>">
				<input type="hidden" name="name" value="<%=data.get(20)%>">
				<font color="red"><%=data.get(20) %></font>
			</td>
		</tr>
		<tr>
			<td>
			<%
				 String date1=""+data.get(6);
		         Date dNow1 = new SimpleDateFormat("yyyy-MM-dd").parse(date1); 
		         SimpleDateFormat ft =new SimpleDateFormat ("dd-MM-yyyy");
     		 %>
				Bill Date:
			</td>
			<td>
					<input type="hidden" name="name" value="<%=data.get(3)%>">
					<input type="hidden" name="name" value="<%=data.get(4)%>">
					<input type="hidden" name="name" value="<%=data.get(6)%>">
				<font color="red"><%=ft.format(dNow1) %></font>
			</td>
		</tr>
		<tr>
			<td>
				Bill Number:
			</td>
			<td>
				<input type="hidden" name="name" value="<%=data.get(5)%>">
				<font color="red"><%=data.get(5) %></font>
			</td>
		<tr>
			<td>
				Supplier Name:
			</td>
			<td>
				<input type="hidden" name="name" value="<%=data.get(7)%>">
				<input type="hidden" name="name" value="<%=data.get(8)%>">
				>
				<font color="red"><%=data.get(7) %></font>
			</td>
		</tr>
		<tr>
			<td>
				Amount:
			</td>
			<td>
				<input type="hidden" name="name" value="<%=data.get(9)%>">
				<font color="red"><%=data.get(9) %></font>
			</td>
		</tr>
		<tr>
			<td>
				Previous Ref No:
			</td>
			<td>
				<input type="hidden" name="name" value="<%=data.get(10)%>">
				<input type="hidden" name="name" value="<%=data.get(11)%>">
				<input type="hidden" name="name" value="<%=data.get(12)%>">
				<font color="red"><%=data.get(11) %></font>
			</td>
		</tr>
		<tr>
			<td>
				Department:
			</td>
			<td>
				<input type="hidden" name="name" value="<%=data.get(13)%>">
				<input type="hidden" name="name" value="<%=data.get(14)%>">
				
				<input type="hidden" name="name" value="<%=data.get(15)%>">
				<input type="hidden" name="name" value="<%=data.get(16)%>">
				<input type="hidden" name="name" value="<%=data.get(17)%>">
			
			
				
				<font color="red"><%=data.get(13) %></font>
			</td>
		</tr>
	
		<%} } %>
		
		<tr>
			<td>
				<input type="button" value="Submit" name="sbm" class="btn" onclick="sendData()">
			</td>
			<td>
				<input type="button" value="Cancel" name="cnl" class="btn" onclick="validate()">
			</td>
		</tr>
		</table></td></tr>
	</table>
	
	<% 
		if(!mc.equals("null"))
		{
			System.out.println("Assets "+!mc.equals("null"));
			trData=assetManager.selectAllDataTrns(mCat);
			System.out.println("In assets managa "+trData);
			for(int k=0;k<trData.size();k++)
   			{
   				fet=(ArrayList)trData.get(k);
   				System.out.println("department id is"+fet.get(0)+" name "+fet.get(1)+" Unit Short name "+fet.get(2)+" department "+fet.get(3));
  		 	}

		 %>
		<input type="hidden" name="name" value="<%=fet.get(0)%>">
		<input type="hidden" name="name" value="<%=fet.get(1)%>">
		<input type="hidden" name="name" value="<%=fet.get(2)%>">
		<input type="hidden" name="name" value="<%=fet.get(3)%>">
		<input type="hidden" name="name" value="<%=email%>">
	<%} %>
</center>
	</div>
</form>
</body>
  <%}else{ %>
<%@include file="../cookieTracker/CookieTrackerBottom.jsp" %>
<%} %>
</HTML>
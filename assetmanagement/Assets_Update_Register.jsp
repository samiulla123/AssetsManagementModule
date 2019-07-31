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
	
 	function display()
	{
		if(document.AssetsStatus.des.value=="")
		{
			alert("Description cannot be empty");
			document.AssetsStatus.des.focus();
			return false;		
		}
		if(document.AssetsStatus.bill_no.value=="")
		{
			alert("bill_no cannot be empty cannot be empty");
			document.AssetsStatus.bill_no.focus();
			return false;		
		}
		if(document.AssetsStatus.sup_name.value=="")
		{
			alert("Supplier name cannot be empty");
			document.AssetsStatus.sup_name.focus();
			return false;		
		}
		if(document.AssetsStatus.quant.value=="")
		{
			alert("Please mention contity");
			document.AssetsStatus.quant.focus();
			return false;		
		}
		if(document.AssetsStatus.amnt.value=="")
		{
			alert("Please mention contity");
			document.AssetsStatus.amnt.focus();
			return false;		
		}
	
		document.AssetsStatus.action="../../AssetsServlet";
		document.AssetsStatus.submit();
	}	
	function previous()
	{	
		if(document.getElementById("Pcmnt").style.visibility==="hidden")
		{
			document.getElementById("Pcmnt").style.visibility="visible";
		}	
		else{
			document.getElementById("Pcmnt").style.visibility="hidden";
		}
	}
	function val()
	{
		var id=document.getElementById("as_id").value;
		if(document.getElementById("as_id").value && document.getElementById("cnl").value)
		{
			document.getElementById("cnl").value="1";
			document.getElementById("dec").disabled=true;
			document.getElementById("bill_no").disabled=true;
			document.getElementById("sup_name").disabled=true;
			document.getElementById("quant").disabled=true;
			document.getElementById("amnt").disabled=true;
		}
		
		document.AssetsStatus.action="../../AssetsServlet";
		document.AssetsStatus.submit();
	}
</script>
<style>
.table-borderless td {
    border: none;
}
</style>
</HEAD>
<%
	//String sub_id=(String)session.getAttribute("userId");
	//session.removeAttribute("userId");
	String sub_id=request.getParameter("userId");
	System.out.println("In Assets update register "+sub_id);
	Assets_DBQueries db=new Assets_DBQueries();
	ArrayList res2=db.selectAssetsRegisterData2(sub_id);
	ArrayList arrL= new ArrayList();
	ArrayList res1=new ArrayList();
	for(int i=0;i<res2.size();i++)
	{
		res1=(ArrayList)res2.get(i);
		String id=""+res1.get(0);
		System.out.println("Id value ="+id);
		arrL=db.selectAssetsStstusData(id);
	}	
	ArrayList fetch=new ArrayList();
	String msg1=(String)session.getAttribute("cancel");
	session.removeAttribute("cancel");
	int count=0;
 %>		
<body><br/>
<form name="AssetsStatus" method="post">
<input type="hidden"  name="ActionId" value="UpdateAssetsReg">
<input type="hidden" name="Task" value="Add">
<div class="container-fluid">
<table class="table table-striped"  border=2 style="border-collapse: collapse; width:50%"">
	<h5>Update Assets</h5>
	<%for (int i=0;i<res2.size();i++) {%>
	<%ArrayList ar=(ArrayList)res2.get(i); %>
	<%System.out.println("Array List Value "+ar); %>
	<% %>
	<tr>
		<td>
			<input type="hidden" id="as_id" name="as_id" value="<%=sub_id%>">
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
			<label><%=ar.get(20) %></label>
		</td>
	</tr>
	<tr>
		<td>
			Description
		</td>
		<td>
			<input type="text" id="dec" name="des" value="<%=ar.get(4)%>" onkeypress="return (event.charCode!=39)">
		</td>
	</tr>
	<tr>
		<td>
			Bill No
		</td>
		<td>
			<input type="text" id="bill_no" name="bill_no" value="<%=ar.get(5)%>" onkeypress="return (event.charCode!=39 && event.charCode!=34) ">
		</td>
	</tr>
	<tr>
		<td>
			Supplier Name
		</td>
		<td>
			<input type="text" id="sup_name" name="sup_name" value="<%=ar.get(7)%> " onkeypress="return (event.charCode!=39 && event.charCode!=34) ">
		</td>
	</tr>
	<tr>
		<td>
			Quantity
		</td>
		<td>
			<input type="text" id="quant" name="quant" value="<%=ar.get(8)%>" onkeypress="return (event.charCode > 47 && event.charCode < 58) || (event.charCode > 7 && event.charCode < 9)">
		</td>
	</tr>
	<tr>
		<td>
			Amount
		</td>
		<td>
			<input type="text" id="amnt" name="amnt" value="<%=ar.get(9)%>" onkeypress="return (event.charCode > 47 && event.charCode < 58) || (event.charCode > 7 && event.charCode < 9)">
		</td>
	</tr>
	<%} %>	
	<tr>

		<td colspan="2" >
		<center>
		<input type="button" class="btn" name="" value="Update" onclick="display()">
		<input type="hidden" value="cancel" id="cnl" name="cnl">
			<input type="button" class="btn" name="" value="Cancel This Asset" onclick="val()">
		</center>
		</td>
	</tr>
</table>
</div>
<div>
	<font color="#FF0000" size="2px"><%if(msg1!=null){ %><%=msg1 %><%} %></font><br/>
</div>
</form>
</body>
  <%}else{ %>
<%@include file="../cookieTracker/CookieTrackerBottom.jsp" %>
<%} %>
</HTML>
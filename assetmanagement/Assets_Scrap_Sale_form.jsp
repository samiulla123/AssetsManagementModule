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
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
function display()
{
	document.Assets_Scrap_Sale.action="";
	document.Assets_Scrap_Sale.submit(); 		
} 
function validate()
{
	window.close();
}
var fileName;
    $(document).ready(function(){

        $('input[type="file"]').change(function(e){

            fileName = e.target.files[0].name;

            alert('The file "' + fileName +  '" has been selected.');

        });

    });
function sendData()
{
	var file=document.getElementById("sale_scrap_file").value;
	var reason=document.getElementById("reason").value;
	var ven=document.getElementById("vend").value;
	if(file=="")
	{
		alert("Upload selected file");
		document.Assets_Scrap_Sale.sale_scrap_file.focus();
		return false;
	}
	if(reason=="")
	{
		alert("Reason for scrap/sale is mendeotory");
		document.Assets_Scrap_Sale.reason.focus();
		return false;
	}
	if(ven="")
	{
		alert("Enter Vendors details");
		document.Assets_Scrap_Sale.vend.focus();
		return false;
	}
	document.Assets_Scrap_Sale.fileName.value=fileName;
	alert("file name "+document.Assets_Scrap_Sale.fileName.value);
	alert("file original "+fileName);
 	document.Assets_Scrap_Sale.action="../../AssetsServlet";
	document.Assets_Scrap_Sale.submit();
	window.opener.location.reload();		
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
	String sal=request.getParameter("ss");
	System.out.println("Id fetchfrom form ="+sal);
	
	ArrayList res2=assetManager.selectAssetsRegisterData2(id);
	System.out.println("Data fetch= "+res2);
	String msg=(String)session.getAttribute("error"); 
 	session.removeAttribute("error");
    Date dNow = new Date( );
    SimpleDateFormat ft2 = new SimpleDateFormat ("M-dd-yyyy");
    String dta=ft2.format(dNow); 
    ArrayList Depart=assetManager.selectDepartment();
    System.out.println("Department "+Depart);
   	String main_name="";
   	String sub_name="";	
   	String sale="1";
   	String scrap="2";	
 %>		
<body>

<form name="Assets_Scrap_Sale"  method="post" enctype="multipart/form-data" >
<input type="hidden" name="ActionId" value="ScrapSale">
<input type="hidden" name="email" value="<%=email%>">
<input type="hidden" name="Task" value="Add">
<div class="container-fluid">
<center>
	<table id="tbl" class="table">
	<tr> 
		<td><table class="table table-striped">
		<h5>Transfer Form</h5>	
		<%if(!res2.isEmpty()){ %>
			<%for (int i=0;i<res2.size();i++){ %>
			<%ArrayList data=(ArrayList)res2.get(i); %>
		<tr>
			<td>
				Asset Name:
			</td>
			<td>
				<inpur type="hidden" name="shName" value="<%=data.get(22)%>">
				<input type="hidden" name="msc_id" value="<%=data.get(12)%>">
				<input type="hidden" name="reg_id" value="<%=data.get(0)%>">
				<input type="hidden" name="aname" value="<%=data.get(20)%>">
				<font color="red"><%=data.get(20) %></font>
			</td>
		</tr>
		<tr>
			<td>
				Asset Reference Number:
			</td>
			<td>
			<input type="hidden" name="ref_no" value="<%=data.get(11) %>">
				<font color="red"><%=data.get(11) %></font>
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
				<input type="hidden" name="bDate" value="<%=data.get(6) %>">
				<font color="red"><%=ft.format(dNow1) %></font>
			</td>
		</tr>
		<tr>
			<td>
				Bill Number:
			</td>
			<td>
				<input type="hidden" name="bNumb" value="<%=data.get(5) %>">
				<font color="red"><%=data.get(5) %></font>
			</td>
		<tr>
			<td>
				Supplier Name:
			</td>
			<td>
				<input type="hidden" name="bNumb" value="<%=data.get(7) %>">
				<font color="red"><%=data.get(7) %></font>
			</td>
		</tr>
		<tr>
			<td>
			<%
				 String date2=""+data.get(3);
		         Date dNow2 = new SimpleDateFormat("yyyy-MM-dd").parse(date2); 
		         SimpleDateFormat ft1 =new SimpleDateFormat ("dd-MM-yyyy");
     		 %>
				Purchase Date
			</td>
			<td>
				<input type="hidden" name="bdate" value="<%=data.get(3) %>">	
				<font color="red"><%=ft1.format(dNow2) %></font>
			</td>
		</tr>
		<tr>
			<td>
				Amount:
			</td>
			<td>
				<input type="hidden" name="amnt" value="<%=data.get(9) %>">	
				<font color="red"><%=data.get(9) %></font>
			</td>
		</tr>
		<tr>
			<td>
				Department:
			</td>
			<td>
				<input type="hidden" name="dep" value="<%=data.get(13) %>">	
				<font color="red"><%=data.get(13) %></font>
			</td>
		</tr>
		<tr>
			<td>
				Unit:
			</td>
			<td>
				<input type="hidden" name="unit" value="<%=data.get(14) %>">	
				<font color="red"><%=data.get(14) %></font>
			</td>
		</tr>
		<tr>
			<td>
				Select Option
			</td>
			<td>
				<select name="ss" id="ss">
					<option value=""></opiton>
					<% System.out.println("Value");%>
					<option value="<%=sale%>" <%if(sale.equals(sal)){ %>selected<%} %>>Sale</option>
					<option value="<%=scrap%>" <%if(scrap.equals(sal)){ %>selected<%} %>> Scrap</option> 
				</select>
			</td>
			</tr>
		

		<tr>	
				<td>Revenue </td>
				<td><input type="text" name="rev" onkeypress="return (event.charCode==46 || event.charCode > 47 && event.charCode < 58) || (event.charCode > 7 && event.charCode < 9)" onchange="calculate()"></td>
			</tr>
		<tr>
			<td>Vendors Details</td><br/>
			<td><textarea name="vend" id="vend" style="background-color:#FFECEC ; size:50; width:50%; height:100%"  onkeypress="return (event.charCode!=39)"></textarea></td>	
		</tr>
		<tr>
		<td>Upload Related Document</td><br/>
			<td>
					     <input type="file" name="sale_scrap_file" id="sale_scrap_file" accept="application/pdf" multiple>
					     <input type="hidden" name="fileName" id="fileName"><br/>
					     <label><font color="red">Please insert .pdf format file</font></label>
			</td>

			<!-- <td>Upload Related Document</td><br/>
			<td><input type="file" ></td> -->	
		</tr>
		<tr>
			<td>Reason For Scrap/Sale</td><br/>
			<td><textarea name="reason" id="reason" style="background-color:#FFECEC ; size:50; width:50%; height:100%"  onkeypress="return (event.charCode!=39)"></textarea></td>	
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
</center>
	</div>
</form>
</body>
  <%}else{ %>
<%@include file="../cookieTracker/CookieTrackerBottom.jsp" %>
<%} %>
</HTML>
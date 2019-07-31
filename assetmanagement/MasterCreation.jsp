<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@page import="com.gen.cms.assets.beans.*"%> 
<%@page import="java.util.ArrayList"%> 
<%@page import="java.sql.ResultSet"%>
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
<SCRIPT language="javascript" src="../../javascript/AssetsJS/AdminAssetsMaster.js"> </SCRIPT>
<SCRIPT language="javascript" src="../../javascript/Validate.js"></SCRIPT>
<jsp:useBean id="assetManager" class="com.gen.cms.assets.beans.Assets_DBQueries"></jsp:useBean>


<TITLE>Master Creation</TITLE>
<script>
function instruction()
{
	if (document.getElementById("demo").style.visibility=== "hidden") 
	{
  		document.getElementById("demo").style.visibility = "visible";
  	}
  	else
  	{
  		document.getElementById("demo").style.visibility = "hidden";
  	}
	return true
}
</script>
<style>
#demo {
  width: 100%;
  padding: 20px 0;
  text-align: left;
  background-color: #DB9796;
  margin-top: 20px;
  border-radius:10px;
  
}

#btn{
  	background: linear-gradient(35deg, #ffcccc,  #ccffff);
}
#btn:hover
{
	color:#FF0000;
}
input:focus{
	background-color:#BD0102;
	transition: all .2s ease-in-out;;
}
</style>
</HEAD>
<body>
<% 
	String msg=(String)session.getAttribute("error"); 
 	session.removeAttribute("error");
 	ArrayList mainCatArr=assetManager.getMainAssetCategory();
	%>
<form name="frmAdminAssetsMaster" method="post">
<input type="hidden" name="ActionId" value="category_master">
<input type="hidden" name="Task" value="Add">

<input type="hidden" name="user_id" value="<%=email%>">

  <div id=Layer5 class="container"
style="Z-INDEX: 6; LEFT: 30px; WIDTH: 376px; POSITION: absolute; TOP: 11px; HEIGHT: 175px"> 
    <table width="98%" border=0>
      <tbody> 
      <tr>
			<td colspan="3"><B>Assets Creation</B></td>
		</tr>
      <tr>
			<td colspan="3" height=13>
			<hr size=1>
			</td>
		</tr>
		<TR>
			<TD height="13" colspan="3"></TD>
		</TR>
		<tr> 
        <td width="33%"> 
          <div align="left">Category <FONT color="#FF0000">*</FONT></div>
        </td>
        <td colspan="2" width="244"> 
          <div align="left"> 
            <input type="text"" name="txtCata" class="form-control" style="background-color:#FFECEC ;" size="12" value=""  maxlength="25" style="border-style: solid; border-width: 1px" tabindex="1" onkeypress="return (event.keyCode!=39)">
            </div>
        </td>
      </tr>
   
      		<tr> 
        <td width="33%"> 
          <div align="left">Short Form <FONT color="#FF0000">*</FONT></div>
        </td>
        <td colspan="2" width="244"> 
          <div align="left"> 
            <input type="text"  name="txtShort" class="form-control" style="background-color:#FFECEC ;" size="12" value="" maxlength="3" style="border-style: solid; border-width: 1px" tabindex="1" onkeypress="return (event.keyCode!=39)">
            </div>
        </td>
      </tr>
		<TR>
			<TD align="left" width="33%">&nbsp;</TD>
			<TD>
			
			   &nbsp;</TD>
			<TD>&nbsp;</TD>
		</TR>
		<tr>
			<td colspan="3" height=14>
			<hr size=1 align="center">
			</td>
		</tr>
      <tr>
			<td colspan="3" height=23>
			<div align="center">
				<input type="button" class="btn" value="Create" name="cmdSubmit" onclick="return checkEmpty()" tabindex="2">
				&nbsp;&nbsp; 
				<input type="reset" class="btn" value="Cancel" 
				name="cmdCancel" onclick="unLoad();" tabindex="3">
			</div>
			</td>
		</tr>
      <tr>
			<td colspan="3" height=23>
			&nbsp;</td>
		</tr>
     
      <tr>
			<td colspan="3" height=23>
			<div align="left"><FONT color="#FF0000">*</FONT> Indicates Mandatory</div>
			</td>
		</tr>
		<tr>
		<td colspan="3" height=23>	
		
			<font color="#FF0000" size="2px"><%if(msg!=null){%>&nbsp;<%=msg%><%} %></font>	
			</td>
		</tr> 
      </tbody> 
    </table>
  
</div>
<div id="Layer2" style="position:absolute; left:450px; top:39px; width:0px; height:2px; z-index:8"></div>
  <div id="Layer3" style="position:absolute; left:410px; top:15px; width:168px; height:24px; z-index:9"><B>Existing
Category</B></div>
 <div id="Layer3" style="position:absolute; left:410px; top:30px; width:168px; height:24px; z-index:9">

	<select size="10" style="border-redius:5px;">
		<%
			
			Iterator itr=mainCatArr.iterator();	
			for(int i=0;i<mainCatArr.size();i++){
				ArrayList mainCatArr1=(ArrayList)mainCatArr.get(i);
				System.out.println("Main Category "+mainCatArr1);
				String catId=""+mainCatArr1.get(0);
				String catName=""+mainCatArr1.get(1);
				String catShName=""+mainCatArr1.get(2);
		%> 
		 <option><%=catName%>(<%=catShName %>)</option>
		 
		
		<%} %>	
	</select>
	
	
  </div>
	<div style="position:absolute; left:50px; top:300px;">
	<input 
		type="button" id="btn" class="btn" value="User-Instructions" name="cmdSubmit" onclick="instruction()" tabindex="2">
		<p id="demo" style="visibility:hidden; font-style:bold; font-size:15px;">
		1. Please Enter the valid category.<br/>&nbsp;&nbsp; Eq: Building, Furniture, Electronics etc<br/><br/><br/>2. Duplicate category which are already exists in CMS are not accepted.<br/>&nbsp;&nbsp; Eq: If Building category exists in CMS then it will not take same value
		<br><br><br>3. Short category should contain 3 characters only<br/> &nbsp;&nbsp; Eg: Building - bld Furniture - fur<br><br><br>
		4. If Entered Category or Short form is already exists, then entered different names in fields<br><br><br>
		5. If Category already register perform different option like "Adding Sub-Category"<br><br><br>
		Example:<br><br><br>
		&nbsp;&nbsp;<img border="10px" src="/images/Assets_images/AssetsMaster.jpg" alt="Image not displayed"/>
		</p>
	</div>

</form>
</BODY>
<%}else{ %>
<%@include file="../cookieTracker/CookieTrackerBottom.jsp" %>
<%} %>
</HTML>
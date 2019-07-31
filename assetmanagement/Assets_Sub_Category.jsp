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
<SCRIPT language="javascript" src="../../javascript/AssetsJS/Assets_Sub_Cate.js"> </SCRIPT>
<SCRIPT language="javascript" src="../../javascript/Validate.js"></SCRIPT>
<jsp:useBean id="assetManager" class="com.gen.cms.assets.beans.Assets_DBQueries"></jsp:useBean>

<TITLE>AdminCreateNation.jsp</TITLE>
<script>
		function display()
		{
			document.frmAdminAssetsSub.action="";
			document.frmAdminAssetsSub.submit();		
		}
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
input:focus{
	background-color:#BD0102;
	transition: transform .2s;
}

#btn{
	background: linear-gradient(45deg,
      #ffcccc,  #ccffff);
}

</style>
</HEAD>
<%
	String mCat=request.getParameter("main_cat");
	long m_cat=0;
	try{
		 m_cat=Integer.parseInt(mCat);
	}
	catch (NumberFormatException e)
	{
		 m_cat=0;
	}
	System.out.println("Long int "+m_cat);
	System.out.println("Va="+mCat);
	System.out.println(" true/false "+mCat!=null);
	ResultSet res1=null;
	String msg=(String)session.getAttribute("error"); 
 	session.removeAttribute("error");
 	ArrayList mainCatArr=assetManager.getMainAssetCategory();
 	System.out.println("Assets Main Category "+mainCatArr);
 	ArrayList SubCatArr=assetManager.selectSubName(m_cat);
 	System.out.println("Assets sub Category "+SubCatArr);
	%>
<body>
<form name="frmAdminAssetsSub" method="post">
<input type="hidden" name="ActionId" value="sub_category_master">
<input type="hidden" name="Task" value="Add">
<input type="hidden" name="user_id" value="<%=email%>">
  <div class="container" id=Layer5 
	style="Z-INDEX: 6; LEFT: 30px; WIDTH: 376px; POSITION: absolute; TOP: 11px; HEIGHT: 175px"> 
    <table width="98%" border=0>
      <tbody> 
      <tr>
			<td colspan="3"><B>Assets Creation</B></td>
		</tr>
		<TR>
			<TD height="13" colspan=""></TD>
		</TR>
		<tr> 
        <td width="33%"> 
          <div align="left">Main-Category <FONT color="#FF0000">*</FONT></div>
        </td>
        <td colspan="2" width="244"> 
          <div align="left"> 
         <select name="main_cat"  data-live-search="true" data-live-search-style="startsWith" class="selectpicker" data-style="btn-default" data-size="10"  data-width="50%" data-height="10%" data-width="50%" data-height="10%" onchange="display()">
			<option value=""></option>
			<%
			
			Iterator itr=mainCatArr.iterator();
			while(itr.hasNext()){
				ArrayList arr=(ArrayList)itr.next();
				String cid=""+arr.get(0);
				String cname=""+arr.get(1);
				String csname=""+arr.get(2);
						
			/*for(int i=0;i<mainCatArr.size();i++){
				ArrayList mainCatArr1=(ArrayList)mainCatArr.get(i);
				String catId=""+mainCatArr1.get(0);
				String catName=""+mainCatArr1.get(1);
				String catShName=""+mainCatArr1.get(2);*/
		%> 
		 <option value="<%=cid%>" <%if(cid.equals(mCat)){%>selected<%}%>> <%=cname%></option>
		 
		
		<%} %>	
          </select>
            </div>
        </td>
      </tr>
		<tr> 
        <td width="33%"> 
          <div align="left" style="position:absolute; top:80px;">Sub-Category <FONT color="#FF0000">*</FONT></div>
        </td>
        <td colspan="2" width="244"> 
          <div align="left" style="position:absolute; left:150px; top:80px;"> 
             <input type="text" class="form-control" style="background-color:#FFECEC ;" name="txtSubCata" size="12" value=""  maxlength="25" style="border-style: solid; border-width: 1px" tabindex="1" onkeypress="return (event.keyCode!=39)">
            </div>
        </td>
      </tr>
      		<tr > 
        <td width="33%"> 
          <div align="left" style="position:absolute;  top:120px;">Sub-Category Short Form <FONT color="#FF0000">*</FONT></div>
        </td>
        <td colspan="2" width="244"> 
          <div align="left" style="position:absolute; left:150px; top:120px;"> 
            <input type="text" class="form-control" style="background-color:#FFECEC ;" name="txtSubShort" size="12" value="" maxlength="3" style="border-style: solid; border-width: 1px" tabindex="1" onkeypress="return (event.keyCode!=39)">
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
			<td colspan="3" height="23px">
			<div align="center" style="position:relative; top:90px;">
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
			<div align="left" style="position:absolute; top:200px;"><FONT color="#FF0000">*</FONT> Indicates Mandatory</div>
			</td>
		</tr>
		<tr>
		<td colspan="3" height=23>	
			<font color="#FF0000" style="position:absolute; top:215px;"><%if(msg!=null){%>&nbsp;<%=msg%><%} %></font>	
			</td>
		</tr> 
		<tr>
  <td>
	<div id="Layer2" style="position:absolute; left:450px; top:39px; width:0px; height:2px; z-index:8"></div>
  	<div id="Layer3" style="position:absolute; left:410px; top:15px; width:168px; height:24px; z-index:9"><B>Existing
	Category</B></div>
 	<div id="Layer3" style="position:absolute; left:410px; top:30px; width:168px; height:24px; z-index:9">
 	<select size="10" id="selectID">	
		<%
			
			Iterator itr1=SubCatArr.iterator();		
			for(int i=0;i<SubCatArr.size();i++){
				ArrayList SubCatArr1=(ArrayList)SubCatArr.get(i);
				String catId=""+SubCatArr1.get(0);
				String catName=""+SubCatArr1.get(2);
				String catShName=""+SubCatArr1.get(2);
		%> 
		 <option><%=catName%></option>
		 
		
		<%} %>	
	</select> 
	<%-- <img src="<%=request.getContextPath()%>/images/Assets_images/AssetsMaster.jpg" alt="Image not displayed"/> --%>
  </div>
  </td>
  </tr>
    </tbody> 
</table>
	</div>
	
	<div style="position:absolute; left:50px; top:250px;">
	<input
		type="button" id="btn" class="btn" value="User-Instructions" name="cmdSubmit" onclick="instruction()" tabindex="2">
		<p id="demo" style="visibility:hidden; font-style:bold; font-size:15px;">
		1. Select main category or you can also search main-category as shown below.<br/>&nbsp;&nbsp;<img border="10px" src="<%=request.getContextPath()%>/images/Assets_images/Main_Cate_Select.jpg" alt="Image not displayed"/> <br/><br/><br/>
		2. Enter valid sub category.<br/>&nbsp;&nbsp; Eq: If you select Furniture then sub category would be "chair, table etc"<br/>&nbsp;&nbsp; <img border="10px" src="<%=request.getContextPath()%>/images/Assets_images/Sub_Cat_Add.jpg" alt="Image not displayed"/>
		<br><br><br>3. Enter valid short form according to SGI format present in document <br/> &nbsp;&nbsp; <br><br><br>
		</p>
	</div>
</form>

</BODY>
  <%}else{ %>
<%@include file="../cookieTracker/CookieTrackerBottom.jsp" %>
<%} %>
</HTML>
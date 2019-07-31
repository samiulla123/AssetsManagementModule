<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@page import="com.gen.cms.util.DateManager"%>
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
			document.frmAdminAssetsAdd.action="";
			document.frmAdminAssetsAdd.submit();		
		}
	</script> 
	<style>
#demo {
  width: 50%;
  padding: 20px 0;
  text-align: left;
  background-color: #DB9796;
  margin-top: 30px;
  border-radius:10px;
  float: right;
}
input:focus{
	background-color:#BD0102;
	transition: transform .2s;
}
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
#btn{
  	background: linear-gradient(45deg,
      #ffcccc,  #ccffff);
}

#flt{
	margin-top: 10px;
	
} 

.div{
  position: absolute;
  top: 110px;
  float:center;
  font-size:15px;
}
.bg{
	font-family: Lato;
 	 font-weight: 400;
	background-color: #26282a;
	color: white;
}

.center {
	margin: 0 auto;
	text-align: center;
}

.spacer {
	margin-top: 6rem;
	background-color:black;
}

/* barcode container */
.anim-box {
	position: relative;
	width: 220px;
	height: 100px;
	padding: 25px 30px;
	transition: transform .6s ease-out;
}


/* top left corner */
.anim-box:before {
	top: 0; left: 0;
	border-width: 2px 0 0 2px;
}

/* top right corner */
.anim-box:after {
	top: 0; right: 0;
	border-width: 2px 2px 0 0;
}

/* bottom right corner */
.anim-box>:first-child:before {
	bottom: 0; right: 0;
	border-width: 0 2px 2px 0;
}

/* bottom left corner */
.anim-box>:first-child:after {
	bottom: 0; left: 0;
	border-width: 0 0 2px 2px;
}

/* barcode bars */
.anim-item {
	display: inline-block;
	background-color: white;
	height: 100px;
	text-align:bottom;
}

.anim-item-sm {
	width: 2px;
	margin-right: 3px;
}

.anim-item-md {
	width: 3px;
	margin-right: 2px;
}

.anim-item-lg {
	width: 5px;
	margin-right: 5px;
}

/* grow on hover */
.anim-box:hover {
	transform: scale(1.5, 2);
}

.anim-box:hover .scanner {
  animation-play-state: running;
}

/* animated laser beam */
.scanner {
	width: 100%;
	height: 3px;
	background-color: red;
  opacity: 0.7;
  position:relative;
  box-shadow: 0px 0px 8px 10px rgba(170, 11, 23, 0.49);
  top:50%;
  animation-name: scan;
  animation-duration: 4s;
  animation-timing-function: linear;
  animation-iteration-count: infinite;
  animation-play-state: paused;
}

@keyframes scan {
  0% {
    box-shadow: 0px 0px 8px 10px rgba(170, 11, 23, 0.49);
    top: 50%;
  }  
  25% {
    box-shadow: 0px 6px 8px 10px rgba(170, 11, 23, 0.49);
    top: 5px;
  }
  75% {
    box-shadow: 0px -6px 8px 10px rgba(170, 11, 23, 0.49);
    top: 98%;
  }
}

.dateBack{
	background-color: #b3ffb3;
}
</style>
</HEAD>
<%
	String un=request.getParameter("unit");
	String dep=request.getParameter("dep");
	System.out.println("Unit "+un+" Reference Number "+dep);
	ResultSet res1=null;
	String msg=(String)session.getAttribute("error"); 
 	session.removeAttribute("error");
 	String refNo=(String)session.getAttribute("ref_no"); 
 	session.removeAttribute("ref_no");
 	ArrayList data=assetManager.selectAssetRegisterReferenceNumber(dep);
%>
  			
<body>
<form name="frmAdminAssetsAdd" method="post" action="">
<input type="hidden" name="ActionId" value="AddAssets">
<input type="hidden" name="Task" value="Add">
<input type="hidden" name="user_id" value="<%=email%>">
  <div class="container"  id=Layer5 style="width: 100%; float: left;"> 
  <br><br>
  <font class="dateBack" size="3px"> Indicate Todays Register Assets   </font>
    <table  class="table table-hover" id="tbl" width="100%" border=0 style="border-collapse: collapse; ">
   
    		<h5>Reference Number List</h5>
   	<hr/>
    	<tr>
    		<td colspan="6">Unit : &nbsp;&nbsp;&nbsp;&nbsp;	
    		<%
    		ArrayList unit=assetManager.SelectUnit();
    		System.out.println("Unit "+unit); %>
    			<select name="unit" data-live-search="true" data-live-search-style="startsWith" class="selectpicker" data-style="btn-default" data-size="10" data-width="50%" data-height="10%" data-width="100%" data-height="10%" onchange="display()">
    				<option value="">Select Unit</option>
    				<%for(int u=0;u<unit.size();u++){ 
    					ArrayList unar=(ArrayList)unit.get(u);
    					System.out.println("Unit "+unar.get(0));
    					%>
    					<option value="<%=unar.get(0)%>" <%if(unar.get(0).equals(un)){ %>selected<%} %>><%=unar.get(0) %></option>
    				<%} %>
    			</select>
    			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;			
    			Department :&nbsp;&nbsp;&nbsp;&nbsp;	<% ArrayList Depart=assetManager.SelectDepartment(un);
    		 System.out.println("Department List "+Depart+" Department Size "+Depart.size());%>
    			<select name="dep" data-live-search="true" data-live-search-style="startsWith" class="selectpicker" data-style="btn-default" data-size="10" data-width="50%" data-height="10%" data-width="100%" data-height="10%" onchange="display()">
    				<option value="">Select Department</option>
    				<%
    				String Did="";
    				String Dname="";
    				String DShName="";
    				for(int d=0;d<Depart.size();d++)
    				{
    					System.out.println("Details Data "+Depart.get(d));
    					ArrayList DepDet=(ArrayList)Depart.get(d);
    					System.out.println("Details Data=== "+DepDet);
    					System.out.println("Department "+DepDet.get(0)+" Unit "+DepDet.get(1));
    					Did=""+DepDet.get(0);
    					Dname=""+DepDet.get(1);
    					DShName=""+DepDet.get(2);
    					System.out.println("Department Sh_name "+DShName);
    				%>
    				<option value="<%=Did%>" <%if(Did.equals(dep)){ %>selected<%} %>><%=Dname %></option>
    			<%} %>
    			</select>
    			<%System.out.println("Department Sh_name=== "+DShName); %>
    		</td>
    	</tr>
    	<tr>
    		<th>Sl.No</th>
    		<th>Asset Name</th>
    		<th>Bill Number</th>
    		<th>Reference Number</th>
    		<th>Created At</th>
    		<th>Created On</th>
    	</tr>
		<% 
		 int count=1;
    	for(int r=0;r<data.size();r++){
    	ArrayList allDa=(ArrayList)data.get(r);
    	String date2=""+allDa.get(17);
    	Date dNow2 = new SimpleDateFormat("yyyy-MM-dd").parse(date2); 
    	SimpleDateFormat ft1 =new SimpleDateFormat ("MM/dd/yyyy");
    	String regDate2=ft1.format(dNow2);
    	DateManager dt=new DateManager();
    	String date=dt.getCurrentDate();
    	String colr="";
    	if(regDate2.equals(date)){
    		colr="dateBack";
    	}%>
    	<tr class="<%=colr%>">
    		<td><%=count %></td>
    		<td><%=allDa.get(20) %></td>
    		<td><%=allDa.get(5) %></td>
    		<td><%=allDa.get(11) %></td>
    		<td><%=allDa.get(16) %></td>
    		<%dNow2 = new SimpleDateFormat("yyyy-MM-dd").parse(date2); 
    	SimpleDateFormat ft2 =new SimpleDateFormat ("dd/MM/yyyy");
    	String regDate=ft2.format(dNow2); %>
    		<td><%=regDate %></td>
    	</tr>
    	<%count=count+1;} %>
	</table>
	<div align="left" style="font-size:15px">
		<font color="#FF0000"><%if(msg!=null){%>&nbsp;<%=msg%><%} %></font>	
	</div>
</div>

</form>

</BODY>
  <%}else{ %>
<%@include file="../cookieTracker/CookieTrackerBottom.jsp" %>
<%} %>
</HTML>
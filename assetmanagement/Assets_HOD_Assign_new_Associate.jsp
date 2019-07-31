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
	function transfer()
	{
		document.hod_hoi.action="../../AssetsServlet";
		document.hod_hoi.submit(); 
		
	}
	
</script>
<style>
td{
	text-align: center;
}
</style>
</HEAD>
<%
	String sub_id=request.getParameter("assetId");
	String progMst_id=request.getParameter("department");
	String fac_id=request.getParameter("facId");
	System.out.println("Prgram Mst Id "+progMst_id);
	System.out.println("Faculty Id "+fac_id);
	System.out.println("In Assets transfer register "+sub_id);
	Dictionary dict=new Hashtable();
	Assets_DBQueries db=new Assets_DBQueries();
	ArrayList prog_id=db.seelctDepartIdName(email);
	System.out.println("data details "+prog_id);
	String msg=(String)session.getAttribute("error");
	session.removeAttribute("error");
	ArrayList ids=new ArrayList();
	System.out.println("Prog Mst Id "+progMst_id);
	ArrayList fac_name=db.Asset_Tran_fac_info(progMst_id);
	System.out.println("Name of Faculties data "+fac_name);
	ArrayList res23=db.selectAssetRegisterData(progMst_id,fac_id );
	System.out.println("Result of all asset particular assoc "+res23);
	System.out.println("size of indi assoc "+res23.size());
 %>		
<body>
<form name="hod_hoi"  method="post" >

<input type="hidden" name="ActionId" value="AssetsTransfer">
<input type="hidden" name="email" value="<%=email%>">
<input type="hidden" name="Task" value="Add">
<input type="hidden" name="TrStatus" value="">
<input type="hidden" name="op" value="6">
	<div class="container-fluid">
	<br/><br/>
	<h5>Assets Assign To New Associate</h5>
	<hr/>
	<br/>
	<select name="department" data-live-search="true" data-live-search-style="startsWith" class="selectpicker" data-style="btn-default" data-size="10"  data-width="50%" data-height="10%" data-width="50%" data-height="10%" onchange="reload()">
				<option value="">Select Department</option>
				<%for(int o=0;o<prog_id.size();o++)
				{
					ArrayList ar10=(ArrayList)prog_id.get(o);%>
					<option value="<%=ar10.get(0)%>" <%if(ar10.get(0).equals(progMst_id)){ %>selected<%} %>><%=ar10.get(1) %></option>
				<%} %>
			</select>&nbsp;&nbsp;&nbsp;&nbsp;	&nbsp;&nbsp;&nbsp;&nbsp;
		<select name="facId" data-live-search="true" data-live-search-style="startsWith" class="selectpicker" data-style="btn-default" data-size="10"  data-width="50%" data-height="10%" data-width="50%" data-height="10%" onchange="reload()">
				<option value="">Select Department</option>
		<%for(int o=0;o<fac_name.size();o++)
				{
					ArrayList stfDet=(ArrayList)fac_name.get(o);
					System.out.println("Name of Faculties "+stfDet);
					String name=""+stfDet.get(1);
					String lname=""+stfDet.get(2);
					String fullName=""+name+" "+lname;%>
					<option value="<%=stfDet.get(0)%>" <%if(stfDet.get(0).equals(fac_id)){ %>selected<%} %>><%=fullName %></option>
				<%} %> 
			</select>
	<hr/>
	<%if(!res23.isEmpty())
	{ 
		int count=1;%>
			<table class="table table-striped"  border=2 style="border-collapse: collapse; width:100%">
					<tr>
					<th>Sl.No</th>
					<th>Main Category </th>
					<th>Sub Category </th>
					<th>Original Location</th>
					<th>Reference Number</th>
					<th>5-S Owner</th>
					<th>Description Of Asset</th>
					<th>New 5-S Owner</th>
					<th>Amount</th>
					</tr>
					<tr>
					<%for (int i=0;i<res23.size();i++) 
					{%>
						<%ArrayList ar=(ArrayList)res23.get(i);%>
								<td><%=count %></td>
								<td>
								<input type="hidden" value="<%=ar.get(0)%>" name="reg_no">
									<label><%=ar.get(19) %></label>
								</td>
								<td>
									<label><%=ar.get(20) %></label>
								</td>
								<td>
									<label><%=ar.get(13)%></label>
								</td>
								<td>
									<label><%=ar.get(11)%></label>
								</td>
								<td>
									<label><%=ar.get(15)%></label>
								</td>
								<td>
									<label><%=ar.get(4)%></label>
								</td>
								<td>
								<select name="Owner" id="owner">
								<option value="">select name</option>
									<%for(int o=0;o<fac_name.size();o++)
										{
											ArrayList stfDet=(ArrayList)fac_name.get(o);
											System.out.println("Name of Faculties "+stfDet);
											String name=""+stfDet.get(1);
											String lname=""+stfDet.get(2);
											String fullName=""+name+" "+lname;%>
											<option value="<%=stfDet.get(0)%>" <%if(stfDet.get(0).equals(fac_id)){ %>selected<%} %>><%=fullName %></option>
										<%} %> 
								</select>
								</td>
								<td>
									<label><%=ar.get(29)%></label>
								</td>
							</tr>
					<% count=count+1;}%>	
				</table> 
		<% %>
				<input type="hidden" value="1" name="AppStatus">
				<center><input class="btn" type="button" name="approve" value="Submit" onclick="return transfer()"/>
	
				<input class="btn" type="button" name="approve" value="Cancel Transfer" onclick="display()"/></center><br/>
	<%}else{ %>
	<center><div id="rect" class="center"><font color="red" size="3px">No Data Found &#128522;</font></div></center>
	<%} %>
	</div>
	<font <%if(msg!=null) {%>>
		<label><%=msg %></label>
		<%} %>
	</font>
</form>
</body> 
  <%}else{ %>
<%@include file="../cookieTracker/CookieTrackerBottom.jsp" %>
<%} %>
</HTML> 
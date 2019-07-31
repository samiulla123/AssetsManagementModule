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
		/* var id=document.hod_hoi.hod.value; */
		
		var id=document.getElementById("hod").value;
		if(id=="1")
		{
			document.hod_hoi.TrStatus.value=0;		
			document.hod_hoi.action="../../AssetsServlet";
			document.hod_hoi.submit();
		} 
		else if(id=="2")
		{
			var data=document.getElementById("owner").value;
			var loc=document.getElementById("loc").value;
			if(data=="")
			{
				alert("Please Select 5-S Owner");
				document.hod_hoi.Owner.focus();
				return false;
			}
			if(loc=="")
			{
				alert("Enter Location");
				document.hod_hoi.newLoc.focus();
				return false;
			}
			document.hod_hoi.TrStatus.value=0;		
			document.hod_hoi.action="../../AssetsServlet";
			document.hod_hoi.submit(); 
		}
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
	System.out.println("In Assets transfer register "+sub_id);
	Dictionary dict=new Hashtable();
	Assets_DBQueries db=new Assets_DBQueries();
	String user_name=email;
	String new_location="";
	String cur_hod_status="";
	String req_id="";
	String tr_proc_id="";
	ArrayList res24=db.Asset_transfer(5, dict, sub_id, "");
	for(int m=0;m<res24.size();m++)
	{
		ArrayList departDet=(ArrayList)res24.get(m);
		new_location=""+departDet.get(4);
		cur_hod_status=""+departDet.get(7);
		req_id=""+departDet.get(0);
		tr_proc_id=""+departDet.get(6);
	}
	System.out.println("Location  "+new_location);
	System.out.println("Current HOd status  "+cur_hod_status);
	System.out.println("Proc Mst Id  "+tr_proc_id);
	
	ArrayList res23=db.selectAssetTransfer(3, email, sub_id, "");
	System.out.println("Data found "+res23);
	String msg=(String)session.getAttribute("error");
	session.removeAttribute("error");
	ArrayList ids=new ArrayList();
 %>		
<body>
<form name="hod_hoi"  method="post" >

<input type="hidden" name="ActionId" value="AssetsTransfer">
<input type="hidden" name="email" value="<%=email%>">
<input type="hidden" name="Task" value="Add">
<input type="hidden" name="TrStatus" value="">
<input type="hidden" name="op" value="2">
	<div class="container-fluid">
		<table class="table table-striped"  border=2 style="border-collapse: collapse; width:100%">
	<h5>Assets Transfer Request</h5>
			<tr>
			<th>Main Category </th>
			<th>Sub Category </th>
			<th>Original Location</th>
			<th>Reference Number</th>
			<th>5-S Owner</th>
			<th>Description Of Asset</th>
			<th>New Location</th>
			<th>New 5-S Owner</th>
			<th>Location</th>
			<th>Amount</th>
			</tr>
			<tr>
			<%for (int i=0;i<res23.size();i++) 
			{%>
				<%ArrayList arr=(ArrayList)res23.get(i);
				for(int j=0;j<arr.size();j++)
				{
					ids.add(arr.get(j));
					 String id=""+arr.get(0);	
					ArrayList value=db.Asset_Reg_Data_For(id); 
					System.out.println("--------------Value Asset Approve============== "+value); 
					for(int k=0;k<value.size();k++)
					{
						ArrayList ar=(ArrayList)value.get(k);
					%>
					<%if(cur_hod_status.equals("0"))
					{ 
						%>
						<td>
							<input type="hidden" name="imp" value="1">
							<input type="hidden" name="hod" id="hod" value="1">
							<input type="hidden" name="id" value="<%=req_id%>">
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
							<label><%=new_location%></label>
						</td>
						<td>
							<label>Assign By Transfer Hod</label>
						</td>
						<td><label>New Location</label></td>
						<td>
							<label><%=ar.get(9)%></label>
						</td>
					</tr>
				<%}else if(cur_hod_status.equals("1"))
					{ 
						ArrayList fac_name=db.Asset_Tran_fac_info(tr_proc_id);
						System.out.println("Name of Faculties "+fac_name);
						System.out.println("Current Hod status if if "+cur_hod_status.equals("0"));
						%>
						<td>
								<input type="hidden" name="imp" value="2">
							 <input type="hidden" name="hod" id="hod" value="2">
							<input type="hidden" name="id" value="<%=req_id%>">
							<input type="hidden" name="reg_no" value="<%=ar.get(0)%>">
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
							<label><%=new_location%></label>
						</td>
						<td>
						<select name="Owner" id="owner">
						<option value="">select name</option>
							<%
								System.out.println("FAcuinfo");
				          		Iterator itr=fac_name.iterator();
				          		System.out.println("Iterator = "+itr);
								while(itr.hasNext()){
								ArrayList arr12=(ArrayList)itr.next();
								System.out.println("id "+arr12);
								System.out.println("name "+arr12.get(1));
								String cid=""+arr12.get(0);
								String name=""+arr12.get(1);
								String lname=""+arr12.get(2);
								String fname=name+" "+lname;
								System.out.println("end");
							 %>
						<option value="<%=cid%>" selected><%=fname %></option>
						<%} %>
						</select>
						</td>
						<td><input type="text" class="form-control" id="loc" style="background-color: #FFECEC" name="newLoc" placeholder="Enter Asset Location"></td>
						<td>
							<label><%=ar.get(9)%></label>
						</td>
					</tr>
				<%} %>

			<% }%>	
		<%} %>
		
<%} %>	
</table>
				<input type="hidden" value="1" name="AppStatus">
				<center><input class="btn" type="button" name="approve" value="Approve" onclick="return transfer()"/>
	
				<input class="btn" type="button" name="approve" value="Cancel Transfer" onclick="display()"/></center><br/>
	
		<div class="form-group">
				<div style="">
					<p id="cmnt" style="visibility:hidden;">
					<label>Enter Your Message Here<font color="red">(Its Mandatory)</font></label>
			
						<textarea id="txtArea" class="form-control" id="cmnt" name="txtMsg" style="background-color:#FFECEC ; size:50; width:70%; height:40%" onkeypress="return (event.keyCode!=39)"></textarea>
						<input class="btn" type="button" value="submit" name="rej_submit" style="" onclick="validate()">
					</p>
				</div>
				</div>
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
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
<%
	String r="0";
	String browserType=(String)request.getHeader("User-Agent");
	System.out.println("Browser Type "+browserType); 
	Assets_DBQueries dbVer=new Assets_DBQueries();
	String version=dbVer.BrowserVersion(browserType);
	float ver=11;
	if(!version.isEmpty())
	{
	ver=Float.parseFloat(version);
	}
	System.out.println("Version of IE "+ver);
	if(ver<11.0){
	r="1";%>
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
<LINK href="../../stylesheet/Assets_CSS/Print.css" rel="stylesheet" type="text/css" />
<SCRIPT language="javascript" src="../../javascript/AssetsJS/Assets_Sub_Cate.js"> </SCRIPT>
<SCRIPT language="javascript" src="../../javascript/Validate.js"></SCRIPT>
<script language="javascript" src="../../javascript/popcalendar.js"></script>
<jsp:useBean id="assetManager" class="com.gen.cms.assets.beans.Assets_DBQueries"></jsp:useBean>

<TITLE>AdminCreateNation.jsp</TITLE>
<script>
	function printText()
	{
		var sTable = document.getElementById("d1").innerHTML;
		tr=document.getElementsByName("tr");
		sst=document.getElementsByName("sst");
		req=document.getElementsByName("req");
        // CREATE A WINDOW OBJECT.
        var win = window.open('', '', 'height=700,width=700,location=yes,scrollbars=yes,resizable=yes');
	
       win.document.write('<html><head>');
       win.document.write('<title>Asset Print</title>');// <title> FOR PDF HEADER.
       win.document.write('<LINK href="../../stylesheet/Assets_CSS/Print.css" rel="stylesheet" type="text/css" />');
       win.document.write('<style>');
       for(i=0;i<req.length;i++)
       {
       		alert(tr[i].value);
       		if(tr[i].value==1)
       		{
       			win.document.write('tr{ background-image: url("..\..\images\Assets_images\TRTo.jpg"); background-repeat: repeat-x; }');
       		}
       		if(sst[i].value==5)
       		{
       			win.document.write('tr{background-image: url("..\..\images\Assets_images\scrapSale.png"); background-repeat: repeat-x;}');
       		}
       		if(sst[i].value==3)
       		{
       			win.document.write('tr{background-image: url("..\..\images\Assets_images\TransferFrom.jpg"); background-repeat: repeat-x;}');
       		}
       }  
        win.document.write('</style>');
        win.document.write('</head>');
        win.document.write('<body>');  
        win.document.write(sTable);         // THE TABLE CONTENTS INSIDE THE BODY TAG.
        win.document.write('</body></html>'); 
 		win.print();
        win.document.close(); 	// CLOSE THE CURRENT WINDOW. 

        /* window.print(sTable); */    // PRINT THE CONTENTS.
	}
</script>
<style>


</style>
</HEAD>
<%
	Assets_DBQueries db=new Assets_DBQueries();
	String m_cat=request.getParameter("m_cat");
	String prog_id=request.getParameter("prog_id");
	String m_name=request.getParameter("m_name");
	System.out.println("Main Category "+m_cat);
	System.out.println("Prog Msgt id "+prog_id);
	System.out.println("Main Name "+m_name);
	ArrayList main_cat=db.selectMainCat();
	ArrayList depuni=db.DepartmentUnit(email);
	String dep="";
	String unit="";
	int count=1;
	for(int m=0;m<depuni.size();m++)
	{
		ArrayList depU=(ArrayList)depuni.get(m);
		dep=""+depU.get(0);
		unit=""+depU.get(1);
	}
 %>		
<body>
<form name="hod_hoi"  method="post">

<input type="hidden" name="ActionId" value="ScrapSale">
<input type="hidden" name="email" value="<%=email%>">
<input type="hidden" name="op" value="5">
<input type="hidden" name="Task" value="Add">
<input type="hidden" name="status123" value="">

 <div class="container-fluid">
 <div id="d1">
 		<center><h1>PES&T's, SHAIKH GROUP OF INSTITUTIONS</h1></center>
	 <br>INSTITUTION : <font size="2px" color="blue"><%=dep %></font> &nbsp;&nbsp;&nbsp;&nbsp;	  DEPARTMENT : <font size="2px" color="red"><%=unit %></font> &nbsp;&nbsp;&nbsp;&nbsp;  PHYSICAL LOCATION : <font size="2px"><b><%=unit %></b></font>
	 <table>
	 	<caption><%=m_name %></caption>
	 	<tr>
	 		<th>Sl_No</th>
			<th>Asset Name</th>
			<th>ENTRY DATE</th>
			<th>DESC OF ASSETS</th>
			<th>BILL NO</th>
			<th>BILL DATE</th>
			<th>SUPPLIER NAME/TRSF FROM DEPT</th>
			<th>RECEIPT/TRSF 
			<table><tr><th>QTY</th><th>AMOUNT</th></tr></table></th>
			<th>TR DEPT.ASSET NO<br>(RECEIVED FROM)</th>
			<th>TRSF TO DEPT/SALES/LOSS
			<table><tr><th>DEPT</th><th>QTY</th><th>AMOUNT</th></tr></table></th>
			<th>TE DEPT. ASSET NO SOLD/SCRAP<br>(TRANSFERED TO)</th>
			<th>ASSET NO. OF DEPT</th>
			<th>SIGNATURE & DATE
			<table><tr><th>5-S OWNER
			<table><tr><th>TR</th><th>TE</th></tr></table>
			</th><th>HOD
			<table><tr><th>TR</th><th>TE</th></tr></table></th></tr></table></th>
			<th>Month</th>
			<th>Year</th>
	 	</tr>
	 	<%
	 		ArrayList ar=db.PrintMethod(prog_id, m_cat);
	 		System.out.println("In jsp page main category data "+ar);
	 		for(int k=0;k<ar.size();k++)
					{
						ArrayList AR=(ArrayList)ar.get(k);
						String regno=""+AR.get(0);
						String color="";
					if(r=="1"){
						try
						{
							if(AR.get(26).equals("1"))
							{  
								color="Transfered";
							}
							else if(AR.get(18).equals("5"))
							{
								color="SaleScrap";
							}
							else if(AR.get(18).equals("3"))
							{
								color="Transfer";
							}
							else{
								color="Default";
							}
						}
						catch(IndexOutOfBoundsException e)
						{
							System.out.println("Index out of range "+e);
						}
					}else if(r=="0"){
						try
						{
							if(AR.get(26).equals("1"))
							{  
								color="Transfered1";
							}
							else if(AR.get(18).equals("5"))
							{
								color="SaleScrap1";
							}
							else if(AR.get(18).equals("3"))
							{
								color="Transfer1";
							}
							else{
								color="Default";
							}
						}
						catch(IndexOutOfBoundsException e)
						{
							System.out.println("Index out of range "+e);
						}
					}
						%>
							<tr class="<%=color%>"><td>
								<%=count %>
								<input type="hidden" value="<%=AR.get(26)%>" name="tr">
								<input type="hidden" value="<%=AR.get(18)%>" name="sst">
								<input type="hidden" value="<%=AR.get(0)%>" name="req">
								</td>
								<td><font color="green"><%=AR.get(20)%></font></td>
								<td><%=AR.get(3) %></td>
								<td><%=AR.get(4) %></td>
								<td><%=AR.get(5) %></td>
								<td><%=AR.get(6) %></td>					         
								<td><%=AR.get(7) %></td>
								<td><table><tr><td><%=AR.get(8) %></td><td><%=AR.get(9) %></td></tr></table></td>
								<%
								prog_id=AR.get(12).toString();
								if(AR.get(26).equals("1")) {
									ArrayList tr_depAssNo=db.TRDataFromTRtable(regno);
									String refNo=tr_depAssNo.get(0).toString().replace("[","").replace("]","");;%>
								<td><%=refNo%></td>
								<%} else {%>
								<td></td>
								<%} %>
								<td><table><tr>
								<%if(AR.get(18).equals("3")) {
									ArrayList depr=db.TRDataFromTRtableDep(regno);
									System.out.println("Empty "+depr.isEmpty());
									String departmnt="";
									if(!depr.isEmpty())
									{
										departmnt=depr.get(0).toString().replace("[","").replace("]","");
									}%>
								<td><%=departmnt %></td><td>1</td><td><%=AR.get(9) %></td>
								<%}else { %>
								<td></td><td></td><td></td><%} %></tr></table></td>
								
								<%
								if(AR.get(18).equals("5")){ 
								ArrayList ref_noScrp=db.ScrapSaleRefNo(regno);
								String ref_noSS=ref_noScrp.get(0).toString().replace("[","").replace("]","");%>
								<td><%=ref_noSS %></td>
								<%}else { %>
								<td></td>
								<%} %>
								<td><%=AR.get(11) %></td>
								<td><%ArrayList sh_name=db.FiveSOwnShName(AR.get(15).toString());
									String SshName=sh_name.toString().replace("[","").replace("]",""); %>
								<table><tr><td><%=SshName.toUpperCase() %></td><td><%=SshName.toUpperCase() %></td><td><%=AR.get(22) %></td><td><%=AR.get(22) %></td></tr></table>
								<!-- <table><tr></tr></table></td> -->
										<%String month[]={"Jan","Feb","Mar","Apr","May","June","July","Aug","Sept","Oct","Nov","Dec"}; 
							String dt=""+AR.get(6);
							System.out.println("Months "+dt);
							String mn=dt.substring(5,7);
							int mon=0;
							String month1="";
							try{
								mon=Integer.parseInt(mn);
								for(int m=0;m<month.length;m++)
								{
									if(m==mon-1)
									{
										month1=month[m];
									}
								}
							}
							catch(NumberFormatException e){
								month1="Not Found";
							}
							System.out.println("Mn "+mon);
							%>
							<td><%=month1 %></td>
							<%String date=""+AR.get(6);
							String year=date.substring(0,4);
							%>
							<td><%=year %></td>
							</tr>
						
				  	<% count=count+1; 
				  }%>
			 	<%%>
			 	<tr>
	 </table>
<%if(r=="1") {%>
<div class="center2">
		<p class="Transfer">Transfer To</p>
		<p class="SaleScrap">SaleScrap</p>
		<p class="Transfered">Transfered From</p>
		<p>Present Assets</p>
</div>  
<%}else if(r=="0"){ %>
<div class="center2">
	<p class="Transfer1">Transfer To</p>
	<p class="SaleScrap1">SaleScrap</p>
	<p class="Transfered1">Transfered From</p>
	<p>Present Assets</p>
</div> 
<%} %>
</div>
	<input type="submit" class="btn" value="Print" onclick="printText()">
</div>
</form>
</body>
  <%}else{ %>
<%@include file="../cookieTracker/CookieTrackerBottom.jsp" %>
<%} %>
</HTML>
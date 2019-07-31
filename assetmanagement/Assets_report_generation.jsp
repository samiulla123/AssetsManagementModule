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
		<font color="green" size="3px">You Are Using Old Version Of Internet Explorer Version IE. <%=ver %>, For Better View Use Latest Version Of Internet Explorer Or Use Different Browser Eq. Chrom, Firefox</font>
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

<style>
#tbl {
  border-collapse: collapse;
   border: 1px solid black;
}
td, th {
  border: 1px solid black;
}
.center2 {
  width: 20%;
   border: 1px solid;
  padding: 5px;
  font-size: 100%;
  text-align: center;
  top: 100px;
  left: 100px;
}

.Transfer{
	background-image: url("..\..\images\Assets_images\TRTo.jpg");
	 background-repeat: repeat-x;
}
.SaleScrap{
	background-image: url("..\..\images\Assets_images\scrapSale.png");
	 background-repeat: repeat-x;
}
.Transfered{
	background-image: url("..\..\images\Assets_images\TransferFrom.jpg");
	 background-repeat: repeat-x;
}
 .Transfer1{
	background:
	linear-gradient(63deg, #b3ffb3 23%, transparent 23%) 7px 0,
	linear-gradient(63deg, transparent 74%, #b3ffb3 78%),
	linear-gradient(63deg, transparent 34%, #b3ffb3 38%, #ccffcc 58%, transparent 62%),
	#ffffff;
	background-size: 16px 48px;
}
.SaleScrap1{
	background:
	radial-gradient(#ffffff 15%, transparent 16%) 0 0,
	radial-gradient(#ffffff 15%, transparent 16%) 8px 8px,
	radial-gradient(rgba(255,255,255,.1) 15%, transparent 20%) 0 1px,
	radial-gradient(rgba(255,255,255,.1) 15%, transparent 20%) 8px 9px;
	background-color:#b3d9ff;
	background-size:16px 16px;
}
.Transfered1{
	background: #36c;
	background:
	linear-gradient(115deg, transparent 75%, rgba(255,255,255,.8) 75%) 0 0,
	linear-gradient(245deg, transparent 75%, rgba(255,255,255,.8) 75%) 0 0,
	linear-gradient(115deg, transparent 75%, rgba(255,255,255,.8) 75%) 7px -15px,
	linear-gradient(245deg, transparent 75%, rgba(255,255,255,.8) 75%) 7px -15px,
	#ffebe6;
	background-size: 15px 30px;
}
</style>
</HEAD>
<%
	Assets_DBQueries db=new Assets_DBQueries();
	ArrayList main_cat=db.selectMainCat();
	ArrayList depuni=db.DepartmentUnit(email);
	String dep="";
	String unit="";
	String prog_id="";
	String main_catName="";
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
<h5>Assets Register</h5>
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
	<p class="Transfered1">Transfer From</p>
	<p>Present Assets</p>
</div> 
<%} %>
 <div class="container-fluid">
 <br>INSTITUTION : <font size="2px" color="blue"><%=dep %></font> &nbsp;&nbsp;&nbsp;&nbsp;	  DEPARTMENT : <font size="2px" color="red"><%=unit %></font> &nbsp;&nbsp;&nbsp;&nbsp;  PHYSICAL LOCATION : <font size="2px"><b><%=unit %></b></font>
 
 <%for(int i=0;i<main_cat.size();i++)
	{ 
		int count=1;
		ArrayList m_det=(ArrayList)main_cat.get(i);%>
		<br>
		<table class="table" id="tbl">
		<caption><%=m_det.get(1).toString().toUpperCase() %></caption>
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
			long in=0;
				try{
				 in=Integer.parseInt(m_det.get(0).toString());
				 }catch (NumberFormatException e)
				 {
				 	in=0;
				 }
			ArrayList sub_cat=db.selectSubName(in); 
			for(int j=0;j<sub_cat.size();j++)
			{
				ArrayList s_cat = (ArrayList)sub_cat.get(j);
				ArrayList asset=db.selectReportAssetRegister(email,s_cat.get(0).toString());
				for(int k=0;k<asset.size();k++)
				{
					ArrayList AR=(ArrayList)asset.get(k);
					String regno=""+AR.get(0);
					String color="";
				if(r=="1"){
					try{
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
					try{
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
						<tr class="<%=color%>">
							<td><%=count %></td>
							<td><font color="green"><%=s_cat.get(2).toString().toUpperCase() %></font></td>
							<td><%=AR.get(3) %></td>
							<td><%=AR.get(4) %></td>
							<td><%=AR.get(5) %></td>
							<%String date2=""+AR.get(6);
				         		Date dNow2 = new SimpleDateFormat("yyyy-MM-dd").parse(date2); 
				         		SimpleDateFormat ft1 =new SimpleDateFormat ("dd-MM-yyyy"); %>
							<td><%=ft1.format(dNow2) %></td>					         
							<td><%=AR.get(7) %></td>
							<td><table><tr><td><%=AR.get(8) %></td><td><%=AR.get(29) %></td></tr></table></td>
							<%
							prog_id=AR.get(12).toString();
							main_catName=AR.get(19).toString();
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
			  <% count=count+1;} %>
		 	<%} %>
		 	<tr>
				<td colspan="13">
					<center><a href="AssetMainPrint.jsp?m_cat=<%=m_det.get(0)%>&prog_id=<%=prog_id%>&m_name=<%=main_catName%>" target="popup" 
		onclick="window.open('AssetMainPrint.jsp?m_cat=<%=m_det.get(0)%>&prog_id=<%=prog_id%>&m_name=<%=main_catName%>','popup','width=600,height=600,location=no,scrollbars=yes,resizable=yes'); return false;"><label style="font-size:20px; font-family: serif;">Preview</label></a></center>
				</td>
			</tr>
	   <%} %>
	</table>
</div>
</form>
</body>
  <%}else{ %>
<%@include file="../cookieTracker/CookieTrackerBottom.jsp" %>
<%} %>
</HTML>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@page import="org.omg.CORBA.FloatSeqHelper"%>
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
	String Chkbx="";
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
		Chkbx="1";%>
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

<script type="text/javascript">
function display()
{
	var ss=document.Assets_transfer.main_cat.value;
	m=document.getElementsByName("mmmm");
	for(i=0;i<m.length;i++){
		document.getElementById("sub"+m[i].value).style.display="none"; 
	}
	document.getElementById("sub"+ss).style.display="inline";
}
		
		var str="";
function addSubCategory(sId)
{
	//alert("Sid="+sId);
	val=document.getElementById("catValue"+sId);
	sname=document.getElementById("sub_cat_name"+sId).value;
	rname=document.getElementById("ref_no"+sId).value;
	mStr=sname+" ( "+rname+" )";
	v=val.value;
	if(val.checked){
		val1=document.getElementById("selectedSubCat").value;
		x=document.Assets_transfer.tempAsset.value;
		if(val1==""){
			str=mStr;
		}else{
			str=val1+", "+mStr;
		}
							
		if(x==""){
			str1=v;
		}else{
			str1=x+","+v;
		}
		document.getElementById("selectedSubCat").innerHTML=str;
		document.Assets_transfer.tempAsset.value=str1;
		}else{
		val1=document.getElementById("selectedSubCat").value;
		x=document.Assets_transfer.tempAsset.value;
		val2="";
		val3="";
		s=val1.split(",");
		s1=x.split(",");
							
		for(i=0;i<s1.length;i++){
			if(!(s1[i]==v)){
				//alert("hi1");
				if(val3==""){
					val3=s1[i];
					val2=s[i];
				}else{
					val3=val3+","+s1[i];
					val2=val2+", "+s[i];
				}
			}
		}
							
		document.getElementById("selectedSubCat").innerHTML=val2;
		document.Assets_transfer.tempAsset.value=val3;
	}
} 

function submitForm()
{
	if(document.Assets_transfer.main_cat.value=="")
	{
		alert("Select Main Category ");
		return false;
	}
	if(document.Assets_transfer.tempAsset.value=="")
	{
		alert("Select One SubCategory ");
		return false;
	}
	if(document.Assets_transfer.reason.value=="")
	{
		alert("Enter Reason For Sale/Scrap ");
		return false;
	}
	
	document.Assets_transfer.action="../../AssetsServlet";
	document.Assets_transfer.submit();
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
#btn{
	background: linear-gradient(35deg, #ffcccc,  #ccffff);
}

#flt{
	float:left;
	position:relative;
	top:240px;
}
</style>
</HEAD>

<%
	String Edate=request.getParameter("entry_date");
	String mCat=request.getParameter("main_cat");
	ResultSet res1=null;
	String msg=(String)session.getAttribute("error"); 
 	session.removeAttribute("error");
 	System.out.println("message "+msg);
    Date dNow = new Date( );
    SimpleDateFormat ft = new SimpleDateFormat ("M-dd-yyyy");
    String dta=ft.format(dNow);     
    ArrayList mainCatArr=assetManager.selectMainCat();
    System.out.println("Main category "+mainCatArr);
   	int count=1;
   	String main_name="";
   	String sub_name="";	
   	String status="";	
   	String d_name="";
   	String id="";
   	String sh_name="";
   	String sh_unit="";
   	String unit="";
   	String assetId="";
   	ArrayList CurDepart=assetManager.selectAssetTransfer(11, email, "", "");
   	ArrayList Depart=assetManager.selectDepartment();
   	for(int k=0;k<CurDepart.size();k++)
   	{
   		ArrayList fetc=(ArrayList)CurDepart.get(k);
   		id=""+fetc.get(2);
   		d_name=""+fetc.get(0);
   		unit=""+fetc.get(1);
   		
   	}
   	String cid="";
   	int cnt=1;
   	System.out.println("Department value "+d_name+" id "+id+" unit "+unit);
 %>		
<body>
<form name="Assets_transfer"  method="post" action="">
<input type="hidden" name="ActionId" value="ScrapSale">
<input type="hidden" name="Task" value="Add">
<input type="hidden" name="selectedAsset"  value="">
<input type="hidden" name="tempAsset" value="">
<input type="hidden" name="email" value="<%=email%>">
<input type="hidden" name="op" value="2">
<div class="container-fluid"  id=Layer5>
	<table   border=0 style=" border-color:red; position: relative;">
	<h5>Assets Scrap Form</h5>
	<tr>
		<td>	
			Main Category<FONT color="#FF0000">*</FONT>
		</td>
		<td style="height: 10px;">
		<input type="hidden" value="<%=d_name%>" name="depart">
		<input type="hidden" value="<%=unit%>" name="unit">
		<input type="hidden" value="<%=id%>" name="prg_id">
		<select name="main_cat" data-live-search="true" data-live-search-style="startsWith" class="selectpicker"  data-size="30"  data-width="50%" data-height="15%"  onchange="display()">
			<option></option>
			<%
					System.out.println("In main category");
	          		Iterator itr=mainCatArr.iterator();
					while(itr.hasNext()){
					ArrayList arr=(ArrayList)itr.next();
					cid=""+arr.get(0);
					main_name=""+arr.get(1);
					String csname=""+arr.get(2);
	       		 %>
			<option value="<%=cid%>" <%if(cid.equals(mCat)){ %> selected<%}%>><%=main_name %></option>
				<%} %>
		</select>
		</td>
	</tr>
</table>
<br>
<br>
	<table>
	<caption>Selected Assets for Scrap/Sale</caption>
	<tr><td>
	<textarea rows="4" cols="40" id="selectedSubCat" class="form-control" onkeypress="return (event.keyCode!=39)"></textarea>
	</td>
	</tr>
	</table>
	<br>
		<font color="#FF0000" size="3px"><%if(msg!=null){%>&nbsp;<%=msg%><%}%></font>
	</div>
	<div style="position:absolute; left:500px; top:50px;">
	
<%
	for(int i=0;i<mainCatArr.size();i++)
	{ 
		ArrayList mainCatArr1=(ArrayList)mainCatArr.get(i);
		String mainCatId=""+mainCatArr1.get(0);
		String mainCatname=""+mainCatArr1.get(1);
		long in=0;
		try{
			in=Integer.parseInt(mainCatId);
		}
		catch (NumberFormatException e)
		{
			in=0;
		}
		ArrayList subCatArr=assetManager.selectSubName(in);
		System.out.println("Sub cat "+subCatArr);
		System.out.println("Main category 1243 "+mainCatId);
%>
		<input type="hidden" name="mmmm" value="<%=mainCatId%>">
		<%
			cnt=1;
			for(int j=0;j<subCatArr.size();j++)
				{
					ArrayList subCatArr1=(ArrayList)subCatArr.get(j);
					String subCatId=""+subCatArr1.get(0);
					String subCatName=""+subCatArr1.get(2);
					ArrayList asset=assetManager.selectAssetTransfer(12,email,subCatId,mainCatId);
					System.out.println("Assets Value "+asset+" Subcategory "+subCatId+" Sub name "+subCatName);
					System.out.println("Array Value "+asset.isEmpty());
		%>
			<div id="sub<%=mainCatId%>" style="display: none; position: absolute; width: 534px">
				<table class="table" style="border-collapse: collapse;">

					<% if(!asset.isEmpty())
						{ System.out.println("Assets value ");%>
					<caption>
						<b><%=mainCatname%></b>
					</caption>
					<tr>
						<th>S.No</th>
						<th>Name Of Assets</th>
						<th>Reference Number</th>
						<th>Details Of Assets</th>
						<th>Purchase Amount</th>
						<th></th>
					</tr>
					<%
								for(int k=0;k<asset.size();k++)
								{
									ArrayList asset1=(ArrayList)asset.get(k);
									assetId=""+asset1.get(0);
									System.out.println("Asset Id "+assetId);
									String sub_id=""+asset1.get(2);
									String ref_no=""+asset1.get(11);
									String name=""+asset1.get(20);	
									System.out.println("Reference number "+name);
									System.out.println("Value fo asset Id="+assetId);		
									%>
					<tr>
						<td style="text-align: center;"><input type="hidden"
							value="<%=sub_id%>" name="sub_id"> <%=cnt%></td>

						<td style="text-align: center;"><%=asset1.get(20) %></td>
						<td style="text-align: center;"><%=asset1.get(11) %></td>
						<td style="text-align: center;"><%=asset1.get(4) %></td>
						<td style="text-align: center;"><%=asset1.get(9) %></td>
						<td style="text-align: center;"><input type="hidden"
							id="sub_cat_name<%=assetId%>" value="<%=name%>"> <input
							type="hidden" id="ref_no<%=assetId%>" value="<%=ref_no%>">
							<input type="checkbox" name="catValue" id="catValue<%=assetId%>"
							value="<%=assetId%>" onclick="addSubCategory('<%=assetId%>')">
						</td>
					</tr>
					<%cnt=cnt+1; 
								}%>
					<%}
						else if(asset.isEmpty())
						{ %>
					<tr>
						<td colspan="5"> <font color="red" size="3px">No Sub Category Data
								Is Available</font></td>
					</tr>
					<%} %>
				</table>
			</div>
			<%} %>
	<%}%>
	</div>

	<div style="position:absolute; left:10px;top;500px">
		<h5>Enter Reason For Sale Scrap</h5>
		<textarea cols="55" rows="6" name="reason" class="form-control" style="background-color:#FFECEC ;"></textarea> <br/> <br/>
		<center><input type="button" class="btn" value="Send For Approve" onclick="return submitForm()">&nbsp;&nbsp;<input type="reset" class="btn" value="Cancel"></center>
	</div>
	<div id="flt" class="container=fluid">
	<input id="btn"
		type="button" class="btn" value="User-Instructions" name="cmdSubmit" onclick="instruction()" tabindex="3">
		<p id="demo" style="visibility:hidden; font-style:bold; font-size:15px; ">
		<b>Select Main Category</b><br/>
		1. Select main category to filter your require category <br/>Consider below image&nbsp;&nbsp;<br/>
		<img border="10px" src="<%=request.getContextPath()%>/images/Assets_images/TR_maincat.jpg" alt="Failed to load image">&nbsp;&nbsp; <br/><br/><br/>&nbsp;&nbsp; 
		
		<b>Check Sub Category</b><br/>
		2. After Selecting main category all sub category of that main category will be displayed<br> tick on check box to select it as shoen below <br/> 
		<img border="10px" src="<%=request.getContextPath()%>/images/Assets_images/TR_chkSub.jpg" alt="Failed to load image">&nbsp;&nbsp; <br><br><br>
		<b>Enter Reason</b><br/>
		3. Selected sub category displayed in box shown in below image,  <br/>
		if you want remove it just uncheck the checkbox. <br>After selecting required sub categiry,  
		enter valid reason for transfer And click on send button<br>
		<img border="10px" src="<%=request.getContextPath()%>/images/Assets_images/TR_reason.jpg" alt="Failed to load image">&nbsp;&nbsp; <br><br><br>
	
		</p>
	</div>
</form>
</body>
  <%}else{ %>
<%@include file="../cookieTracker/CookieTrackerBottom.jsp" %>
<%} %>
</HTML>
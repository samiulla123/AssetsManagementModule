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

<TITLE>Assets Transfer</TITLE>
<script type="text/javascript">
function display()
{
	var ss=document.Assets_transfer.main_cat.value;
	m=document.getElementsByName("mmmm");
	
	for(i=0;i<m.length;i++){
		document.getElementById("sub"+m[i].value).style.visibility="hidden";
	}
	document.getElementById("sub"+ss).style.visibility="visible";
	
}
		
		var str="";
function addSubCategory(sId)
{
	val=document.getElementById("catValue"+sId);
	sname=document.getElementById("sub_cat_name"+sId).value;
	rname=document.getElementById("ref_no"+sId).value;
	mStr=sname+" ( "+rname+" )";
	alert("mStr="+mStr);
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
	if(document.Assets_transfer.dep_name.value=="")
	{
		alert("Select Department Name ");
		return false;
	}
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
		alert("Enter Reason For Transfer ");
		return false;
	}
	
	document.Assets_transfer.action="../../AssetsServlet";
	document.Assets_transfer.submit();
}
</script>
<style>
.center {
  width: 50%;
  border: 2px solid black;
  padding: 10px;
  text-align: center;
    font-size: 150%;
    margin-top: 10%;
  background: linear-gradient(35deg, #ff99dd, #99b3ff, #ccffcc);
}
td, th{
	text-align: center;
}
</style>
</HEAD>
<%
	Assets_DBQueries db=new Assets_DBQueries();
	ArrayList ar=db.Asset_MT_Request();
	String msg=(String)session.getAttribute("error");
	session.removeAttribute("error");
	System.out.println("Assets Transfer dep "+ar);
	System.out.println("");
	int count=1;
	int sum=0;
 %>		
 <div class="container-fluid"  id=Layer5>
<body>
	<form name="management"  method="post" action="">
		<h5>Assets Transfer Request</h5>
		<%if(!ar.isEmpty()){ %>
		<table id="tbl" class="table" border=2 style="border-collapse: collapse; width:100%">
			<tr>
				<th>Sl.No</th>
				<th>Associate Name</th>
				<th>Department</th>
				<th>Last Rejected Comments</th>
			</tr>
			<%
				for(int i=0;i<ar.size();i++)
				{
					ArrayList arr=(ArrayList)ar.get(i);
					System.out.println("Name "+arr.get(17)+" Department "+arr.get(1));
			 %>
					<tr>
						<td>
							<%=count %>
						</td>
						<td>
							<a href="ManagementAppr_Form.jsp?req_id=<%=arr.get(0)%>"><%=arr.get(17) %></a>
						</td>
						<td>
							<%=arr.get(1) %>
						</td>
					<%System.out.println("Null pointer "+arr.get(13).toString().length());
					if(arr.get(12)!=null){ %>	
						<td>
							<font color="blue"><%=arr.get(12) %></font>
						</td>
					<%}else{%>
						<td>
							<font color="green">New Entry</font>
						</td>
					<%} %>
					</tr>
					
			  <%
			  	count=count+1;
			  	sum=sum+1;
			  } %>
		</table>
		<%}else { %>
		<%System.out.println("Sum of value "+sum);
	 if(sum==0){%><center><div id="rect" class="center"><b>No Request is Found &#128522;</b></div></center>
	 <%} %>
	 <%} %>
		<%if(msg!=null) {%></label><font color="red" size="3px"><%=msg %></font><%} %>
	</form>
</body> 
</div>
  <%}else{ %>
<%@include file="../cookieTracker/CookieTrackerBottom.jsp" %>
<%} %>
</HTML> 

</body>
</html>
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
	var cnt=0;
	function checkAddEmpty()
	{
	sum=0;
	amn=document.getElementsByName("amnt");
	for(i=0;i<amn.length;i++)
	{
		sum=sum+Number(amn[i].value);
	}
	if (document.frmAdminAssetsAdd.main_cat.value=="")
		{
			alert("Select valid main category");
			document.frmAdminAssetsSub.main_cat.focus();
			   return false;
		}
	if (document.frmAdminAssetsAdd.sub_cat.value=="")
		{
			alert("select valid sub category");
			document.frmAdminAssetsSub.sub_cat.focus();
			   return false;
		}
	/**/	
	if (document.frmAdminAssetsAdd.unit.value=="")
		{
			alert("select Unit");
			document.frmAdminAssetsSub.unit.focus();
			   return false;
		}
	if (document.frmAdminAssetsAdd.dep.value=="")
		{
			alert("select department");
			document.frmAdminAssetsSub.dep.focus();
			   return false;
		}
	if (document.frmAdminAssetsAdd.asso_name.value=="")
		{
			alert("select associate name");
			document.frmAdminAssetsSub.asso_name.focus();
			   return false;
		}
	/**/	
	if (document.frmAdminAssetsAdd.amount.value=="")
	{
		alert("Enter amount");
		document.frmAdminAssetsSub.amount.focus();
		   return false;
	}
	if (document.frmAdminAssetsAdd.amount.value!="")
	{
		if(sum!=document.frmAdminAssetsAdd.amount.value)
		{
			alert("Amount Not tally");
			document.frmAdminAssetsSub.amount.focus();
		   return false;
		}
	}
	if (document.frmAdminAssetsAdd.entry_date.value=="")
		{
			alert("Click on entry date to select valid date");
			document.frmAdminAssetsSub.entry_date.focus();
			   return false;
		}
	if (document.frmAdminAssetsAdd.desc.value=="")
	{
		alert("Enter Description");
		document.frmAdminAssetsSub.desc.focus();
		   return false;
	}
	if (document.frmAdminAssetsAdd.Bill_no.value=="")
	{
		alert("Enter bill number");
		document.frmAdminAssetsSub.Bill_no.focus();
		   return false;
	}
	if (document.frmAdminAssetsAdd.bill_date.value=="")
	{
		alert("Click on bill date to select valid date");
		document.frmAdminAssetsSub.bill_date.focus();
		   return false;
	}
	if (document.frmAdminAssetsAdd.supply_name.value=="")
	{
		alert("Enter name of supllier");
		document.frmAdminAssetsSub.supply_name.focus();
		   return false;
	}
	/**/
	if (document.frmAdminAssetsAdd.m_no.value=="")
	{
		alert("Enter Mobile Number");
		document.frmAdminAssetsSub.m_no.focus();
		   return false;
	}
	if (document.frmAdminAssetsAdd.warranty.value=="")
	{
		alert("Enter Warranty");
		document.frmAdminAssetsSub.warranty.focus();
		   return false;
	}
	/**/
	if (document.frmAdminAssetsAdd.Loc.value=="")
	{
		alert("Enter Location Of Asset");
		document.frmAdminAssetsSub.Loc.focus();
		   return false;
	}
	else{
	    document.frmAdminAssetsAdd.action="../../AssetsServlet";
	    document.frmAdminAssetsAdd.submit();
	 }
	
}	
	
	
	
		function display()
		{
			document.frmAdminAssetsAdd.action="";
			document.frmAdminAssetsAdd.submit();		
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
		function onkey(event)
		{
			alert("Samiulla Pathan "+event.keyCode);
			if(event.keyCode==39)
			{
				event.keycode=0;
				return false;  
			}
		}
		function dataValue(event)
		{
			if((event.keyCode > 47 && event.keyCode < 58)  || (event.keyCode > 7 && event.keyCode < 9))
			{
				var x=event.keyCode;
				cnt = String.fromCharCode(x);
				return true;
			}
			else
			{
				return false;
			}
		}
		function DataFetch(event)
		{
			if((event.keyCode > 47 && event.keyCode < 58)  || (event.keyCode > 7 && event.keyCode < 9))
			{
				event.keyCode=0;
				return true;
			}
			else
			{
				return false;
			}
		}
		function onCal()
		{
			sum=0;
			var amn=document.getElementsByName("amnt");
			if(isNaN(amn))
			{
				for(i=0;i<amn.length;i++)
				{
					sum=sum+Number(amn[i].value);
				}
				document.getElementById("amntoo").innerHTML=sum;
				document.getElementById("tamnt").value=sum;
			}
			else
			{
				alert("Enter Only Number");
				document.frmAdminAssetsSub.amnt.focus();
		   		return false;
			}
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
th {
  padding: 8px;
  text-align: left;
  border-bottom: 1px solid #ddd;
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

</style>
</HEAD>
<%
	String Edate=request.getParameter("entry_date");
	String mCat=request.getParameter("main_cat");
	String un=request.getParameter("unit");
	String dep=request.getParameter("dep");
	String assoc=request.getParameter("asso_name");
	System.out.println("Unit "+un+" department "+dep+" associcate "+assoc);
	
	long m_cat=0;
	try{
		 m_cat=Integer.parseInt(mCat);
	}
	catch (NumberFormatException e)
	{
		 m_cat=0;
	}
	String sCat=request.getParameter("sub_cat");
	System.out.println("Value="+mCat);
	ResultSet res1=null;
	String msg=(String)session.getAttribute("error"); 
 	session.removeAttribute("error");
 	String refNo=(String)session.getAttribute("ref_no"); 
 	session.removeAttribute("ref_no");
    Date dNow = new Date( );
    SimpleDateFormat ft = new SimpleDateFormat ("M-dd-yyyy");
   String dta=ft.format(dNow);     
   ArrayList mainCatArr=assetManager.selectMainCat();
   	ArrayList SubCatArr=assetManager.selectSubName(m_cat); 
   	
   	String main_name="";
   	String sub_name="";		
   
%>
  			
<body>
<form name="frmAdminAssetsAdd" method="post" action="">
<input type="hidden" name="ActionId" value="AddAssets">
<input type="hidden" name="Task" value="Add">
<input type="hidden" name="user_id" value="<%=email%>">
<input type="hidden" name="entry_date" value="<%=dta %>">
  <div class="container"  id=Layer5 style="width: 50%; float: left;"> 
    <table  class="table table-hover" width="98%" border=0 style="border-collapse: collapse; ">
   
    		<h5>Add Assets</h5>
   	<hr/>
    	<tr>
    		<td>
    			Main Category<FONT color="#FF0000">*</FONT>
    		</td>
    		<td>
    			<select name="main_cat"  data-live-search="true" data-live-search-style="startsWith" class="selectpicker" data-style="btn-default" data-size="10"  data-width="50%" data-height="10%" data-width="50%" data-height="10%" onchange="display()">
	         	<option value=""></option>
	          		<%
	          		Iterator itr=mainCatArr.iterator();
					while(itr.hasNext()){
					ArrayList arr=(ArrayList)itr.next();
					String cid=""+arr.get(0);
					main_name=""+arr.get(1);
					String csname=""+arr.get(2);
	       		 %>
				
				<option value="<%=cid%>" <%if(cid.equals(mCat)){ %> selected<%}%>><%=main_name %></option>
				<%} %>
          </select>
          </td>

    	</tr> 
    	<tr>
    		<td>
    			Sub Category <font color="#FF0000">*</font>
    		</td>
    		<td>
    			<select name="sub_cat" data-live-search="true" data-live-search-style="startsWith" class="selectpicker" data-style="btn-default" data-size="10" data-width="50%" data-height="10%" data-width="100%" data-height="10%" onchange="display()">
              <option value="">Select Sub Category</option> 
            		<%
			
							Iterator itr1=SubCatArr.iterator();		
							for(int i=0;i<SubCatArr.size();i++){
							ArrayList SubCatArr1=(ArrayList)SubCatArr.get(i);
							String catId=""+SubCatArr1.get(0);
							sub_name=""+SubCatArr1.get(2);
							String catShName=""+SubCatArr1.get(2);
					%> 
				<option value="<%=catId%>" <%if(catId.equals(sCat)){ %> selected<%}%>><%=sub_name %></option>
				<% }%>
            </select>
            </td>
    	</tr>
    	<tr>
    		<td>Unit</td>
    		<td>
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
    		</td>
    	</tr>
    	<tr>
    		<td>Department</td>
    		<td>
    		<% ArrayList Depart=assetManager.SelectDepartment(un);
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
    	<td>Associate Name</td>
    		<td>
    		<%ArrayList fac_name=assetManager.Asset_Tran_fac_info(dep);
						System.out.println("Name of Faculties "+fac_name); %>
    			<select name="asso_name" data-live-search="true" data-live-search-style="startsWith" class="selectpicker" data-style="btn-default" data-size="10" data-width="50%" data-height="10%" data-width="100%" data-height="10%" onchange="display()">
    				<option value="">Select Associate Name</option>
    				<%for(int f=0;f<fac_name.size();f++){ 
    					ArrayList FacDet=(ArrayList)fac_name.get(f);
    					String FacId=""+FacDet.get(0);
    					String FacName=""+FacDet.get(1);
    					String FacLname=""+FacDet.get(2);
    					String FullName=" "+FacName+" "+FacLname;
    				%>
    				<option value="<%=FacId%>" <%if(FacId.equals(assoc)){ %>selected<%} %>><%=FullName %></option>
    				<%} %>
    			</select>
    		</td>
    	</tr>
    	 <tr>	
    		<td>
    		   Quantity:</td><td><font color="#FF0000">*</font>&nbsp;<input type="text" name="quant" id="quant" class="form-control" style="background-color:#FFECEC ;" size="10" value=""  maxlength="25" style="border-style: solid; border-width: 1px" tabindex="1" onkeypress="return dataValue(event)"> <input type="submit" value="Display"><br/><br/>
    		</td>
    		</tr>
    			
    			<%	String quant=request.getParameter("quant");
				System.out.println("Quantity "+quant); 
				int qanuty=0;
				try{
				qanuty=Integer.parseInt(quant);
				}catch(NumberFormatException e)
				{
					System.out.println(e);
				}
				System.out.println("value "+qanuty);
				int count=1;
				for(int a=0;a<qanuty;a++){%>
				<tr>
				<td>Amount&nbsp;<%=count %> </td>
    		   	<td><input type="text" class="form-control" name="amnt" id="amnt" onblur="onCal()"></td>
    		   	</tr>
    		   	<%count=count+1;} %>
    		<tr>
    		<td>
    			Total Amount:</td><td> 
    			<label id="amntoo" style="size: 5%;">0</label>
    			<input type="hidden" name="amount" id="tamnt">&nbsp; <%-- <input type="text" name="amount" id="amntoo" class="form-control" style="background-color:#FFECEC ;" size="10" value=""  maxlength="25" style="border-style: solid; border-width: 1px" tabindex="1"  onkeypress="return (event.keyCode > 47 && event.keyCode < 58)  || (event.keyCode > 7 && event.keyCode < 9)">			 --%>
    		</td>
    	</tr>
    	
    	<tr>
    		<td> 
    		Description <font color="#FF0000">*</font>
    		</td>
    		<td>
    			<textarea rows="4" cols="20" name="desc" width="2px" class="form-control" style="background-color:#FFECEC ;" style="border-style: solid; border-width: 1px" tabindex="1" onkeypress="return (event.keyCode!=39)"></textarea>
    	
    		</td>
    	</tr>
    	<tr>
    		<td>
    			Bill No <font color="#FF0000">*</font>
    		</td>
    		<td>
    			 <input type="text" name="Bill_no" size="12" value="" class="form-control" style="background-color:#FFECEC ;"  maxlength="25" style="border-style: solid; border-width: 1px" tabindex="1"  onkeypress="return (event.keyCode!=39)">
    		</td>
    	</tr>
    	<tr>
    		<td>
    			Bill Date <font color="#FF0000">*</font>
    		</td>
    		<td>
    			<input type="text" name="bill_date" class="form-control" style="background-color:#FFECEC ;" onfocus="javascript:popUpCalendar(this,document.frmAdminAssetsAdd.bill_date,'dd-mmmm-yyyy');">
    		</td>
    	</tr>
    	<tr>
    		<td>
    			Supplier Name <font color="#FF0000">*</font>
    		</td>
    		<td>
    			<input type="text" name="supply_name" class="form-control" style="background-color:#FFECEC ;" size="30" value=""  maxlength="25" style="border-style: solid; border-width: 1px" tabindex="1" onkeypress="return (event.keyCode!=39)">
    		</td>
    	</tr>
    	<tr>
    		<td>
    			Supplier Number <font color="#FF0000">*</font>
    		</td>
    		<td>
    			<input type="text" name="m_no" class="form-control" style="background-color:#FFECEC ;" size="30" value=""  maxlength="10" style="border-style: solid; border-width: 1px" tabindex="1" onkeypress="return (event.keyCode > 47 && event.keyCode < 58)  || (event.keyCode > 7 && event.keyCode < 9)">
    		</td>
    	</tr>
    	<tr>
    		<td>
    			Warranty <font color="#FF0000">*</font>
    		</td>
    		<td>
    			<input type="text" name="warranty" class="form-control" style="background-color:#FFECEC ;" size="30" value="1"  maxlength="25" style="border-style: solid; border-width: 1px" tabindex="1" onkeypress="return (event.keyCode > 47 && event.keyCode < 58)  || (event.keyCode > 7 && event.keyCode < 9)"">
    		</td>
    	</tr>
		<tr>
    		<td>
    			Location <font color="#FF0000">*</font>
    		</td>
    		<td>
    			<input type="text" name="Loc" class="form-control" style="background-color:#FFECEC ;" size="30" value=""  maxlength="25" style="border-style: solid; border-width: 1px" tabindex="1" >
    		</td>
    	</tr>
    	<tr>
    		<td>
    			Bill Scan Copy <font color="#FF0000">*</font>
    		</td>
    		<td>
    			<input type="file" name="bill_img" accept=".pdf" class="form-control" style="background-color:#FFECEC ;" value="" style="border-style: solid; border-width: 1px" tabindex="1" >
    			<font color="green">Upload PDF format file for easy access</font>
    		</td>
    	</tr>
    	<tr>
    		<td>
    		<div align="center">
    			<input type="button" value="Create" class="btn" name="cmdSubmit" onclick="return checkAddEmpty()" tabindex="2">
    		</div>
    		</td>
    		<td>
    		<div align="center">
    			<input type="reset" value="Cancel" class="btn"
				name="cmdCancel" onclick="unLoad();" tabindex="3">
    		</div>
    		</td>
    	</tr>
    
 
	</table>
	<div align="left" style="font-size:15px"><FONT color="#FF0000" >*</FONT> Indicates Mandatory</div>
	<div align="left" style="font-size:15px">
		<font color="#FF0000"><%if(msg!=null){%>&nbsp;<%=msg%><%} %></font>	
	</div>
	<div align="left" style="font-size:15px">
		<font color="#FF0000"><%if(refNo!=null){%>&nbsp;<%=refNo%><%} %></font>	
	</div>
</div>
<div id="flt" class="container-fluid">
	<input id="btn"
		type="button" class="btn" value="User-Instructions" name="cmdSubmit" onclick="instruction()" tabindex="3">
		<p id="demo" style="visibility:hidden; font-style:bold; font-size:15px; ">
		@Main Category<br/>
		1. Select main category or you can also search main-category by typing name in search box<br/>
		<img border="10px" src="<%=request.getContextPath()%>/images/Assets_images/main_cat.jpg" alt="Failed to load image">&nbsp;&nbsp; <br/><br/><br/>
		
		@Sub Category<br/>
		2. Select sub category which you want to enter <br/>&nbsp;&nbsp;<br/>
		<img border="10px" src="<%=request.getContextPath()%>/images/Assets_images/sub_Cat.jpg" alt="Failed to load image">&nbsp;&nbsp; <br/><br/><br/>&nbsp;&nbsp; 
		
		@Description<br/>
		3. Provide detail description of purchase assets <br/> &nbsp;&nbsp; <br><br><br>
		@Bill No<br/>
		4. Enter the bill number present on the bill. <br/> &nbsp;&nbsp; <br><br><br>
		@Bill Date<br/>
		5. Select purchase date which is mentioned on the bill <br/> &nbsp;&nbsp; 
		<img border="10px" src="<%=request.getContextPath()%>/images/Assets_images/date.jpg" alt="Failed to load image"><br><br><br>
		@Supplier Name<br/>
		6. Provide name of supplier present on the bill. <br/> &nbsp;&nbsp; <br><br><br>
		@Receipt<br/>
		7.   Enter  quantity.
		   	 Enter amount mentioned on bill.   <br/> &nbsp;&nbsp; <br><br><br>
		</p>
	</div>

</form>

</BODY>
  <%}else{ %>
<%@include file="../cookieTracker/CookieTrackerBottom.jsp" %>
<%} %>
</HTML>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<HTML>
<HEAD>
<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ include file="../cookieTracker/CookieTrackerTop.jsp"%>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.1/css/bootstrap-select.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.1/js/bootstrap-select.js"></script>
<META http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<META name="GENERATOR" content="IBM WebSphere Studio">
<META http-equiv="Content-Style-Type" content="text/css">
<LINK href="../../stylesheet/RedLeft.css" rel="stylesheet"
	type="text/css">
<script src="../../javascript/ForAll.js" language="javascript">
</script>

<%@ page import="com.gen.cms.faculty.dao.FacultyManager,com.gen.cms.admin.dao.AdminManager,com.gen.cms.performance.dao.PerformanceManager"%>
<%@ page import="com.gen.cms.faculty.dao.FacultyDAO,com.gen.cms.admin.dao.DmsManager"%>

<TITLE>Admission Menu</TITLE>
<%
 	DmsManager dm=new DmsManager();
 	String progid=dm.getProgId(email);
    String staffId = email;	
     
	session.setAttribute("user","guest");
	ArrayList modules=(ArrayList)session.getAttribute("modules");	
	String userFname=""+session.getAttribute("userFname");
	String initials=""+session.getAttribute("initials");
	String url="../../gateWay.jsp?initials="+initials+"&userFname="+userFname+"&modules="+modules; 
%>
<script language="JavaScript">
<!--
function FP_preloadImgs() {//v1.0
 var d=document,a=arguments; if(!d.FP_imgs) d.FP_imgs=new Array();
 for(var i=0; i<a.length; i++) { d.FP_imgs[i]=new Image; d.FP_imgs[i].src=a[i]; }
} 
// -->
</script>
<base target="main">
<script type="text/javascript">
var img1, img2;
	img1 = new Image();
	img1.src = "../../images/closedfolder.gif";
	img2 = new Image();
	img2.src = "../../images/openfolder.gif";
	var targetElementPrevious ,srcElementPrevious, targetIdPrevious;
	function doOutline() {
	  var targetId, srcElement, targetElement;
	  srcElement = window.event.srcElement;
	  if (srcElement.className == "LEVEL1" || srcElement.className == "LEVEL3" ) 
	  {
	    srcElement = srcElement.id
	    srcElement = srcElement.substr(0, srcElement.length-1);
	    targetId = srcElement + "s";
	    srcElement = srcElement + "i";
	    srcElement = document.all(srcElement);
        targetElement = document.all(targetId);
	   if (targetElementPrevious) 
		{
	      if (targetElementPrevious != targetElement) 
		  {  
				if (targetElementPrevious.style.display == "" && srcElement.className != "LEVEL3") 
		 		 {  
			        targetElementPrevious.style.display = "none"; 
	        		srcElementPrevious.src = "../../images/down.gif";	
	      		 }
      	  }
	    }
	    if (targetElement) {
	      if (targetElement.style.display == "none") {
	        targetElement.style.display = "";   
	        srcElement.src = "../../images/up.gif";
			targetElementPrevious=targetElement;
			srcElementPrevious=srcElement;
	      } else {
	        targetElement.style.display = "none";  
	        srcElement.src = "../../images/down.gif";
	      }
		    }
		  }
		}
	document.onclick = doOutline;

function FP_swapImg() {//v1.0
 var doc=document,args=arguments,elm,n; doc.$imgSwaps=new Array(); for(n=2; n<args.length;
 n+=2) { elm=FP_getObjectByID(args[n]); if(elm) { doc.$imgSwaps[doc.$imgSwaps.length]=elm;
 elm.$src=elm.src; elm.src=args[n+1]; } }
}
function FP_getObjectByID(id,o) {//v1.0
 var c,el,els,f,m,n; if(!o)o=document; if(o.getElementById) el=o.getElementById(id);
 else if(o.layers) c=o.layers; else if(o.all) el=o.all[id]; if(el) return el;
 if(o.id==id || o.name==id) return o; if(o.childNodes) c=o.childNodes; if(c)
 for(n=0; n<c.length; n++) { el=FP_getObjectByID(id,c[n]); if(el) return el; }
 f=o.forms; if(f) for(n=0; n<f.length; n++) { els=f[n].elements;
 for(m=0; m<els.length; m++){ el=FP_getObjectByID(id,els[n]); if(el) return el; } }
 return null;
}


</script>
<script language=javascript>
function register(){
	document.f.submit();
}
</script>
</head>

<body style="BACKGROUND-IMAGE: " leftMargin="0" topMargin="0"
	onload="FP_preloadImgs(/*url*/'images/button1D.jpg', /*url*/'images/button3C1.jpg', /*url*/'images/button3D.jpg', /*url*/'images/button3F.jpg', /*url*/'images/button40.jpg', /*url*/'images/button42.jpg', /*url*/'images/button43.jpg', /*url*/'images/button45.jpg', /*url*/'images/button46.jpg', /*url*/'images/button48.jpg', /*url*/'images/button49.jpg', /*url*/'images/button4B.jpg', /*url*/'images/button4C.jpg', /*url*/'images/button4E.jpg', /*url*/'images/button4F.jpg', /*url*/'images/button51.jpg', /*url*/'images/button52.jpg', /*url*/'images/button54.jpg', /*url*/'images/button55.jpg', /*url*/'images/button57.jpg', /*url*/'images/button58.jpg', /*url*/'../../images/button8B.jpg', /*url*/'../../images/button82.jpg', /*url*/'../../images/button81.jpg', /*url*/'../../images/buttonC.jpg', /*url*/'Alumni1.jpg', /*url*/'Alumni2.jpg', /*url*/'place1.jpg', /*url*/'place2.jpg', /*url*/'lib1.jpg', /*url*/'lib2.jpg', /*url*/'carp1.jpg', /*url*/'carp2.jpg', /*url*/'../../images/images/button31.jpg', /*url*/'../../images/images/button32.jpg', /*url*/'../../images/button5C.gif', /*url*/'../../images/button5D.gif')">
<input type="hidden" name="staffId" value="<%=staffId%>">

<div class="container" id="Layer1"
	style="Z-INDEX: 1; LEFT: -5px; WIDTH: 329px; POSITION: absolute; TOP: 6px; HEIGHT: 89px">
<TABLE height="45" width="250" border="0">
	<TBODY>
		<%
	AdminManager admmgr=new AdminManager(); 
	FacultyManager fm=new FacultyManager();
	int batch=fm.getCurrBatchId();
	FacultyDAO fd=new FacultyDAO();
	ArrayList cotype=new ArrayList();
	session.setAttribute("email",email);
	String sql="select distinct(co_type) from dir_asn_co where admsn_fac_id='"+email+"'" 
				+" and co_status=1 and batch_mst_id="+batch+" and co_acpt_status=2";
	try{
	cotype=fd.select(sql);
	}catch(Exception e){
	e.printStackTrace();
	}
	String sql1="select kra_id from pa_key_result_area where user_id='"+email+"' and batch_id="+batch;
	String kraId="";
	try{
	kraId=fd.selectText(sql1);
	}catch(Exception e){
	e.printStackTrace();
	}
	String sql2="select apr_status from pa_key_result_area where kra_id="+kraId;
	String aprStat="";
	try{
	aprStat=fd.selectText(sql2);
	}catch(Exception e){
	e.printStackTrace();
	}
	%>
		<%
		Iterator ritr=cotype.iterator();
     	while(ritr.hasNext()){
      		 ArrayList tArr=(ArrayList)ritr.next();
      		 Iterator citr=tArr.iterator();
      		 if(citr.hasNext()){
      		 	String ctype=""+citr.next();
      		 	System.out.println("hhhh "+ctype);
      		 	if(ctype.equals("1")){
		%>

		<%}if(ctype.equals("3")){%>
		<tr>
			<td nowrap="" style="width: 240px">&nbsp;<input type="hidden" value="staff" name="desig"> <img
				src="../../images/left.gif" width="12" height="12" /> <!--<a href="../../CmsController?moduleIndicator=FACULTY&task=VIEW&beanIndicator=COORDINATORVIEW&COTYPE=3&FACID=<%//=email%>" target="indexCenter" onclick="change(this)">-->
			<a href="../../CmsController?moduleIndicator=FACULTY&task=VIEW&beanIndicator=GOTOVIEW&COTYPE=3&desig=staff"
				target="_parent" onclick="change(this)"> Coordinator View </a></td>
		</tr>
				<% }
			}
		}%>
	
	 	<tr>
			<TD nowrap height="0">&nbsp; <IMG border="0"
				src="../../images/left.gif" width="12" height="12">&nbsp;
			<A href="Asset_UnitWise_Report.jsp" target="indexCenter"
				onclick="change(this)">Asset Unit Report</A></TD>
		</tr>
		<tr>
			<TD nowrap height="0">&nbsp; <IMG border="0"
				src="../../images/left.gif" width="12" height="12">&nbsp;
			<A href="Assets_HOD_Assign_new_Associate.jsp" target="indexCenter"
				onclick="change(this)">Assign To New Associate</A></TD>
		</tr>
		<tr>
			<TD nowrap height="0">&nbsp; <IMG border="0"
				src="../../images/left.gif" width="12" height="12">&nbsp;
			<A href="Assets_Department_reference_number.jsp" target="indexCenter"
				onclick="change(this)">List Of Reference Number</A></TD>
		</tr>
		
<!-- 		<TR>
			<TD nowrap height="0">&nbsp; <IMG border="0"
				src="../../images/left.gif" width="12" height="12">&nbsp; <A
				href="MasterCreation.jsp" target="indexCenter" onclick="change(this)">View Master Creation of Assets</A></TD>

			<A href="MasterCreation.jsp" target="indexCenter"
				onclick="change(this)">Main Category Creation</A></TD>

		</TR>
		<tr>
			<TD nowrap height="0">&nbsp; <IMG border="0"
				src="../../images/left.gif" width="12" height="12">&nbsp; <A
				href="MasterCreation.jsp" target="indexCenter" onclick="change(this)">View Master Creation of Assets</A></TD>

			<A href="Assets_Sub_Category.jsp" target="indexCenter"
				onclick="change(this)">Sub-Category Creation</A></TD>
		</tr>
		
		<tr>
			<TD nowrap height="0">&nbsp; <IMG border="0"
				src="../../images/left.gif" width="12" height="12">&nbsp;
			<A href="AddAssets.jsp" target="indexCenter"
				onclick="change(this)">Register New Assets</A></TD>
		</tr>
		<tr>
			<TD nowrap height="0">&nbsp; <IMG border="0"
				src="../../images/left.gif" width="12" height="12">&nbsp;
			<A href="AssetsHodHoiApprovals.jsp" target="indexCenter"
				onclick="change(this)">Register Assets Request</A></TD>
		</tr>

		<tr>
			<TD nowrap height="0">&nbsp; <IMG border="0"
				src="../../images/left.gif" width="12" height="12">&nbsp;
			<A href="Assets_Rejected_Status_Report.jsp" target="indexCenter"
				onclick="change(this)">Register Assets Status</A></TD>
		</tr>

		<tr>
			<TD nowrap height="0">&nbsp; <IMG border="0"
				src="../../images/left.gif" width="12" height="12">&nbsp;
			<A href="Assets_Scrap_Sale.jsp" target="indexCenter"
				onclick="change(this)">Assets Scrap/Sale Form</A></TD>
		</tr>

		<tr>
			<TD nowrap height="0">&nbsp; <IMG border="0"
				src="../../images/left.gif" width="12" height="12">&nbsp;
			<A href="Assets_HOD_Sale_Scrap.jsp" target="indexCenter"
				onclick="change(this)">Assets Sale/Scrap Request</A></TD>
		</tr>
		
		<tr>
			<TD nowrap height="0">&nbsp; <IMG border="0"
				src="../../images/left.gif" width="12" height="12">&nbsp;
			<A href="Assets_Sale_Srap_reject_status.jsp" target="indexCenter"
				onclick="change(this)">Assets Sale/Scrap Status</A></TD>
		</tr>

		<tr>
			<TD nowrap height="0">&nbsp; <IMG border="0"
				src="../../images/left.gif" width="12" height="12">&nbsp;
			<A href="Assets_transfer_Form.jsp" target="indexCenter"
				onclick="change(this)">Assets Transfer</A></TD>
		</tr>
	
		<tr>
			<td nowrap height="0" >&nbsp;
				<IMG border="0"
				src="../../images/left.gif" width="12" height="12">&nbsp;
				<a href="Assets_Transfer_Appr.jsp" target="indexCenter"
				onclick="change(this)">Assets Transfer Requests</a>
			</td>
		</tr>
		<tr>
			<td nowrap height="0" >&nbsp;
				<IMG border="0"
				src="../../images/left.gif" width="12" height="12">&nbsp;
				<a href=Assets_transfer_Hod_appr.jsp target="indexCenter"
				onclick="change(this)">Assets Transfer Requests(TR Dep)</a>
			</td>
		</tr>
		<tr>
			<td nowrap height="0" >&nbsp;
				<IMG border="0"
				src="../../images/left.gif" width="12" height="12">&nbsp;
				<a href=Assets_Transfer_Status_HOD.jsp target="indexCenter"
				onclick="change(this)">Assets Transfer Status</a>
			</td>
		</tr>
		<tr>
			<td nowrap height="0" >&nbsp;
				<IMG border="0"
				src="../../images/left.gif" width="12" height="12">&nbsp;
				<a href=ManagementAppr.jsp target="indexCenter"
				onclick="change(this)">MT Transfer Request</a>
			</td>
		</tr>
		<tr>
			<td nowrap height="0" >&nbsp;
				<IMG border="0"
				src="../../images/left.gif" width="12" height="12">&nbsp;
				<a href=MT_sale_Scrap.jsp target="indexCenter"
				onclick="change(this)">MT Sale/Scrap Request</a>
			</td>
		</tr>
		<tr>
			<td nowrap height="0" >&nbsp;
				<IMG border="0"
				src="../../images/left.gif" width="12" height="12">&nbsp;
				<a href=Assets_report_generation.jsp target="indexCenter"
				onclick="change(this)">Assets Report</a>
			</td>
		</tr>
		<tr>
			<td nowrap height="0" >&nbsp;
				<IMG border="0"
				src="../../images/left.gif" width="12" height="12">&nbsp;
				<a href=Asset_Transfer_Report.jsp target="indexCenter"
				onclick="change(this)">Transfer Report</a>
			</td>
		</tr>
		<tr>
			<td nowrap height="0" >&nbsp;
				<IMG border="0"
				src="../../images/left.gif" width="12" height="12">&nbsp;
				<a href=Asset_Sale_Scrap_Report.jsp target="indexCenter"
				onclick="change(this)">Sale/Scrap Report</a>
			</td>
		</tr>-->
		<tr>
			<td nowrap height="0" >&nbsp;
				<IMG border="0"
				src="../../images/left.gif" width="12" height="12">&nbsp;
				<a href=Search.jsp target="indexCenter"
				onclick="change(this)">Search Assets</a>
			</td>
		</tr> 
		<tr>
			<td nowrap height="0" >&nbsp;
				<IMG border="0"
				src="../../images/left.gif" width="12" height="12">&nbsp;
				<a href=ManagementRequAssets.jsp target="indexCenter"
				onclick="change(this)">Assets Summary Report</a>
			</td>
		</tr>
		<%-- <tr>
			<td nowrap="" width="236">&nbsp; <img id="OUT11i"
				src="../../images/down.gif" width="12" height="12" class="LEVEL1"
				style="cursor: hand" /> <a class="LEVEL1" style="cursor: hand"
				id="OUT11t" onclick="change(this)">&nbsp;Meeting Activities</a>
			<div id="OUT11s" style="display: None">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img height="12" src="../../images/flat.gif" width="12">
			<a target="indexCenter" onclick="change(this)" href="../meeting/MeetingMaster.jsp">&nbsp;Create Agenda </a><br>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <img
				src="../../images/flat.gif" width="12" height="12" />&nbsp; <a
				class="LEVEL2" id="OUT4t" href="../faculty/Notifications.jsp"
				target="indexCenter" onclick="change(this)"> View Meetings </a><br>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <img height="12"
				src="../../images/flat.gif" width="12" />&nbsp;  <a class="LEVEL2"
				id="OUT20t" href="../meeting/meetingMinutesForConUpdate.jsp" target="indexCenter"
				onclick="change(this)"> Sending Follow-up Tasks</a><br />	
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <img height="12"
				src="../../images/flat.gif" width="12" />&nbsp;  <a class="LEVEL2"
				id="OUT20t" href="../meeting/meetingTask.jsp" target="indexCenter"
				onclick="change(this)"> Follow-up Tasks</a><br />
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <img height="12"
				src="../../images/flat.gif" width="12" />&nbsp;  <a class="LEVEL2"
				id="OUT20t" href="../meeting/meetingMinutesForCon.jsp" target="indexCenter"
				onclick="change(this)"> Meeting Minutes</a><br />
			<!-- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <img height="12"
				src="../../images/flat.gif" width="12" />&nbsp;  <a class="LEVEL2"
				id="OUT20t" href="../mto/WKT1.jsp" target="indexCenter"
				onclick="change(this)"> WKT Master</a><br />
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <img height="12"
				src="../../images/flat.gif" width="12" />&nbsp;  <a class="LEVEL2"
				id="OUT20t" href="../mto/WKt2.jsp?staffId=<%=email%>" target="indexCenter"
				onclick="change(this)"> WKT Task Master</a><br />
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <img height="12"
				src="../../images/flat.gif" width="12" />&nbsp;  <a class="LEVEL2"
				id="OUT20t" href="../mto/WKT3.jsp?staffId=<%=email%>" target="indexCenter"
				onclick="change(this)"> Pending WKT Tasks</a><br />
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <img height="12"
				src="../../images/flat.gif" width="12" />&nbsp;  <a class="LEVEL2"
				id="OUT20t" href="../mto/WKTReport.jsp?staffId=<%=email%>" target="indexCenter"
				onclick="change(this)"> WKT-Report</a><br />-->				
			<!-- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <img height="12"
				src="../../images/flat.gif" width="12" />&nbsp;  <a class="LEVEL2"
				id="OUT20t" href="../faculty/agenda.jsp" target="indexCenter"
				onclick="change(this)"> Meeting Minutes</a><br /> -->	
		    <!-- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <img height="12"
				src="../../images/flat.gif" width="12" />&nbsp;  <a class="LEVEL2"
				id="OUT20t" href="../meeting/InstantMeetingMaster.jsp" target="indexCenter"
				onclick="change(this)"> Instant Meeting</a><br /> -->		
					
			</div>
			</td>
		</tr> --%>
	</TBODY>
</TABLE>
</div>
</BODY>
<%} else {%>
<%@ include file="../cookieTracker/CookieTrackerBottom.jsp"%>
<%}
%>
</HTML>
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

<style>
#hvr:hover{
	background: linear-gradient(35deg,
      #ccffff,
      #ffcccc);
	color: black;
}
#btn:hover{
	color: #FFC0CB;
}
.center {
    margin: auto;
  width: 50%;
  border: 3px solid green;
  padding: 10px;
  text-align: center;
    font-size: 150%;
}
.center1 {
    margin: auto;
  width: 50%;
  padding: 10px;
  text-align: center;
}
.center2 {
  width: 20%;
   border: 1px solid;
  padding: 5px;
  font-size: 100%;
  text-align: center;
}
  #rect {
    animation-name: rainbow;
    animation-duration: 3s;
  }

  @keyframes rainbow {
    0%{
      background-color:  #ffffff;
      color:  #ffe6ff
    }
    15%{
        background-color: #ffe6e9B;
        color: #ff4dff; 
    }
    25%{
    	background-color: #ffccd4;
    	color: #e600e6;
    }
    40%{
        background-color: #FFC0CB;
        color:  #b300b3;
    }
    50%{
    	background-color: #FFB6C1;
    	color: #800080;
    }
     60%{
        background-color: #FFC0CB;
        color: #660066;
    }
     75%{
    	background-color: #ffccd4;
    	color: #4d004d
    }
    90%{
        background-color: #ffe6e9B;
        color: #1a001a;
    }
    100%{
      background-color:  #ffffff;
      color: #000000
    }
  }
  
</style>
</HEAD>
	<body>
	<form action="" method="post">
		<br>
		<br>
		<div class="center2">
		<p class="bg-info">Transfer</p>
		<p class="bg-warning">SaleScrap</p>
		</div>
		<div class="center1">
		<div class="container">
			<div class="form-group">
				<div class="col-sm-5">
					<div class="input-group">
						<input id="hvr" type="text" name="search" class="form-control" placeholder="Type name here " autocomplete="on" >
						<div class="input-group-btn">
							<button type="submit" id="btn" value="Search" class="btn btn-primary"><span class="glyphicon glyphicon-search">Search</span></button>
						</div>
					</div>
				</div>
			</div>
		</div>
		</div>
		
		<%/* AssetsDAO ad=new AssetsDAO(); */
			System.out.println("Data In JSP");
			int count=1;
			Assets_DBQueries db=new Assets_DBQueries();
			String nl="null";
			String data=(String)request.getParameter("search");
			System.out.println("Data List "+data);
			try
			{
				if("null"!=data)
				{
					ArrayList res=db.Seearch(data);
					System.out.println("List od data found is "+res);
					if(!res.isEmpty())
					{
				%>
						<table class="table table-border table-striped">
							<tr>
							<th>Sl.No</th>
							<th>Entry Date</th>
							<th>Description</th>
							<th>Bill No</th>
							<th>Bill Date</th>
							<th>Supplier Name/TRSF From Dep</th>
							<th>Department</th>
							<th>Reference Number</th>
							<th>Created By</th>
							</tr>
							<%
							for(int i=0;i<res.size();i++)
							{ArrayList ar=(ArrayList)res.get(i);
								String color="";
								if(ar.get(18).equals("1"))
								{
									color="Default";
								}
								else if(ar.get(18).equals("3"))
								{
									color="bg-info";
								}
								else if(ar.get(18).equals("5"))
								{
									color="bg-warning";
								}
								%>		
								<tr class="<%=color%>">
								<td><%=count %></td>
								<td><%=ar.get(3) %></td>
								<td><%=ar.get(4) %></td>
								<td><%=ar.get(5) %></td>
								<td><%=ar.get(6) %></td>
								<td><%=ar.get(7) %></td>
								<td><%=ar.get(13) %></td>
								<td><%=ar.get(11) %></td>
								<%String arr=db.FullNameAssoc(ar.get(15).toString()); 
								System.out.println("Full name found "+arr);%>
								<td><%=arr %></td>
								</tr>
								<%count=count+1;}%>					
		 				</table>
		 				
		 				
		 		    <%} 
			 		   else if(res.isEmpty())
			 		   {%>
			 		   		<div id="rect" class="center"><p>No Data Found &#128528;</p></div>
			 		   <%}
		 		   }%> 
		 	  	<%} 
		 	   catch(NullPointerException e)
		 	   {
		 	   		System.out.println("Null pointer Exception "+e);
		 	   }%>
	</form>
	</body>
  <%}else{ %>
<%@include file="../cookieTracker/CookieTrackerBottom.jsp" %>
<%} %>
</HTML>
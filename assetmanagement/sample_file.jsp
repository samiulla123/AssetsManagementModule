<!DOCTYPE html>
<html lang="en">
<head>
  <title>Excell Enterprice</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
   <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
  <script>
  	function Display(num)
  	{
  		if(document.getElementById("hid"+num).style.display=="none")
  		{
  			document.getElementById("hid"+num).style.display="inline";
  		}
		else if(document.getElementById("hid"+num).style.display=="inline")
  		{
  			document.getElementById("hid"+num).style.display="none";
  		}
  	}
  </script>
  <style>
    /* Remove the navbar's default rounded borders and increase the bottom margin */ 
    .navbar {
      margin-bottom: 1px;
      border-radius: 0;
    }
    
    /* Remove the jumbotron's default bottom margin */ 
     .jum {
      margin-bottom: 1;
	  background-color: #e6f3ff;
	  height: 10%;
    }
   
    /* Add a gray background color and some padding to the footer */
    footer {
      background-color: #e6f3ff;
      padding: 25px;
    }
	.bgclr
	{
		 background-color: #e6f3ff;
		 color: black;
	}
	
	label
	{
		color: black;
	}
	label:hover
	{
		color: #4d94ff;
	}
	.clr{
		background-color: #e6f3ff;
		margin-bottom:1;
	}
	 
	/* Make the image fully responsive */
  .slider
  {
	height: 10%;
	width: 100%;
	margin-top: 2px;
  }
  
  .item{
	height: 25%;
  }
  .carousel-inner > .item {
   height: 400px;
}
  .margin{
	margin-bottom: 1;
  }
  .head{
	font-family:sans-serif;
	color:#4d94ff;
	font-weight: bold;
  }
  </style>
</head>
<body>
<header>

<div class="container-fluid jum">
  <div class="container text-center">
    <h1>Excell Enterprise</h1>      
    <blockquote class="blockquote">Mission, Vission & Values</blockquote>
  </div>
</div>

<div class="container-fluid">
  <div class="navbar">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
	    <!--<a class="navbar-brand" href="#"><img src="logo.jpg" alt="Image Not Found" height="30" width="30"/></a>-->
    </div>
    <div class="collapse navbar-collapse bgclr" id="myNavbar" style="border-bottom: 2px solid back; ">
      <ul class="nav navbar-nav">
        <li><a href="#"><label>Home</label></a></li>
        <li><a href="#"><label>Products</label></a></li>
        <li><a href="#"><label>Deals</label></a></li>
        <li><a href="#"><label>Stores</label></a></li>
        <li><a href="#"><label>Contact</label> </a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <li><a href="#"><label><span class="glyphicon glyphicon-user"></span> Your Account</label></a></li>
        <li><a href="#"><label><span class="glyphicon glyphicon-shopping-cart"></span> Cart</label></a></li>
      </ul>
    </div>
  </div>
</div>


<!-- Sliding Image -->
<div class="container-fluid" style="background-color:#e6f3ff; margin: 2;">
  <h4>Our Products</h4>
  <div id="myCarousel" class="carousel slide" data-ride="carousel">
    <!-- Indicators -->
    <ol class="carousel-indicators">
      <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
      <li data-target="#myCarousel" data-slide-to="1"></li>
      <li data-target="#myCarousel" data-slide-to="2"></li>
    </ol>

    <!-- Wrapper for slides -->
    <div class="carousel-inner">

      <div class="item active">
        <img src="water\water1.jpg" alt="Los Angeles" style="width:100%; height:100%;">
        <div class="carousel-caption">
          <h3>Los Angeles</h3>
          <p>LA is always so much fun!</p>
        </div>
      </div>

      <div class="item">
        <img src="water\water1.jpg"  alt="Chicago" style="width:100%; height:100%;">
        <div class="carousel-caption">
          <h3>Chicago</h3>
          <p>Thank you, Chicago!</p>
        </div>
      </div>
    
      <div class="item">
        <img src="water\water1.jpg"  alt="New York" style="width:100%; height:100%;">
        <div class="carousel-caption" >
          <h3>New York</h3>
          <p>We love the Big Apple!</p>
        </div>
      </div>
  
    </div>

    <!-- Left and right controls -->
    <a class="left carousel-control" href="#myCarousel" data-slide="prev">
      <span class="glyphicon glyphicon-chevron-left"></span>
      <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#myCarousel" data-slide="next">
      <span class="glyphicon glyphicon-chevron-right"></span>
      <span class="sr-only">Next</span>
    </a>
  </div>
</div>
<div class="container-fluid clr" style="margin-top: 5px;">
	<center><h2 class="head">NEXT-GEN RO PURIFIERS</h2>
  <h3 style="font-family: sans-serif; font-weight: bold; color: black;">To Protect Your Family</h3>
<p style="font-family: sans-serif; font-weight: bold;">
The world's best RO purifiers that make your water 100% pure by removing even dissolved
impurities, as well as bacteria & viruses, now offer unmatched benefits. These Next-Gen RO purifiers
maintain essential natural minerals in water and display minerals & purity on the digital screen.
So go ahead and change your water purifier now.

It's Time to Change...Your RO Purifier.</h3></p></center>  
</div>


<footer class="container-fluid text-center" style="margin-top: 5px;">
  <p>Online Store Copyright</p>  
  <form class="form-inline">Get deals:
    <input type="email" class="form-control" size="50" placeholder="Email Address">
    <button type="button" class="btn btn-danger">Sign Up</button>
  </form>
</footer>

</body>
</html>

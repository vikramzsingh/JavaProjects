<%@page import="com.vikram.helper.ConnectionProvider"%>
<%--  <%@page import="java.sql.Connection"%> --%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Home</title>

<!-- css and bootstrap -->
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/themes/css/bootstrap.css" />
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/themes/css/mystyle.css" />

<!-- font-Awesome -->
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/font-awesome-master/css/font-awesome.css" />

<!-- javascript  -->
<script type="text/javascript"
	src="<%=request.getContextPath()%>/themes/js/myjs.js"></script>

<!-- jquery -->
<script type="text/javascript"
	src="<%=request.getContextPath()%>/themes/jquery/jquery.js"></script>

<script>
	$(document).ready(function(e) {
		$("#b1").click(function(e) {
			$("#item").slideToggle("linear");
		});
	});
</script>

</head>
<body>
	<!-- navbar -->
	<%@include file="normal_navbar.jsp"%>

	<!-- //banner -->
	<div class="jumbotron primary-background banner-background text-white">
		<div class="container">
			<h1 class="display-3">Welcome to My Site</h1>
			<p>
				A programming language is a formal language comprising a set of instructions that produce various kinds of output. Programming languages are used in computer programming to implement algorithms. 
			</p>
			<p>
				A programming language is a type of written language that tells computers what to do in order to work.A programming language is a formal language comprising a set of instructions that produce various kinds of output. Programming languages are used in computer programming to implement algorithms.
			</p>
			
			<button class="btn btn-outline-light btn-lg"><span class="fa fa-user-plus"></span>Start it free!</button>
			<a href="login_page.jsp" class="btn btn-outline-light btn-lg"><span class="fa fa-user-circle fa-spin"></span>Login</a>
			
		</div>
	</div>
	
	<!-- //cards  -->
	<div class="container">
		
		<div class="row mb-2">
			
			<div class="col col-md-4">
				<div class="card" >
            		<div class="card-body">
                		<h5 class="card-title">java Programming</h5>
                		<p class="card-text">This is card text</p>
                		<a href="#" class="btn primary-background text-white">Read more</a>
            		</div>
        		</div>
			</div>
			<div class="col col-md-4">
				<div class="card" >
            		<div class="card-body">
                		<h5 class="card-title">java Programming</h5>
                		<p class="card-text">This is card text</p>
                		<a href="#" class="btn primary-background text-white">Read more</a>
            		</div>
        		</div>
			</div>
			<div class="col col-md-4">
				<div class="card" >
            		<div class="card-body">
                		<h5 class="card-title">java Programming</h5>
                		<p class="card-text">This is card text</p>
                		<a href="#" class="btn primary-background text-white">Read more</a>
            		</div>
        		</div>
			</div>
			
		</div>
		
		<!-- Second row -->
		<div class="row">
			
			<div class="col col-md-4">
				<div class="card" >
            		<div class="card-body">
                		<h5 class="card-title">java Programming</h5>
                		<p class="card-text">This is card text</p>
                		<a href="#" class="btn primary-background text-white">Read more</a>
            		</div>
        		</div>
			</div>
			<div class="col col-md-4">
				<div class="card" >
            		<div class="card-body">
                		<h5 class="card-title">java Programming</h5>
                		<p class="card-text">This is card text</p>
                		<a href="#" class="btn primary-background text-white">Read more</a>
            		</div>
        		</div>
			</div>
			<div class="col col-md-4">
				<div class="card" >
            		<div class="card-body">
                		<h5 class="card-title">java Programming</h5>
                		<p class="card-text">This is card text</p>
                		<a href="#" class="btn primary-background text-white">Read more</a>
            		</div>
        		</div>
			</div>
			
		</div>
		
				
	</div>

	<div class="container-fluid"></div>

	<h1>Hello world</h1>

	<%-- calling Connection 
	<%
		Connection con = ConnectionProvider.getConnection();
	%>
	<h1><%=con%></h1>
	--%>

</body>
</html>
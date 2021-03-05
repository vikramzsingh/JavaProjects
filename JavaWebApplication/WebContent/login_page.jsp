<%@page import="com.vikram.entities.Message"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login page</title>

<!-- css and botstrap -->
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
	<%@include file="normal_navbar.jsp" %>
	
	<main class="d-flex align-items-center primary-background" style="height: 70vh;">
		
		<div class="container">
		
			<div class="row">
				<div class="col col-md-4 offset-md-4">
					
					<div class="card">
						
						<div class="card-header primary-background text-white text-center">
							<span class="fa fa-user-plus fa-3x"></span>
							<p>Login here</p>
						</div>
						
						<%-- For showing message if login is incorrect --%>
						<%
							Message m=(Message)session.getAttribute("msg"); //session is built-in oject by jsp
							if(m!=null) // msg object mai kuch hai
							{
						%>
								
						<div class="alert <%= m.getCssClass() %> text-center" role="alert">
  							<%= m.getContent() %>
						</div>
						
						<% 
								session.removeAttribute("msg");
							}
						%>
						
						<div class="card-body">
							<form action="Login" method="post">
								<div class="form-group">
									<label for="Email">Email</label>
									<input class="form-control" type="text" name="email" required="required" placeholder="Enter your email"/>
								</div>
								
								<div class="form-group">
									<label for="Password">Password</label>
									<input class="form-control" type="text" name="password" required="required" placeholder="Enter your password"/>
								</div>
								
								<div class="container text-center">
									<input type="submit" class="btn btn-primary" value="Login"/>
								</div>
								
							</form>
						</div>
						
					</div>
					
				</div>
			</div>
			
		</div>
		
	</main>

</body>
</html>
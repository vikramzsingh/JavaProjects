<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!-- declared as isErrorPage, in order to handel error raised in other pages -->
<%@page isErrorPage="true" %> 

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Sorry ! something went wrong...</title>

<!-- css and botstrap -->
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/themes/css/bootstrap.css" />
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/themes/css/mystyle.css" />

<!-- font-Awesome -->
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/font-awesome-master/css/font-awesome.css" />

</head>
<body>
	<div class="container text-center">
		<img src="images/error.png" class="img-fluid"/>
		<h3 class="display-3">Sorry ! something went wrong... </h3>
		
		<%-- to show exception --%> 
		<%= exception %>
		<br>
		
		<a class="btn btn-lg primary-background text-white mt-3" href="index.jsp">Home</a>
	</div>
</body>
</html>
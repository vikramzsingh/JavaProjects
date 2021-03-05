<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>404 error</title>

<!-- bootstrap -->
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/themes/css/bootstrap.css" />

</head>
<body>
    <div class="container text-center">
        <img class="img-fluid" src="images/404-error.jpg"/>
        <h1 class="display-3">Sorry ! something went wrong</h1>
        <a class="btn btn-primary btn-lg mt-2" href="index.jsp">Go To Home</a>
    </div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Register page</title>

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
	src="<%=request.getContextPath()%>/themes/jquery/jquery-3.5.1.js"></script>

<!-- sweetalert -->	
<script type="text/javascript"
	src="<%=request.getContextPath()%>/sweetalert/sweetalert.min.js"></script>

<script>
//nab-bar button
	$(document).ready(function(e) {
		$("#b1").click(function(e) {
			$("#item").slideToggle("linear");
		});
		
		//Ajax message
		console.log("loaded.......");
		$("#reg_form").on('submit',function(event){ 
			event.preventDefault();
			
			//here we create variable with let (Variable)
			let form=new FormData(this);// the data of the reg_form will store in this form variable
			
			// before sending data hide submit button
			$("#submit-btn").hide();
			$("#loader").show();
			
			// send register servlet
			$.ajax({
				url: "RegisterServlet", // its Servlet name
				type: "POST",
				data: form,
				success: function(data, textStatus, jqXHR){
					console.log(data)
					$("#submit-btn").show();
					$("#loader").hide();
					
					if(data.trim()==="done") //trim means remove space etc
						{
							// sweetalert message on success
							swal("Registered successfully..We are going redirecting to login page")
							.then((value) => {
							  window.location="login_page.jsp"
							});
						}
					else
						{
							swal(data);
						}
				},
				error: function(jqXHR, textStatus, errorThrown){
					$("#submit-btn").show();
					$("#loader").hide();
					
					swal("Somthing went worng..try again")
				},
				processData: false,
				contentType: false,
			});
		});
		
	});
</script>


</head>
<body>
	
	<!-- navbar -->
	<%@include file="normal_navbar.jsp" %>
	
	<main class="primary-background  p-5">
		
		<div class="container">
		
			<div class="col col-md-6 offset-md-3">
			
				<div class="card">
					
					<div class="card-header text-center primary-background text-white">
						<span class="fa fa-user-circle fa-3x"></span>
						<br>
						Register here
					</div>
					<div class="card-body">
						
						<form id="reg_form" action="Register" method="post">
							<div class="form-group">
								<label for="user_name">User Name</label>
								<input class="form-control" type="text" name="user_name" placeholder="Enter your name"/>
							</div>
						
							<div class="form-group">
								<label for="Email">Email</label>
								<input class="form-control" type="text" name="user_email" placeholder="Enter your email"/>
							</div>
								
							<div class="form-group">
								<label for="Password">Password</label>
								<input class="form-control" type="text" name="user_password" placeholder="Enter your password"/>
							</div>
							
							<div class="form-group">
								<label for="gender">Select Gender</label>
								<br>
								<input type="radio" id="gender" name="gender" value="Male"/>Male
								<input type="radio" id="gender" name="gender" value="Female"/>Female
							</div>
							
							<div class="form-group">
								<textarea class="form-control" rows="5" name="about" placeholder="Enter something about you"></textarea>
							</div>
							
							<div class="form-check">
								<input class="form-check-input" type="checkbox" name="check"/>
								<label for="exampleCheck1">agree terms and conditions</label>
							</div>
								<br>
								<div class="container text-center" id="loader" style="display: none;">
									<span class="fa fa-refresh fa-spin fa-4x"></span>
									<h4>Please wait..</h4>
								</div>
								<input id="submit-btn" type="submit" class="btn btn-primary" value="Sign up"/>
						</form>
						
					</div>
						
				</div>
				
				
			</div>
		
		</div>
		
	</main>
	
</body>
</html>
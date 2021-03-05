
<%-- scriptlet tag --%>
<%@page import="com.vikram.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.vikram.helper.ConnectionProvider"%>
<%@page import="com.vikram.dao.PostDao"%>
<%@page import="com.vikram.entities.Message"%>
<%@page import="com.vikram.entities.User"%>
<%@page errorPage="error_page.jsp" %>

<%
// session OBJECT u is of User TYPE, so type-cast session into User Type 
	User user = (User)session.getAttribute("currentUser");
	if(user==null)
	{
		response.sendRedirect("login_page.jsp");
	}
%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Profile page</title>

<!-- css and botstrap -->
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/themes/css/bootstrap.css" />
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/themes/css/mystyle.css" />
	
	<style>
		
		/* by tag <body> */
		body{
			background: url("images/blog-pg-Background.gif");
			background-size: cover;
			background-attachment: fixed;
		}
		
	</style>

<!-- font-Awesome -->
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/font-awesome-master/css/font-awesome.css" />

<!-- javascript  -->
<script type="text/javascript"
	src="<%=request.getContextPath()%>/themes/js/myjs.js"></script>
	
<!-- jquery -->
<script type="text/javascript"
	src="<%=request.getContextPath()%>/themes/jquery/jquery.js"></script>
	
<!-- sweetalert -->	
<script type="text/javascript"
	src="<%=request.getContextPath()%>/sweetalert/sweetalert.min.js"></script>


<script>
// for navbar
	$(document).ready(function(e) {
		$("#b1").click(function(e) {
			$("#item").slideToggle("linear");
		});
		
//for porfile modal		
		$("#modal").click(function(e) {
            $("#profile-modal").show();
        });
		
		$("#cross-close").click(function(e) {
            $("#profile-modal").hide();
        });
		
		$("#cancel-close").click(function(e) {
            $("#profile-modal").hide();
        });
		
//for edit profile
		let editStatus = false;

		$("#edit-profile-button").click(function(e){
			
			if(editStatus==false)
			{
				$("#profile-detail").hide();
				$("#profile-edit").show();
				
				editStatus=true;
				$(this).text("Back")
			}
			else
			{
				$("#profile-detail").show();
				$("#profile-edit").hide();
				
				editStatus=false;
				$(this).text("Edit")
			}
		});
		
	// for DoPost modal
	
		$("#do-post-btn").click(function(e) {
            $("#add-post-modal").show();
        });
		
		$("#b2").click(function(e) {
            $("#add-post-modal").hide();
        });
		$("#b3").click(function(e) {
            $("#add-post-modal").hide();
        });
	});

</script>

<!-- post JQuery  -->
<!-- Uploading post -->

<script>
	$(document).ready(function(e){
		
		$("#add-post-form").on("submit",function(event){
			// this code is gets called when form is submitted
			//alert("loaded");
			
			event.preventDefault();
			
			//console.log("You have clicked on submit");
			
			let form=new FormData(this);
			
			// now requesting to server
			// ajax to send servlet request
			$.ajax({
				url: "AddPost",
				type: 'POST',
				data: form,
				success: function (data, textStatus, jqXHR) {// data para, send data by this function
					//success
					console.log(data);
					if(data.trim()==='done') //space on left and right of data is removed with trim()
					{
						swal("Good job!", "saved successfully", "success"); // the in this is tik sign inside the msg box
					}
					else
					{
						swal("error!", "somthing went wrong try agaim...", "error");
					}
				},
				error: function (jqXHR, textStatus, errorThrown) {
					//error
					swal("error!", "somthing went wrong try agaim...", "error");
				},
				processData: false,
				contentType: false,
			})
		});
	});
	
</script>


<!-- loading post using ajax -->
<!-- javaScript  -->
<script>
	function getPosts(catId,temp) // temp is ref variable to chande active link
	{
		$("#loader").show();
		$("#post-container").hide();
		
		$(".c-link").removeClass("active");
		
		// ajax to get post
		$.ajax({
			url: "load_post.jsp",
			data: {cid:catId}, // from here cid goes to server, it is recieved by load_post.jsp
			// by default method is get
			success: function(data, textStatus, jqXHR){
				//console.log(data);
				$("#loader").hide();
				$("#post-container").show();
				$("#post-container").html(data);
				$(temp).addClass("active");		
			}
		});
	}
	
	$(document).ready(function(e){
		
		let allPostRef=$(".c-link")[0] // is may array hoti hai, so 0 position par allPostRef aa jaye gaa, hence we using[0]
		getPosts(0,allPostRef); // calling function
		
	});	
</script>

</head>
<body>
	
	<!-- navbar -->
	
	<nav class="navbar navbar-expand-md navbar-dark primary-background">
	<a href="index.jsp" class="navbar-brand"><span class="fa fa-asterisk asterisk-color"></span>MySite</a>
	<button class="navbar-toggler" id="b1">
		<span class="navbar-toggler-icon"></span>
	</button>

	<div class="collapse navbar-collapse" id="item">

		<ul class="navbar mr-auto text-centerx navbar-nav">
			<li class="nav-item active"><a class="nav-link" href="#"><span class="fa fa-bell-o"></span><b>Learn code</b></a></li>
			<li class="nav-item active"><a class="nav-link" href="#">Programming language</a></li>
			<li class="nav-item active"><a class="nav-link" href="#">Contact</a></li>
			<li class="nav-item active"><a class="nav-link" href="#!" id="do-post-btn"  data-toggle="modal" data-target="#add-post-modal">Do Post</a></li>
		</ul>

		<ul class="navbar-nav mr-right text-center">
			<li class="nav-item active">
			<a class="nav-link" href="#!" id="modal" data-toggle="modal" data-target="#profile-modal"><span class="fa fa-user-circle"></span> <%= user.getName() %></a></li>
			<li class="nav-item active">
			<a class="nav-link" href="logout"><span class="fa fa-user-plus"></span> Logout</a></li>
		</ul>

	</div>
</nav>
	
	<!-- end of navbar -->
	
							<!-- Message displaying -->
						<%
							Message m=(Message)session.getAttribute("msg");
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
						
	<!-- Main body of the page -->
		
		<main>
			<div class="container">
				<div class="row mt-4">
					
					<div class="col col-md-4">
						
						<!-- categories -->
						<div class="list-group">
						  <a href="#" onclick="getPosts(0,this)" class="c-link list-group-item list-group-item-action active">
						    All Posts
						  </a>
						  <!-- Categories form DataBase -->
						  
						  <%
						  	PostDao d=new PostDao(ConnectionProvider.getConnection());
						  	ArrayList<Category> list1=d.getAllCategories();
						  	for(Category c:list1) // for each loop
						  	{
						  %>
						  <a href="#" onclick="getPosts(<%= c.getCid() %>,this)" class="c-link list-group-item list-group-item-action"><%= c.getName() %></a>
						
						<%
						  	}
						%>
						</div>
					</div>
					
					<!-- second colum -->
					
					<div class="col col-md-8" >
						
						<!-- post -->
						
						<div class="container text-center" id="loader">
							<i class="fa fa-refresh fa-4x fa-spin"></i>
							<h3 class="mt-2">Loading...</h3>	
						</div>
						
						<div class="container-fluid" id="post-container">
						</div>
						
					</div>
					
				</div>
			</div>
		</main>
		
	<!-- Main body of the page -->	

	<!-- start of profile Modal -->

<div class="modal" id="profile-modal" tabindex="-1" role="dialog">
	<div class="modal-dialog" role="document">
    	<div class="modal-content">
        	
            <div class="modal-header primary-background text-white">
            <h1>Profile</h1>
            <span class="fa fa-close  text-danger" id="cross-close"></span>
            </div>
            
            <div class="modal-body">
            	<div class="container text-center">
            		<div class="container text-center">
            			<img style="height: 120px; max-width: 120px; border-radius: 50%;" src="photos/<%= user.getProfile()%>" class="img img-thumbnail img-fluid"/>
            		</div>
            			<h5 class="mt-3"><%= user.getName() %></h5>
            			
            			<!-- Details -->
            			
            			<div id="profile-detail">
	            			<table class="table">
						  
							  <tbody>
							    <tr>
							      <th scope="row">ID : </th>
							      <td><%= user.getId() %></td>
							    </tr>
							    <tr>
							      <th scope="row">Email : </th>
							      <td><%= user.getEmail() %></td>
							    </tr>
							    <tr>
							      <th scope="row">Gender : </th>
							      <td><%= user.getGender() %></td>
							    </tr>
							    <tr>
							      <th scope="row">Status : </th>
							      <td><%= user.getAbout() %></td>
							    </tr>
							    <tr>
							      <th scope="row">Registered on : </th>
							      <td><%= user.getDateTime().toString() %></td>
							    </tr>
							  </tbody>
							  
						</table>
					</div>
					
					<!-- //profile edit-->
					<div id="profile-edit" style="display: none;">
						<h3 class="mt-2">Please Edit Carefully</h3>
						
						<form action="EditProfile" method="post" enctype="multipart/form-data">
							<table class="table">
								
							    <tr>
							      <th scope="row">Email : </th>
							      <td><input type="text" class="form-control" name="user_email" value="<%= user.getEmail() %>"></td>
							    </tr>
							    
							    <tr>
							      <th scope="row">Name : </th>
							      <td><input type="text" class="form-control" name="user_name" value="<%= user.getName() %>"></td>
							    </tr>
							    
							    <tr>
							      <th scope="row">Password : </th>
							      <td><input type="text" class="form-control" name="user_password" value="<%= user.getPassword() %>"></td>
							    </tr>
							    
							    <tr>
							      <th scope="row">Gender : </th>
							      <td><%= user.getGender().toUpperCase() %></td>
							    </tr>
							    
							    
							    <tr>
							      <th scope="row">About : </th>
							      <td>
							      	<textarea class="form-control" name="user_about"><%= user.getAbout() %></textarea>
							      </td>
							    </tr>
							    
							    <tr>
							      <th scope="row">New Profile : </th>
							      <td>
							      	<input type="file" class="form-control" name="image">
							      </td>
							    </tr>
							    
							</table>
							
							<div class="container">
								<input type="submit" class="btn btn-outline-primary" value="Save">
							</div>
							
						</form>
					</div>
					
					
					
            	</div>
            </div>
            
            <div class="modal-footer">
            <button type="button" class="btn btn-danger mt-2" id="cancel-close">Cancel</button>
            <button id="edit-profile-button" type="button" class="btn btn-success mt-2 primary-background" >Edit</button>
            </div>
            
        </div>
    </div>
</div>
	<!-- end of Modal -->
	
	<!-- Add post Modal -->

<div class="modal" id="add-post-modal">
	<div class="modal-dialog">
    	<div class="modal-content">
        	
            <div class="modal-header">
            <h5>Provide the post details..</h5>
            <span class="fa fa-close  text-danger" id="b2"></span>
            </div>
            
            <div class="modal-body">
            	<form id="add-post-form" class="form-group" action="AddPost" method="post" enctype="multipart/form-data">
            		
            		<div class="form-group">
	            		<select class="form-control" name="cid">
	            			<option selected disabled>---Select category---</option>
	            			<%
	            			PostDao postd=new PostDao(ConnectionProvider.getConnection());
	            			ArrayList<Category> list = postd.getAllCategories();// calling method getAllCategories, it returning a list of c object 
	            			for(Category x:list) //for each category c(at a,b,c,x,x,y can be any variable) in list
	            			{					 //(loop list)list is of Category-type, Category varuable(x,c..):list is used
	            			%>
	            			<option value="<%= x.getCid() %>"><%= x.getName() %></option>
	            			<%
	            			}
	            			%>
	            		</select>
                	</div>
                	
                	<div class="form-group">
                    	<input name="pTitle" type="text" class="form-control" placeholder="Enter post title" />
                    </div>
                    
                    <div class="form-group">
                    	<textarea name="pContent" class="form-control" style="height: 200px;" placeholder="Enter your content"></textarea>
                    </div>
                         
                    <div class="form-group">
                    	<textarea name="pCode" class="form-control" style="height: 200px;" placeholder="Enter your program (if any)"></textarea>
                    </div>
                    
                    <div class="form-group">
                    	<label for="SelectPic">Select your pic</label><br>
                    	<input name="pic" type="file" class="form-control" />
                    </div>
                    
                    <div class="container text-center">
                    	<button type="submit" class="btn btn-outline-primary">Post</button>
                    </div>
                </form>
            </div>
            
            <div class="modal-footer">
            <input type="button" class="btn btn-danger mt-2" value="Cancel" id="b3">
            </div>
            
        </div>
    </div>
</div>
	<!-- End post Modal -->
	
</body>
</html>
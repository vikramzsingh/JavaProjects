<%@page import="com.vikram.dao.LikeDao"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.vikram.dao.UserDao"%>
<%@page import="com.vikram.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.vikram.entities.Post"%>
<%@page import="com.vikram.helper.ConnectionProvider"%>
<%@page import="com.vikram.dao.PostDao"%>
<%@page import="com.vikram.entities.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page errorPage="error_page.jsp" %>
    
    <!-- validation or Authentication  -->
    <%
		// session OBJECT u is of User TYPE, so type-cast session into User Type 
		User user = (User)session.getAttribute("currentUser");
		if(user==null)
		{
			response.sendRedirect("login_page.jsp");
		}
	%>
    
    
    <%
    	int postId=Integer.parseInt(request.getParameter("post_id"));
    	PostDao d = new PostDao(ConnectionProvider.getConnection());
    	
    	Post p = d.getPostByPostId(postId);
    %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title><%= p.getpTitle() %> || learn code</title>
</head>

<!-- css and botstrap -->
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/themes/css/bootstrap.css" />
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/themes/css/mystyle.css" />
	
	<style>
		.post-title{
			font-weight: 100;
			font-size: 30px;
		}
		
		.post-content{
			font-weight: 100;
			font-size: 25px;
		}
		
		.post-date{
			font-style: italic;
			font-weight: bold;
		}
		
		.post-user-info{
			font-size: 20px;
		}
		
		.row-user{
			border: 1px solid #e2e2e2;
			padding-top: 15px;
		}
		
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

<!-- like button -->

<script>
function doLike(pid, uid)
{
	console.log(pid + "," + uid);
	
	// creating object in JavaScript or data
	const d={
		uid: uid,
		pid: pid,
		operation: 'like'
	} 
	
	$.ajax({
		url: "LikedServlet",
		data: d,
		success: function(data, textStatus, jqXHR){
			console.log(data);
			
			if(data.trim()==="true")
			{
				let c=$(".like-counter").html();
				c++;
				$('.like-counter').html(c);
			}
		},
		error: function(jqXHR, textStatus, errorThrown){
			console.log(data);
		}
	})
}
</script>

<!-- facebook comment plugin -->
<div id="fb-root"></div>
<script async defer crossorigin="anonymous" src="https://connect.facebook.net/en_GB/sdk.js#xfbml=1&version=v8.0" nonce="dFrTnEPO"></script>

<body>

<!-- navbar -->
	
	<nav class="navbar navbar-expand-md navbar-dark primary-background">
	<a href="index.jsp" class="navbar-brand"><span class="fa fa-asterisk asterisk-color"></span>MySite</a>
	<button class="navbar-toggler" id="b1">
		<span class="navbar-toggler-icon"></span>
	</button>

	<div class="collapse navbar-collapse" id="item">

		<ul class="navbar mr-auto text-centerx navbar-nav">
			<li class="nav-item active"><a class="nav-link" href="profile.jsp"><span class="fa fa-bell-o"></span><b>Learn code</b></a></li>
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
	
	<!-- start of main content of the body -->	
	<main>
	
		<div class="container">
			
			<div class="row my-4">
				<div class="col col-md-8 offset-md-2">
					
					<div class="card">
						<div class="card-header primary-background text-white">
							<h4 class="post-title"><%= p.getpTitle() %></h4>
						</div>
						
						<div class="card-body">
						<img class="card-img-top my-2" src="blog_pics/<%= p.getpPic() %>" alt="Card image cap">
							
							<div class="row my-3 row-user">
								<div class="col col-md-8">
								
									<%
										UserDao ud = new UserDao(ConnectionProvider.getConnection());
										
										//User postofuser = ud.getUserByUsertId(p.getUserId()); or you use it directly
										// postofuser.getName(); uesd
									%>
									
									<p class="post-user-info"><a href="#!"><%= ud.getUserByUsertId(p.getUserId()).getName() %></a> has posted</p>
								</div>
								
								<div class="col col-md-4"><!-- DateFormat is a built-in class -->
									<p class="post-date"><%= DateFormat.getDateTimeInstance().format(p.getpDate()) %></p>
								</div>
							</div>
							
							<p class="post-content"><%= p.getpContent() %></p>
							
							<br>
							<br>
							<div class="post-code">
								<pre><%= p.getpCode() %></pre>
							</div>
						</div>
						
						<div class="card-footer primary-background">
						<%
							LikeDao ld = new LikeDao(ConnectionProvider.getConnection());
						%>
							<a href="#!" onclick="doLike(<%= p.getPid() %>, <%= user.getId() %>)" class="btn btn-outline-light btn-sm"><i class="fa fa-thumbs-o-up"></i><span class="like-counter"><%= ld.countLikeOnPost(p.getPid()) %></span></a>
							<a href="#!" class="btn btn-outline-light btn-sm"><i class="fa fa-commenting-o"></i><span>20</span></a>
						</div>
						
						<div class="card-footer">
							<div class="fb-comments" data-href="http://localhost:8092/JavaWebApplication/show_blog_page.jsp?post_id=<%= p.getPid() %>" data-numposts="5" data-width=""></div>
						</div>
					</div>
						
				</div>
			</div>
			
		</div>
		
	</main>
	<!-- end of main content of the body -->
	
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
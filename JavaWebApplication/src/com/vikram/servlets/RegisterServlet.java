package com.vikram.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.vikram.dao.UserDao;
import com.vikram.entities.User;
import com.vikram.helper.ConnectionProvider;

/**
 * Servlet implementation class RegisterServlet
 */
@MultipartConfig //To ignore data type
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		try(PrintWriter out=response.getWriter())
		{
			
			
			//fetch all form data
			String check=request.getParameter("check");
			
			if(check==null)
			{
				out.println("box not checked");
			}
			else
			{
				//Rest of the data here
				String name=request.getParameter("user_name");
				String email=request.getParameter("user_email");
				String password=request.getParameter("user_password");
				String gender=request.getParameter("gender");
				String about=request.getParameter("about");
				
				// Create User object and set all data to that object(it is const of User(class))
				User user=new User(name,email,password,gender,about);// const call
				
				//Create UserDao object to store data in database(it is const of UserDao(class))
				UserDao dao=new UserDao(ConnectionProvider.getConnection());//const call
				if(dao.saveUser(user))
				{
					//save
					out.println("done");
				}
				else
				{
					out.println("error");
				}
			}
			
			
		}
	}

}

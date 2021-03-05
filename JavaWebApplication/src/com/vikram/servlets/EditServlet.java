package com.vikram.servlets;

import java.io.File;
import java.io.IOException;	
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;


import com.vikram.dao.UserDao;
import com.vikram.entities.Message;
import com.vikram.entities.User;
import com.vikram.helper.ConnectionProvider;
import com.vikram.helper.Helper;


/**
 * Servlet implementation class EditServlet
 */
@SuppressWarnings("deprecation")
@MultipartConfig
@WebServlet("/EditServlet")
public class EditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");
		try(PrintWriter out=response.getWriter())
		{	
			out.println("<!DOCTYPE html>");
			out.println("<html>");
			out.println("<head>");
			out.println("<title></title>");
			out.println("</head>");
			out.println("<body>");
			
			String userEmail = request.getParameter("user_email");
			String userName = request.getParameter("user_name");
			String userPassword = request.getParameter("user_password");
			String userAbout = request.getParameter("user_about");
			
			// Part(INTERFACE) is built-in INTERFACE in Httpservlet, It is used to fetch IMAGE
			Part part = request.getPart("image");
			// getSubmittedFileName() provide IMAGE name with extension from part OBJECT
			// then strored in a Variable e.g. (imageName)
			String imageName = part.getSubmittedFileName();
			
			// get the user from the session
			HttpSession s= request.getSession();
			User user=(User)s.getAttribute("currentUser");
			
			user.setEmail(userEmail);
			user.setName(userName);
			user.setPassword(userPassword);
			user.setAbout(userAbout);
			
			String oldFile=user.getProfile();
			user.setProfile(imageName);
			
			// At this point the data inside user OBJECT is Updated, now where-ever we use this user OBJECT, we will get Updated data 
			
			// now Update database
			UserDao userDao=new UserDao(ConnectionProvider.getConnection());
			
			boolean ans = userDao.updateUser(user); // user Argument passed to updateUser(User parameter) {Method}
			
			if(ans)
			{
				/* Here File.separator works for both window and linux to provide {//,/}
					Also for window you can use // to create path as webApplication/photos/....
				*/
				String path = request.getRealPath("/") + "photos" + File.separator + user.getProfile();
				//System.out.println(path);
				
				//  for deleting old-photo code
				String pathOldFile = request.getRealPath("/") + "photos" + File.separator + oldFile;
				
				if(!oldFile.equals("default.png"))
				{
					Helper.deleteFile(pathOldFile);
				}
				
				
				
				if(Helper.saveFile(part.getInputStream(), path))
				{
					Message msg= new Message("Profile Details Updated...","success","alert-success");
					s.setAttribute("msg", msg);
					
				}
				else
				{
					Message msg= new Message("Something! went wrong...","error","alert-danger");
					s.setAttribute("msg", msg);
					//out.println(path);
					//out.println("block 1");
				}
				
				
			}
			else
			{
				//Message msg= new Message("Something! went wrong...","error","alert-danger");
				//s.setAttribute("msg", msg);
			}
			
			response.sendRedirect("profile.jsp");
			out.println("</body>");
			out.println("</html>");
		}
	}

}

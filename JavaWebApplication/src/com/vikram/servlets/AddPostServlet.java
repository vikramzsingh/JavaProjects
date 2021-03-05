package com.vikram.servlets;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
//import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.vikram.dao.PostDao;
import com.vikram.entities.Post;
import com.vikram.entities.User;
import com.vikram.helper.ConnectionProvider;
import com.vikram.helper.Helper;

/**
 * Servlet implementation class AddPostServlet
 */
@MultipartConfig
//@WebServlet("/AddPostServlet")  -->checking ajax url(also working with this modification)
public class AddPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		response.setContentType("text/html");
		try(PrintWriter out = response.getWriter())
		{
			
			int cid=Integer.parseInt(request.getParameter("cid"));
			String pTitle=request.getParameter("pTitle");
			String pContent=request.getParameter("pContent");
			String pCode=request.getParameter("pCode");
			//fetching pic from FORM and storing in part OBJECT
			Part part=request.getPart("pic");
			//storing the name of image in pic from part OBJECT
			String pPic=part.getSubmittedFileName();
			
			//getting current User id
			HttpSession session=request.getSession();
			User user=(User) session.getAttribute("currentUser");
			int userId=user.getId();
			
			//out.println("Photo name:"+pPic);
			
			//out.println("Your post title:"+pTitle);
			
			Post p = new Post(pTitle, pContent, pCode, pPic, null, cid, userId);
			PostDao dao=new PostDao(ConnectionProvider.getConnection());
			//dao.savePost(p); -->true/false
			if(dao.savePost(p)) 
			{
				out.println("done");
				
				@SuppressWarnings("deprecation")
				String path = request.getRealPath("/") + "blog_pics" + File.separator + pPic;
				Helper.saveFile(part.getInputStream(), path);
			}
			else
			{
				out.println("error");
			}
			
		}
	}

}

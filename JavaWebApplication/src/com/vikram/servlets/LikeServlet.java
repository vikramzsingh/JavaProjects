package com.vikram.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.vikram.dao.LikeDao;
import com.vikram.helper.ConnectionProvider;


/**
 * Servlet implementation class LikeServlet
 */
@WebServlet("/LikeServlet")
public class LikeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		response.setContentType("text/html");
		try(PrintWriter out=response.getWriter())
		{	
			String operation = request.getParameter("operation");
			int uid=Integer.parseInt(request.getParameter("uid"));
			int pid=Integer.parseInt(request.getParameter("pid"));
			
			//out.println("Data from server");
			//out.println(operation);
			//out.println(uid);
			//out.println(pid);
			
			LikeDao ldao = new LikeDao(ConnectionProvider.getConnection());
			if(operation.equals("like"))
			{
				boolean f = ldao.insertLike(pid, uid);
				out.println(f);
			}
		}
	}

}

package com.vikram.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.vikram.entities.Message;

/**
 * Servlet implementation class LogoutServlet
 */
@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		response.setContentType("text/html");
		try(PrintWriter out=response.getWriter())
		{	
			out.println("<!DOCTYPE html>");
			out.println("<html>");
			out.println("<head>");
			out.println("<title></title>");
			out.println("</head>");
			out.println("<body>");
			// in jsp we can take value from session object directly, no need to create session object(because it is present implicitly in jsp)
			// in servlet we have to create session object
			HttpSession s=request.getSession();
			
			s.removeAttribute("currentUser");
			
			Message m = new Message("Logout Successfully", "success", "alert-success");
			
			s.setAttribute("msg", m);
			
			response.sendRedirect("login_page.jsp");
			out.println("</body>");
			out.println("</html>");
		}
	}

}

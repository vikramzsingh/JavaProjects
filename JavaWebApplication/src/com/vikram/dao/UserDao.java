package com.vikram.dao;

import java.sql.*;

import com.vikram.entities.User;

public class UserDao {
	private Connection con;  

	public UserDao(Connection con) {
		this.con = con;    // this KEYWORD is used to access the methods and variables of the same class
	}
	
	// method to insert user to database or registration
	public boolean saveUser(User user) 
	{
		boolean f=false;// to find out query executed or not
		try 
		{
			//user --> database
			String query="insert into user(name,email,password,gender,about) values(?,?,?,?,?)";
			PreparedStatement pstmt=this.con.prepareStatement(query);
			pstmt.setString(1,user.getName());
			pstmt.setString(2, user.getEmail());
			pstmt.setString(3, user.getPassword());
			pstmt.setString(4, user.getGender());
			pstmt.setString(5, user.getAbout());
			
			pstmt.executeUpdate();
			f=true;
		}
		catch(Exception e) 
		{
			e.printStackTrace();
		}
		return f;
	}
	
	
	// get user by email and password: or login
	
	public User getUserByEmailAndPassword(String email, String password) 
	{
		User user = null;
		
		try 
		{
			String query="select * from user where email =? and password =?";
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setString(1, email);
			pstmt.setString(2, password);
			
			ResultSet rs = pstmt.executeQuery();
			
			// agar ek b row ayi hai tho mai sara data nikal lu ga
			if(rs.next())
			{
				user = new User(); // OBJECT of User class
				
				// getting data from data base
				String name=rs.getString("name");
				
				//setting(setter method) data in user OBJECT
				user.setName(name);
				
				// this is getting(data from database) and setting in user object with setter method
				user.setId(rs.getInt("id"));
				user.setEmail(rs.getString("email"));
				user.setPassword(rs.getString("password"));
				user.setGender(rs.getString("gender"));
				user.setAbout(rs.getString("about"));
				user.setDateTime(rs.getTimestamp("rdate")); // because in database its type is TimeStamp
				user.setProfile(rs.getString("profile"));
			}
		}
		catch(Exception e) 
		{
			e.printStackTrace();
		}
		
		return user;
	}
	
	
	// to save updated Profile details [form EditServlet(This Servlet Stored the Updated data in user OBJECT)]
	
	public boolean updateUser(User user) // user is a PARAMETER of User-Type
	{
		boolean f = false;
		try 
		{
			String query="update user set name=? , email=? , password=? , gender=? , about=? , profile=? where id=? ";
			PreparedStatement p=con.prepareStatement(query);
			p.setString(1, user.getName());
			p.setString(2, user.getEmail());
			p.setString(3, user.getPassword());
			p.setString(4, user.getGender());
			p.setString(5, user.getAbout());
			p.setString(6, user.getProfile());
			p.setInt(7, user.getId());
			
			p.executeUpdate();
			f = true;
		}
		catch(Exception e) 
		{
			e.printStackTrace();
		}
		
		return f;
	}
	
	public User getUserByUsertId(int userId)
	{
		User user = null;
		
		try 
		{
			String q = "select * from user where id=?";
			PreparedStatement ps = this.con.prepareStatement(q);
			ps.setInt(1, userId);
			ResultSet rs = ps.executeQuery();
			if(rs.next())
			{
				user = new User(); // OBJECT of User class
				
				// getting data from data base
				String name=rs.getString("name");
				
				//setting(setter method) data in user OBJECT
				user.setName(name);
				
				// this is getting(data from database) and setting in user object with setter method
				user.setId(rs.getInt("id"));
				user.setEmail(rs.getString("email"));
				user.setPassword(rs.getString("password"));
				user.setGender(rs.getString("gender"));
				user.setAbout(rs.getString("about"));
				user.setDateTime(rs.getTimestamp("rdate")); // because in database its type is TimeStamp
				user.setProfile(rs.getString("profile"));
			}
		}
		catch(Exception e) 
		{
			e.printStackTrace();
		}
		
		return user;
	}
	
}

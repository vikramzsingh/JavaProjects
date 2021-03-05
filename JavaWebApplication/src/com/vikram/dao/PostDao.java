package com.vikram.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList; //Child class of List INTERFACE
import java.util.List; //INTERFACE

import com.vikram.entities.Category;
import com.vikram.entities.Post;

public class PostDao {
	
	Connection con;
	
	// constructor
	public PostDao(Connection con)
	{
		this.con=con;
	}
	
	public ArrayList<Category> getAllCategories(){
		
		// its gets ArrayList from Category(class) and store in list VARIABLE
		// Also ArrayList is built-in class in util package
		
		ArrayList<Category> list = new ArrayList<Category>(); //creating array list of Category type
		
		try 
		{
			String q = "select * from categories";
			Statement st = this.con.createStatement();
			ResultSet rs = st.executeQuery(q);
			while(rs.next())
			{
				int cid = rs.getInt("cid");
				String name = rs.getString("name");
				String description = rs.getString("description");
				
				Category c = new Category(cid, name, description);
				
				//when loop is finish all details in c OBJECT will be added in list(in the form of list/tuple)
				list.add(c);
			}
			
		}
		catch(Exception e) 
		{ 
			e.printStackTrace();
		}
		
		return list;
	}
	
	// Save Post data
	public boolean savePost(Post p) // Passing the entire Post p(OBJECT) 
	{
		boolean f = false;
		try 
		{
			String q ="insert into posts(pTitle,pContent,pCode,pPic,catId,userId) values(?,?,?,?,?,?)";
			PreparedStatement pstmt=con.prepareStatement(q);
			pstmt.setString(1, p.getpTitle());
			pstmt.setString(2, p.getpContent());
			pstmt.setString(3, p.getpCode());
			pstmt.setString(4, p.getpPic());
			pstmt.setInt(5, p.getCatId());
			pstmt.setInt(6, p.getUserId());
			pstmt.executeUpdate();
			f = true;
		}
		catch(Exception e) 
		{
			e.printStackTrace();
		}
		return f;
	}
	
	//get all posts
	
	public List<Post> getAllPosts()
	{
		// list is interface of its object cannot be created, so its child class ArrayList OBJECT is created 
		List<Post> list=new ArrayList<Post>();
		
		//featch all the post
		try 
		{
			
			String q = "Select * from posts order by pid desc";
			PreparedStatement p=con.prepareStatement(q);
			ResultSet rs=p.executeQuery();
			while(rs.next())
			{
				int pid = rs.getInt("pid");
				String pTitle = rs.getString("pTitle");
				String pContent = rs.getString("pContent");
				String pCode = rs.getString("pCode");
				String pPic = rs.getString("pPic");
				Timestamp date = rs.getTimestamp("pDate");
				int catId = rs.getInt("catId");
				int userId = rs.getInt("userId");
				
				Post post = new Post(pid, pTitle, pContent, pCode, pPic, date, catId, userId);// constr call while object creation
				// this post OBJECT contains one row.
				// when while loop repeat again. 
				// this post OBJECT contain second row.
				// every time we add row in the list.
				list.add(post);
			}
		}
		catch(Exception e) 
		{
			e.printStackTrace();
		}
		
		return list;
	}
	
	// get posts by category id(catId)
	
	public List<Post> getPostByCatId(int catId)
	{
		List<Post> list=new ArrayList<Post>(); //Here Post is a Class
		
		// fetch all  posts by category id(catId)
		try 
		{
			
			String q = "Select * from posts where catId=?";
			PreparedStatement p=con.prepareStatement(q);
			p.setInt(1, catId);
			ResultSet rs=p.executeQuery();
			while(rs.next())
			{
				int pid = rs.getInt("pid");
				String pTitle = rs.getString("pTitle");
				String pContent = rs.getString("pContent");
				String pCode = rs.getString("pCode");
				String pPic = rs.getString("pPic");
				Timestamp date = rs.getTimestamp("pDate");
				int userId = rs.getInt("userId");
				
				Post post = new Post(pid, pTitle, pContent, pCode, pPic, date, catId, userId);// constr call while object creation
				// this post OBJECT contains one row.
				// when while loop repeat again. 
				// this post OBJECT contain second row.
				// every time we add row in the list.
				list.add(post);
			}
		}
		catch(Exception e) 
		{
			e.printStackTrace();
		}
		
		return list;
	}
	
	public Post getPostByPostId(int postId)
	{
		Post post = null;
		try 
		{
			String q="select * from posts where pid=?";
			PreparedStatement p = this.con.prepareStatement(q); //this keyword is used to access methods and variable from same class
			p.setInt(1, postId);
			
			ResultSet rs = p.executeQuery();
			if(rs.next())
			{
				int pid = rs.getInt("pid");
				String pTitle = rs.getString("pTitle");
				String pContent = rs.getString("pContent");
				String pCode = rs.getString("pCode");
				String pPic = rs.getString("pPic");
				Timestamp date = rs.getTimestamp("pDate");
				int catId = rs.getInt("catId");
				int userId = rs.getInt("userId");
				
				// adding data of selected post into new Post Object  
				post = new Post(pid, pTitle, pContent, pCode, pPic, date, catId, userId);// constr call while object creation
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return post;
	}
	
}

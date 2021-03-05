package com.vikram.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LikeDao {
	
	Connection con = null;
	
	public LikeDao(Connection con)
	{
		this.con = con;
	}
	
	// inserting like
	public boolean insertLike(int pid, int uid)
	{
		boolean f = false;
		
		try
		{
			String q = "insert into liked(pid,uid) values(?,?)";
			PreparedStatement p = con.prepareStatement(q);
			p.setInt(1, pid);
			p.setInt(2, uid);
			p.executeUpdate();
			
			f=true;
		}
		catch(Exception e) 
		{
			e.printStackTrace();
		}
		
		return f;
	}
	
	//count likes on post
	public int countLikeOnPost(int pid)
	{
		int count = 0;
		
		try 
		{
			String q = "select count(*) from liked where pid=?";
			PreparedStatement p = this.con.prepareStatement(q);
			p.setInt(1, pid);
			
			ResultSet rs = p.executeQuery();
			if(rs.next())
			{
				count=rs.getInt("count(*)");
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return count;
	}
	
	// check if user liked post or not
	public boolean isLikedByUser(int pid, int uid)
	{
		boolean f = false;
		
		try 
		{
			String q = "select * from liked where pid=? AND uid=?";
			PreparedStatement p = this.con.prepareStatement(q);
			p.setInt(1, pid);
			p.setInt(2, uid);
			ResultSet rs = p.executeQuery();
			if(rs.next())
			{
				f=true;
			}
		}
		catch(Exception e) 
		{
			e.printStackTrace();
		}
		return f;
	}
	
	// delete like from post
		public boolean deleteLike(int pid, int uid)
		{
			boolean f = false;
			
			try 
			{
				String q = "delete from liked where pid=? and uid=?";
				PreparedStatement p = this.con.prepareStatement(q);
				p.setInt(1, pid);
				p.setInt(2, uid);
				p.executeUpdate();
				f = true;
				
			}
			catch(Exception e) 
			{
				e.printStackTrace();
			}
			return f;
		}
		
}

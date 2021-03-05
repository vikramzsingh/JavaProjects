package com.vikram.helper;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;


public class Helper {

	// To delete file (In Photos folder)
	public static boolean deleteFile(String path)
	{
		boolean f = false;
		
		try 
		{
			File file=new File(path);
			f = file.delete(); //delete() returns true(boolean value) on Success
			
		}
		catch(Exception e) 
		{ 
			e.printStackTrace();
		}
		
		
		return f;
	}
	
	// TO save file(In photos folder)
	public static boolean saveFile(InputStream is, String path)
	{
		boolean f = false;
		
		try 
		{
			//create a byte array to store image data
			byte b[] = new byte[is.available()]; // jado tak data available(is.available) hai,
												// odhoo tak is.read(b) method read kare ga b(byte array) da data. 
			is.read(b); //read image data
			
			FileOutputStream fos = new FileOutputStream(path);
			fos.write(b);
			
			fos.flush();
			fos.close();
			f=true;
		}
		catch(Exception e) 
		{
			e.printStackTrace();
		}
		
		return f;
	}
}

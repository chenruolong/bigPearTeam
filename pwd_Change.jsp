<%@page import="java.io.Console"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="my.dao.*"  %>
<%
	String UserId = (String)session.getAttribute("UserId");
	

	Rec dep = MyDao.queryOne("select * from user_ where u_id=?", UserId);
	String ucode_old=request.getParameter("u_code_old"); 
	String ucode=request.getParameter("u_code"); 
	String ucodes=request.getParameter("u_codes"); 
	if(!(ucode_old.equals("") || ucode.equals("") || ucodes.equals("")))
	{	
		if( ucode_old.equals(dep.get("u_pwd")))
		{
			if(!ucode_old.equals(ucode))
			{
				if(ucode.equals(ucodes))
				{
			 	//执行数据操作
			 	MyDao.update(
					"update  user_ set u_pwd=? where u_id=?", 
					ucode,dep.get("u_id")
				 );

			 		//向浏览器回送消息
			 		String info=MyDao.jsonMessage(true, "密码修改成功！");    
			 		out.print(info);

				}
		   		else{
					//向浏览器回送消息
					String info=MyDao.jsonMessage(false, "您两次输入的两次密码不一致！");    
					out.print(info);
					return;
		   		}
			}
		
			else
		 	{
				//向浏览器回送消息
				String info=MyDao.jsonMessage(false, "原密码与新密码相同！");
				    
				out.print(info);
				return;
		 	}	
		}
	
		 
		else{
			
			String info=MyDao.jsonMessage(false, "您请输入正确的原始密码！");    
			out.print(info);
			return;
		}
	}
	else
	{
		String info=MyDao.jsonMessage(false, "请填写完整内容！");    
 		out.print(info);
		return ;
	}
%>
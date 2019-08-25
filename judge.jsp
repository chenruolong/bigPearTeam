<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  import="my.dao.*" %>
    
    
                        
                            <!-- 货物入库的数据库更新-->
                       
                       

<%

		String pro_id=request.getParameter("pro_id"); 

		
		int cnt=MyDao.queryInteger("select count(*) from pro_infor where pro_id=?", pro_id);
		
		
		if(cnt>0)
		{


		
			session.setAttribute("pro_id", pro_id);
			   
			response.sendRedirect("enter_form1.jsp");
			return;
			
			
		}
		else{
			
			

			session.setAttribute("pro_id", pro_id);
			response.sendRedirect("enter_form2.jsp");

		



		}

		 %>


	
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  import="my.dao.*" %>
    
    
    
    
                           <!-- 新货物入库的数据库更新-->
                       
                       

<%

		String pro_id=request.getParameter("pro_id"); 
		String pro_name=request.getParameter("pro_name"); 
		String pro_num=request.getParameter("pro_num"); 
		String pro_wei=request.getParameter("pro_wei"); 
		String pro_price=request.getParameter("pro_price"); 
		String enter_supply=request.getParameter("enter_supply"); 
		
		MyDao.update(
				"insert into pro_infor values(?,?,?,?,?)", 
				pro_id,pro_name,pro_num,pro_wei,pro_price
				);
		
		
		MyDao.update(
				"insert into enter values(?,?,now(),?)",
				      pro_id,pro_num,enter_supply
						
		);

		out.print("新货物入库成功！");

	
	 %>


	




<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  import="my.dao.*" %>
    
    
                       <!-- 出库后数据库的更新以及出库成功弹出框-->
                       
                       
<%


	//参数名应与增加页的表单元素的name一致
	String pro_id=request.getParameter("pro_id"); 
	String pro_numnew=request.getParameter("pro_num"); 


	
	//执行数据操作
	MyDao.update(
			"update pro_infor set pro_num=pro_num-? where pro_id=?",
					pro_numnew,pro_id
					
	);
	
	//执行数据操作
	MyDao.update(
			"insert into delivery values(?,?,now())",
			      pro_id,pro_numnew
					
	);
	 
	
	
	
	//向浏览器回送消息
    out.print("该货物出库成功！");    
    
%>














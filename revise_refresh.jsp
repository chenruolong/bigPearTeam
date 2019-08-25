<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  import="my.dao.*" %>

<% 
	String pro_id=request.getParameter("pro_id"); 
	String pro_name=request.getParameter("pro_name"); 
	String pro_num=request.getParameter("pro_num"); 
	String pro_wei=request.getParameter("pro_wei"); 
	String pro_price=request.getParameter("pro_price"); 
   
	

	//执行数据操作
	MyDao.update(
			"update pro_infor set pro_name=?,pro_price=? where pro_id=?",
			pro_name,pro_price,pro_id
			 
	);
	
	//向浏览器回送消息
 
    out.print("该货物调价成功！");
%>

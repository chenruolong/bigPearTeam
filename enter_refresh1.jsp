<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  import="my.dao.*" %>
    
    
                        
                            <!-- 货物入库的数据库更新-->
                       
                      
<% 
		String pro_id=request.getParameter("pro_id"); 
		String pro_name=request.getParameter("pro_name"); 
		String pro_numnew=request.getParameter("pro_num"); 
		String pro_wei=request.getParameter("pro_wei"); 
		String pro_price=request.getParameter("pro_price"); 
		String enter_supply=request.getParameter("enter_supply"); 


			MyDao.update(
					"update pro_infor set pro_num=pro_num+? where pro_id=?",
							pro_numnew,pro_id
							);
			
			MyDao.update(
					"insert into enter values(?,?,now(),?)",
							pro_id,pro_numnew,enter_supply
							);
			
			out.print("该货物入库成功！");

			%>		
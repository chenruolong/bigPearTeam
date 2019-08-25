<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="my.dao.*"%>


<%


	String uid = request.getParameter("u_id");
	String upwd = request.getParameter("u_pwd");
	Rec user = MyDao.queryOne("select * from user_ where u_id=? and u_pwd=?", uid,upwd);

	if (user!=null){


		session.setAttribute("UserId", user.getString("u_id"));
		response.sendRedirect("main-UI.html");
	}else{
		request.setAttribute("error", "登录失败！");
		request.getRequestDispatcher("loginPage.jsp").forward(request, response);
	}





%>

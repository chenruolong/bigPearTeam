

                             
                                     <%--货物的出库 --%>
                                     


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="my.dao.*" %>
    
<%
	
	String tt=request.getParameter("t"); //文本框的值
	String d=request.getParameter("a");	//下拉框的id
	RecList recList=null;
	String sql= "select * from pro_infor where 1=1 ";
	String search_content="";
	if(d!=null && (!tt.equals(""))){


		if(Integer.parseInt(d)==-1){
			sql=sql+"and pro_id like ? ";
		}

		else if(Integer.parseInt(d)==0){
			sql=sql+"and pro_name like ? ";
		}

		else if(Integer.parseInt(d)==1){
			sql=sql+"and pro_num like ? ";
		}

		else if(Integer.parseInt(d)==2){
			sql=sql+"and pro_wei like ? ";
		}

		else if(Integer.parseInt(d)==3){
			sql=sql+"and pro_price like ? ";
		}
		else{
			out.print("d的值不是null，也不是-1到3.");
		}
		search_content="%" + tt + "%";
		recList=MyDao.query(sql,search_content);

	}
	else{
		recList=MyDao.query(sql);
	}



%>
	<link rel="stylesheet" href="css/bootstrap.min.css">
	<link rel="stylesheet" href="css/normalize.css">
	<link rel="stylesheet" href="css/index.css">

                                  <%--面包屑导航设置--%>
                                  

<ol style="line-height:30px;" class="breadcrumb">
  	<li>仓库管理</li>  
  	<li class="active">货物出库</li>
  	<%-- 搜索部分 --%>
<form style=" display: inline-block; float:right;" action="#" method="post">

<%-- 搜索栏前面的选择按钮 --%>
<select style="border:1px solid rgba(85, 63, 122, 0.5);backgroung:#fff; display: inline-block; width: auto; height:21;" name="a" id="a" >
<option value="-1">货物编号</option>
<option value="0">货物名称</option>
<option value="1">货物数量</option>
<option value="2">货物重量</option>
<option value="3">货物价格</option>
</select>
<%-- 搜索栏前面的选择按钮 --%>
<input  style="right:100px; border-radius: 10px; border:1px solid rgba(85, 63, 122, 0.5);" type="text" name="t">
<button style="right:10px; margin-left: 5px; background: rgba(85, 63, 122, 0.9);padding: 2px 12px;color:#fff;font-weight:300;bolid:0;"  id="query-emp-id" type="submit"data-href="delivery.jsp" class="btn dq-click" name="button">搜索</button>

</form>


<%-- 搜索部分 --%>
</ol>

<form style="margin: 10px;">
	


                                     <%-- 表格设置 --%>


<table class="table table-striped table-hover table-condensed">
	<thead>
		<tr>
		<th>货物编号</th><th>货物名称</th><th>货物重量</th><th>货物价格</th><th>货物数量</th>
		</tr>
	</thead>
	<tbody>
<%
	for(int i=0;i<recList.size();i++){
		Rec dep=recList.recAt(i);
%>		
		<tr>

			<td><% out.print(dep.get("pro_id")); %></td>
			<td><% out.print(dep.get("pro_name")); %></td>
			<td><% out.print(dep.get("pro_wei")); %></td>
			<td><% out.print(dep.get("pro_price")); %></td>
			<td><% out.print(dep.get("pro_num")); %></td>
			<td>
				<a href="delivery_form.jsp?pro_id=<% out.print(dep.get("pro_id")); %>" class="dq-click" data-dq-target="dq-dlg" >出库</a>		
				
			</td>
		</tr>
<%
	}
%>		
	</tbody>

</table>
</form>





	



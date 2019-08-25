

                             
                                                         <%--调整价格 --%>
                                     


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="my.dao.*" %>
    

<%


                                                          // 货物编号的查询

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
			sql=sql+"and pro_price like ? ";
		}
		else{
			out.print("d的值不是null，也不是-1到1.");
		}
		search_content="%" + tt + "%";
		recList=MyDao.query(sql,tt);

	}
	else{
		recList=MyDao.query(sql);
	}
%>
                                                        <%--面包屑导航设置--%>
                                

<ol style="line-height:30px;" class="breadcrumb">
<li>货物信息</li>  
<li class="active">价格调整</li>
<%-- 搜索部分 --%>
<form style=" display: inline-block; float:right;" action="#" method="post">

<%-- 搜索栏前面的选择按钮 --%>
<select style="border:1px solid rgba(85, 63, 122, 0.5);backgroung:#fff; display: inline-block; width: auto; height:21;" name="a" id="a" >
<option value="-1">货物编号</option>
<option value="0">货物名称</option>
<option value="1">货物价格</option>
</select>
<%-- 搜索栏前面的选择按钮 --%>
<input  style="right:100px; border-radius: 10px; border:1px solid rgba(85, 63, 122, 0.5);" type="text" name="t">
<button style="right:10px; margin-left: 5px; background: rgba(85, 63, 122, 0.9);padding: 2px 12px;color:#fff;font-weight:300;bolid:0;"  id="query-emp-id" type="submit"data-href="revise.jsp" class="btn dq-click" name="button">搜索</button>

</form>


<%-- 搜索部分 --%>
</ol>
                                                     <%-- 表格设置 --%>


<table style="margin:10px;" class="table table-striped table-hover table-condensed">
	<thead>
		<tr>
		<th>货物编号</th><th>货物名称</th><th>货物价格</th>
		</tr>
	</thead>
	<tbody>
<% if(recList!=null){
	for(int i=0;i<recList.size();i++){
		Rec dep_revise=recList.recAt(i);
%>		
		<tr>
			<td><% out.print(dep_revise.get("pro_id")); %></td>
			<td><% out.print(dep_revise.get("pro_name")); %></td>
			<td><% out.print(dep_revise.get("pro_price")); %></td>
			<td>
				<a href="revise_form.jsp?pro_id=<% out.print(dep_revise.get("pro_id")); %>" class="dq-click" data-dq-target="dq-dlg" >调价</a>		
				
			</td>
		</tr>
<%
	}
}
%>		
	</tbody>

</table>




	



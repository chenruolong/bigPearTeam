<%@page import="java.io.Console"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="my.dao.*" %>




<%
	//参数名应与增加页的表单元素的name一致
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
	<link rel="stylesheet" href="css/bootstrap-theme.min.css">
	<link rel="stylesheet" href="css/normalize.css">
	<link rel="stylesheet" href="css/index.css">

<style type="text/css">
	.my-query-label{
		display:inline-block;
		width:40px;
		text-align:right;

	}
</style>
  <!-- 面包屑导航条 -->
  <ol style="line-height:30px;" class="breadcrumb">
    <li>货物信息</li>
    <li class="active">信息查看</li>

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
<button style="right:10px; margin-left: 5px; background: rgba(85, 63, 122, 0.9);padding: 2px 12px;color:#fff;font-weight:300;bolid:0;"  id="query-emp-id" type="submit"data-href="base_info.jsp" class="btn dq-click" name="button">搜索</button>

</form>


<%-- 搜索部分 --%>
  </ol>
    <!-- 面包屑导航条 -->



    <%-- 标签页 --%>
    <ul  style="margin:10px;"  class="nav nav-tabs">
      <li class="active"><a href="#base_info">基本信息</a></li>
      <li><a href="import_info.jsp" class="dq-click">入库信息</a></li>
      <li><a href="outport_info.jsp" class="dq-click">出库信息</a></li>
    </ul>

      <div class="tab-pane active" id="base_info">
      <%-- 基本信息表 --%>
<form class="form-inline" >

                                    <%-- 表格设置 --%>

<table id="table" style="margin:10px;" class="table table-striped table-hover table-condensed">
	<thead>
		<tr>
		<th>货物编号</th><th>货物名称</th><th onclick="paixu(2)">货物数量</th><th onclick="func()">货物重量</th><th onclick="paixu(4)">货物价格</th>
		</tr>
	</thead>
	<tbody id="t1">
<%
if(recList!=null){
	for(int i=0;i<recList.size();i++){
		Rec dep=recList.recAt(i);
%>
		<tr>

			<td><% out.print(dep.get("pro_id")); %></td>
			<td><% out.print(dep.get("pro_name")); %></td>
		    <td><% out.print(dep.get("pro_num")); %></td>
			<td><% out.print(dep.get("pro_wei")); %></td>
			<td><% out.print(dep.get("pro_price")); %></td>

		</tr>
<%
	}

}

%>
	</tbody>

</table>
</form>
      <%-- 基本信息表 --%>
      </div>


    <%-- 标签页 --%>


<%-- 排序代码 --%>
	 <script type="text/javascript">
			// 1.获取所有的tr
			
			var oTr = document.querySelectorAll("#t1 tr");
			var flag = true;
			function paixu (idx) {
				
				
				if (flag){
				for (var i = 0; i < oTr.length; i++) {
					for (var j = 0; j < oTr.length-1-i; j++) {  //每次一次都会比出最大的值，放到最后，然后第二次数组长度减去1，再循环比一次
						if( Number(oTr[j].querySelectorAll("td")[idx].innerHTML)< Number(oTr[j+1].querySelectorAll("td")[idx].innerHTML)){
							var t = oTr[j+1].innerHTML;
							oTr[j+1].innerHTML = oTr[j].innerHTML;
							oTr[j].innerHTML = t;
						}
					}		
				}
				flag = false;
			}
			
			else{
				
					for (var i = 0; i < oTr.length; i++) {
						for (var j = 0; j < oTr.length-1-i; j++) {  //每次一次都会比出最大的值，放到最后，然后第二次数组长度减去1，再循环比一次
							if( Number(oTr[j].querySelectorAll("td")[idx].innerHTML)> Number(oTr[j+1].querySelectorAll("td")[idx].innerHTML)){
								var t = oTr[j+1].innerHTML;
								oTr[j+1].innerHTML = oTr[j].innerHTML;
								oTr[j].innerHTML = t;
							}
						}		
				
			flag = true;
			}
			}
			}
			function func() {
				for (var i = 0; i < oTr.length; i++) {
					for (var j = 0; j < oTr.length-1-i; j++) {  //每次一次都会比出最大的值，放到最后，然后第二次数组长度减去1，再循环比一次
						if( Number(oTr[j].querySelectorAll("td")[idx].innerHTML)< Number(oTr[j+1].querySelectorAll("td")[idx].innerHTML)){
							var t = oTr[j+1].innerHTML;
							oTr[j+1].innerHTML = oTr[j].innerHTML;
							oTr[j].innerHTML = t;
						}
					}		
				}
			}
			
		 </script>
<%-- 排序代码 --%>


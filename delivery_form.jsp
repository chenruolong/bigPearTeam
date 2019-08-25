<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="my.dao.*"  %>

<%
	String id = request.getParameter("pro_id");
	Rec dep = MyDao.queryOne("select * from pro_infor where pro_id=?", id);

%>    

                                <%-- 货物出库的弹出页面（填写出库单）--%>


<form>
  <h3>出库单</h3>
  
  <div class="form-group">
    <label for="pro_id">货物编号：</label>
    <input type="text" readonly="readonly"  class="form-control" id="pro_id" name="pro_id" value="<%=dep.get("pro_id") %>" >
  </div>      
  
  <div class="form-group">
    <label for="pro_name">货物名称：</label>
    <input type="text" readonly="readonly" class="form-control" id="pro_name" name="pro_name" value="<%=dep.get("pro_name") %>" >
  </div>   
  
  <div class="form-group">
    <label for="pro_wei">货物重量：</label>
    <input type="text" readonly="readonly"  class="form-control" id="pro_wei" name="pro_wei" value="<%=dep.get("pro_wei") %>" >
  </div>
  
   <div class="form-group">
    <label for="pro_price">货物价格：</label>
    <input type="text" readonly="readonly"  class="form-control" id="pro_price" name="pro_price" value="<%=dep.get("pro_price") %>" >
  </div>
  
  
  <div class="form-group">
    <label for="pro_num">出库数量：&nbsp;&nbsp;&nbsp;现库存数量(<%=dep.get("pro_num") %>)</label>
    <input type="text"  class="form-control" id="pro_num" name="pro_num" placeholder="<%=dep.get("pro_num") %>" >
  </div>
  
  <button type="submit" data-confirm="您确实要提交这条信息吗？" data-href="delivery_refresh.jsp" class="btn btn-default dq-click" data-succeed-click="#afterDoUpdSucceed"  >提交</button>
  <button type="button" onclick="dqClose();" class="btn btn-default">关闭</button>
  
  
  <div class="dq-click" data-href="delivery.jsp" id="afterDoUpdSucceed" ></div>

</form>

    
    
    
    
    
    
    
    
    
    
    
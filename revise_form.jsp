<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="my.dao.*"  %>

<%
	String id = request.getParameter("pro_id");
	Rec revise = MyDao.queryOne("select * from pro_infor where pro_id=?", id);

%>    

                                
                                                          <%-- 货物调价弹出页面--%>




<form>
  <h3>调价单</h3>
  
  <div class="form-group">
    <label for="pro_id">货物编号：</label>
    <input type="text" readonly="readonly"  class="form-control" id="pro_id" name="pro_id" value="<%=revise.get("pro_id") %>" >
  </div>      
  
  <div class="form-group">
    <label for="pro_name">货物名称：</label>
    <input type="text" readonly="readonly"  class="form-control" id="pro_name" name="pro_name" value="<%=revise.get("pro_name") %>" >
  </div>   
  
  
  
   <div class="form-group">
    <label for="pro_price">货物价格&nbsp;&nbsp;&nbsp;[当前价格(<%=revise.get("pro_price") %>)]</label>
    <input type="text" class="form-control" id="pro_price" name="pro_price" placeholder="请填写调整后的价格" >
  </div>
  
  
  
  <button type="submit" data-confirm="您确定调整该货物价格吗？" data-href="revise_refresh.jsp" class="btn btn-default dq-click" data-succeed-click="#afterDoUpdSucceed"  >确定</button>
  <button type="button" onclick="dqClose();" class="btn btn-default">取消</button>
  
  
  <div class="dq-click" data-href="revise.jsp" id="afterDoUpdSucceed" ></div>

</form>

    
    
    
    
    
    
    
    
    
    
    
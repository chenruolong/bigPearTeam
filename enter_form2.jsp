<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="my.dao.*"  %>



<style>
.enter{
	display:inline-block;
	position:relative;
	top:20px;
	left:calc(50% - 135px);
  	-webkit-box-shadow: rgba(0,0,0,.2) 0px 0px 30px;
  	-moz-box-shadow: rgba(0,0,0,.2) 0px 0px 30px;
  	box-shadow: rgba(0,0,0,.2) 0px 0px 30px;
}
</style>


<ol class="breadcrumb">
  	<li>库存管理</li>
  	<li class="active">货物入库</li>
</ol>
                                                     <!-- 填写新货物入库单-->





 <%


	String pro_id =  (String)session.getAttribute("pro_id");

	Rec dep = MyDao.queryOne("select * from pro_infor where pro_id=?", pro_id);


%>


<h3 style="position:relative; top:-20px;background-color:rgb(200, 198, 215); line-height:5px; padding:20px; margin:0;">入库单</h3>
<div style="position:relative; top:-10px;">
<div class="enter">

<form style="margin:10px;">


  <div class="form-group">
    <label for="pro_id">货物编号：</label>
    <input style="display:inline-block;" type="text" readonly="readonly" class="form-control" id="pro_id" name="pro_id" value="<%=session.getAttribute("pro_id") %>">

  </div>


  <div class="form-group">
    <label for="pro_name">货物名称：</label>
    <input style="display:inline-block;" type="text"  class="form-control" id="pro_name" name="pro_name" placeholder="请填写货物名称" >
  </div>

 <div class="form-group">
    <label for="pro_wei">货物重量：</label>
    <input style="display:inline-block;" type="text"  class="form-control" id="pro_wei" name="pro_wei" placeholder="例：50g" >
  </div>

 <div class="form-group">
    <label for="pro_price">货物价格：</label>
    <input style="display:inline-block;" type="text"  class="form-control" id="pro_price" name="pro_price" placeholder="例：4.00" >
  </div>


 <div class="form-group">
    <label for="enter_supply">供应商：</label>
    <input style="display:inline-block; " type="text" name="enter_supply"  class="form-control" placeholder="请填写供应商" >
  </div>



  <div class="form-group">
    <label style="display:block;" for="pro_num">入库数量&nbsp;&nbsp;&nbsp;</label>
    <input style="display:inline-block;" type="text" class="form-control" id="pro_num" name="pro_num" placeholder="请填写入库数量" >
  </div>


  <button style="position:relative;background-color:#fff; border:1px solid rgb(84, 65, 120);" type="button"  data-href="enter_refresh2.jsp" class="btn dq-click" data-succeed-click="#afterDoUpdSucceed"  >提交</button>


<div class="dq-click" data-href="enter.jsp" id="afterDoUpdSucceed" ></div>
</form>
</div>

</div>

<%@ page import="top.kernelpanic.entity.Country" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  ServletContext context=request.getServletContext();
  ArrayList<Country>countries=(ArrayList<Country>) context.getAttribute("countries");
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="utf-8">
  <meta http-equiv="x-ua-compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title>添加作者</title>
  <link rel="stylesheet" href="dist/css/bootstrap.min.css">
  <script src="dist/js/jquery.min.js"></script>
  <script src="dist/js/bootstrap.min.js"></script>
  <script src="js/authorvalidate.js"></script>
</head>
<body>
<div class="container">
  <form action="add?obj=author" method="post" class="form-horizontal">
    <div class="form-group">
      <label for="name" class="col-md-2 control-label">姓名:</label>
      <div class="col-md-2">
        <input type="text" name="name" class="form-control" id="name" placeholder="请输入作者姓名"/>
        <span id="name_msg">.</span>
      </div>
    </div>
    <div class="form-group">
      <label for="country" class="col-md-2 control-label">国家:</label>
      <div class="col-md-2">
        <select name="country_id" class="form-control" id="country">
        <%
          if(countries!=null&&countries.size()>0)
            for(Country country:countries){
        %>
        <option value="<%=country.getId()%>"><%=country%></option>
        <%
            }
        %>
        </select>
      </div>
    </div>
    <div class="form-group">
      <label for="age" class="col-md-2 control-label">年龄:</label>
      <div class="col-md-2">
        <input type="text" name="age" class="form-control" id="age" placeholder="请输入作者年龄"/>
        <span id="age_msg">.</span>
      </div>
    </div>
    <div class="form-group">
      <label for="info" class="col-md-2 control-label">作者简介:</label>
      <div class="col-md-6">
        <textarea name="info" rows="10" class="form-control" id="info" placeholder="请输入作者简介"></textarea>
      </div>
    </div>
    <div class="col-md-offset-4 col-md-4">
      <input type="reset" value="清空" class="btn btn-warning btn-lg col-md-offset-4 col-md-3"/>
      <input type="submit" value="提交" class="btn  btn-success btn-lg col-md-offset-1 col-md-3" id="sbm" disabled=""/>
    </div>
  </form>
</div>
</body>
</html>

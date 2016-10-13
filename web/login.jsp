<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="utf-8">
  <meta http-equiv="x-ua-compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title>登录页面</title>
  <link rel="stylesheet" href="dist/css/bootstrap.min.css">
  <script src="dist/js/bootstrap.min.js"></script>
  <script src="dist/js/jquery.min.js"></script>
</head>
<body>
<div class="container">
  <form action="<%=request.getContextPath()%>/login" method="post" class="form-horizontal">
    <div class="form-group">
      <label for="username" class="col-md-2 control-label">用户名:</label>
      <div class="col-md-2">
        <input type="text" name="username" class="form-control" id="username" placeholder="请输入用户名"/>
      </div>
    </div>
    <div class="form-group">
      <label for="password" class="col-md-2 control-label">密码:</label>
      <div class="col-md-2">
        <input type="password" name="password" class="form-control" id="password" placeholder="请输入密码"/>
      </div>
    </div>
    <button type="submit" class="btn btn-success col-md-offset-2">登录</button>
  </form>
</div>
</body>
</html>

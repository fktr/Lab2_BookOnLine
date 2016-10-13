<%@ page import="java.util.ArrayList" %>
<%@ page import="top.kernelpanic.entity.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  ArrayList<User>userList=(ArrayList<User>) request.getServletContext().getAttribute("userList");
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="utf-8">
  <meta http-equiv="x-ua-compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title>日志信息</title>
  <link rel="stylesheet" href="dist/css/bootstrap.min.css">
  <script src="dist/js/bootstrap.min.js"></script>
  <script src="dist/js/jquery.min.js"></script>
</head>
<body>
<div class="container">
  <h1>当前在线人数:<%=request.getServletContext().getAttribute("userNumber")%></h1>
  <table class="table table-hover" border="1">
    <thead>
    <td>用户ID</td><td>用户IP</td><td>首次登录时间</td><td>用户最近一次登录时间</td><td>SessionID</td><td>用户收藏夹</td>
    </thead>
    <%
      if(userList!=null&&userList.size()>0)
        for(User user:userList){
    %>
    <tr>
      <td><%=user.getId()%></td>
      <td><%=user.getIp()%></td>
      <td><%=user.getFirstTime()%></td>
      <td><%=user.getLastTime()%></td>
      <td><%=user.getSessionID()%></td>
      <td><a href="<%=request.getContextPath()%>/mybook?from=admin&id=<%=user.getId()%>" class="btn btn-success">Go</a></td>
    </tr>
    <%
        }
    %>
  </table>
</div>
</body>
</html>

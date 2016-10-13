<%@ page import="top.kernelpanic.entity.User" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="top.kernelpanic.entity.Book" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="top.kernelpanic.entity.Author" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  User user=(User)request.getAttribute("user");
  user.setLastTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
  HashSet<Book>booksForUser=user.getFavorites();
  ServletContext context=request.getServletContext();
  HashMap<Integer,Author>authorMap=(HashMap<Integer, Author>) context.getAttribute("authorMap");
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="utf-8">
  <meta http-equiv="x-ua-compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title>收藏夹</title>
  <link rel="stylesheet" href="dist/css/bootstrap.min.css">
  <script src="dist/js/bootstrap.min.js"></script>
  <script src="dist/js/jquery.min.js"></script>
  <style type="text/css">
    .sm_img{
      width:60px;
      height:80px;
    }
  </style>
</head>
<body>
<div class="container">
  <h1>欢迎！您是本站第<%=user.getId()%>位游客!</h1>
  <p>您首次光临时间:<%=user.getFirstTime()%></p>
  <p>您最近一次光临时间:<%=user.getLastTime()%></p>
  <h2>您的收藏夹:</h2>
  <table class="table table-hover" border="1">
    <thead>
    <td>图片</td><td>书名</td><td>ISBN</td><td>作者</td><td>移除</td>
    </thead>
    <%
      if(booksForUser!=null&&booksForUser.size()>0)
        for(Book book:booksForUser){
        if(book!=null){
    %>
    <tr>
      <td><img class="sm_img" src="images/<%=book.getImage()%>"/></td>
      <td><a href="<%=request.getContextPath()%>/detail?obj=book&prm=<%=book.getIsbn()%>"><%=book%></a></td>
      <td><%=book.getIsbn()%></td>
      <td><a href="<%=request.getContextPath()%>/detail?obj=author&prm=<%=book.getAuthor_id()%>"><%=authorMap.get(book.getAuthor_id())%></a></td>
      <td><a href="<%=request.getContextPath()%>/remove?prm=<%=book.getIsbn()%>" class="btn btn-warning">移除</a><button class="btn btn-primary" onclick="location.reload()">刷新</button></td>
    </tr>
    <%
          }
        }
    %>
  </table>
</div>
</body>
</html>

<%@ page import="top.kernelpanic.entity.Author" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="top.kernelpanic.entity.Country" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  ServletContext context=request.getServletContext();
  Author author=(Author)request.getAttribute("author");
  HashMap<Integer,Country>countryMap=(HashMap<Integer,Country>)context.getAttribute("countryMap");
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="utf-8">
  <meta http-equiv="x-ua-compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title>作者详情</title>
  <link rel="stylesheet" href="dist/css/bootstrap.min.css">
  <script src="dist/js/bootstrap.min.js"></script>
  <script src="dist/js/jquery.min.js"></script>
</head>
<body>
<div class="container">
    <div>
    <%
      if(author!=null){
    %>
    <h1><%=author%></h1>
    <p>国家:<%=countryMap.get(author.getCountry_id())%></p>
    <p>年龄:<%=author.getAge()%></p>
    <h1>作者简介:</h1>
    <p><%=author.getInfo()%></p>
    <%
      }
    %>
  </div>
  <div>
    <a href="<%=request.getContextPath()%>/add?obj=author" class="btn btn-primary btn-lg">增加作者</a>
    <a href="<%=request.getContextPath()%>/update?obj=author&prm=<%=author.getId()%>" class="btn btn-success btn-lg">我要纠错</a>
    <a href="<%=request.getContextPath()%>/delete?obj=author&prm=<%=author.getId()%>" class="btn btn-danger btn-lg">不要乱删</a>
  </div>
</div>
</body>
</html>

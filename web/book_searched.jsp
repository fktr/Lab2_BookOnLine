<%@ page import="java.util.ArrayList" %>
<%@ page import="top.kernelpanic.entity.Book" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="top.kernelpanic.entity.Author" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  ServletContext context=request.getServletContext();
  HashMap<Integer,Author>authorMap=(HashMap<Integer, Author>) context.getAttribute("authorMap");
  ArrayList<Book>booksSearched=(ArrayList<Book>) request.getAttribute("booksSearched");
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="utf-8">
  <meta http-equiv="x-ua-compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title>搜索结果</title>
  <link rel="stylesheet" href="dist/css/bootstrap.min.css">
  <script src="dist/js/bootstrap.min.js"></script>
  <script src="dist/js/jquery.min.js"></script>
</head>
<body>
<div class="container">
  <div>
    <table class="table table-hover" border="1">
      <thead>
      <td>书名</td><td>ISBN</td><td>作者</td>
      </thead>
      <%
        if(booksSearched!=null&&booksSearched.size()>0)
          for(Book book:booksSearched){
      %>
      <tr>
        <td><a href="<%=request.getContextPath()%>/detail?obj=book&prm=<%=book.getIsbn()%>"><%=book%></a></td>
        <td><%=book.getIsbn()%></td>
        <td><a href="<%=request.getContextPath()%>/detail?obj=author&prm=<%=book.getAuthor_id()%>"><%=authorMap.get(book.getAuthor_id())%></a></td>
      </tr>
      <%
        }
      %>
  </div>
  </div>
</div>
</body>
</html>

<%@ page import="java.util.ArrayList" %>
<%@ page import="top.kernelpanic.entity.Book" %>
<%@ page import="top.kernelpanic.entity.Author" %>
<%@ page import="java.util.HashMap" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  ServletContext context=request.getServletContext();
  ArrayList<Book>books=(ArrayList<Book>)context.getAttribute("books");
  ArrayList<Book>booksPerPage=(ArrayList<Book>)request.getAttribute("booksPerPage");
  HashMap<Integer,Author>authorMap=(HashMap<Integer,Author>)context.getAttribute("authorMap");
  int pages=books.size()/25+1;
  int curPage;
  if(request.getParameter("page")==null)
    curPage=1;
  else
    curPage=Integer.parseInt(request.getParameter("page"));
%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>首页</title>
    <link rel="stylesheet" href="dist/css/bootstrap.min.css">
    <script src="dist/js/jquery.min.js"></script>
    <script src="dist/js/bootstrap.min.js"></script>
    <style type="text/css">
      .book{
        float:left;
        margin:6px;
        width:200px;
        height:400px;
      }
      img{
        height:146px;
        width:101px;
      }
      #pages{
        clear: both;
      }
      #main{
        margin-top:60px;
      }
      #search{
        display: block;
        width:600px;
        float:left;
        margin-right:10px;
      }
    </style>
  </head>
  <body>
  <div class="container">
    <nav class="navbar navbar-inverse navbar-fixed-top">
      <div class="col-md-offset-3">
        <form class="navbar-form" method="get" action="<%=request.getContextPath()%>/search">
          <input id="search" class="form-control" type="text" name='search' placeholder="书名、作者、ISBN">
          <button class="btn btn-success" type="submit">搜索</button>
        </form>
      </div>
    </nav>
    <div id="main">
      <%
        if(booksPerPage!=null&&booksPerPage.size()>0)
          for(Book book:booksPerPage){
      %>
      <div class="book">
        <p>
          <a href="<%=request.getContextPath()%>/detail?obj=book&prm=<%=book.getIsbn()%>">
            <p><img src="images/<%=book.getImage()%>"/></p>
            <p><%=book%></p>
          </a>
        </p>
        <p>作者:
          <a href="<%=request.getContextPath()%>/detail?obj=author&prm=<%=book.getAuthor_id()%>"><%=authorMap.get(book.getAuthor_id())%></a>
        </p>
        <p>价格:<%=book.getPrice()%></p>
        <p>ISBN:<%=book.getIsbn()%></p>
        <p>出版社:<%=book.getPublisher()%></p>
        <p>出版日期:<%=book.getPublish_date()%></p>
      </div>
      <%
          }
      %>
    </div>
    <div id="pages" class="col-md-offset-3 col-md-6">
      <nav>
        <ul class="pagination">
          <li><a href="index?page=<%=curPage-1%>">&laquo;</a></li>
          <%
            for(int i=1;i<=pages;i++){
              if(curPage==i){
          %>
          <li class="active"><a href="index?page=<%=i%>"><%=i%></a></li>
          <%
              }else{
          %>
          <li><a href="index?page=<%=i%>"><%=i%></a></li>
          <%
              }
            }
          %>
          <li><a href="index?page=<%=curPage+1%>">&raquo;</a></li>
        </ul>
      </nav>
    </div>
  </div>
  </body>
</html>

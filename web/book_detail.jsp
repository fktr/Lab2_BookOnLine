<%@ page import="top.kernelpanic.entity.Book" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="top.kernelpanic.entity.Author" %>
<%@ page import="top.kernelpanic.entity.Country" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  ServletContext context=request.getServletContext();
  Book book=(Book)request.getAttribute("book");
  HashMap<Integer,Author>authorMap=(HashMap<Integer,Author>)context.getAttribute("authorMap");
  HashMap<Integer,Country>countryMap=(HashMap<Integer,Country>)context.getAttribute("countryMap");
  ArrayList<Book>booksHistoryView=(ArrayList<Book>) request.getAttribute("booksHistoryView");
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="utf-8">
  <meta http-equiv="x-ua-compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title>书籍详情</title>
  <link rel="stylesheet" href="dist/css/bootstrap.min.css">
  <script src="dist/js/jquery.min.js"></script>
  <script src="dist/js/bootstrap.min.js"></script>
  <style type="text/css">
    .lg_img{
      width:303px;
      height:438px;
    }
    .oldbook{
      float: left;
      margin:6px;
      width:120px;
      height:240px;
    }
    .md_img{
      width:106px;
      height:158px;
    }
  </style>
</head>
<body>
<div class="container">
  <%
    if(book!=null){
  %>
  <div>
    <div class="col-md-7">
      <h1><%=book%></h1>
      <% Author author=authorMap.get(book.getAuthor_id());%>
      <p>作者:
        <a href="<%=request.getContextPath()%>/detail?obj=author&prm=<%=book.getAuthor_id()%>">
          [<%=countryMap.get(author.getCountry_id())%>]<%=author%>
        </a>
      </p>
      <p>价格:<%=book.getPrice()%></p>
      <p>页数:<%=book.getPage_num()%></p>
      <p>豆瓣评分:<%=book.getScore()%></p>
      <p>评分人数:<%=book.getReader_num()%></p>
      <p>ISBN:<%=book.getIsbn()%></p>
      <p>出版社:<%=book.getPublisher()%></p>
      <p>出版日期:<%=book.getPublish_date()%></p>
      <h1>内容简介:</h1>
      <p><%=book.getInfo()%></p>
      <div>
        <a href="<%=request.getContextPath()%>/collect?prm=<%=book.getIsbn()%>" class="btn btn-primary btn-lg">收藏起来</a>
        <a href="<%=request.getContextPath()%>/mybook" class="btn btn-primary btn-lg">显示收藏</a>
        <a href="<%=request.getContextPath()%>/add?obj=book" class="btn btn-primary btn-lg">增加图书</a>
        <a href="<%=request.getContextPath()%>/update?obj=book&prm=<%=book.getIsbn()%>" class="btn btn-success btn-lg">我要纠错</a>
        <a href="<%=request.getContextPath()%>/delete?obj=book&prm=<%=book.getIsbn()%>" class="btn btn-danger btn-lg">不要乱删</a>
      </div>
    </div>
    <div class="col-md-5">
      <div>
        <img class="lg_img" src="images/<%=book.getImage()%>"/>
      </div>
      <h1>您最近关注的书籍:</h1>
      <%
        if(booksHistoryView!=null&&booksHistoryView.size()>0)
          for(Book oldBook:booksHistoryView){
      %>
      <div class="oldbook">
        <p>
          <a href="<%=request.getContextPath()%>/detail?obj=book&prm=<%=oldBook.getIsbn()%>">
            <img class="md_img" src="images/<%=oldBook.getImage()%>"/><br>
            <span>&nbsp;&nbsp;&nbsp;<%=oldBook%></span>
          </a>
        </p>
        <p>作者:<a href="<%=request.getContextPath()%>/detail?obj=author&prm=<%=oldBook.getAuthor_id()%>"><%=authorMap.get(oldBook.getAuthor_id())%></a></p>
      </div>
      <%
          }
      %>
    </div>
  </div>
  <%
    }
  %>
</div>
</body>
</html>

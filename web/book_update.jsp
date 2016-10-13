<%@ page import="top.kernelpanic.entity.Book" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="top.kernelpanic.entity.Author" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  ServletContext context=request.getServletContext();
  ArrayList<Author>authors=(ArrayList<Author>) context.getAttribute("authors");
  Book book=(Book)request.getAttribute("book");
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="utf-8">
  <meta http-equiv="x-ua-compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title>修改书籍信息</title>
  <link rel="stylesheet" href="dist/css/bootstrap.min.css">
  <script src="dist/js/jquery.min.js"></script>
  <script src="dist/js/bootstrap.min.js"></script>
  <script src="js/bookvalidate.js"></script>
  <style type="text/css">
    img{
      width:107px;
      height:155px;
    }
  </style>
</head>
<body>
<div class="container">
  <form  action="update?obj=book&prm=<%=book.getIsbn()%>" method="post" class="form-horizontal">
    <div class="form-group">
      <label for="title" class="col-md-2 control-label">书名:</label>
      <div class="col-md-2">
        <input type="text" name="title" class="form-control" id="title" value="<%=book%>"/>
        <span id="title_msg"></span>
      </div>
    </div>
    <div class="form-group">
      <label for="author" class="col-md-2 control-label">作者</label>
      <div class="col-md-2">
        <select name="author_id" class="form-control" id="author">
          <%
            if(authors!=null&&authors.size()>0)
              for(Author author:authors){
                if(author.getId()==book.getAuthor_id()){
          %>
          <option value="<%=author.getId()%>" selected="selected"><%=author%></option>
          <%
          }else{
          %>
          <option value="<%=author.getId()%>"><%=author%></option>
          <%
                }
              }
          %>
        </select>
      </div>
    </div>
    <div class="form-group">
      <label for="price" class="col-md-2 control-label">价格:</label>
      <div class="col-md-2">
        <input type="text" name="price" class="form-control" id="price"value="<%=book.getPrice()%>"/>
        <span id="price_msg"></span>
      </div>
    </div>
    <div class="form-group">
      <label for="page_num" class="col-md-2 control-label">页数:</label>
      <div class="col-md-2">
        <input type="text" name="page_num" class="form-control" id="page_num" value="<%=book.getPage_num()%>"/>
      </div>
    </div>
    <div class="form-group">
      <label for="score" class="col-md-2 control-label">豆瓣评分:</label>
      <div class="col-md-2">
        <input type="text" name="score" class="form-control" id="score" value="<%=book.getScore()%>"/>
      </div>
    </div>
    <div class="form-group">
      <label for="reader_num" class="col-md-2 control-label">评价人数:</label>
      <div class="col-md-2">
        <input type="text" name="reader_num" class="form-control" id="reader_num" value="<%=book.getReader_num()%>"/>
      </div>
    </div>
    <div class="form-group">
      <label for="isbn" class="col-md-2 control-label">ISBN:</label>
      <div class="col-md-2">
        <input type="text"name="isbn" class="form-control" id="isbn" value="<%=book.getIsbn()%>"/>
        <span id="isbn_msg"></span>
      </div>
    </div>
    <div class="form-group">
      <label for="publisher" class="col-md-2 control-label">出版社:</label>
      <div class="col-md-2">
        <input type="text" name="publisher" class="form-control" id="publisher" value="<%=book.getPublisher()%>"/>
      </div>
    </div>
    <div class="form-group">
      <label for="publish_date" class="col-md-2 control-label">出版日期:</label>
      <div class="col-md-2">
        <input type="date" name="publish_date" class="form-control" id="publish_date" value="<%=book.getPublish_date()%>"/>
      </div>
    </div>
    <div class="form-group">
      <label for="image" class="col-md-2 control-label">图片:</label>
      <div class="col-md-2">
        <img src="images/<%=book.getImage()%>"/>
        <input type="file" name="image" class="form-control" id="image" disabled/>
      </div>
    </div>
    <div class="form-group">
      <label for="info" class="col-md-2 control-label">书籍信息:</label>
      <div class="col-md-6">
        <textarea name="info" rows="10" class="form-control" id="info"><%=book.getInfo()%></textarea>
      </div>
    </div>
    <div class="col-md-offset-4 col-md-4">
      <input type="reset" value="复原" class="btn btn-warning btn-lg col-md-offset-4 col-md-3"/>
      <input type="submit" value="提交" class="btn  btn-success btn-lg col-md-offset-1 col-md-3" id="sbm" disabled="" />
    </div>
  </form>
</div>
</body>
</html>

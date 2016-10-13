<%@ page import="java.util.ArrayList" %>
<%@ page import="top.kernelpanic.entity.Author" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  ServletContext context=request.getServletContext();
  ArrayList<Author>authors=(ArrayList<Author>) context.getAttribute("authors");
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="utf-8">
  <meta http-equiv="x-ua-compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title>添加书籍</title>
  <link rel="stylesheet" href="dist/css/bootstrap.min.css">
  <script src="dist/js/jquery.min.js"></script>
  <script src="dist/js/bootstrap.min.js"></script>
  <script src="js/bookvalidate.js"></script>
</head>
<body>
<div class="container">
  <form action="add?obj=book" method="post" class="form-horizontal">
    <div class="form-group">
      <label for="title" class="col-md-2 control-label">书名:</label>
      <div class="col-md-2">
        <input type="text" name="title" class="form-control" id="title" placeholder="请输入书名"/>
        <span id="title_msg">.</span>
      </div>
    </div>
    <div class="form-group">
      <label for="author" class="col-md-2 control-label">作者</label>
      <div class="col-md-2">
        <select name="author_id" class="form-control" id="author">
          <%
            if(authors!=null&&authors.size()>0)
              for(Author author:authors){
          %>
          <option value="<%=author.getId()%>"><%=author%></option>
          <%
              }
          %>
        </select>
      </div>
    </div>
    <div class="form-group">
      <label for="price" class="col-md-2 control-label">价格:</label>
      <div class="col-md-2">
        <input type="text" name="price" class="form-control" id="price" placeholder="请输入价格"/>
        <span id="price_msg">.</span>
      </div>
    </div>
    <div class="form-group">
      <label for="page_num" class="col-md-2 control-label">页数:</label>
      <div class="col-md-2">
        <input type="text" name="page_num" class="form-control" id="page_num" placeholder="请输入页数"/>
      </div>
    </div>
    <div class="form-group">
      <label for="score" class="col-md-2 control-label">豆瓣评分:</label>
      <div class="col-md-2">
        <input type="text" name="score" class="form-control" id="score" placeholder="请输入评分"/>
      </div>
    </div>
    <div class="form-group">
      <label for="reader_num" class="col-md-2 control-label">评价人数:</label>
      <div class="col-md-2">
        <input type="text" name="reader_num" class="form-control" id="reader_num" placeholder="请输入评价人数"/>
      </div>
    </div>
    <div class="form-group">
      <label for="isbn" class="col-md-2 control-label">ISBN:</label>
      <div class="col-md-2">
        <input type="text"name="isbn" class="form-control" id="isbn" placeholder="请输入ISBN号"/>
        <span id="isbn_msg">.</span>
      </div>
    </div>
    <div class="form-group">
      <label for="publisher" class="col-md-2 control-label">出版社:</label>
      <div class="col-md-2">
        <input type="text" name="publisher" class="form-control" id="publisher" placeholder="请输入出版社名称"/>
      </div>
    </div>
    <div class="form-group">
      <label for="publish_date" class="col-md-2 control-label">出版日期:</label>
      <div class="col-md-2">
        <input type="date" name="publish_date" class="form-control" id="publish_date" placeholder="请输入出版日期"/>
      </div>
    </div>
    <div class="form-group">
      <label for="image" class="col-md-2 control-label">图片:</label>
      <div class="col-md-2">
        <input type="file" name="image" class="form-control" id="image" disabled/>
      </div>
    </div>
    <div class="form-group">
      <label for="info" class="col-md-2 control-label">书籍信息:</label>
      <div class="col-md-6">
        <textarea name="info" rows="10" class="form-control" id="info" placeholder="请输入书籍信息"></textarea>
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

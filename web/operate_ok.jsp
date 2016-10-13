<%@ page import="java.util.Locale" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String uri=(String)request.getAttribute("uri");
%>
<html>
<head>
  <title>操作成功</title>
</head>
<body>
<h1>操作成功!</h1>
<h2><span id="timeleft"></span>秒返回!</h2>
<script>
  var i=3;
  function jmpBack() {
    if(i==0){
      <%if(uri!=null){%>
      location.href="<%=request.getContextPath()%>/<%=uri%>";
      <%}else{%>
      history.back();
      <%}%>
    }
    document.getElementById("timeleft").innerHTML=i--;
    setTimeout("jmpBack()",1000);
  }
  jmpBack();
</script>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title>出现错误</title>
  <style type="text/css">
    div{
      text-align: center;
      margin-top:30px;
    }
    #chess{
      box-shadow: -2px -2px 2px #EFEFEF,5px 5px 5px #B9B9B9;
    }
  </style>
</head>
<body>
<div>
  <p>额,对不起,出错了...</p>
  <button onclick="back()">点我返回首页!</button>
  <p>或者留下来陪我玩会游戏吧!</p>
</div>
<script>
  function back() {
    location.href="<%=request.getContextPath()%>/index";
  }
  function refresh() {
    location.reload();
  }
</script>
<div>
  <canvas id="clock" width="200px" height="200px"></canvas>
</div>
<div>
  <canvas id="chess" width="450px" height="450px"></canvas>
</div>
<div>
  <button onclick="refresh()">再来一局</button>
</div>
<script src="js/funnygame.js"></script>
</body>
</html>

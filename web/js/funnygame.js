var dom=document.getElementById("clock");
var ctx=dom.getContext("2d");
var width=ctx.canvas.width;
var height=ctx.canvas.height;
var r=width/2;
function drawBackground() {
    ctx.save();
    ctx.translate(r,r);
    ctx.beginPath();
    ctx.lineWidth=10;
    ctx.arc(0,0,r-5,0,2*Math.PI,false);
    ctx.stroke();

    var hourNumbers=[3,4,5,6,7,8,9,10,11,12,1,2];
    ctx.font='18px Arial';
    ctx.textAlign='center';
    ctx.textBaseline='middle';
    hourNumbers.forEach(function (number,i) {
        var rad=2*Math.PI/12*i;
        var x=Math.cos(rad)*(r-30);
        var y=Math.sin(rad)*(r-30);
        ctx.fillText(number,x,y);
    });

    for(var i=0;i<60;i++){
        var rad=2*Math.PI/60*i;
        var x=Math.cos(rad)*(r-18);
        var y=Math.sin(rad)*(r-18);
        ctx.beginPath();
        if(i%5===0){
            ctx.fillStyle="#000";
            ctx.arc(x,y,2,0,2*Math.PI,false);
        }else{
            ctx.fillStyle="#ccc";
            ctx.arc(x,y,2,0,2*Math.PI,false);
        }
        ctx.fill();
    }
}
function drawHour(hour,minute){
    ctx.save();
    ctx.beginPath();
    var rad=2*Math.PI/12*hour;
    var mrad=2*Math.PI/12/60*minute;
    ctx.rotate(rad+mrad);
    ctx.lineWidth=6;
    ctx.lineCap="round";
    ctx.moveTo(0,10);
    ctx.lineTo(0,-r/2);
    ctx.stroke();
    ctx.restore();
}
function drawMinute(minute){
    ctx.save();
    ctx.beginPath();
    var rad=2*Math.PI/60*minute;
    ctx.rotate(rad);
    ctx.lineWidth=3;
    ctx.lineCap="round";
    ctx.moveTo(0,10);
    ctx.lineTo(0,-r+30);
    ctx.stroke();
    ctx.restore();
}
function drawSecond(second) {
    ctx.save();
    ctx.beginPath();
    ctx.fillStyle="#c14543";
    var rad=2*Math.PI/60*second;;
    ctx.rotate(rad);
    ctx.moveTo(-2,20);
    ctx.lineTo(2,20);
    ctx.lineTo(1,-r+18);
    ctx.lineTo(1,-r+18);
    ctx.fill();
    ctx.restore();
}
function drawDot(){
    ctx.beginPath();
    ctx.fillStyle="#fff";
    ctx.arc(0,0,3,0,2*Math.PI,false);
    ctx.fill();
}
function draw() {
    ctx.clearRect(0,0,width,height);
    var now=new Date();
    var hour=now.getHours();
    var minute=now.getMinutes();
    var second=now.getSeconds();
    drawBackground();
    drawHour(hour,minute);
    drawMinute(minute);
    drawSecond(second);
    drawDot();
    ctx.restore();
}
setInterval(draw,1000);

var chess=document.getElementById('chess');
var context=chess.getContext("2d");
context.strokeStyle="#000";
var chessBoard=[];
var me=true;
var wins=[];
var count=0;
var myWin=[];
var computerWin=[];
var over=false;
var logo=new Image();
var drawChessBoard=function () {
    for (var i = 0; i < 15; i++) {
        context.moveTo(15, 15 + i * 30);
        context.lineTo(435, 15 + i * 30);
        context.stroke();
        context.moveTo(15 + i * 30, 15);
        context.lineTo(15 + i * 30, 435);
        context.stroke();
    }
}
logo.src="images/one.jpg";
logo.onload=function () {
    context.drawImage(logo,0,0,450,450);
    drawChessBoard();
}
var oneStep=function (i,j,me) {
    context.beginPath();
    context.arc(15+i*30,15+j*30,13,0,2*Math.PI);
    context.closePath();
    var gradient=context.createRadialGradient(15+i*30+2,15+j*30-2,13,15+i*30+2,15+j*30-2,0);
    if(me) {
        gradient.addColorStop(0, "#0A0A0A");
        gradient.addColorStop(1, "#636766");
    }else{
        gradient.addColorStop(0,"#D1D1D1");
        gradient.addColorStop(1,"#F9F9F9");
    }
    context.fillStyle=gradient;
    context.fill();
}
for(var i=0;i<15;i++){
    chessBoard[i]=[];
    for(var j=0;j<15;j++)
        chessBoard[i][j]=0;
}
for(var i=0;i<15;i++){
    wins[i]=[];
    for(var j=0;j<15;j++){
        wins[i][j]=[];
    }
}
for(var i=0;i<15;i++){
    for(var j=0;j<11;j++){
        for(var k=0;k<5;k++){
            wins[i][j+k][count]=true;
        }
        count++;
    }
}
for(var i=0;i<15;i++){
    for(var j=0;j<11;j++){
        for(var k=0;k<5;k++){
            wins[j+k][i][count]=true;
        }
        count++;
    }
}
for(var i=0;i<11;i++){
    for(var j=0;j<11;j++){
        for(var k=0;k<5;k++){
            wins[i+k][j+k][count]=true;
        }
        count++;
    }
}
for(var i=0;i<11;i++){
    for(var j=14;j>3;j--){
        for(var k=0;k<5;k++){
            wins[i+k][j-k][count]=true;
        }
        count++;
    }
}
for(var i=0;i<count;i++){
    myWin[i]=0;
    computerWin[i]=0;
}

chess.onclick=function (e) {
    if(over)
        return;
    if(!me)
        return;
    var x=e.offsetX;
    var y=e.offsetY;
    var i=Math.floor(x/30);
    var j=Math.floor(y/30);
    if(chessBoard[i][j]==0){
        oneStep(i,j,me);
        chessBoard[i][j]=1;
        for(var k=0;k<count;k++){
            if(wins[i][j][k]){
                myWin[k]++;
                computerWin[k]=6;
                if(myWin[k]==5){
                    alert("恭喜你,你赢了!");
                    over=true;
                }
            }
        }
        if(!over){
            me=!me;
            computerAI();
        }
    }
}

var computerAI=function () {
    var myScore=[];
    var computerScore=[];
    var max=0;
    var u=0,v=0;

    for(var i=0;i<15;i++){
        myScore[i]=[];
        computerScore[i]=[];
        for(var j=0;j<15;j++){
            myScore[i][j]=0;
            computerScore[i][j]=0;
        }
    }

    for(var i=0;i<15;i++){
        for(var j=0;j<15;j++){
            if(chessBoard[i][j]==0){
                for(var k=0;k<count;k++){
                    if(wins[i][j][k]){
                        if(myWin[k]==1){
                            myScore[i][j]+=2;
                        }else if(myWin[k]==2){
                            myScore[i][j]+=4;
                        }else if(myWin[k]==3){
                            myScore[i][j]+=20;
                        }else if(myWin[i][j]==4){
                            myScore[i][j]+=10000;
                        }

                        if(computerWin[k]==1){
                            computerScore[i][j]+=2;
                        }else if(computerWin[k]==2){
                            computerScore[i][j]+=4;
                        }else if(computerWin[k]==3){
                            computerScore[i][j]+=10;
                        }else if(computerWin[k]==4){
                            computerScore[i][j]+=10000;
                        }
                    }
                }
                var scores=10*myScore[i][j]+computerScore[i][j];
                if(scores>max){
                    max=scores;
                    u=i;
                    v=j;
                }
   /*             if(myScore[i][j]>max){
                    max=myScore[i][j];
                    u=i;
                    v=j;
                }else if(myScore[i][j]==max){
                    if(computerScore[i][j]>computerScore[u][v]){
                        u=i;
                        v=j;
                    }
                }
                if(computerScore[i][j]>max){
                    max=computerScore[i][j];
                    u=i;
                    v=j;
                }else if(computerScore[i][j]==max){
                    if(myScore[i][j]>myScore[u][v]){
                        u=i;
                        v=j;
                    }
                }*/
            }
        }
    }
    oneStep(u,v,false);
    chessBoard[u][v]=2;
    for(var k=0;k<count;k++){
        if(wins[u][v][k]){
            computerWin[k]++;
            myWin[k]=6;
            if(computerWin[k]==5){
                alert("不好意思,计算机赢了");
                over=true;
            }
        }
    }
    if(!over)
        me=!me;
}

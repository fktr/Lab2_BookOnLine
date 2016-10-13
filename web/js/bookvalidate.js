window.onload=function () {
    var title=document.getElementById("title");
    var price=document.getElementById("price");
    var page_num=document.getElementById("page_num");
    var score=document.getElementById("score");
    var reader_num=document.getElementById("reader_num");
    var isbn=document.getElementById("isbn");
    var publisher=document.getElementById("publisher");
    var title_msg=document.getElementById("title_msg");
    var price_msg=document.getElementById("price_msg");
    var isbn_msg=document.getElementById("isbn_msg");
    var submit=document.getElementById("sbm");

    publisher.onblur=function () {
        if(this.value!=""){
            var re=/[^a-zA-Z·\u4e00\u9fa5]/g;
            if(re.test(this.value))
                this.value="未知";
        }else
            this.value="未知";
    }
    reader_num.onblur=function () {
        if(this.value!=""){
            var re=/[^0-9]/g;
            if(re.test(this.value))
                this.value="0";
        }else
            this.value="0";
    }
    score.onblur=function () {
        if(this.value!=""){
            var re=/[^0-9.]/g;
            if(re.test(this.value))
                this.value="0";
        }else
            this.value="0";
    }
    page_num.onblur=function () {
        if(this.value!=""){
            var re=/[^0-9]/g;
            if(re.test(this.value))
                this.value="0";
        }else
            this.value="0";
    }
    function check() {
        if(title_msg.innerHTML.length!=0||price_msg.innerHTML.length!=0||isbn_msg.innerHTML.length!=0)
            submit.disabled="disabled";
        else
            submit.disabled="";
    }
    title.onfocus=function () {
        title_msg.innerHTML="";
    }
    title.onblur=function () {
        var re=/[^a-zA-z·\u4e00-\u9fa5]/g;
        if(re.test(this.value))
            title_msg.innerHTML="含有非法字符!";
        else if(this.value=="")
            title_msg.innerHTML="此为必填字段!";
        check();
    }
    price.onfocus=function () {
        price_msg.innerHTML="";
    }
    price.onblur=function () {
        var re = /[^0-9.]/g;
        if (re.test(this.value))
            price_msg.innerHTML = "内容非法,仅限浮点数!";
        else if(this.value=="")
            price_msg.innerHTML="此为必填字段!";
        check();
    }
    isbn.onfocus=function () {
        isbn_msg.innerHTML="";
    }
    isbn.onblur=function () {
        var re=/[^0-9]/g;
        if(re.test(this.value))
            isbn_msg.innerHTML="字符非法!";
        else if(this.value=="")
            isbn_msg.innerHTML="此为必填字段!";
        else if(this.value.length!=13)
            isbn_msg.innerHTML="字段长度不匹配!";
        check();
    }
}

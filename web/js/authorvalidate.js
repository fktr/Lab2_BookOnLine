window.onload=function () {
    var name=document.getElementById("name");
    var age=document.getElementById("age");
    var name_msg=document.getElementById("name_msg");
    var age_msg=document.getElementById("age_msg");
    var submit=document.getElementById("sbm");

    function check() {
        if (name_msg.innerHTML.length != 0 || age_msg.innerHTML.length != 0)
            submit.disabled = "disabled";
        else
            submit.disabled = "";
    }

    name.onfocus=function () {
        name_msg.innerHTML="";
    }

    name.onblur=function () {
        var re=/[^a-zA-Z·\u4e00-\u9fa5]/g;
        if(re.test(this.value)){
            name_msg.innerHTML="含有非法字符!";
        }else if(this.value=="") {
            name_msg.innerHTML = "此为必填字段!";
        }
        check();
    }

    age.onfocus=function () {
        age_msg.innerHTML="";
    }

    age.onblur=function () {
        if(this.value==""){
            this.value="0";
        }
        var re=/[^0-9]/g;
        if(re.test(this.value)) {
            age_msg.innerHTML = "年龄不合法!";
        }
        check();
    }
}

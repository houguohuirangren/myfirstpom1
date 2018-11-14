<%--
  Created by IntelliJ IDEA.
  User: LWW
  Date: 2018/11/7
  Time: 20:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <base href="${pageContext.request.contextPath}/"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>注册</title>

    <!-- jQuery -->
    <script type="text/javascript"
            src="resources/scripts/jquery-1.8.3.min.js"></script>
    <%--引入表单验证插件--%>
    <script src="/resources/widget/check/dist/jquery.validate.min.js"></script>
    <script src="/resources/widget/check/dist/localization/messages_zh.js"></script>

    <!-- 时间日期插件 -->
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/resources/widget/My97DatePicker/WdatePicker.js"></script>
    <script>
        $().ready(function () {
// 在键盘按下并释放及提交后验证提交表单
            $("#empform").validate({
                rules: {
                    phone:"required",
                    name: {
                        required: true,
                        minlength: 2
                    },
                    password: {
                        required: true,
                        minlength: 5
                    },
                    confirm_password: {
                        required: true,
                        minlength: 5,
                        equalTo: "#password"
                    },
                    email: {
                        required: true,
                        email: true
                    },
                },
                messages: {
                    phone:"请输入电话号码",
                    name: {
                        required: "请输入用户名",
                        minlength: "用户名必需由两个字母组成"
                    },
                    password: {
                        required: "请输入密码",
                        minlength: "密码长度不能小于 5 个字母"
                    },
                    confirm_password: {
                        required: "请输入密码",
                        minlength: "密码长度不能小于 5 个字母",
                        equalTo: "两次密码输入不一致"
                    },
                    email: "请输入一个正确的邮箱"
                }
            })
        });
    </script>
</head>
<body>
<form class="cmxform" id="empform" method="post" action="/emp/register">
    <fieldset>
        <p>
            <label>邮箱</label>
            <input id="email" name="email" type="email">
        </p>
        <p>
            <label>姓名</label>
            <input id="name" name="name" type="text">
        </p>
        <p>
            <label>密码</label>
            <input id="password" name="password" type="password">
        </p>
        <p>
            <label for="confirm_password">验证密码</label>
            <input id="confirm_password" name="confirm_password" type="password">
        </p>
        <p>
            <label>电话</label>
            <input id="phone" name="phone" type="text">
        </p>
        <p>
            <label>性别</label>
            <input  name="sex" type="radio" value="1" checked="checked">男
            <input  name="sex" type="radio" value="0"/>女
        </p>
        <p>
            <label>生日</label>
            <input  name="birthday" class="Wdate" onclick="WdatePicker()" type="text"/>
        </p>
        <p>
            <input class="submit" type="submit" value="提交">
        </p>
    </fieldset>
</form>
</body>
</html>

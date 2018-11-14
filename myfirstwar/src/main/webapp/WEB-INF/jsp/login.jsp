<%--
  Created by IntelliJ IDEA.
  User: ken
  Date: 2018/11/1
  Time: 9:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN""http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <base href="${pageContext.request.contextPath}/"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Simpla Admin</title>
    <!--                       CSS                       -->
    <!-- Reset Stylesheet -->
    <link rel="stylesheet" href="resources/css/reset.css" type="text/css"
          media="screen" />
    <!-- Main Stylesheet -->
    <link rel="stylesheet" href="resources/css/style.css" type="text/css"
          media="screen" />
    <!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid -->
    <link rel="stylesheet" href="resources/css/invalid.css" type="text/css"
          media="screen" />
    <!--                       Javascripts                       -->
    <!-- jQuery -->
    <script type="text/javascript"
            src="resources/scripts/jquery-1.3.2.min.js"></script>
    <!-- jQuery Configuration -->
    <script type="text/javascript"
            src="resources/scripts/simpla.jquery.configuration.js"></script>
    <!-- Facebox jQuery Plugin -->
    <script type="text/javascript" src="resources/scripts/facebox.js"></script>
    <!-- jQuery WYSIWYG Plugin -->
    <script type="text/javascript" src="resources/scripts/jquery.wysiwyg.js"></script>
    <script>
        function myregister() {
            window.location="/getToPage/register";
        }
    </script>

</head>
<body id="login">

<div id="login-wrapper" class="png_bg">
    <div id="login-top">
        <h1>OA办公自动化系统</h1>
        <!-- Logo (221px width) -->
        <a href="#"><img id="logo" src="resources/images/logo.png"
                         alt="Simpla Admin logo" /></a>
    </div>
    <!-- End #logn-top -->
    <div id="login-content">
        <form action="/emp/login"
              method="post">
            <div class="notification information png_bg">
                <div>用户名或者密码错误</div>
            </div>
            <p>
                <label>邮箱</label> <input class="text-input" name="email"
                                         type="text" />
            </p>
            <div class="clear"></div>
            <p>
                <label>密码</label> <input class="text-input" name="password"
                                         type="password" />
            </p>
            <div class="clear"></div>
            <p id="remember-password">
                <input type="checkbox" /> 记住我
            </p>
            <div class="clear"></div>
            <p>
                <input class="mybutton" type="submit" value="登录" />
                <input class="mybutton" onclick="javascript:myregister()" type="button" value="注册" />
            </p>
        </form>
    </div>
    <!-- End #login-content -->
</div>
<!-- End #login-wrapper -->
</body>
</html>


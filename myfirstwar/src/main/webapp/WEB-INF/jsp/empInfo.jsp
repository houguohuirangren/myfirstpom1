<%--
  Created by IntelliJ IDEA.
  User: ken
  Date: 2018/11/1
  Time: 10:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html>
<head>
    <base href="${pageContext.request.contextPath}/"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
    <!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid -->
    <!-- Reset Stylesheet -->
    <link rel="stylesheet" href="resources/css/reset.css" type="text/css"
          media="screen"/>
    <!-- Main Stylesheet -->
    <link rel="stylesheet" href="resources/css/style.css" type="text/css"
          media="screen"/>
    <link rel="stylesheet" href="resources/css/invalid.css" type="text/css"
          media="screen"/>

    <!--                       Javascripts                       -->
    <!-- jQuery -->
    <script type="text/javascript"
            src="resources/scripts/jquery-1.8.3.min.js"></script>
    <!-- jQuery Configuration -->
    <script type="text/javascript"
            src="resources/scripts/simpla.jquery.configuration.js"></script>

    <!-- 时间日期插件 -->
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/resources/widget/My97DatePicker/WdatePicker.js"></script>

    <!-- dialog弹出框的导入 -->
    <link rel="stylesheet" href="//apps.bdimg.com/libs/jqueryui/1.10.4/css/jquery-ui.min.css"/>
    <script type="text/javascript" src="resources/widget/dialog/jquery-ui-1.9.2.custom.min.js"></script>
    <script type="text/javascript" src="resources/js/pulings.js"></script>

    <!-- ztree树形结构 -->
    <link rel="stylesheet" href="resources/widget/zTree/zTreeStyle/zTreeStyle.css"/>
    <script type="text/javascript" src="resources/widget/zTree/jquery.ztree.all.min.js"></script>
    <%--上传插件--%>
    <link rel="stylesheet" href="resources/widget/webuploader/webuploader.css"/>
    <script type="text/javascript" src="resources/widget/webuploader/webuploader.min.js"></script>

    <%--职员更新操作--%>
    <script>
        function updateemp(id, email, password, name, birthday, phone, sex, did, dname, img) {
            if (img != null && img != '') {
                $("#header_id").attr("src", "/img/getImg?imgpath=" + img)
                $("#image_id").val(img)
            }
            $("#e_id").val(id);
            $("#email_id").val(email);
            $("#password_id").val(password);
            $("#name_id").val(name);
            var date = new Date(birthday);
            datestr = date.getFullYear() + "-" + date.getMonth() + "-" + date.getDate();
            $("#birthday_id").val(datestr);
            $("#phone_id").val(phone);
            $("#btn_id").html(dname);
            $("#did_id").val(did);
            $("input[type='radio'][value='" + sex + "']").attr("checked", "checked")
            openDialog("div_dialog", "职员更新");

        }

    </script>
    <%--职员添加操作--%>
    <script>
        function addemp() {
            $("#add_clear").trigger("click");
            $("image_id").val("");
            $("e_id").val("");
            $("did_id").val("");
            $("#header_id").attr("src", "resources/images/icons/header.jpg");
            openDialog('div_dialog', '添加职员');
        }
    </script>

    <%--删除操作--%>
    <script>
        function delectemp(empId) {
            var resulut = confirm("是否要删除");
            if (resulut) {
                window.location = "/emp/deleteEmpById/" + empId;
            }
        }
    </script>
    <%--设置我的角色权限--%>
    <script>
        function updateMyRole(id, name) {
            $("#eid_id").val(id);
            $.get("role/getAllRoleAjax", {eid: id}, function (data) {
                var html = "";
                for (var i = 0; i < data.length; i++) {
                    if (data[i].checked) {
                        html += "<input type=\"checkbox\" name=\"rids\" checked=checked value=\"" + data[i].id + "\"/>" + data[i].rolename + "<br/>";
                    } else {
                        html += "<input type=\"checkbox\" name=\"rids\"  value=\"" + data[i].id + "\"/>" + data[i].rolename + "<br/>";
                    }


                }
                $("#role_id").html(html)
                openDialog("role_dialog", name + "角色修改", 300, 200);
            }, "json")


        }
    </script>


    <style>
        .time-input {
            padding: 6px;
            font-size: 13px;
            border: 1px solid #d5d5d5;
            color: #333;
        }
    </style>

    <script>
        /**
         * 显示父部门的树形结构
         */
        function showDepsTree() {
            $.get("dept/listajax", function (data) {

                //生成Ztree
                createZtree("ztree_div", data, {
                    name: "dname",
                    pid: "pid",
                    icon: false,
                    expand: true,
                    onclick: function (event, treeId, treeNode) {
                        //将选中的父部门名称设置给button按钮
                        $("#btn_id").html(treeNode.dname);
                        $("#did_id").val(treeNode.id);
                        //关闭弹出框
                        closeDialog("tree_dialog");
                    }
                }, $("#did_id").val());

                //弹出dialog
                openDialog("tree_dialog", "选择部门", 300, 200)
            }, "json");
        }

    </script>

</head>
<body>
<div id="main-content">
    <div class="content-box">
        <!-- End .content-box-header -->
        <div class="content-box-content">
            <div class="tab-content default-tab" id="tab1">
                <table>
                    <thead>
                    <tr>
                        <th><input class="check-all" type="checkbox"/></th>
                        <th>头像</th>
                        <th>编号</th>
                        <th>邮箱</th>
                        <th>密码</th>
                        <th>姓名</th>
                        <th>生日</th>
                        <th>电话</th>
                        <th>性别</th>
                        <th>部门名称</th>
                        <th>操作</th>
                    </tr>
                    </thead>

                    <tbody>
                    <c:forEach items="${emps}" var="emp">
                        <tr>
                            <td><input type="checkbox"/></td>
                            <td>
                                <c:if test="${emp.img==null||emp.img==''}">
                                    <img width="60" height="60" src="resources/images/icons/header.jpg">
                                </c:if>
                                <c:if test="${emp.img!=null&&emp.img!=''}"><img width="60" height="60"
                                                                                src="/img/getImg?imgpath=${emp.img}"></c:if>
                            </td>
                            <td>${emp.id}</td>
                            <td>${emp.email}</td>
                            <td>${emp.password}</td>
                            <td>${emp.name}</td>
                            <td><fmt:formatDate value="${emp.birthday}" pattern="yyyy-MM-dd"/></td>
                            <td>${emp.phone}</td>
                            <td>${emp.sex==1?'男':'女'}</td>
                            <td>${emp.dname}</td>
                            <td>
                                <!-- Icons -->
                                <shiro:hasPermission name="/emp/addOrUpdateEmp">
                                    <a href="javascript:updateemp('${emp.id}','${emp.email}','${emp.password}','${emp.name}','${emp.birthday}','${emp.phone}','${emp.sex}','${emp.did}','${emp.dname}','${emp.img}');"
                                       title="Edit"><img
                                            src="resources/images/icons/pencil.png" alt="Edit"/></a>
                                </shiro:hasPermission>
                                <shiro:hasPermission name="/emp/deleteEmpById">
                                    <a
                                            href="javascript:delectemp('${emp.id}')" title="Delete"><img
                                            src="resources/images/icons/cross.png" alt="Delete"/></a>
                                </shiro:hasPermission>
                                <shiro:hasPermission name="/role/updateRoleByEid">
                                    <a
                                            href="javascript:updateMyRole('${emp.id}','${emp.name}')" title="Edit Meta"><img
                                            src="resources/images/icons/hammer_screwdriver.png"
                                            alt="Edit Meta"/></a>
                                </shiro:hasPermission>


                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>

                    <tfoot>
                    <tr>
                        <td colspan="6">
                            <div class="bulk-actions align-left">
                                <shiro:hasPermission name="/emp/addOrUpdateEmp">
                                    <a class="mybutton" href="javascript:addemp()">添加职员</a>
                                </shiro:hasPermission>
                            </div>

                            <!-- 分页导航 -->
                            <%@ include file="page.jsp" %>
                            <div class="clear"></div>
                        </td>
                    </tr>
                    </tfoot>
                </table>
            </div>
        </div>
        <!-- End .content-box-content -->
    </div>
</div>
<!-- End #main-content -->

<!-- 弹出框 -->
<div id="div_dialog" style="display: none;">
    <form action="/emp/addOrUpdateEmp" method="post">
        <input type="hidden" id="e_id" name="id">
        <fieldset>
            <!-- Set class to "column-left" or "column-right" on fieldsets to divide the form into columns -->
            <p>
                <label>头像</label>
                <img id="header_id" width="100" height="110" src="resources/images/icons/header.jpg"/>
                <input id="image_id" type="hidden" name="img"/>
            <div id="filePicker">选择头像</div>
            </p>
            <p>
                <label>邮箱</label>
                <input id="email_id" type="text" name="email"/>
            </p>

            <p>
                <label>密码</label>
                <input id="password_id" type="text" name="password"/>
            </p>
            <p>
                <label>姓名</label>
                <input id="name_id" type="text" name="name"/>
            </p>
            <p>
                <label>部门</label>
                <button id="btn_id" class="mybutton" type="button" onclick="showDepsTree();">无</button>
                <input id="did_id" name="did" type="hidden" value="0"/>
            </p>
            <p>
                <label>电话</label>
                <input id="phone_id" type="text" name="phone"/>
            </p>
            <p>
                <label>性别</label>
                <input type="radio" name="sex" value="1" checked="checked"/>男
                <input type="radio" name="sex" value="0">女
            </p>
            <p>
                <label>生日</label>
                <input class="Wdate time-input" type="text" id="birthday_id" onclick="WdatePicker()" name="birthday"/>
            </p>
            <p>
                <input class="mybutton" type="submit" value="提交"/>

            </p>
            <input id="add_clear" type="reset" style="display: none"/>
        </fieldset>
        <div class="clear"></div>
        <!-- End .clear -->
    </form>
</div>

<!-- 树形弹出框 -->
<div id="tree_dialog" style="display: none;">
    <div id="ztree_div" class="ztree"></div>
</div>
<%--角色弹出框--%>
<div id="role_dialog" style="display: none">
    <form action="/role/updateRoleByEid" method="post">
        <input id="eid_id" type="hidden" name="eid"/>
        <div id="role_id"></div>
        <input type="submit" value="提交"/>
    </form>
</div>

<script>
    // 初始化Web Uploader
    var uploader = WebUploader.create({
        // 选完文件后，是否自动上传。
        auto: true,
        // swf文件路径
        swf: ${pageContext.request.contextPath} +'/resources/widget/webuploader/Uploader.swf',
        // 文件接收服务端。
        server: 'img/uploadImg',
        // 选择文件的按钮。可选。
        // 内部根据当前运行是创建，可能是input元素，也可能是flash.
        pick: '#filePicker'
    });

    //设置一个队列监听事件，当有一个图片添加进队列中时，触发该方法
    uploader.on("fileQueued", function (file) {
        //找到头像的img标签
        var $img = $("#header_id");

        //创建缩略图
        uploader.makeThumb(file, function (error, src) {
            if (error) {
                $img.replaceWith('<span>不能预览</span>');
                return;
            }

            $img.attr('src', src);
        }, 100, 110);
    });


    uploader.on("uploadSuccess", function (file, response) {
        $("#image_id").val(response.uploadpath);
    });

</script>

</body>
</html>

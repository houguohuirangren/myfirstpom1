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

    <style>
        .time-input {
            padding: 6px;
            font-size: 13px;
            border: 1px solid #d5d5d5;
            color: #333;
        }


    </style>
    <%--部门添加操作--%>
    <script>
        function addDept() {
            $("#add_clear").trigger("click");
            $("#d_id").val("");
            $("#pid_id").val(0);
            $("#btn_id").html("无")

            openDialog('div_dialog', '部门添加');
        }
    </script>
    <%--更新操作--%>
    <script>

        function updatedept(id, dname, pname, deptinfo, createtimt, pid) {
            $("#d_id").val(id);
            $("#dname_id").val(dname);
            $("#dinfo_id").val(deptinfo);
            $("#pid_id").val(pid);
            $("#btn_id").html(pname);
            var date = new Date(createtimt);
            var datestr = date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate();
            $("#createtime_id").val(datestr);
            openDialog("div_dialog", "部门信息修改");
        }
    </script>
    <%--删除操作--%>
    <script>
        function delectemp(deptId) {
            var resulut = confirm("是否要删除");
            if (resulut) {
                window.location = "/dept/deleteDeptById/" + deptId;
            }
        }
    </script>

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
                        $("#pid_id").val(treeNode.id);
                        //关闭弹出框
                        closeDialog("tree_dialog");
                    }
                }, $("#pid_id").val());

                //弹出dialog
                openDialog("tree_dialog", "选择父部门", 300, 200)
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
                        <th>编号</th>
                        <th>部门名称</th>
                        <th>父部门</th>
                        <th>部门描述</th>
                        <th>成立时间</th>
                        <th>操作</th>
                    </tr>
                    </thead>

                    <tbody>
                    <c:forEach items="${deptList}" var="dep">
                        <tr>
                            <td><input type="checkbox"/></td>
                            <td>${dep.id}</td>
                            <td>${dep.dname}</td>
                            <td>${dep.pname}</td>
                            <td>${dep.deptinfo}</td>
                            <td><fmt:formatDate value="${dep.createtime}" pattern="yyyy-MM-dd"/></td>
                            <td>
                                <!-- Icons -->
                                <shiro:hasPermission name="/dept/addOrDept">
                                    <a href="javascript:updatedept('${dep.id}','${dep.dname}','${dep.pname}','${dep.deptinfo}','${dep.createtime}','${dep.pid}')"
                                       title="Edit"><img
                                            src="resources/images/icons/pencil.png" alt="Edit"/></a>
                                </shiro:hasPermission>
                                <shiro:hasPermission name="/dept/deleteDeptById">
                                    <a
                                            href="javascript:delectemp('${dep.id}')" title="Delete"><img
                                            src="resources/images/icons/cross.png" alt="Delete"/></a>
                                </shiro:hasPermission>

                                <a
                                        href="#" title="Edit Meta"><img
                                        src="resources/images/icons/hammer_screwdriver.png"
                                        alt="Edit Meta"/></a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>

                    <tfoot>
                    <tr>
                        <td colspan="6">
                            <div class="bulk-actions align-left">
                                <shiro:hasPermission name="/dept/addOrDept">
                                    <a class="mybutton" href="javascript:addDept();">添加部门</a>
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
    <form action="/dept/addOrDept" method="post">
        <fieldset>
            <input type="hidden" id="d_id" name="id"/>
            <!-- Set class to "column-left" or "column-right" on fieldsets to divide the form into columns -->
            <p>
                <label>部门名称</label>
                <input class="text-input input" type="text" id="dname_id"
                       name="dname"/>
            </p>
            <p>
                <label>父部门</label>
                <button id="btn_id" class="mybutton" type="button" onclick="showDepsTree();">无</button>
                <input id="pid_id" name="pid" type="hidden" value="0"/>
            </p>
            <p>
                <label>成立时间</label>
                <input class="Wdate time-input" onclick="WdatePicker()" type="text" id="createtime_id"
                       name="createtime"/>
            </p>

            <p>
                <label>部门描述</label>
                <textarea class="text-input textarea wysiwyg" id="dinfo_id"
                          name="deptinfo" cols="79" rows="15"></textarea>
            </p>
            <p>
                <input class="mybutton" type="submit" value="提交"/>
                <input type="reset" id="add_clear" style="display: none"/>
            </p>
        </fieldset>
        <div class="clear"></div>
        <!-- End .clear -->
    </form>
</div>

<!-- 树形弹出框 -->
<div id="tree_dialog" style="display: none;">
    <div id="ztree_div" class="ztree"></div>
</div>
<div>
    <a href="/DeptexcelImport">部门表的导出</a>
</div>
    <div class="align-right">
    <form action="/DeptexcelLeading" method="post" enctype="multipart/form-data">
        部门表的导入<input type="file" name="excelFile"/><br/>
        <input type="submit" value="提交"/>
    </form>
    </div>


</body>
</html>

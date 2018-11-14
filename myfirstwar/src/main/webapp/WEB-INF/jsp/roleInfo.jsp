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


    <!-- dialog弹出框的导入 -->
    <link rel="stylesheet" href="//apps.bdimg.com/libs/jqueryui/1.10.4/css/jquery-ui.min.css"/>
    <script type="text/javascript" src="resources/widget/dialog/jquery-ui-1.9.2.custom.min.js"></script>
    <script type="text/javascript" src="resources/js/pulings.js"></script>

    <!-- ztree树形结构 -->
    <link rel="stylesheet" href="resources/widget/zTree/zTreeStyle/zTreeStyle.css"/>
    <script type="text/javascript" src="resources/widget/zTree/jquery.ztree.all.min.js"></script>


    <%--角色的更新操作--%>
    <script>
        function updaterole(id, rolename) {
            $("#r_id").val(id);
            $("#rolename_id").val(rolename);
            openDialog("div_dialog", rolename + "的角色更新");
        }

    </script>
    <%--角色的添加操作--%>
    <script>
        function addRole() {
            $("#add_clear").trigger("click");
            $("#r_id").val("");
            openDialog("div_dialog", "角色添加")
        }
    </script>
    <%--角色删除操作--%>
    <script>
        function delectRoleById(roleId) {
            var resulut = confirm("是否要删除");
            if (resulut) {
                window.location = "/role/deleteRoleById/" + roleId;
            }
        }

    </script>

    <%--角色的权限设置--%>
    <script>
        var rid;

        function getResc(rolename, id) {
            rid = id;
            $.get("resc/getRescByRidAjax", {rid: id}, function (data) {

                //生成Ztree
                createZtree("ztree_div", data, {
                    name: "rname",
                    pid: "pid",
                    icon: false,
                    expand: true,
                    check: true,
                    checkType: {"Y": "ps", "N": "s"}
                });

                //弹出dialog
                openDialog("tree_dialog", "设置角色的权限", 300, 400)

            }, "json");
        }


        function updateMyRescAjax() {
            var reids = [];
            var treeObj = $.fn.zTree.getZTreeObj("ztree_div");
            var nodes = treeObj.getCheckedNodes(true);
            for (var i = 0; i < nodes.length; i++) {
                reids.push(nodes[i].id);
            }

            $.ajax({
                type: "POST",
                url: "/role/updateMyRescAjax",
                traditional: true,
                data: {rid: rid, reids: reids},
                success: function (data) {
                    if (data == 1) {
                        alert("修改成功");
                        window.location = "/role/getRoleInfo";
                    } else {
                        alert("修改失败");
                    }
                }
            })
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
                        <th>角色名称</th>
                        <th>操作</th>
                    </tr>
                    </thead>

                    <tbody>
                    <c:forEach items="${roles}" var="role">
                        <tr>
                            <td><input type="checkbox"/></td>
                            <td>${role.id}</td>
                            <td>${role.rolename}</td>
                            <td>
                                <!-- Icons -->
                                <shiro:hasPermission name="/role/addOrupdateRole">
                                    <a href="javascript:updaterole('${role.id}','${role.rolename}')" title="Edit"><img
                                            src="resources/images/icons/pencil.png" alt="Edit"/></a>
                                </shiro:hasPermission>

                                <shiro:hasPermission name="/role/deleteRoleById">
                                    <a
                                            href="javascript:delectRoleById('${role.id}')" title="Delete"><img
                                            src="resources/images/icons/cross.png" alt="Delete"/></a>
                                </shiro:hasPermission>

                                <a
                                        href="javascript:getResc('${role.rolename}','${role.id}');"
                                        title="Edit Meta"><img
                                        src="resources/images/icons/hammer_screwdriver.png"
                                        alt="Edit Meta"/></a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>

                    <tfoot>
                    <tr>
                        <td colspan="6">
                            <shiro:hasPermission name="/role/addOrupdateRole">
                                <div class="bulk-actions align-left">
                                    <a class="mybutton" href="javascript:addRole();">角色添加</a>
                                </div>
                            </shiro:hasPermission>


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
    <form action="/role/addOrupdateRole" method="post">
        <fieldset>
            <input type="hidden" id="r_id" name="id"/>
            <!-- Set class to "column-left" or "column-right" on fieldsets to divide the form into columns -->
            <p>
                <label>角色名称</label>
                <input class="text-input input" type="text" id="rolename_id"
                       name="rolename"/>
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
    <button type="button" class="mybutton" onclick="updateMyRescAjax();">提交</button>

</div>


</body>
</html>

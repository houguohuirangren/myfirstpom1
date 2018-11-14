<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
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

    <!-- jQuery Configuration -->
    <script type="text/javascript"
            src="resources/scripts/simpla.jquery.configuration.js"></script>
    <%--富文本编辑器--%>
    <link rel="stylesheet" href="http://www.jq22.com/jquery/bootstrap-3.3.4.css">
    <link href="resources/widget/dist/summernote.css" rel="stylesheet"/>
    <script src="http://www.jq22.com/jquery/jquery-1.10.2.js"></script>
    <script src="http://www.jq22.com/jquery/bootstrap-3.3.4.js"></script>
    <script src="resources/widget/dist/summernote.js"></script>
    <script src="resources/widget/dist/lang/summernote-zh-CN.js"></script>
    <!-- 自动补全插件 -->
    <link href="resources/widget/autocompleter/styles.css" rel="stylesheet"/>
    <script src="resources/widget/autocompleter/jquery.autocomplete.min.js"></script>
    <%--引入表单验证插件--%>
    <script src="resources/widget/check/dist/jquery.validate.min.js"></script>
    <script src="resources/widget/check/dist/localization/messages_zh.js"></script>
</head>
<style>
    .errorfrom{color: red}
</style>
<script>
    $().ready(function () {
    // 在键盘按下并释放及提交后验证提交表单
        $("#email_from").validate({
            rules: {
                myinput: "required",
                emailTitle: "required",
            },
            messages: {
                myinput: "请输入收件人",
                emailTitle: "请输入标题",
            },
            errorClass:"errorfrom"
        })
    });
</script>


<script>

    $(function () {
        $('.summernote').summernote({
            height: 600,
            tabsize: 2,
            lang: 'zh-CN'
        });


        <%--初始化自动补全插件--%>


        $('#autocomplete').autocomplete({
            lookup: function (query, done) {
                $.post("/emp/getempInfoAjax", {keyword: query}, function (data) {

                    done(data);
                }, "json");


            },
            onSelect: function (suggestion) {

                $("#reciveEmail_id").val(suggestion.data);
            }
        });
    });

</script>
<%--邮件发送--%>
<script>
    function sendmail() {
        var content = $('.summernote').summernote('code');
        $("#content_id").val(content)
        $("#email_from").submit();
    }
</script>
<body>
<div id="main-content">
    <div class="content-box">
        <div class="content-box-content">
            <div class="tab-content default-tab" id="tab2">
                <form action="/email/senEmail" method="post" id="email_from" enctype="multipart/form-data">
                    <fieldset>
                        <!-- Set class to "column-left" or "column-right" on fieldsets to divide the form into columns -->
                        <p>
                            <label>收件人</label> <input
                                class="text-input small-input" type="text" id="autocomplete"
                                name="myinput"/> <span
                                class="input-notification success png_bg">
									</span>
                            <input type="hidden" name="recivePesonal" id="reciveEmail_id"/>
                            <!-- Classes for input-notification: success, error, information, attention -->
                            <br/>
                        </p>
                        <p>
                            <label>标题</label> <input
                                class="text-input medium-input datepicker" type="text"
                                id="medium-input" name="emailTitle"/> <span
                                class="input-notification error png_bg"></span>
                        </p>
                        <p>
                            <label>附件</label> <input
                                class="text-input large-input" type="file" name="emailFile"
                                name="large-input"/>
                        </p>

                        <p>
                            <label>内容</label>

                        <div class="summernote"></div>
                        <input type="hidden" name="emailContent" id="content_id"/>
                        </p>
                        <p>
                            <input class="mybutton" type="button" onclick="javascript:sendmail()" value="提交"/>
                        </p>
                    </fieldset>
                    <div class="clear"></div>
                    <!-- End .clear -->
                </form>
            </div>
            <!-- End #tab2 -->
        </div>
        <!-- End .content-box-content -->
    </div>
</div>
<!-- End #main-content -->
</body>
</html>
<%--
  Created by IntelliJ IDEA.
  User: LWW
  Date: 2018/11/8
  Time: 10:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <base href="${pageContext.request.contextPath}/"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Title</title>

    <!-- jQuery -->
    <script type="text/javascript"
            src="resources/scripts/jquery-1.8.3.min.js"></script>
    <%--图标插件的引入--%>
    <script type="text/javascript" src="resources/widget/chart/echarts.common.min.js"></script>
</head>
<script>
    function load() {
        var deptname = [];
        var count = [];

        $.post("/dept/countempAjax", function (data) {
            for (var i = 0; i < data.length; i++) {
                deptname.push(data[i].deptname);
                count.push(data[i].countemp);
            }

            // 基于准备好的dom，初始化echarts实例
            var myChart = echarts.init(document.getElementById('main'));
            // 指定图表的配置项和数据
            var option1 = {
                title: {
                    text: '部门人数分布图'
                },
                tooltip: {},
                legend: {
                    data: ['人数']
                },
                xAxis: {
                    data: deptname
                },
                yAxis: {},
                series: [{
                    name: '人数',
                    type: 'bar',
                    data: count
                }]
            };
            // 使用刚指定的配置项和数据显示图表。
            myChart.setOption(option1);
        }, "json");

        //饼状图
        $.post("/emp/countsexByempAjax", function (data) {
            var myChartpei = echarts.init(document.getElementById('main1'));
            // 指定图表的配置项和数据
            var optionpei = {
                title: {
                    text: '男女职工比例图',
                    subtext: '纯属虚构',
                    x: 'center'
                },
                tooltip: {
                    trigger: 'item',
                    formatter: "{a} <br/>{b} : {c} ({d}%)"
                },
                legend: {
                    orient: 'vertical',
                    left: 'left',
                    data: (function(){
                        var res = [];
                        var len = data.length;
                        for(var i=0;i<len;i++) {
                            res.push({
                                name: data[i].sex,
                            });
                        }
                        return res;
                    })()
                },
                series: [
                    {
                        name: '男女职工比例图',
                        type: 'pie',
                        radius: '55%',
                        center: ['50%', '60%'],
                        data: (function () {
                            var res = [];
                            for (var i = 0; i < data.length; i++) {
                                res.push({
                                    //通过把data进行遍历循环来获取数据并放入Echarts中
                                    name: data[i].sex,
                                    value: data[i].sexcount
                                });
                            }
                            return res;
                        })(),
                        itemStyle: {
                            emphasis: {
                                shadowBlur: 10,
                                shadowOffsetX: 0,
                                shadowColor: 'rgba(0, 0, 0, 0.5)'
                            }
                        }
                    }
                ]
            };

            // 使用刚指定的配置项和数据显示图表。
            myChartpei.setOption(optionpei);
        },"json");

    }
</script>
<body onload="load()">
<div id="main" style="width: 600px;height:400px;"></div>
<div id="main1" style="width: 600px;height:400px;"></div>
</body>
</html>

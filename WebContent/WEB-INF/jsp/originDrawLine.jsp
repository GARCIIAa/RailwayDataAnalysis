<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-CN">
<head>
    <!-- 原始地址：//webapi.amap.com/ui/1.0/ui/misc/PointSimplifier/examples/index.html -->
    <base href="//webapi.amap.com/ui/1.0/ui/misc/PointSimplifier/examples/" />
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no, width=device-width">
    <title>海量点展示</title>
     <!-- MAIN EFFECT -->
    <link rel="stylesheet" href="<%=basePath%>assets/css/loader-style.css">
    <link rel="stylesheet" href="<%=basePath%>assets/css/bootstrap.css">
    <link rel="stylesheet" href="<%=basePath%>assets/css/styleForMap.css">
    <link type="text/css" rel="stylesheet" href="<%=basePath%>css/popup_blacklist.css" />
    <link rel="stylesheet" href="<%=basePath%>assets/css/icons-style.css" >
    <link rel="stylesheet" href="<%=basePath%>assets/css/media.css" >
    <link rel="stylesheet" href="<%=basePath%>assets/js/switch/bootstrap-switch.css">
     <script type="text/javascript" src="<%=basePath%>assets/js/jquery.js"></script>
     <script type="text/javascript" src="<%=basePath%>assets/js/switch/bootstrap-switch.js"></script>
     <script async="" src="<%=basePath%>js/analytics.js"></script>
     <script src="<%=basePath%>js/Chart.bundle.js"></script>
     <script src="<%=basePath%>js/utils.js"></script>
   
     <style type="text/css">/* Chart.js */
@-webkit-keyframes chartjs-render-animation{from{opacity:0.99}to{opacity:1}}@keyframes chartjs-render-animation{from{opacity:0.99}to{opacity:1}}.chartjs-render-monitor{-webkit-animation:chartjs-render-animation 0.001s;animation:chartjs-render-animation 0.001s;}</style>

     <style>
	canvas {
		-moz-user-select: none;
		-webkit-user-select: none;
		-ms-user-select: none;
	}
	</style>
	
    <style>
    html,
    body{
        width: 100%;
        height: 100%;
        margin: 0px;
    }
    #container {
        width: 70%;
        height: 100%;
        margin: 0px;
        border: 1px solid #f5f5f5;
        border-style:solid none solid solid;
        box-shadow: 0px 1px 3px #777;
    }
     #container2 {
        border: 1px solid #f5f5f5;
        border-style:solid solid none none;
        box-shadow: 0px 1px 3px #777;
    }
    .map1 {
        width: 70%;
        margin: 0px;
        height: 100%;
    }
     .map2 {
        width: 30%;
        margin: 0px;
        height: 50%;
    }
    .text {
        width: 30%;
        margin: 0px;
        height: 50%;
    }
    .mapshow{
	padding-top: 0px;
	padding-bottom: 10px;
	padding-left: 10px;
	padding-right: 10px;
	position: absolute;
	top: 50px;
	bottom: 0px;
	width: 100%;
	left: 0;
	background: none;
    }
    .label1{
	font-weight: bold;
	font-size: 17px;
    position: absolute;
    }
    .label2{
	font-weight: bold;
	font-size: 17px;
    position: absolute;
    left:150px
    }
    .oneline{
        height: 40px;
    }
    .s1{
        font-weight: bold;
        font-size: 17px;
    }
    .s2{
        padding-left: 5px;
    }
     .st{
	position: absolute;
	width: 85px;
	margin-top: 5px;
	margin-right: 310px;
    right:0px;
    }
     .ed{
	position: absolute;
	width: 85px;
	margin-top: 5px;
	margin-right: 110px;
    right:0px;
    }
    .st-label{
	position: absolute;
	margin-right: 400px;
	margin-top: 10px;
	font-size: 15px;
	font-weight: bold;
	font-family: 'Open Sans', serif;
    right:0px;
    }
    .ed-label{
	position: absolute;
	margin-right: 200px;
	margin-top: 10px;
	font-size: 15px;
	font-weight: bold;
	font-family: 'Open Sans', serif;
    right:0px;
    }
    #loadingTip {
        position: absolute;
        z-index: 9999;
        top: 0;
        left: 0;
        padding: 3px 10px;
        background: red;
        color: #fff;
        font-size: 14px;
    }
    .hoverStyle {
       position: absolute;
    }
    </style>
</head>

<body>
    <!-- <div id="container"></div>
     <div id="container1"></div> -->
     <!-- <div class="content-wrap">
                <div class="row">
                    <div class="col-sm-12"> -->
                        <div class="nest map1" id="GmapClose">
                            <div class="title-alt">
                                <span class="st-label">
                                   Start station:</span>
                                <select id="fromCity" class="filter-status form-control st">
                                        <option value="">--Station--
                                        <option value="成都">Chengdu
                                        <option value="北京">Beijing
                                </select>
                                <span class="ed-label">
                                   End station:</span>
                                <select id="toCity" class="filter-status form-control ed">
                                       <option value="">--Station--
                                        <option value="成都">Chengdu
                                        <option value="北京">Beijing
                                </select>
                                <a onclick="retrieveLine();" style="margin-top:5px;margin-right:20px;"class="pull-right btn btn-info filter-api">Retrieve</a>
                            </div>
                            <div class="body-nest mapshow" id="Gmap">
                                <div id="container" class="gmap" style="width:100%;height:100%;position:relative;"></div>
                            </div>
                        </div>
                        <div class="nest map2" id="GmapClose">
                                <div style="padding:0px;width:100%;height:100%;position:relative;" class="body-nest" id="Gmap">
                                
                    <div class="blog-list-nest">
                        <div class="vendor" style="margin:0;">
                            <blockquote  style="margin:0;">
                                <p>Detail Infomation of the Chosen Railway Line</p>
                                <p id ="cityTitle">
                                    <small></small>
                                </p>
                            </blockquote>
                        </div>
                        </div>
                        <div class="oneline">
                                <div class="entypo-tooltip" style="color:#3498DB">
                                <li style="padding:0px;"class="icon icon-location" data-placement="right" title="aboveground-rail"></li>
                                </div>
                                <span class="label1"><span class="label s1">From:</span><span id="fromCityName" class="s2"></span> </span>
                                <span class="label2"><span class="label s1">To:</span><span id="toCityName" class="s2"></span> </span>
                                </div>
                        <div class="oneline">
                                <div class="entypo-tooltip" style="color:#3498DB">
                                <li style="padding:0px;"class="fontawesome-truck" data-placement="right" title="aboveground-rail"></li>
                                </div>
                                <span class="label1"><span class="label s1">Car Numbers:</span><span id="carNums" class="s2"></span> </span>
                                </div>
                        <div class="oneline">
                                <div class="entypo-tooltip" style="color:#3498DB">
                                <li style="padding:0px;"class="maki-aboveground-rail " data-placement="right" title="aboveground-rail"></li>
                                </div>
                                <span class="label1"><span class="label s1">Total Freight:</span><span id="totalFreight" class="s2"></span> </span>
                                </div>     
                                </div>
                            </div>
                        <div class="nest text" id="GmapClose">
                            <div style="padding:0px;width:100%;height:100%;position:relative;" class="body-nest" id="Gmap">
                                
                    <div class="blog-list-nest">
                        <div class="vendor"  style="margin:0;">
                            <blockquote  style="margin:0;">
                                <p>Analysis Infomation about the RailwayLine</p>
                            </blockquote>
                        </div>
                        </div>
                     <div class="oneline">
                     <ul class="list-inline">
                                <li>
                                    <a id="ssjk">
                                        <span class="entypo-network"></span>&nbsp;2 Days Ago</a>
                                </li>
                                </ul>
                        <a id="ssjk" style="margin-top:5px;margin-right:20px;"class="pull-right btn btn-info filter-api">One</a>
                                </div>
                                </div>
                            </div>
     <div id="gray3"></div>
	<div class="popup" id="popup_ssjk" style = "width:1000px;height:550px;top:15px;">
	<div class="top_nav" id='top_nav'style = "width:1000px">
		<div align="center">
			<span>Top 5 hot cities</span>
			<k class="guanbi"></k>
		</div>
		</div>
 <div id="container" style="width: 100%; height:504px"><div class="chartjs-size-monitor" style="position: absolute; left: 0px; top: 0px; right: 0px; bottom: 0px; overflow: hidden; pointer-events: none; visibility: hidden; z-index: -1;"><div class="chartjs-size-monitor-expand" style="position:absolute;left:0;top:0;right:0;bottom:0;overflow:hidden;pointer-events:none;visibility:hidden;z-index:-1;"><div style="position:absolute;width:1000000px;height:1000000px;left:0;top:0"></div></div><div class="chartjs-size-monitor-shrink" style="position:absolute;left:0;top:0;right:0;bottom:0;overflow:hidden;pointer-events:none;visibility:hidden;z-index:-1;"><div style="position:absolute;width:200%;height:200%;left:0; top:0"></div></div></div>
		<canvas id="canvas" width="905" height="452" class="chartjs-render-monitor" style="display: block; height: 362px; width: 724px;"></canvas>
	</div>
	</div>
     <script type="text/javascript" src='//webapi.amap.com/maps?v=1.4.6&key=您申请的key值'></script>
    <!-- UI组件库 1.0 -->
    <script src="//webapi.amap.com/ui/1.0/main.js?v=1.0.11"></script>
    <script type="text/javascript">
	var color = Chart.helpers.color;
	var barChartData = {
		labels: ['January', 'February', 'March', 'April', 'May'],
		datasets: [{
			label: 'Dataset 1',
			backgroundColor: color(window.chartColors.red).alpha(0.5).rgbString(),
			borderColor: window.chartColors.red,
			borderWidth: 1,
			data: [
				randomScalingFactor(),
				randomScalingFactor(),
				randomScalingFactor(),
				randomScalingFactor(),
				randomScalingFactor(),
			]
		}, {
			label: 'Dataset 2',
			backgroundColor: color(window.chartColors.blue).alpha(0.5).rgbString(),
			borderColor: window.chartColors.blue,
			borderWidth: 1,
			data: [
				randomScalingFactor(),
				randomScalingFactor(),
				randomScalingFactor(),
				randomScalingFactor(),
				randomScalingFactor(),
			]
		}]

	};

	window.onload = function() {
		var ctx = document.getElementById('canvas').getContext('2d');
		window.myBar = new Chart(ctx, {
			type: 'bar',
			data: barChartData,
			options: {
				responsive: true,
				legend: {
					position: 'top',
				},
				title: {
					display: true,
					text: 'Top 5 hottest cities'
				}
			}
		});

	};
    </script>
    <script type="text/javascript">
    //创建地图
    var map = new AMap.Map('container', {
        zoom: 4
    });

    AMapUI.load(['ui/misc/PathSimplifier', 'lib/$'], function(PathSimplifier, $) {

        if (!PathSimplifier.supportCanvas) {
            alert('当前环境不支持 Canvas！');
            return;
        }

        var pathSimplifierIns = new PathSimplifier({
            zIndex: 100,
            //autoSetFitView:false,
            map: map, //所属的地图实例

            getPath: function(pathData, pathIndex) {

                return pathData.path;
            },
            getHoverTitle: function(pathData, pathIndex, pointIndex) {

                if (pointIndex >= 0) {
                    //point 
                    return '站点:' + pathData.point[pointIndex] ;
                }
                return pathData.data;
            },
            renderOptions: {

                renderAllPointsIfNumberBelow: 100 //绘制路线节点，如不需要可设置为-1
            }
        });

        window.pathSimplifierIns = pathSimplifierIns;

        pathSimplifierIns.on('pathClick pointClick', function(e, info){
//info.pathData 即是相关的轨迹数据，如果info.pointIndex >= 0，则表示由轨迹上的节
           $("#fromCityName").text(info.pathData.point[0]);
           $("#toCityName").text(info.pathData.point[1]);
           $("#carNums").text(info.pathData.carNum);
           $("#totalFreight").text(info.pathData.tonnage);
           document.getElementById('cityTitle').innerHTML="<small>"+info.pathData.data+"</small>";
          });

    });
    function retrieveLine(){
         $.ajax({
				type:'get',
				url:"<%=basePath%>railwayData/fuzzyQuery",
				data:{"from":$('#fromCity option:selected').val(),"to":$('#toCity option:selected').val()},
				dataType:'json',
				success:function(data1){
                    pathSimplifierIns.setData(data1.railways);
                    for(var i =0;i<data1.railwaynum;i++){
                      var navg = pathSimplifierIns.createPathNavigator(i, {
                          loop: true, //循环播放
                          speed: 1000000 //巡航速度，单位千米/小时
                        });
                        navg.start();
                }
				},
				error: function(json){  
					alert("用户数据加载异常，请刷新后重试...");  
				}  
			});
    }
    </script>
      <script src="<%=basePath%>js/popup.js"></script>
</body>

</html>
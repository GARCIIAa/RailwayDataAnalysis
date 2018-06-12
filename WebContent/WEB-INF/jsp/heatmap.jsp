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
    <link rel="stylesheet" href="<%=basePath%>assets/js/datepicker/datepicker.css">
    <link rel="stylesheet" href="<%=basePath%>assets/js/switch/bootstrap-switch.css">
    <script type="text/javascript" src="<%=basePath%>assets/js/jquery.js"></script>
    <script type="text/javascript" src="<%=basePath%>assets/js/datepicker/bootstrap-datepicker.js"></script>
    <script async="" src="<%=basePath%>js/analytics.js"></script>
    <script src="<%=basePath%>js/Chart.bundle.js"></script>
    <script src="<%=basePath%>js/utils.js"></script>
   
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
    .chart {
        width: 70%;
        height: 100%;
        margin: 0px;
        border: 1px solid #f5f5f5;
        border-style:solid none solid solid;
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
    .oneline{
        height: 40px;
    }
    .s1{
        font-weight: bold;
        font-size: 17px;
    }
    .s2{
        padding-left: 15px;
    }
     .sl{
	position: absolute;
	width: 150px;
	margin-top: 5px;
	margin-right: 590px;
    right:0px;
    }
     .sctl{
	position: absolute;
	width: 75px;
	margin-top: 5px;
	margin-right: 800px;
    right:0px;
    }
     .st{
	position: absolute;
	width: 150px;
	margin-top: 5px;
	margin-right: 340px;
    right:0px;
    }
     .ed{
	position: absolute;
	width: 150px;
	margin-top: 5px;
	margin-right: 110px;
    right:0px;
    }
     .ty-label{
	position: absolute;
	margin-right: 750px;
	margin-top: 10px;
	font-size: 15px;
	font-weight: bold;
	font-family: 'Open Sans', serif;
    right:0px;
    }
    .st-label{
	position: absolute;
	margin-right: 500px;
	margin-top: 10px;
	font-size: 15px;
	font-weight: bold;
	font-family: 'Open Sans', serif;
    right:0px;
    }
    .ed-label{
	position: absolute;
	margin-right: 260px;
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
                           <select id="ctl" class="filter-status form-control sctl">
                                        <option value="from">发站
                                        <option value="to">到站
                            </select>
                                <span class="ty-label">
                                   Type:</span>
                                 <select id="type" class="filter-status form-control sl">
                                 <option value="01">01-煤
                                 <option value="02">02-石油
                                 <option value="03">03-焦炭
                                 <option value="04">04-金属矿石
                                 <option value="05">05-钢铁及有色金属
                                 <option value="06">06-非金属矿石
                                 <option value="07">07-磷矿石
                                 <option value="08">08-矿物性建筑材料
                                 <option value="09">09-水泥
                                 <option value="10">10-木材
                                 <option value="11">11-粮食
                                 <option value="12">12-棉花
                                 <option value="13">13-化肥及农药
                                 <option value="14">14-盐
                                 <option value="15">15-化工品
                                 <option value="16">16-金属制品
                                 <option value="17">17-工业机械
                                 <option value="18">18-电子电气机械
                                 <option value="19">19-农业机具
                                 <option value="20">20-鲜活货物
                                 <option value="21">21-农副产品
                                 <option value="22">22-饮食品及烟草制品
                                 <option value="23">23-纺织品
                                 <option value="24">24-纸及文教用品
                                 <option value="25">25-医药品
                                 <option value="99">99-其他货物
                                </select>
                                <span class="st-label">
                                   Start time:</span>
                                        <div data-date-viewmode="years" data-date-format="dd-mm-yyyy" data-date="15-05-2018" id="dpYears1" class="input-group date st">

                                            <input type="text" value="15-05-2018" class="form-control" id="time1">
                                            <span class="input-group-addon add-on entypo-calendar "></span>
                                        </div>
                                <span class="ed-label">
                                   End time:</span>
                                 <div data-date-viewmode="years" data-date-format="dd-mm-yyyy" data-date="15-05-2018" id="dpYears2" class="input-group date ed">

                                            <input type="text" value="15-05-2018" class="form-control" id="time2">
                                            <span class="input-group-addon add-on entypo-calendar "></span>
                                        </div>
                                <a onclick="showHeat();" style="margin-top:5px;margin-right:20px;"class="pull-right btn btn-info filter-api">Retrieve</a>
                            </div>
                            <div class="body-nest mapshow" id="Gmap">
                                <div id="container" class="gmap" style="width:100%;height:100%;position:relative;"></div>
                            </div>
                        </div>
                        <div class="nest map2" id="GmapClose">
                                <div style="padding:0px;width:100%;height:100%;position:relative;" class="body-nest" id="Gmap">
                                
                    <div class="blog-list-nest">
                        <div class="vendor">
                            <blockquote>
                                <p>Detail Infomation about the chosen type</p>
                            </blockquote>
                        </div>
                        </div>
                        <div class="oneline">
                                <div class="entypo-tooltip" style="color:#3498DB">
                                <li style="padding:0px;"class="icon icon-location" data-placement="right" title="aboveground-rail"></li>
                                </div>
                                <span class="label1"><span class="label s1">Type Name:</span><span id="cityName" class="s2"></span> </span>
                                </div>
                        <div class="oneline">
                                <div class="entypo-tooltip" style="color:#3498DB">
                                <li style="padding:0px;"class="fontawesome-truck" data-placement="right" title="aboveground-rail"></li>
                                </div>
                                <span class="label1"><span class="label s1">Total tonnage:</span><span id="total_tonnage" class="s2"></span> </span>
                                </div>
                        <div class="oneline">
                                <div class="entypo-tooltip" style="color:#3498DB">
                                <li style="padding:0px;"class="maki-aboveground-rail " data-placement="right" title="aboveground-rail"></li>
                                </div>
                                <span class="label1"><span class="label s1">Top Car Nums:</span><span id="total_carnum" class="s2"></span> </span>
                                </div>     
                                </div>
                            </div>
                        <div class="nest text" id="GmapClose">
                            <div style="padding:0px;width:100%;height:100%;position:relative;" class="body-nest" id="Gmap">
                                
                    <div class="blog-list-nest">
                        <div class="vendor">
                            <blockquote>
                                <p>Analysis about the send station</p>
                                <p id ="cityTitle">
                                    <small>电器类</small>
                                </p>
                            </blockquote>
                        </div>
                        </div>
                         <div class="oneline">
                     <ul class="list-inline" style="position:absolute;left:10px">
                                <li>
                                    <a id="ssjk" style="font-size:20px;color:#9ea7b3" onclick="showChart(1);">
                                        <span class="entypo-network" style="padding-right:15px"></span>&nbsp;&nbsp;Variety during chosen times</a>
                                </li>
                                </ul>
                                </div>
                        <div class="oneline">
                     <ul class="list-inline" style="position:absolute;left:10px">
                                <li>
                                    <a id="ssjk-1" style="font-size:20px;color:#9ea7b3" onclick="showChart(2);">
                                        <span class="entypo-network" style="padding-right:15px"></span>&nbsp;&nbsp;Top 5 Hottest Sub-types</a>
                                </li>
                                </ul>
                                </div>
                        <div id="tryc" class="oneline" style="margin-top:10px;margin-left:220px;display:none">
                                <div class="entypo-tooltip" style="color:#3498DB">
                                <li style="padding:0px;"class="icon icon-arrow-up data-placement="right" title="arrow-up"></li>
                                </div>
                                <span id= "tryClick"class="label1" style="margin-left:15px">Try Click</span>
                                </div>  
                                </div>
                            </div>
      <div id="gray3"></div>
	<div class="popup" id="popup_ssjk" style = "width:1000px;height:550px;top:15px;">
	<div class="top_nav" id='top_nav'style = "width:1000px">
		<div align="center">
			<span id="chartTitle"></span>
			<k class="guanbi"></k>
		</div>
		</div>
 <div id="chart1" class="chart" style="width: 100%; height:504px;display:none"><div class="chartjs-size-monitor" style="position: absolute; left: 0px; top: 0px; right: 0px; bottom: 0px; overflow: hidden; pointer-events: none; visibility: hidden; z-index: -1;"><div class="chartjs-size-monitor-expand" style="position:absolute;left:0;top:0;right:0;bottom:0;overflow:hidden;pointer-events:none;visibility:hidden;z-index:-1;"><div style="position:absolute;width:1000000px;height:1000000px;left:0;top:0"></div></div><div class="chartjs-size-monitor-shrink" style="position:absolute;left:0;top:0;right:0;bottom:0;overflow:hidden;pointer-events:none;visibility:hidden;z-index:-1;"><div style="position:absolute;width:200%;height:200%;left:0; top:0"></div></div></div>
		<canvas id="canvas" width="905" height="452" class="chartjs-render-monitor" style="display: block; height: 362px; width: 724px;"></canvas>
	</div>
<div id="chart2" class="chart" style="width: 100%; height:504px;display:none"><div class="chartjs-size-monitor" style="position: absolute; left: 0px; top: 0px; right: 0px; bottom: 0px; overflow: hidden; pointer-events: none; visibility: hidden; z-index: -1;"><div class="chartjs-size-monitor-expand" style="position:absolute;left:0;top:0;right:0;bottom:0;overflow:hidden;pointer-events:none;visibility:hidden;z-index:-1;"><div style="position:absolute;width:1000000px;height:1000000px;left:0;top:0"></div></div><div class="chartjs-size-monitor-shrink" style="position:absolute;left:0;top:0;right:0;bottom:0;overflow:hidden;pointer-events:none;visibility:hidden;z-index:-1;"><div style="position:absolute;width:200%;height:200%;left:0; top:0"></div></div></div>
		<canvas id="chart-area" width="482" height="241" class="chartjs-render-monitor" style="display: block; height: 193px; width: 386px;"></canvas>
	</div>
	</div>
                    <!-- </div>

                </div>
            </div> -->
    <script src="http://webapi.amap.com/maps?v=1.4.6&key=您申请的key值"></script>
    <script type="text/javascript" src="http://cache.amap.com/lbs/static/addToolbar.js"></script>
    <script type="text/javascript" src="http://a.amap.com/jsapi_demos/static/resource/heatmapData.js"></script>
    
    //创建地图
<script>
var randomScalingFactor = function() {
	return Math.round(Math.random() * 100);
};

var config = {
	type: 'pie',
	data: {
		datasets: [{
			data: [
				randomScalingFactor(),
				randomScalingFactor(),
				randomScalingFactor(),
				randomScalingFactor(),
				randomScalingFactor(),
			],
			backgroundColor: [
				window.chartColors.red,
				window.chartColors.orange,
				window.chartColors.yellow,
				window.chartColors.green,
				window.chartColors.blue,
			],
			label: 'Dataset 1'
		}],
		labels: [
			'Red',
			'Orange',
			'Yellow',
			'Green',
			'Blue'
		]
	},
	options: {
		responsive: true
	}
};

var chartData = {
		labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
		datasets: [{
			type: 'line',
			label: 'tonnage(Line)',
			borderColor: window.chartColors.blue,
			borderWidth: 2,
			fill: false,
			data: [
				randomScalingFactor(),
				randomScalingFactor(),
				randomScalingFactor(),
				randomScalingFactor(),
				randomScalingFactor(),
				randomScalingFactor(),
				randomScalingFactor()
			]
		}, {
			type: 'bar',
			label: 'tonnage(Bar)',
			backgroundColor: window.chartColors.red,
			data: [
				randomScalingFactor(),
				randomScalingFactor(),
				randomScalingFactor(),
				randomScalingFactor(),
				randomScalingFactor(),
				randomScalingFactor(),
				randomScalingFactor()
			],
			borderColor: 'white',
			borderWidth: 2
		}]
	};
	
window.onload = function() {
	var ctx1 = document.getElementById('canvas').getContext('2d');
	window.myLine = new Chart(ctx1, {
		type: 'bar',
		data: chartData,
		options: {
			responsive: true,
			title: {
				display: true,
				text: 'Variety during chosen times'
			},
			tooltips: {
				mode: 'index',
				intersect: true
			}
		}
	});
	var ctx2 = document.getElementById('chart-area').getContext('2d');
	window.myPie = new Chart(ctx2, config);
};
    $('#dpYears1').datepicker();
    $('#dpYears2').datepicker();
    var map = new AMap.Map("container", {
        resizeEnable: true,
        center: [116.418261, 39.921984],
        zoom: 4
    });
    if (!isSupportCanvas()) {
        alert('热力图仅对支持canvas的浏览器适用,您所使用的浏览器不能使用热力图功能,请换个浏览器试试~')
    }
    //详细的参数,可以查看heatmap.js的文档 http://www.patrick-wied.at/static/heatmapjs/docs.html
    //参数说明如下:
    /* visible 热力图是否显示,默认为true
     * opacity 热力图的透明度,分别对应heatmap.js的minOpacity和maxOpacity
     * radius 势力图的每个点的半径大小   
     * gradient  {JSON} 热力图的渐变区间 . gradient如下所示
     *	{
     .2:'rgb(0, 255, 255)',
     .5:'rgb(0, 110, 255)',
     .8:'rgb(100, 0, 255)'
     }
     其中 key 表示插值的位置, 0-1 
     value 为颜色值 
     */
    var heatmap;
    map.plugin(["AMap.Heatmap"], function() {
        //初始化heatmap对象
        heatmap = new AMap.Heatmap(map, {
            radius: 30, //给定半径
            opacity: [0.1, 0.8],
            /* gradient:{
             0.3: '#00FFFF',
             0.4: '#0000FF',
             0.5: '#7FFFAA',
             0.65: '#7FFFAA',
             0.7: 'rgb(0, 255, 0)',
             0.9: '#ffea00',
             1.0: 'red'*/
            /* gradient:{
                 0.4: '#FFB6C1',
                 0.5: '#7FFFAA',
                 0.65: '#7FFFAA',
                 0.7: 'rgb(0, 255, 0)',
                 0.9: '#ffea00',
                 1.0: 'red'
             }*/
             gradient:{
                 0.4: '#FFB6C1',
                 0.5: '#FA8072',
                 0.65: '#FF8C00',
                 0.7: '#FF7F50',
                 0.9: '#FF6347',
                 1.0: 'red'
             }
        });
    });
    //判断浏览区是否支持canvas
    function isSupportCanvas() {
        var elem = document.createElement('canvas');
        return !!(elem.getContext && elem.getContext('2d'));
    }
    var first=true;
    var flashWord=null;
    var isAble=false;
    function showHeat(){
    var urlCtl="ShipNum";
    if($('#ctl option:selected').val() == 'to')
    	urlCtl="ReceiptNum";
    load.loading.add(0.4);
        $.ajax({
				type:'get',
				url:"<%=basePath%>railwayData/"+urlCtl,
				data:{"startmonth":$("#time1").val(),"endmonth":$("#time2").val(),"productId":$('#type option:selected').val()},
				dataType:'json',
				success:function(data1){
					load.loading.remove();
					if(first==true){
				    	 document.getElementById('ssjk').style.color="#0DB8DF";
						 document.getElementById('ssjk-1').style.color="#0DB8DF";
						 document.getElementById('tryc').style.display="block";
						 flashWord=window.setInterval('set_word_shanshuo ()', 300);
						 first=false;
						 isAble=true;
				    }
                     heatmap.setDataSet({
                                     data: data1.city_ton_array,
                                     max: 3
                                            });
                    chartData.datasets[0].data.splice(0, 1);
                    chartData.datasets[1].data.splice(0, 1);
                    var colorNames = Object.keys(window.chartColors);
        			chartData.datasets[0].data=data1.per_month.y_ton;
        			chartData.datasets[1].data=data1.per_month.y_ton;
        			chartData.labels=data1.per_month.x_month;
        			window.myLine.update();
                    config.data.datasets.splice(0, 1);
         			var newDataset = {
         					backgroundColor: [],
         					data: data1.benifit_5.benifit,
         					label: 'Top 5 Hottest Sub-types' ,
         				};
         			config.data.labels=data1.benifit_5.productName;
         			for (var index = 0; index < config.data.labels.length; ++index) {
         					var colorName = colorNames[index % colorNames.length];
         					var newColor = window.chartColors[colorName];
         					newDataset.backgroundColor.push(newColor);
         				}

         			config.data.datasets.push(newDataset);
         			window.myPie.update();
         			$("#total_tonnage").text(data1.total_tonnage);
         			$("#total_carnum").text(data1.total_carnum);
         			$("#cityName").text($('#type option:selected').text());
				},
				error: function(json){
					load.loading.remove();
					alert("用户数据加载异常，请刷新后重试...");  
				}  
			});
    }
    function showChart(ctl){
    	if(!isAble){
    		return;
    	}
    	if(ctl==1){
    		document.getElementById("chart1").style.display="block";
    		document.getElementById("chart2").style.display="none";
    		$("#chartTitle").text("Variety during chosen times");
    	}
    	if(ctl==2){
    		document.getElementById("chart1").style.display="none";
    		document.getElementById("chart2").style.display="block";
    		$("#chartTitle").text("Top 5 Hottest Sub-types");
    	}
    }
    function set_word_shanshuo() {
    	var color = ['red','green','yellow','black','purple'];
    	$('#tryClick').css('color',color[parseInt(Math.random()*color.length)]);
    }
</script>
<script>
var load = window.whir || {};      
load.loading =      
{      
    add: function (opacity) {      
        opacity = opacity == undefined ? 0.4 : opacity;      
        var arr = this.getPageSize();      
        var width = parseInt(arr[2]);      
        var height = parseInt(arr[3]);      
      
        //背景遮罩      
        var mask = document.createElement("div");      
        mask.id = 'mask';      
        mask.style.position = 'fixed';      
        mask.style.left = '0';      
        mask.style.top = '0';      
        mask.style.width = '100%';      
        mask.style.height = parseInt(arr[1]) + "px";      
        mask.style.background = "#fff";      
        mask.style.filter = "alpha(opacity=" + opacity * 100 + ")";      
        mask.style.opacity = opacity;  
        mask.style.zIndex = "10000";      
        mask.addEventListener('touchstart', function (e) { e.preventDefault(); }, false);   //触摸事件      
        mask.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);    //滑动事件      
        mask.addEventListener('touchend', function (e) { e.preventDefault(); }, false);         //离开元素事件      
        document.body.appendChild(mask);      
      
        //提示文本      
        var loading = document.createElement("div");      
        loading.id = 'loading';      
        loading.style.position = 'absolute';      
        loading.style.left = ((width / 2) - 75) + "px";      
        loading.style.top = (height / 2 - 70) + "px";      
        loading.style.width = '50px';      
        loading.style.height = "50px";      
        loading.style.display = "inline-block";      
        loading.style.padding = "0px 5px 0 50px";      
        loading.style.zIndex = "100001";      
        loading.style.background = "url(<%=basePath%>images/loading.gif) no-repeat 20px 20px";
        document.body.appendChild(loading);      
    },   
    remove: function () {      
        var element = document.getElementById("mask");      
        element.parentNode.removeChild(element);      
        element = document.getElementById("loading");      
        element.parentNode.removeChild(element);      
    },      
    getPageSize: function () {      
        var xScroll, yScroll;      
        if (window.innerHeight && window.scrollMaxY) {      
            xScroll = window.innerWidth + window.scrollMaxX;      
            yScroll = window.innerHeight + window.scrollMaxY;      
        } else {      
            if (document.body.scrollHeight > document.body.offsetHeight) { // all but Explorer Mac          
                xScroll = document.body.scrollWidth;      
                yScroll = document.body.scrollHeight;      
            } else { // Explorer Mac...would also work in Explorer 6 Strict, Mozilla and Safari          
                xScroll = document.body.offsetWidth;      
                yScroll = document.body.offsetHeight;      
            }      
        }      
        var windowWidth = 0;      
        var windowHeight = 0;      
        var pageHeight = 0;      
        var pageWidth = 0;      
      
        if (self.innerHeight) { // all except Explorer          
            if (document.documentElement.clientWidth) {      
                windowWidth = document.documentElement.clientWidth;      
            } else {      
                windowWidth = self.innerWidth;      
            }      
            windowHeight = self.innerHeight;      
        } else {      
            if (document.documentElement && document.documentElement.clientHeight) { // Explorer 6 Strict Mode          
                windowWidth = document.documentElement.clientWidth;      
                windowHeight = document.documentElement.clientHeight;      
            } else {      
                if (document.body) { // other Explorers          
                    windowWidth = document.body.clientWidth;      
                    windowHeight = document.body.clientHeight;      
                }      
            }      
        }      
        // for small pages with total height less then height of the viewport          
      
        if (yScroll < windowHeight) {      
            pageHeight = windowHeight;      
        } else {      
            pageHeight = yScroll;      
        }      
        // for small pages with total width less then width of the viewport          
        if (xScroll < windowWidth) {      
            pageWidth = xScroll;      
        } else {      
            pageWidth = windowWidth;      
        }      
        var arrayPageSize = new Array(pageWidth, pageHeight, windowWidth, windowHeight);      
        return arrayPageSize;      
    }      
};      
</script>
<script src="<%=basePath%>js/popup.js"></script>
</body>

</html>
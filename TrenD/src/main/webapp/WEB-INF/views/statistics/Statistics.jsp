<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<title>TrenD</title>
<jsp:include page="../include/metalink.jsp" />

<!-- anychart 라이브러리 -->
<script
	src="https://cdn.anychart.com/releases/8.12.0/js/anychart-core.min.js"></script>
<script
	src="https://cdn.anychart.com/releases/8.12.0/js/anychart-tag-cloud.min.js"></script>
<script
	src="https://cdn.anychart.com/releases/v8/js/anychart-base.min.js"></script>
<script src="https://cdn.anychart.com/releases/v8/js/anychart-ui.min.js"></script>
<script
	src="https://cdn.anychart.com/releases/v8/js/anychart-exports.min.js"></script>
<link
	href="https://cdn.anychart.com/releases/v8/css/anychart-ui.min.css"
	type="text/css" rel="stylesheet">
<link
	href="https://cdn.anychart.com/releases/v8/fonts/css/anychart-font.min.css"
	type="text/css" rel="stylesheet">
<script>
 anychart.onDocumentReady(
		function () {
	$("#container1").hide();
	$("button").hide();

    // create data   
    var data = 
    	${json}		//[{"x" : 값,"value" : 값},{"x" : 값,"value" : 값}]의 형태로 값을 받음
    ;

    // create a chart and set the data
    var chart = anychart.tagCloud(data);
    
 // configure tooltips
    chart.tooltip().format("관심도:{%yPercentOfTotal}%\n접속횟수:{%value}");

    // Set starting angle.
    chart.fromAngle(0);

    // Set end angle.
     chart.toAngle(0);
    
    // set the chart title
    chart.title("클릭 시 상세 통계 페이지로 이동");

    // set the container id
    chart.container("container");

 // 워드클라우드의 모양을 결정. 단어가 많아지면 원형으로 표현되지만 단어가 적으면 효과가 적음
      chart.mode("spiral");
 
    // initiate drawing the chart
    chart.draw();
    
 // add an event listener
 //각 단어를 클릭시 해당 단어의 상세 통계 페이지로 이동하도록
    chart.listen("pointClick", function(e){
    	if(e.point.get("value")>0){
      //var url = "/StatisticsDetail?cateNm=" + e.point.get("x");
      //location.href=url; 
      detail(e.point.get("x"),"연령")
      //팝업처리? 아니면 ajax나 rest api?
      //restapi를 위해선 상세통계 페이지까지 여기서 다 함께 처리해야 함
      //각 단어를 클릭 시 location.href가 아니라 ajax 함수를 호출하도록 해야 함. 
      //해당 함수는 매개변수가 두 개. 카테고리 명과 value값을 받도록 해야 됨. 이 함수는 상세통계 페이지에서 버튼을 눌렀을 때 이동하는 동작을 동시에 처리하도록 만들어야
      //매개변수 두 개를 받아 컨트롤러에 전달 후, 해당 컨트롤러에서 리스트를 생성하여 model로 공유하는 것이 아닌 restapi 방식으로 받아오도록 처리해야 됨
    	}
    });
 
}
		); 

function detail(a,b){
	const value = b

	var category = a;
	
	
	$.ajax({
		type : "get",
		url : "${pageContext.request.contextPath}/StatisticsDetail/"+value,
		data : {"category":category},

		success : function(result){
			$("#container").hide()
			$("#container1").empty()

	 	    var chart1 = anychart.pie(result.list);

	 		chart1.tooltip().format("접속횟수:{%value}");

	 	    chart1
	 	      .title(result.value+' 별 통계')
	 	      .radius('43%')
	  	      .innerRadius('30%');

	 	    chart1.container('container1');
	 	   $("#container1").show()					
	 	   $("button").show()
	 	  	  chart1.draw();
	 	   
	 	    // initiate chart drawing
	 	    
	 	  
	 	  
	 	  var buttons = 
	 		  '<button type="button" class="btn btn-primary" id="age" value="연령"'
	 		  buttons +=' onclick="javascript:detail(`'+result.category+'`,this.value)">연령</button>'
	 		  buttons +='<button type="button" class="btn btn-secondary" id="gender" value="성별"'
	 		  buttons +=' onclick="javascript:detail(`'+result.category+'`,this.value)">성별</button>'
	 		  buttons +='<button type="button" class="btn btn-info" id="location" value="지역"'
	 		  buttons +=' onclick="javascript:detail(`'+result.category+'`,this.value)">지역</button>'
	 		  buttons +='<button type="button" class="btn btn-light"'
	 		  //매우 다행히도 백틱(`)을 통해 삼중 따옴표를 구현하는 것이 가능. 따라서 "" 안에 '' 안에 ``의 형태로 값을 넣는 것이 가능
	 		  //location.href=""의 형태로 사용되는데, 이때 "" 안의 값이 문자열이라면 한 번 더 감싸줘야 함. 이 코드를 문자열 안에서 구현 중
	 		  //다만 백틱은 ES6부터만 호환됨... 어떻게 해결할 것인가?
	 		  buttons +=' onclick="home()">처음으로</button>'
			<!-- this로 현재 위치의 DOM 객체를 지정 가능. 그 중 value값을 뽑아냄. -->
	 		  console.log(result.category)

	 		  $("#button").html(buttons);		
			
				
			
				
			
	 	  
	 	    
		}	
	});	
 	
 	}

function home(){
	  location.href="/Statistics"
 }



</script>
<style>
html, body, main, #container, #container1 {
	width: 95%;
	height: 95%;
	margin: 0px 0px 0px 0px;
	padding: 0px 0px;
}

#button {
	width: 50%;
	margin: 5px 0px 5px 400px;
}

button {
	margin: 5px 10px 5px 10px;
}
}
</style>

</head>
<body>
	<main id=main class="main">
		<jsp:include page="../include/header.jsp" />
		<jsp:include page="../include/sidebar.jsp" />
		<div id="container"></div>
		<div id="container1"></div>
		<div id="button"></div>
		<!-- 워드클라우드 출력 -->
		<%@ include file="../include/footer.jsp"%>
	</main>
</body>
</html>
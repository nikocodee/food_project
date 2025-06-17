<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>       
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/resources/css/storeInfo.css">
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
<title>Insert title here</title>
<style type="text/css">
	#result_card img{
		max-width: 100%;
	    height: auto;
	    display: block;
	    padding: 5px;
	    margin-top: 10px;
	    margin: auto;	
	    width:250px; 
	    height:169px;
	}
	#result_card {
		position: relative;
	}
</style>
</head>

<body>
	<div class="container">	
	<a class="main_logo" href="/main">
		<img src="/resources/img/logo.jpg" style="width:160px;transform:translate(-770px,10px);">
		</a>
	<div class="card">
		<a class="back_logo" href="/search" style="margin:0; padding:0;">
			<img src="/resources/img/back.png" style="margin:0; padding:0; width:30px;transform:translate(10px,10px);">
		</a>
		<div class="register" style="width:540px;margin-left:530px;border:1px;">
		    <div class="info-container">
		        <div class="pop-conts">
		        	  <form id="info_form" method="post">
					<div class="logo_wrap2">
					</div>
					<div class="login_id2" style="margin-top:10px;font-weight:900;">
						<div class="col-name">
							<c:out value="${storeInfo.st_name}"/>
						</div>
					</div>
					<div class="login_id2">
						<div class="col-type">
							<c:out value="${storeInfo.st_type}"/>
						</div>
					</div>
					<div class="login_id2">
						<div class="col">
							<img src="/resources/img/tel.png" style="width:15px;">
							&nbsp;<c:out value="${storeInfo.st_tel}"/>
						</div>
					</div>
					<div class="login_id2">
						<div class="col">
							<img src="/resources/img/time.png" style="width:15px;">&nbsp;
							<c:out value="${storeInfo.st_time1}"/> ~ 
							<c:out value="${storeInfo.st_time2}"/>
						</div>
					</div>
					<div class="login_id2">
						<div class="col-addr1">
							<img src="/resources/img/map.png" style="width:15px;">
							<c:out value="${storeInfo.st_addr1}"/>
						</div>
					</div>
					<div class="login_id2" style="margin-top: 10px;">
						<div class="col-addr2">
							<c:out value="${storeInfo.st_addr2}"/>
						</div>
					</div>
					<div class="login_id2" style="margin-top: 10px;">
						<div class="col-addr3">
							<c:out value="${storeInfo.st_addr3}"/>
						</div>
					</div>
					<div class="login_id2">
						<div class="col-info">
							<c:out value="${storeInfo.st_info}"/>
						</div>
					</div>
				
				<div id="image_section" style="transform:display: inline-block;height:0;">
				<div style="border:1px solid lightgray;width:48%;height:177px;transform:translate(-186%,-95%);">
					<div class="image">
					
						<div id="uploadResult">
						
						</div>	
					</div>
				</div>
				</div>
				<div>
				
				</div>
				<div id="map" style="width:70%;height:300px;transform:translate(-53%, -169px);border:1px solid lightgray;"></div>

				</form>
				
				<form id="moveForm" action="/search" method="get" >
				<input type="hidden" name="pageNum" value="${cri.pageNum}">
				<input type="hidden" name="amount" value="${cri.amount}">
				<input type="hidden" name="keyword" value="${cri.keyword}">
				</form>
		        </div>
		    </div>
		</div>
		</div>
	</div>	
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=163f4d05cd47589d5149d06341d694a1&libraries=services"></script>	
<script>
	$(document).ready(function(){
		
		/* 이미지 정보 호출 */
		let st_id = '<c:out value="${storeInfo.st_id}"/>';
		let uploadResult = $("#uploadResult");			
		
		$.getJSON("/getAttachList", {st_id : st_id}, function(arr){	
			
			let str = "";
			let obj = arr[0];	
			
			let fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
			str += "<div id='result_card'";
			str += "data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "'";
			str += ">";
			str += "<img src='/display?fileName=" + fileCallPath +"'>";
			str += "</div>";		
			
			uploadResult.html(str);
			
		});	
		
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };  

	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 

	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();

	// 주소로 좌표를 검색합니다
	geocoder.addressSearch('${storeInfo.st_addr2}', function(result, status) {

	    // 정상적으로 검색이 완료됐으면 
	     if (status === kakao.maps.services.Status.OK) {

	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

	        // 결과값으로 받은 위치를 마커로 표시합니다
	        var marker = new kakao.maps.Marker({
	            map: map,
	            position: coords
	        });

	        // 인포윈도우로 장소에 대한 설명을 표시합니다
	        var infowindow = new kakao.maps.InfoWindow({
	            content: '<div style="width:150px;text-align:center;padding:6px 0;">${storeInfo.st_name}</div>'
	        });
	        infowindow.open(map, marker);

	        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	        map.setCenter(coords);
	    } 
	});    
		
	});
	

</script>
</body>
</html>
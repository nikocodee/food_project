<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>       
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/resources/css/store.css">
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
	    height:200px;
	}
	#result_card {
		position: relative;
	}
	.imgDeleteBtn{
	    position: absolute;
	    top: 0;
	    right: 5%;
	    background-color: #ef7d7d;
	    color: wheat;
	    font-weight: 900;
	    width: 30px;
	    height: 30px;
	    border-radius: 50%;
	    line-height: 26px;
	    text-align: center;
	    border: none;
	    display: block;
	    cursor: pointer;	
	}
	
</style>
</head>

<body>
	<div class="container">	
		<div class="register" style="width:540px;margin-left:530px;border:1px;">
		    <div class="info-container">
		        <div class="pop-conts">
		            <form id="info_form" method="post">
					<div class="logo_wrap2">
						<h2 style="margin-top:30px;margin-right:200px;margin-left:-260px;margin-bottom:50px;">매장 정보</h2>
					</div>
					<div class="login_id2" style="margin-top: 10px;">
						<h4 style="padding-left: 72px;">매장 이름</h4>
						<div class="col">
							<input name="st_name" value="<c:out value="${storeInfo.st_name}"/>" disabled>
						</div>
					</div>
					<div class="login_id2">
						<h4 style="padding-left: 72px;">사업자번호</h4>
						<div class="col">
							<input id="pw_input" name="st_biznum" value="<c:out value="${storeInfo.st_biznum}"/>" disabled>
						</div>
					</div>
					<div class="login_id2">
						<h4 style="padding-left: 72px;">매장 종류</h4>
						<div class="col">
							<input id="pw_input" name="st_type" value="<c:out value="${storeInfo.st_type}"/>" disabled>
						</div>
					</div>
					<div class="login_id2">
						<h4 style="padding-left: 72px;">매장 번호</h4>
						<div class="col">
							<input id="tel_input" name="st_tel" value="<c:out value="${storeInfo.st_tel}"/>" disabled>
						</div>
					</div>
					<div class="login_id2">
						<h4 style="padding-left: 72px;">운영시간</h4>
						<div class="col">
							<input type="time" id="tel_input" name="st_time1" value="<c:out value="${storeInfo.st_time1}"/>" disabled style="width:33%;"> ~&nbsp 
							<input type="time" id="tel_input" name="st_time2" value="<c:out value="${storeInfo.st_time2}"/>" disabled style="width:33%;margin-left:-6px;">
						</div>
					</div>
					<div class="login_id2">
						<h4 style="padding-left:72px;">주소</h4>
						<div class="addr_input_box">
							<input id="address_input_1" name="st_addr1" value="<c:out value="${storeInfo.st_addr1}"/>" disabled
							style="display:inline;width:71%;">
						</div>
					</div>
					<div class="login_id2" style="margin-top: 10px;">
						<div class="col">
							<input id="address_input_2" name="st_addr2" value="<c:out value="${storeInfo.st_addr2}"/>" disabled
							style="margin-top: -5px;">
						</div>
					</div>
					<div class="login_id2" style="margin-top: 10px;">
						<h4 style="padding-left:72px;">상세주소</h4>
						<div class="col">
							<input id="address_input_3" name="st_addr3" value="<c:out value="${storeInfo.st_addr3}"/>" disabled>
						</div>
					</div>
					<div class="login_id2">
						<h4 style="padding-left: 72px;">매장 소개</h4>
						<div class="col">
							<textarea id="st_info_input" name="st_info" disabled>${storeInfo.st_info}
							</textarea>
						</div>
					</div>
				
				<div id="image_section" style="transform:display: inline-block;height:0;">
				<div style="border:1px solid lightgray;border-radius:20px;width:70%;height:240px;transform:translate(-90%,-285%);">
					<div class="image">
					
						<div id="uploadResult">
						
						</div>	
					</div>
				</div>
				</div>
				<div id="map" style="width:70%;height:340px;transform:translate(-90%,-120%);"></div>

				</form>
				<form style="transform: translate(-75%,-320%);">
					<div class="submit2">
						<input type="button" id="list_button" value="목록" style="margin-top: 20px;margin-left: 160px;">
						<input type="button" id="modify_button" value="수정" style="transform: translate(115%,-100%);margin-left: 160px;background: dodgerblue;">
					</div>
				</form>
				<form id="moveForm" action="/store/main" method="get" >
				<input type="hidden" name="pageNum" value="${cri.pageNum}">
				<input type="hidden" name="amount" value="${cri.amount}">
				<input type="hidden" name="keyword" value="${cri.keyword}">
				</form>
		        </div>
		    </div>
		</div>
	</div>	
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=163f4d05cd47589d5149d06341d694a1&libraries=services"></script>	
<script>
	$(document).ready(function(){
		$('#modify_button').on("click", function(){
			let addInput = '<input type="hidden" name="st_id" value="${storeInfo.st_id}">';
			$("#moveForm").append(addInput);
			$("#moveForm").attr("action", "/store/storeModify");
			$("#moveForm").submit();
		});
		$('#list_button').on("click", function(e){
			e.preventDefault();
			$("#moveForm").submit();		
		});
		
		
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
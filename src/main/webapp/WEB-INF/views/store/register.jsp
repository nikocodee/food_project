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
						<h2 style="margin-top:30px;margin-right:200px;margin-left:-260px;margin-bottom:50px;">매장 정보 등록</h2>
					</div>
					<div class="login_id2" style="margin-top: 10px;">
						<h4 style="padding-left: 72px;">매장 이름</h4>
						<div class="col">
							<input name="st_name">
						</div>
					</div>
					<div class="login_id2">
						<h4 style="padding-left: 72px;">사업자번호</h4>
						<div class="col">
							<input id="pw_input" name="st_biznum">
						</div>
					</div>
					<div class="login_id2">
						<h4 style="padding-left: 72px;">매장 종류</h4>
						<div class="col" style="margin-left:70px;">
							<select name="st_type" style="border-radius:20px;width:50%;height:30px;border:1px solid lightgray;margin-top:10px;">
               					<option value="종류" selected>-- 카테고리 --</option>
               					<option value="한식">한식</option>
               					<option value="양식">양식</option>
               					<option value="중식">중식</option>
               					<option value="일식">일식</option>
               					<option value="카페/디저트">카페/디저트</option>
               				</select>
						</div>
					</div>
					<div class="login_id2">
						<h4 style="padding-left: 72px;">매장 번호</h4>
						<div class="col">
							<input id="tel_input" name="st_tel">
						</div>
							<span class="final_tel_ck">전화번호를 입력해주세요.</span>
					</div>
					<div class="login_id2">
						<h4 style="padding-left: 72px;">운영시간</h4>
						<div class="col">
							<input type="time" id="tel_input" name="st_time1" style="width:33%;"> ~&nbsp 
							<input type="time" id="tel_input" name="st_time2" style="width:33%;margin-left:-6px;">
						</div>
							<span class="final_tel_ck">전화번호를 입력해주세요.</span>
					</div>
					<div class="login_id2">
						<h4 style="padding-left:72px;">주소</h4>
						<div class="addr_input_box">
							<input id="address_input_1" name="st_addr1" readonly="readonly"
							style="display:inline;width:71%;">
							<input type="button" id="address_button" onclick="execution_daum_adress()" value="주소 찾기"
							style="background:#ececec;word-spacing: normal;font-weight:bolder;width: 29%;margin-left: -130px;
							cursor:pointer;">
						</div>
					</div>
					<div class="login_id2" style="margin-top: 10px;">
						<div class="col">
							<input id="address_input_2" name="st_addr2" readonly="readonly"
							style="margin-top: -5px;">
						</div>
					</div>
					<div class="login_id2" style="margin-top: 10px;">
						<h4 style="padding-left:72px;">상세주소</h4>
						<div class="col">
							<input id="address_input_3" name="st_addr3">
						</div>
					</div>
					<span class="final_addr_ck">주소를 입력해주세요.</span>
					<div class="login_id2">
						<h4 style="padding-left: 72px;">매장 소개</h4>
						<div class="col">
							<textarea id="st_info_input" name="st_info">
							</textarea>
						</div>
							<span class="final_tel_ck">전화번호를 입력해주세요.</span>
					</div>
				
				<div id="image_section" style="transform:display: inline-block;height:0;">
				<div style="border:1px solid lightgray;border-radius:20px;width:65%;height:440px;transform:translate(-90%,-162%);">
					<div class="image">
						<input type="file" id="fileItem" name='uploadFile' style="height:30px;transform: translate(30%,1600%);" multiple>
						<div id="uploadResult">
							<!-- 
							<div id="result_card">
								<div class="imgDeleteBtn">x</div>
								<img src="/display?fileName=img.png">
							</div>
							 -->
						</div>	
					</div>
				</div>
				</div>
				</form>
				<form style="transform: translate(-75%,-110%);">
					<div class="submit2">
						<input type="button" id="cancel_button" value="취소" style="margin-top: 20px;margin-left: 160px;">
						<input type="button" id="register_button" value="등록" style="transform: translate(115%,-100%);margin-left: 160px;background: dodgerblue;">
					</div>
				</form>
		        </div>
		    </div>
		</div>
	</div>	
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>	
<script>
	$(document).ready(function(){
		$('#register_button').on("click", function(){
			$('#info_form').submit();		
		});
		$('#cancel_button').on("click", function(){
			$('#info_form').attr("action","/store/main");
			$('#info_form').attr("method","get");
			$('#info_form').submit();		
		});
		
		/*이미지 업로드*/
		$("input[type='file']").on("change", function(e){
			
			/* 이미지 존재시 삭제 */
			/* if($(".imgDeleteBtn").length > 0){
				deleteFile();
			} */
			
			let formData = new FormData();
			let fileInput = $('input[name="uploadFile"]');
			let fileList = fileInput[0].files;
			let fileObj = fileList[0];
			
			
			/* if(!fileCheck(fileObj.name, fileObj.size)){
				return false;
			} */
			
			for(let i = 0; i < fileList.length; i++){
				formData.append("uploadFile", fileList[i]);
			}
			
			$.ajax({
				url: '/store/uploadAjaxAction',
				processData: false,
				contentType: false,
				data: formData,
				type: 'POST',
				dataType: 'json',
				success: function(result){
					console.log(result);	
					showUploadImage(result);
				},
				error: function(result){
					alert("이미지 파일이 아닙니다.");
				}
			});
			
		});
		
		let regex = new RegExp("(.*?)\.(jpg|png)$");
		let maxSize = 1048576; //1MB	
		
		function fileCheck(fileName, fileSize){

			if(fileSize >= maxSize){
				alert("파일 사이즈 초과");
				return false;
			}
				  
			if(!regex.test(fileName)){
				alert("해당 종류의 파일은 업로드할 수 없습니다.");
				return false;
			}
			
			return true;		
			
		}
		
		/* 이미지 출력*/
		function showUploadImage(uploadResultArr){
			if(!uploadResultArr || uploadResultArr.length == 0){return}
			
			let uploadResult = $("#uploadResult");
			
			let obj = uploadResultArr[0];
			
			let str = "";
			
			let fileCallPath = encodeURIComponent(obj.uploadPath.replace(/\\/g, '/') + "/s_" + obj.uuid + "_" + obj.fileName);
			
			str += "<div id='result_card'>";
			str += "<img src='/display?fileName="+ fileCallPath +"'>";
			str += "<div class='imgDeleteBtn' data-file='" + fileCallPath + "'>x</div>";
			str += "<input type='hidden' name='imageList[0].fileName' value='"+ obj.fileName +"'>";
			str += "<input type='hidden' name='imageList[0].uuid' value='"+ obj.uuid +"'>";
			str += "<input type='hidden' name='imageList[0].uploadPath' value='"+ obj.uploadPath +"'>";
			str += "</div>";
			
			uploadResult.append(str);
		}
		
		/* 이미지 삭제 버튼 동작 */
		$("#uploadResult").on("click", ".imgDeleteBtn", function(e){
			deleteFile();
			
		});
		
		/* 파일 삭제 메서드 */
		function deleteFile(){
			
			let targetFile = $(".imgDeleteBtn").data("file");
			let targetDiv = $("#result_card");
			
			$.ajax({
				url: '/store/deleteFile',
				data : {fileName : targetFile},
				dataType : 'text',
				type : 'POST',
				success : function(result){
					console.log(result);
					
					targetDiv.remove();
					$("input[type='file']").val("");
					
				},
				error : function(result){
					console.log(result);
					
					alert("파일을 삭제하지 못하였습니다.")
				}
			});
			
		}
		
	});
	
	function execution_daum_adress(){
		
		new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
	        	// 각 주소의 노출 규칙에 따라 주소를 조합한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            var addr = ''; // 주소 변수
	            var extraAddr = ''; // 참고항목 변수
	
	            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                addr = data.roadAddress;
	            } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                addr = data.jibunAddress;
	            }
	
	            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	            if(data.userSelectedType === 'R'){
	                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                    extraAddr += data.bname;
	                }
	                // 건물명이 있고, 공동주택일 경우 추가한다.
	                if(data.buildingName !== '' && data.apartment === 'Y'){
	                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                if(extraAddr !== ''){
	                    extraAddr = ' (' + extraAddr + ')';
	                }
	             	// 주소변수 문자열과 참고항목 문자열 합치기
	               	 addr += extraAddr;
	            
	            } else {
	                addr += ' ';
	            }
	
	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	            $("#address_input_1").val(data.zonecode);
	            //$("[name=memberAddr1]").val(data.zonecode);    // 대체가능
	            $("#address_input_2").val(addr);
	            //$("[name=memberAddr2]").val(addr);    
	            // 커서를 상세주소 필드로 이동한다.
	            // 상세주소 입력란 disabled 속성 변경 및 커서를 상세주소 필드로 이동한다.
	           	$("#address_input_3").attr("readonly",false);
	            $("#address_input_3").focus();
	        }
	    }).open();
	}
</script>
</body>
</html>
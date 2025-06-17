<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>       
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/resources/css/menuRegister.css">
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
						<h2 style="margin-top:50px;margin-right:200px;margin-left:-260px;margin-bottom:40px;">메뉴 등록</h2>
					</div>
					<div class="login_id2" style="margin-top: 10px;">
						<h4 style="transform: translate(1px, 65px);">메뉴 이름</h4>
						<div class="col">
							<input name="mn_name" style="transform: translate(0px, 40px);">
						</div>
					</div>
					<div class="login_id2">
						<h4 style="transform: translate(10px, 46px);">메뉴 가격</h4>
						<div class="col">
							<input name="mn_price" id="money" style="transform: translate(0px, 20px);" onkeyup="numberWithCommas(this.value)">
						</div>
					</div>
					<div class="login_id2">
						<h4 style="transform: translate(37px, 25px);">매장</h4>
						<div class="col">
							<input id="store_name_input" style="transform: translate(0px, 1px);">
							<input id="st_id_input" name="st_id" type="hidden">
							<button class="store_btn"
							style="border-radius:10px;background:lightpink;border: 1px solid;color:white;
							width:75px;padding:2px;font-weight:500;cursor:pointer;height: 30px;">매장 선택</button>
						</div>
					</div>
					<div class="login_id2">
						<h4 style="transform: translate(7px, 15px);">메뉴 소개</h4>
						<div class="col">
							<textarea name="mn_content" 
							style="border-radius: 10px; transform: translate(72px, -10px); border: 1px solid #ccc;width: 217px;">
							</textarea>
						</div>
					</div>
				
				<div id="image_section" style="transform:display: inline-block;height:0;">
				<div style="border:1px solid lightgray;border-radius:20px;width:45%;height:150px;transform:translate(-110%,-123%);">
					<div class="image">
						<input type="file" id="fileItem" name='uploadFile' style="transform: translate(35px,155px);" multiple>
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
						<input type="button" id="cancel_button" value="취소" style="transform: translate(320px, 140px);">
						<input type="button" id="register_button" value="등록" style="transform: translate(270px,90px);margin-left: 160px;background:lightblue;">
					</div>
				</form>
		        </div>
		    </div>
		</div>
	</div>	
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>	
<script>
	$(document).ready(function(){
		$('#register_button').on("click", function(e){
			e.preventDefault();
			$('#info_form').submit();		
		});
		$('#cancel_button').on("click", function(){
			$('#info_form').attr("action","/menu/main");
			$('#info_form').attr("method","get");
			$('#info_form').submit();		
		});
		
		/*매장 선택 버튼*/
		$('.store_btn').on("click", function(e){
			e.preventDefault();
			
			let popUrl = "/menu/storePop";
			let popOption = "width=650px;, height=500px; top=300px; left=300px; scrollbars=yes";
		
			window.open(popUrl,"매장 찾기",popOption);		
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
				url: '/menu/uploadAjaxAction',
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
				url: '/menu/deleteFile',
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
	
	function numberWithCommas(x) {
		x = x.replace(/[^0-9]/g,'');   // 입력값이 숫자가 아니면 공백
		x = x.replace(/,/g,'');          // ,값 공백처리
		$("#money").val(x.replace(/\B(?=(\d{3})+(?!\d))/g, ",")); // 정규식을 이용해서 3자리 마다 , 추가 
	}
	
</script>
</body>
</html>
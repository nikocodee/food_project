<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>       
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/resources/css/info_modify.css">
<link href="/resources/img/favicon.png" rel="icon" type="image/x-icon" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
<title>오늘 뭐 먹지?</title>
<style>
h4{
	font-size: 13px;
    font-weight: 600;
}
</style>
</head>
<body>
	<div class="container">	
		<div class="info" style="width:530px;margin-left:300px;border:1px;">
		    <div class="pop-container" style="border:1px solid #ccc;margin-top:20px;height:530px;">
		        <div class="pop-conts">
		            <form id="info_form" method="get" style="margin-left:-20px;">
					<div class="logo_wrap2">
						<h2 style="margin-top:20px;font-size:1.8em;margin-left:20px;">회원정보</h2>
					</div>
					<div class="login_id2" style="margin-top: 10px;">
						<h4 style="padding-left:72px;width:60%;transform: translate(26px, 30px);">아이디</h4>
						<div class="col">
							<input name="id" value="${info.id}" readonly="readonly" style="background-color:#dcdcdc;">
						</div>
					</div>
					<div class="login_id2">
						<h4 style="padding-left: 72px;transform: translate(38px, 10px);">이름</h4>
						<div class="col">
							<input name="name" value="${info.name}" readonly="readonly" 
							style="background-color:#dcdcdc;transform: translate(1px, -20px);">
						</div>
					</div>
					<div class="login_id2">
						<h4 style="padding-left: 72px;transform: translate(18px, -8px);">전화번호</h4>
						<div class="col">
							<input id="tel_input" name="tel" value="${info.tel}" onfocus="this.value=''" style="transform: translate(1px, -40px);">
						</div>
							<span class="final_tel_ck">전화번호를 입력해주세요.</span>
					</div>
					<div class="login_id2">
						<h4 style="padding-left: 72px;transform: translate(25px, -30px);">이메일</h4>
						<div class="mail_name"></div> 
						<div class="mail_input_box">
							<input type="email" id="mail_input" name="mail" value="${info.mail}" readonly="readonly" 
							style="background-color:#dcdcdc;transform: translate(15px, -60px);width: 320px;">
						</div>
					</div>
					
					<div class="login_id2">
						<h4 style="padding-left:72px;transform: translate(35px, -50px);">주소</h4>
						<div class="addr_input_box">
							<input id="address_input_1" name="addr1" value="${info.addr1}" readonly="readonly"
							style="display:inline;width:66%;transform: translate(15px, -82px);">
							<input type="button" id="address_button" onclick="execution_daum_adress()" value="주소 찾기"
							style="background:pink;font-size:0.8em;color:#fff;word-spacing: normal;font-weight:600;width: 29%;margin-left: -130px;
							cursor:pointer;transform: translate(50px,-83px);height:33px;">
						</div>
					</div>
					<div class="login_id2" style="margin-top: 10px;">
						<div class="col">
							<input id="address_input_2" name="addr2" value="${info.addr2}" readonly="readonly"
							style="margin-top: -5px;transform: translate(1px, -78px);">
						</div>
					</div>
					<div class="login_id2" style="margin-top: 10px;">
						<div class="col">
							<input id="address_input_3" name="addr3" value="${info.addr3}" onfocus="this.value=''" style="transform: translate(1px,-75px);">
						</div>
					</div>
					<span class="final_addr_ck">주소를 입력해주세요.</span>
				</form>
				<div class="submit2">
					<input type="hidden" name="id" class="member_id">
					<input type="button" id="cancel_button" value="취소" style="margin-top: 20px;margin-left: 90px;background: lightgray;transform: translate(30px, -60px);">
					<input type="button" id="modify_button" value="수정" style="transform: translate(140px, -110px);margin-left: 90px;background: dodgerblue;">
					<input type="button" id="delete_button" value="회원탈퇴" style="transform: translate(260%,-320%);margin-left: 90px;background:tomato;"> 
					</div>
		            <!--// content-->
		        </div>
		    </div>
		</div>
	</div>	

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>			
<script>

	var code = ""; //이메일전송 인증번호 저장위한 코드
	
	var pwCheck = false;          
	var pwckCheck = false;           
	var pwckcorCheck = false;        // 비번 확인 일치 확인
	var telCheck = false;
	var mailCheck = false;
	var addressCheck = false
	
	var regPhone = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
	var regPw = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$/;

  $(document).ready(function(){
	 $("#cancel_button").on("click", function(){
		 $("#info_form").attr("action", "/main");
		 $("#info_form").submit();
	 });
	
 	 $("#delete_button").on("click", function(){
		 $("#info_form").attr("action", "/member/info_delete");
		 $("#info_form").attr("method", "get");
 		 $("#info_form").submit();
 		 alert("회원탈퇴가 완료되었습니다.");
	 });
	 
	 $("#modify_button").on("click", function(){
		 
		 /* 입력값 변수 */
		var name = $('#user_input').val();
		var tel = $('#tel_input').val();
		var mail = $('#mail_input').val();
		var addr = $('#address_input_3').val();
		
		if( regPhone.test(tel) === false ){
			alert("올바르지 못한 전화번호 형식입니다. 다시 입력해주세요. ex) 010-1234-5678");
			return;
		}
		
		/* 전화번호 유효성 검사 */
        if(tel == ""){
            $('.final_tel_ck').css('display','block');
            telCheck = false;
        }else{
            $('.final_tel_ck').css('display', 'none');
            telCheck = true;
        }
		
        /* 이메일 유효성 검사 */
        if(mail == ""){
            $('.final_mail_ck').css('display','block');
            mailCheck = false;
        }else{
            $('.final_mail_ck').css('display', 'none');
            mailCheck = true;
        }
        
        /* 주소 유효성 검사 */
        if(addr == ""){
            $('.final_addr_ck').css('display','block');
            addressCheck = false;
        }else{
            $('.final_addr_ck').css('display', 'none');
            addressCheck = true;
        }
        
        /* 최종 유효성 검사 */
        if(telCheck&&addressCheck){
		 
		 $("#info_form").attr("action", "/member/info_modify");
		 $("#info_form").attr("method", "post");
		 $("#info_form").submit();
		 alert("회원정보가 수정되었습니다.");
        }
        
        return false;
	 });
  
 	$("#modify_button2").on("click", function(){
 		 $("#pw_form").submit();	
 	});
 	
 	
 	/* var pw = $('#new_pw').val();
		 	var params = { "pw" : pw };
		 	
        	$.ajax({
    			type : "POST",
    			url : "/member/info_modify.do",
    			contentType : 'application/json; charset=UTF-8',
    			data:JSON.stringify(params),
    			success:function(data){
    				console.log(data);
    				
    				if(data == "1"){
    					alert("비밀번호가 수정되었습니다.");
    					document.location.reload();
    				}else{
    					alert("잘못된 비밀번호 입니다.");
    				}
    			},
    			error : function(request, status, error) {
    				console.log("시스템에러 입니다. 시스템 담당자에게 문의주세요.");
    			}
    		}); */
 
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
	
	/*비밀번호 확인 일치 유효성검사*/
	/*change keyup paste 변화감지(입력하면 변화됨)*/
	$('#new_pw2').on("propertychange change keyup paste input", function(){
		var pw = $('#new_pw').val();
		var pwck = $('#new_pw2').val();
		$('.final_pwck_ck').css('display','none');
		
		if(pw == pwck){
			$('.pwck_input_re_1').css('display','block');
			$('.pwck_input_re_2').css('display','none');
			pwckcorCheck = true;
		}else{
			$('.pwck_input_re_1').css('display','none');
			$('.pwck_input_re_2').css('display','block');
			pwckcorCheck = false;
		}
		
	});
  });	
</script>			
</body>
</html>
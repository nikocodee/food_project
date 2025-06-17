<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>       
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/resources/css/info.css">
<link href="/resources/img/favicon.png" rel="icon" type="image/x-icon" />
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
.pop-container{
 	border: 1px solid #ccc;
 	margin-top: 100px;
    width: 400px;
}
.newpw_input_box input{
	width: 60%;
	height: 30px;
	border-radius: 30px;
	margin-top: 10px;
	margin-left: 78px;
	padding: 0px 20px;
	border: 1px solid lightgray;
	outline: none;
}
.submit2 input{
	width: 23%;
	height: 45px;
}
</style>
</head>
<body>
	<div class="container">	
		<div class="info" style="width:540px;margin-left:430px;border:1px;">
		    <div class="pop-container">
		        <div class="pop-conts">
		            <form id="pw_form" method="post">
						<div class="repw_wrap">
							<div class="newpw_input_box">
								<h4 style="margin-left:80px;margin-top:50px;">현재 비밀번호 확인</h4>
								<input type="password" class="repw_input" id="join_pw" name="pw"  placeholder="현재 비밀번호 확인">
							</div>
						</div>
						<div class="pw_wrap">
							<div class="newpw_input_box">
								<h4 style="margin-left:80px;margin-top:10px;">새 비밀번호</h4>
								<input type="password" class="newpw_input" id="new_pw" name="newpw" placeholder="새 비밀번호">
							</div>
								<span class="pw_input_re" 
								style="font-size: 0.5rem;margin-left:85px;font-weight:bolder;
								color:darkgrey;word-spacing: normal;">
								※대소문자,숫자,특수문자 포함 8자리 이상 입력</span>
								<span class="final_pw_ck">비밀번호를 입력해주세요.</span>
							<div class="newpw_input_box">
								<input type="password" class="newpw_input2" id="new_pw2" name="newpwco" placeholder="새 비밀번호 획인">
							</div>
								<span class="pwck_input_re_1">비밀번호가 일치합니다.</span>
								<span class="pwck_input_re_2">비밀번호가 일치하지 않습니다.</span>
								<span class="final_pwck_ck">비밀번호를 입력해주세요.</span>
						<c:if test="${result == 0 }">
							<div class = "pw_warn">기존 비밀번호를 잘못 입력하셨습니다.</div>
						</c:if>
					 </div>
				</form>
				<div class="submit2">
					<input type="hidden" name="id" class="member_id">
					<input type="button" id="cancel_button" value="취소" style="margin-top: 20px;margin-left:100px;background:lightgray;color:#fff;border-radius:10px;">
					<input type="button" id="modify_button" value="수정" style="transform: translate(125%,-102%);margin-left: 90px;background:tomato;color:#fff;border-radius:10px;">
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
	
	var regPw = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$/;

  $(document).ready(function(){
	 $("#cancel_button").on("click", function(){
		 $("#pw_form").attr("action", "/member/info");
		 $("#pw_form").attr("method", "get");
		 $("#pw_form").submit();
	 });
  
 	$("#modify_button").on("click", function(){
 		$("#pw_form").attr("action", "/member/pw_modify");
 		$("#pw_form").submit();	
 	});
 	
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
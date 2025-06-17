<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
</head>
<style>
#mail_check_input_box_false{
    background-color:#ebebe4;
}
 
#mail_check_input_box_true{
    background-color:white;
}
.correct{
    color : green;
}
.incorrect{
    color : red;
}
 
</style>
<body>
	<div class="container">
		<form id="join_form" method="post">
			<div class="wrap">
				<span>회원가입</span>
			</div>
			
			<div class="row">
				<label>아이디</label>
				<div class="col">
					<input type="text" id="id_input" name="id">
				</div>
					<span class="id_input_re_1">사용 가능한 아이디입니다.</span>
					<span class="id_input_re_2">아이디가 이미 존재합니다.</span>
					<span class="final_id_ck">아이디를 입력해주세요.</span>
			</div>
			<div class="row">
				<label>비밀번호</label>
				<div class="col">
					<input type="password" id="pw_input" name="pw">
				</div>
					<span class="pw_input_re">※대소문자,숫자,특수문자 포함 8자리 이상 입력</span>
					<span class="final_pw_ck">비밀번호를 입력해주세요.</span>
			</div>
			<div class="row">
				<label>비밀번호 확인</label>
				<div class="col">
					<input type="password" id="pwck_input">
				</div>
					<span class="pwck_input_re_1">비밀번호가 일치합니다.</span>
					<span class="pwck_input_re_2">비밀번호가 일치하지 않습니다.</span>
					<span class="final_pw_ck">비밀번호를 입력해주세요.</span>
			</div>
			<div class="row">
				<label>이름</label>
				<div class="col">
					<input type="text" id="user_input" name="name">
				</div>
					<span class="final_name_ck">이름을 입력해주세요.</span>
			</div>
			<div class="row">
				<label>전화번호</label>
				<div class="col">
					<input type="text" id="tel_input" name="tel">
				</div>
					<span class="final_tel_ck">전화번호를 입력해주세요.</span>
			</div>
			<div class="mail_wrap">
				<div class="mail_name">이메일</div> 
				<div class="mail_input_box">
					<input class="mail_input" name="mail">
				</div>
				<span class="final_mail_ck">이메일을 입력해주세요.</span>
				<span class="mail_input_box_warn"></span>
				<div class="mail_check_wrap">
					<div class="mail_check_input_box" id="mail_check_input_box_false">
						<input class="mail_check_input" disabled="disabled">
					</div>
					<div class="mail_check_button">
						<span>인증번호 전송</span>
					</div>
					<div class="clearfix"></div>
					<span id="mail_check_input_box_warn"></span>
				</div>
			</div>
			
			<div class="row">
				<label>주소</label>
				<div class="col">
					<input type="email" id="address_input_1" name="addr1" readonly="readonly">
				</div>
			</div>
			<button type="button" id="address_button" onclick="execution_daum_adress()">주소 찾기</button>
			<div class="row">
				<label>주소</label>
				<div class="col">
					<input type="email" id="address_input_2" name="addr2" readonly="readonly">
				</div>
			</div>
			<div class="row">
				<label>상세주소</label>
				<div class="col">
					<input type="email" id="address_input_3" name="addr3" readonly="readonly">
				</div>
			</div>
			<span class="final_addr_ck">주소를 입력해주세요.</span>
		</form>
		<div class="join_button_wrap">
			<button type="button" id="cancel_button">닫기</button>
			<button type="button" id="join_button">회원가입</button>
		</div>
	</div>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	
	var code = ""; //이메일전송 인증번호 저장위한 코드
	
	var idCheck = false;
	var idckCheck = false;
	var pwCheck = false;          
 	var pwckCheck = false;           
 	var pwckcorCheck = false;        // 비번 확인 일치 확인
 	var nameCheck = false; 
 	var telCheck = false;
 	var addressCheck = false
 	
 	var regPhone = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
 //	var regEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
 	var regPw = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$/;
 	
	$(document).ready(function(){
		$("#join_button").click(function(){
			/* 입력값 변수 */
			var id = $('#id_input').val();
			var pw = $('#pw_input').val();
			var pwck = $('#pwck_input').val();
			var name = $('#user_input').val();
			var tel = $('#tel_input').val();
			var addr = $('#address_input_3').val();
			
			if( regPhone.test(tel) === false ){
 				alert("올바르지 못한 전화번호 형식입니다. 다시 입력해주세요. ex) 010-1234-5678");
 				return;
 			}
			
			/* if( regEmail.test(mail) === false ){
				alert("이메일 유효성검사 실패");
 				return;
 			} */
			
			if( regPw.test(pw) === false ){
 				alert("대소문자, 숫자, 특수문자 포함 8자이상 입력해주세요.");
 				return;
 			}
			
			/*아이디 유효성 검사*/
			if(id == ""){
				$('.final_id_ck').css('display','block');
				idCheck = false;
			}else{
				$('.final_id_ck').css('display','none');
				idCheck = true; //중복이 없는 경우
			}
			
			/*비밀번호 유효성 검사*/
			if(pw == ""){
				$('.final_pw_ck').css('display','block');
				pwCheck = false;
			}else{
				$('.final_pw_ck').css('display','none');
				pwCheck = true; 
			}
			
			/*비밀번호 확인 유효성 검사*/
			if(pwck == ""){
				$('.final_pwck_ck').css('display','block');
				pwckCheck = false;
			}else{
				$('.final_pwck_ck').css('display','none');
				pwckCheck = true;
			}
			
			/*이름 유효성 검사*/
			if(name == ""){
				$('.final_name_ck').css('display','block');
				nameCheck = false;
			}else{
				$('.final_name_ck').css('display','none');
				nameCheck = true;
			}
			
			/* 전화번호 유효성 검사 */
	        if(tel == ""){
	            $('.final_tel_ck').css('display','block');
	            telCheck = false;
	        }else{
	            $('.final_tel_ck').css('display', 'none');
	            telCheck = true;
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
	        if(idCheck&&idckCheck&&pwCheck&&pwckCheck&&pwckcorCheck&&nameCheck&&telCheck&&addressCheck){
	 		
	        	$("#join_form").attr("action", "/member/join");
				$("#join_form").submit();
				alert("환영합니다~ 회원가입이 완료되었습니다!");
	        }      
	        
	        return false;
			
		});
	});
	
	$('#id_input').on("propertychange change keyup paste input", function(){
		/* console.log("keyup 테스트"); */
		
		var id = $('#id_input').val();
		var data = {id : id}
		
		$.ajax({
			type : "post",
			url : "/member/memberIdChk",
			data : data,
			success : function(result){
				//console.log("성공 여부" + result);
				if(result != 'fail'){
					$('.id_input_re_1').css("display","inline-block");
					$('.id_input_re_2').css("display","none");
					idckCheck = true; //중복이 없는 경우
				}else{
					$('.id_input_re_2').css("display","inline-block");
					$('.id_input_re_1').css("display","none");
					idckCheck = false;
				}
			}
		});
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
	
	/*비밀번호 확인 일치 유효성검사*/
	/*change keyup paste 변화감지(입력하면 변화됨)*/
	$('#pwck_input').on("propertychange change keyup paste input", function(){
		var pw = $('#pw_input').val();
		var pwck = $('#pwck_input').val();
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
	
	 /* 입력 이메일 형식 유효성 검사 */
	 function mailFormCheck(mail){
	    var form = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
	 	return form.test(mail);
	}
	
	/* 인증번호 이메일 전송 */
	$(".mail_check_button").click(function(){
	    
	    var mail = $(".mail_input").val();        // 입력한 이메일
	    var checkBox = $(".mail_check_input"); // 인증번호 입력란
	    var boxWrap = $(".mail_check_input_box"); // 인증번호 입력란 박스
	    var warnMsg = $(".mail_input_box_warn");
	    
	    /* 이메일 형식 유효성 검사 */
	    if(mailFormCheck(mail)){
	        warnMsg.html("이메일이 전송 되었습니다. 이메일을 확인해주세요.");
	        warnMsg.css("display", "inline-block");
	    } else {
	        warnMsg.html("올바르지 못한 이메일 형식입니다.");
	        warnMsg.css("display", "inline-block");
	        return false;
	    }    
	    
	    $.ajax({
	        
	        type:"GET",
	        url:"mailCheck?mail=" + mail,
	        success:function(data){
	        	
	        	//console.log("data : " + data);
	        	checkBox.attr("disabled", false);
	        	boxWrap.attr("id", "mail_check_input_box_true");
	        	code = data;
	        }		
	                
	    });
	});
	
	/* 인증번호 비교 */
	$(".mail_check_input").blur(function(){
	    
	    var inputCode = $(".mail_check_input").val();        // 입력코드    
	    var checkResult = $("#mail_check_input_box_warn");    // 비교 결과     
	    
	    if(inputCode == code){                            // 일치할 경우
	        checkResult.html("인증번호가 일치합니다.");
	        checkResult.attr("class", "correct");        
	    } else {                                            // 일치하지 않을 경우
	        checkResult.html("인증번호를 다시 확인해주세요.");
	        checkResult.attr("class", "incorrect");
	    }    
	    
	});
	
	$("#cancel_button").on("click", function(){
		$("#join_form").attr("action", "/main");
		$("#join_form").submit();
	});
	 
</script>
</body>
</html>
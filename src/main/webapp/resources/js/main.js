/**로그인, 회원가입
 * 
 */
 	$("#logout_button").on("click", function(){
		$.ajax({
			type : "POST",
			url : "/member/logout.do",
			success:function(data){
				alert("로그아웃되었습니다.");
				document.location.reload(); //새로고침
			}
		});
	});
	
$(document).ready(function () {
	$(".login_button").on("click", function(){
		var id = $('#login_id').val();
		var pw = $('#login_pw').val();
		var params = { "id" : id, "pw" : pw };
		
		$.ajax({
			type : "post",
			url : "/member/login.do",
			contentType : 'application/json; charset=UTF-8',
			data:JSON.stringify(params),
			success:function(data){
			    console.log(data); // 실패: 0 , 성공: 1
			    
			    if( data == "1" ){
					alert("환영합니다!");
					document.location.reload();
				}else{
					alert("잘못된 아이디나 비밀번호 입니다.");
				}
			},
			  error : function(request, status, error) {
				console.log("시스템에러 입니다. 시스템 담당자에게 문의주세요.");
//              	console.log("code:" + request.status + "\n" + "error:" + error);
			}
		});
	});
});		

    $(".cancel_button").on("click", function(){
		$("#login_form").attr("action", "/main");
		$("#login_form").submit();
	});
	
	/* 회원가입 */
	var code = ""; //이메일전송 인증번호 저장위한 코드
	
	var idCheck = false;
	var idckCheck = false;
	var pwCheck = false;          
 	var pwckCheck = false;           
 	var pwckcorCheck = false;        // 비번 확인 일치 확인
 	var nameCheck = false; 
 	var telCheck = false;
 	var addressCheck = false;
 	var mailCheck = false;
 	var mailckCheck = false;
 	
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
			var mail = $('.mail_input').val();
			var mailck = $('.mail_check_input').val();
			
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
	        
			/* 이메일 유효성 검사 */
	        if(mail == ""){
	            $('.final_mail_ck').css('display','block');
	            mailCheck = false;
	        }else{
	            $('.final_mail_ck').css('display', 'none');
	            mailCheck = true;
	        }
	        
	        /* 이메일인증 유효성 검사 */
	        if(mailck == ""){
	            $('.final_mailck_ck').css('display','block');
	            mailckCheck = false;
	        }else{
	            $('.final_mailck_ck').css('display', 'none');
	            mailckCheck = true;
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
	        if(idCheck&&idckCheck&&pwCheck&&pwckCheck&&pwckcorCheck&&nameCheck&&telCheck&&mailCheck&&mailckCheck&&addressCheck){
	 		
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
	$("#mail_check_button").click(function(){
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
	        url:"/member/mailCheck?mail=" + mail,
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
	
	
	$("#close").on("click", function(){
		$("#login_form").attr("action", "/main");
		$("#login_form").submit();
	});
	
	$("#close2").on("click", function(){
		$("#join_form").attr("action", "/main");
		$("#join_form").submit();
	});
    
 /* 레이어팝업 */
 $(document).ready(function(){
	$('#btn-example').click(function(){
        var $href = $(this).attr('href');
        layer_popup($href);
    });
    $('#btn-example2').click(function(){
        var $href = $(this).attr('href');
        layer_popup($href);
    });
    
    $('.nav-link').click(function(){
	    $('.dim-layer').fadeIn();
	});
	
    $('#close').click(function(){
	    $('.dim-layer').fadeOut();
	});
	
    $('.dimBg').click(function(){
	    $('.dim-layer').fadeOut();
	    $('#close').trigger("click");
	});
	
 });
    
    function layer_popup(el){
		console.log(el);

        var $el = $(el);    //레이어의 id를 $el 변수에 저장
        var isDim = $el.prev().hasClass('dimBg'); //dimmed 레이어를 감지하기 위한 boolean 변수

        isDim ? $('.dim-layer').fadeIn() : $el.fadeIn();

        var $elWidth = ~~($el.outerWidth()),
            $elHeight = ~~($el.outerHeight()),
            docWidth = $(document).width(),
            docHeight = $(document).height();

        // 화면의 중앙에 레이어를 띄운다.
        if ($elHeight < docHeight || $elWidth < docWidth) {
            $el.css({
                marginTop: -$elHeight /2,
                marginLeft: -$elWidth/2
            })
        } else {
            $el.css({top: 0, left: 0});
        }

        $el.find('a.btn-layerClose').click(function(){
            isDim ? $('.dim-layer').fadeOut() : $el.fadeOut(); // 닫기 버튼을 클릭하면 레이어가 닫힌다.
            return false;
        });

    }
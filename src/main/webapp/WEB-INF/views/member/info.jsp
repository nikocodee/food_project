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
</head>
<body>
			<div class="container">	
				<a class="main_logo" href="/main">
				<img src="/resources/img/logo.png" style="width:170px;">
				</a>
				<div class="info" style="width:540px;margin-left: 360px;margin-top:-110px;">
				    <div class="pop-container" style="border:1px solid #ccc;margin-top:60px;height:450px;">
				        <div class="pop-conts">
				            <form id="info_form" method="get">
							<div class="logo_wrap2">
								<h2 style="margin-top:20px;font-size: 1.8em;font-weight:500;">회원정보</h2>
							</div>
							<div class="login_id2" style="margin-top: 10px;">
								<h4 style="padding-left: 72px;transform: translate(8%,130%);">아이디</h4>
								<div class="col">
									<input name="id" value="<c:out value="${info.id}"/>" disabled style="transform:translate(10%,-30%);">
								</div>
							</div>
							<div class="login_id2">
								<h4 style="padding-left: 72px;transform: translate(10%,1%);">이름</h4>
								<div class="col">
									<input name="name" value="<c:out value="${info.name}"/>" disabled style="transform: translate(10%,-120%);">
								</div>
							</div>
							<div class="login_id2">
								<h4 style="padding-left: 72px;transform: translate(5%,-150%);">전화번호</h4>
								<div class="col">
									<input name="tel" value="<c:out value="${info.tel}"/>" disabled style="transform: translate(10%,-200%);">
								</div>
							</div>
							<div class="login_id2">
								<h4 style="padding-left: 72px;transform: translate(8%,-275%);">이메일</h4>
								<div class="mail_name"></div> 
								<div class="mail_input_box">
									<input type="email" name="mail" value="<c:out value="${info.mail}"/>" disabled style="transform: translate(10%,-280%);">
								</div>
								<div class="mail_check_wrap">
									<div class="mail_check_input_box" id="mail_check_input_box_false">
									</div>
								</div>
							</div>
							
							<div class="login_id2">
								<h4 style="padding-left:72px;transform: translate(10%,-450%);">주소</h4>
								<div class="addr_input_box">
									<input name="addr1" value="<c:out value="${info.addr1}"/>" disabled
									style="display:inline;transform: translate(10%,-370%);">
								</div>
							</div>
							<div class="login_id2" style="margin-top: 10px;">
								<div class="col">
									<input name="addr2" value="<c:out value="${info.addr2}"/>" disabled
									style="margin-top: -5px;transform: translate(10%,-370%);">
								</div>
							</div>
							<div class="login_id2" style="margin-top: 10px;">
								<div class="col">
									<input name="addr3" value="<c:out value="${info.addr3}"/>" disabled
									style="margin-top: -5px;transform: translate(10%,-370%);">
								</div>
							</div>
						</form>
				    </div>
			   		<div class="submit2">
						<input type="button" id="modify_button" value="회원정보 수정" style="transform: translate(-105%,-980%);width: 150px;color: darkgray;">
						<input type="button" id="pwmodify_button" value="비밀번호 변경" style="width:150px;transform: translate(-158px,-480px);color: darkgray;">
					</div>
			            <!--// content-->
			        </div>
				</div>
			</div>	
<script>
 $(document).ready(function(){
	 $("#modify_button").on("click", function(){
		 $("#info_form").attr("action", "/member/info_modify");
		 $("#info_form").submit();
	 });
	 $("#pwmodify_button").on("click", function(){
		 $("#info_form").attr("action", "/member/pw_modify");
		 $("#info_form").submit();
	 });
	 
 });
</script>			
</body>
</html>
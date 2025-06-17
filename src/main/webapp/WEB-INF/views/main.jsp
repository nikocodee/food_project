<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}resources/css/main.css">
<link rel="stylesheet" href="/resources/css/login.css">
<link rel="stylesheet" href="/resources/css/join.css">
<link href="/resources/img/favicon.png" rel="icon" type="image/x-icon" />
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
<title>오늘 뭐 먹지?</title>
</head>
<body>
	<div class="container">
	<c:if test="${member == null }">
			<input type="checkbox" id="menuicon" class="nav-link">
				<label for="menuicon">
					<span style="transform:translate(10px,10px);"></span>
					<span style="transform:translate(10px,5px);"></span>
					<span style="transform:translate(10px,4px);"></span>
				</label>
		<div class="sidebar">
			<a href="/search" class="side_link">매장정보</a>
			<a href="#" class="side_link">매장후기</a>
		</div>	
		</c:if>
	<c:if test="${member.adminCk == 0 }">
			<input type="checkbox" id="menuicon" class="nav-link">
				<label for="menuicon">
					<span style="transform:translate(10px,10px);"></span>
					<span style="transform:translate(10px,5px);"></span>
					<span style="transform:translate(10px,4px);"></span>
				</label>
		<div class="sidebar">
			<a href="/search" class="side_link">매장정보</a>
			<a href="#" class="side_link">매장후기</a>
		</div>	
		</c:if>
		<c:if test="${member.adminCk == 2 }">
			<input type="checkbox" id="menuicon" class="nav-link">
				<label for="menuicon">
					<span style="transform:translate(10px,10px);"></span>
					<span style="transform:translate(10px,5px);"></span>
					<span style="transform:translate(10px,4px);"></span>
				</label>
		<div class="sidebar">
			<a href="/search" class="side_link">매장정보</a>
			<a href="/store/main" class="side_link">매장관리</a>
			<a href="/menu/main" class="side_link">메뉴관리</a>
			<a href="#" class="side_link">예약관리</a>
			<a href="#" class="side_link">매장후기</a>
		</div>	
		</c:if>
		<c:if test="${member.adminCk == 1 }">
			<input type="checkbox" id="menuicon" class="nav-link">
				<label for="menuicon">
					<span style="transform:translate(10px,10px);"></span>
					<span style="transform:translate(10px,5px);"></span>
					<span style="transform:translate(10px,4px);"></span>
				</label>
		<div class="sidebar">
			<a href="/search" class="side_link">매장정보</a>
			<a href="/store/main" class="side_link">매장관리</a>
			<a href="/menu/main" class="side_link">메뉴관리</a>
			<a href="#" class="side_link">예약관리</a>
			<a href="#" class="side_link">매장후기</a>
		</div>	
		</c:if>
		<nav class="login_box" style="margin-top: 20px;">
			<div class="login_area">
				<c:if test="${member == null }"> <!-- 로그인x -->
				<ul class="login-nav" style="margin-top:-50px;">
				<li class="login-item">
				<a class="nav-link" href="#layer1" id="btn-example">로그인</a>
				<div id="layer1" class="pop-layer">
				    <div class="pop-container">
				        <div class="pop-conts">
				        	<form id="login_form" method="get">
								<div class="logo_wrap">
									<div class="notice-box">
									<button id='close' onclick="this.parentNode.style.display = 'none';">&times;</button>
									</div>
									<h2>로그인</h2>
								</div>
								   <div class="login_id">
									<div class="id_wrap">
										<div class="id_input_box">
											<h4 style="padding-left: 30px;">ID</h4>
											<input class="id_input" id="login_id" name="login_id"  placeholder="id">
										</div>
									</div>
									</div>
									<div class="login_pw">
										<div class="pw_input_box">
											<h4 style="padding-left: 30px;">Password</h4>
											<input type="password" class="pw_input" id="login_pw" name="login_pw" placeholder="Password">
										</div>
									<c:if test="${result == 0 }">
										<div class = "login_warn">사용자 ID 또는 비밀번호를 잘못 입력하셨습니다.</div>
									</c:if>
									<div class="submit">
										<ul>
											<li>
											  <input type="button" class="login_button" value="로그인">
											</li>
										</ul>
									</div>
								 </div>
							</form>
				            <!--// content-->
				        </div>
				    </div>
				</div>
				<a class="nav-link" href="#layer2" id="btn-example2">회원가입</a>
				<div id="layer2" class="pop-layer" style="width:540px;">
				    <div class="pop-container2">
				        <div class="pop-conts">
				            <form id="join_form" method="post">
							<div class="logo_wrap2">
								<div class="notice-box2">
								<button id='close2' onclick="this.parentNode.style.display = 'none';">&times;</button>
								</div>
								<h2 style="margin-top:30px;">회원가입</h2>
							</div>
							
							<div class="login_id2" style="margin-top: 40px;">
								<h4 style="padding-left: 72px;">아이디</h4>
								<div class="col">
									<input type="text" id="id_input" name="id">
								</div>
									<span class="id_input_re_1">사용 가능한 아이디입니다.</span>
									<span class="id_input_re_2">아이디가 이미 존재합니다.</span>
									<span class="final_id_ck">아이디를 입력해주세요.</span>
							</div>
							<div class="adminck" style="transform: translate(-339px, -100px);">
								<label><input type="checkbox" name="adminCk" value="0">회원</label>
								<label><input type="checkbox" name="adminCk" value="2">점주</label>
							</div>
							<div class="login_id2">
								<h4 style="padding-left: 72px;">비밀번호</h4>
								<div class="col">
									<input type="password" id="pw_input" name="pw">
								</div>
									<span class="pw_input_re" 
									style="font-size: 0.7rem;margin-left:74px;font-weight:bolder;
									color:darkgrey;word-spacing: normal;">
									※대소문자,숫자,특수문자 포함 8자리 이상 입력</span>
									<span class="final_pw_ck">비밀번호를 입력해주세요.</span>
							</div>
							<div class="login_id2">
								<h4 style="padding-left: 72px;word-spacing: normal;">비밀번호 확인</h4>
								<div class="col">
									<input type="password" id="pwck_input">
								</div>
									<span class="pwck_input_re_1">비밀번호가 일치합니다.</span>
									<span class="pwck_input_re_2">비밀번호가 일치하지 않습니다.</span>
									<span class="final_pwck_ck">비밀번호를 입력해주세요.</span>
							</div>
							<div class="login_id2">
								<h4 style="padding-left: 72px;">이름</h4>
								<div class="col">
									<input type="text" id="user_input" name="name">
								</div>
									<span class="final_name_ck">이름을 입력해주세요.</span>
							</div>
							<div class="login_id2">
								<h4 style="padding-left: 72px;">전화번호</h4>
								<div class="col">
									<input type="text" id="tel_input" name="tel">
								</div>
									<span class="final_tel_ck">전화번호를 입력해주세요.</span>
							</div>
							<div class="login_id2">
								<h4 style="padding-left: 72px;">이메일</h4>
								<div class="mail_name"></div> 
								<div class="mail_input_box">
									<input class="mail_input" name="mail">
								</div>
								<span class="final_mail_ck">이메일을 입력해주세요.</span>
								<span class="mail_input_box_warn" 
								style="font-size: 0.7rem;margin-left:74px;font-weight:bolder;
									color:darkgrey;word-spacing: normal;"></span>
								<div class="mail_check_wrap">
									<div class="mail_check_input_box" id="mail_check_input_box_false">
										<input type="text" class="mail_check_input" disabled="disabled" 
										style="width:60%;">
										<input type="button" id="mail_check_button" value="인증번호 전송"
										style="background:#ececec;cursor:pointer;">
									</div>
									<div class="clearfix"></div>
									<span id="mail_check_input_box_warn" 
									style="font-size: 0.7em;margin-left: 74px;font-weight: bolder;word-spacing: normal;"></span>
								</div>
								<span class="final_mailck_ck">인증번호를 입력해주세요.</span>
							</div>
							
							<div class="login_id2">
								<h4 style="padding-left:72px;">주소</h4>
								<div class="addr_input_box">
									<input type="email" id="address_input_1" name="addr1" readonly="readonly" 
									style="display:inline;width:71%;">
									<input type="button" id="address_button" onclick="execution_daum_adress()" value="주소 찾기"
									style="background:#ececec;word-spacing: normal;font-weight:bolder;width: 29%;margin-left: -130px;
									cursor:pointer;">
								</div>
							</div>
							<div class="login_id2">
								<h4 style="padding-left: 72px;"></h4>
								<div class="col">
									<input type="email" id="address_input_2" name="addr2" readonly="readonly"
									style="margin-top:-1px;">
								</div>
							</div>
							<div class="login_id2" style="margin-top: 10px;">
								<h4 style="padding-left: 72px;">상세주소</h4>
								<div class="col">
									<input type="email" id="address_input_3" name="addr3" readonly="readonly">
								</div>
							</div>
							<span class="final_addr_ck">주소를 입력해주세요.</span>
						</form>
						<div class="submit2">
							<input type="button" id="join_button" value="회원가입">
							</div>
				            <!--// content-->
				        </div>
				    </div>
				</div>
				</ul>
				</c:if>
				<c:if test="${member.adminCk == 0 }"> <!-- 회원 로그인o -->
					<li class="login-item" style="margin-top: -50px;">
						<span style="color:white">♡${member.name}님♡</span>
						<a class="nav-link" id="info_button" href="/member/info">회원정보</a>
						<a class="nav-link" id="logout_button" href="/member/logout.do">로그아웃</a>
					</li>
				</c:if>
				<c:if test="${member.adminCk == 2 }"> <!-- 점주 로그인o -->
					<li class="login-item" style="margin-top: -50px;">
						<span style="color:white">♡${member.name} 점주님♡</span>
						<a class="nav-link" id="info_button" href="/member/info">회원정보</a>
						<a class="nav-link" id="logout_button" href="/member/logout.do">로그아웃</a>
					</li>
				</c:if>
				<c:if test="${member.adminCk == 1 }"> <!-- 관리자계정 -->
					<li class="login-item" style="margin-top: -50px;">
						<span style="color:white;">♡관리자님♡</span>
						<a class="nav-link" href="/store/main">관리자페이지</a>
						<a class="nav-link" id="logout_button" href="/member/logout.do">로그아웃</a>
					</li>
				</c:if>
			</div>
		</nav>
		<form class="search" role="search" id="searchForm" action="/search" method="get">
			<a class="main-logo" href="/main"><img src="/resources/img/logo.jpg"></a>
			<input type="text" name="keyword" placeholder="검색어를 입력하세요." value='<c:out value="${pageMaker.cri.keyword}"></c:out>'>
			<button><img alt="search" src="/resources/img/search.png"></button>
		</form>
	</div>	
	
	<div class="dim-layer">
	    <div class="dimBg">
		</div>
	</div>
	
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>	
<script type="text/javascript" src="/resources/js/main.js"></script>
<script>
	$(document).ready(function(){
		let searchForm = $('#searchForm');
		
		/* 검색 버튼 동작 */
		$("#searchForm button").on("click", function(e){
			
			e.preventDefault();
			
			/* 검색 키워드 유효성 검사 */
			if(!searchForm.find("input[name='keyword']").val()){
				alert("키워드를 입력하십시오");
				return false;
			}
			
			searchForm.find("input[name='pageNum']").val("1");
			
			searchForm.submit();
			
		});
	});

</script>		
</body>
</html>
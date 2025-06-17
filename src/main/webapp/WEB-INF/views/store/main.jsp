<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/resources/css/storemain.css">
<title>Insert title here</title>
 <style>
 </style>
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
</head>
<body>
	<div class="container">
		<div class="store_content_wrap">
			<div class="store_content_subject">
			<a class="back_logo" href="/main">
			<img src="/resources/img/back.png" style="width:30px;transform: translate(-460px,-15px);"></a>
			<a href="/store/main" style="color:black;">매장 관리</a></div>
		</div>
		<div class="store_table_wrap">
			<a href="/store/register" id="register_button">등록</a>
			<c:if test="${listCheck != 'empty' }">
				<table class="store_table" style="margin-top: 15px;">
					<thead>
						<tr>
							<td class="th_column_1">번호</td>
							<td class="th_column_2">매장사진</td>
							<td class="th_column_3">매장이름</td>
							<td class="th_column_4">사업자번호</td>
							<td class="th_column_5">카테고리</td>
							<td class="th_column_6">등록일자</td>
							<td class="th_column_7">수정</td>
							<td class="th_column_8">삭제</td>
						</tr>
					</thead>
					<c:forEach items="${list}" var="list">
					<tr>
						<td><c:out value="${list.st_id}"></c:out></td>
						<td>
							<div class="image_wrap" data-st_id="${list.imageList[0].st_id}" data-path="${list.imageList[0].uploadPath}" data-uuid="${list.imageList[0].uuid}" data-filename="${list.imageList[0].fileName}">
								<img style="width:250px;height:180px;">
							</div>
						</td>
						<td>
							<a class="move" href='<c:out value="${list.st_id}"/>'>
							 	<c:out value="${list.st_name}"></c:out>
							</a>
						</td>
						<td><c:out value="${list.st_biznum}"></c:out></td>
						<td><c:out value="${list.st_type}"></c:out></td>
						<td><fmt:formatDate value="${list.regdate}" pattern="yyyy-MM-dd"/></td>
						<td class="modify" style="padding: 3px 3px;background:#348735ad;font-size:1.0em; border-radius:10px;">
						<a href="/store/storeModify?st_id=${list.st_id }" style="color:white;">수정</a></td>
						<td class="delete" style="padding: 3px 3px;background:tomato;font-size:1.0em; border-radius:10px;">
						<a href="/store/storeDelete?st_id=${list.st_id }" style="color:white;">삭제</a></td>
					</tr>
					</c:forEach>
				</table>
			</c:if>
			<c:if test="${listCheck == 'empty'}">
       			<div class="table_empty">
       				해당하는 내용을 찾을 수 없습니다.
       			</div>
       		</c:if>  
		</div>
		<!-- 검색 영역 -->
       	<div class="search_wrap">
       		<form id="searchForm" action="/store/main" method="get">
       			<div class="search_input">
           			<input type="text" name="keyword" value='<c:out value="${pageMaker.cri.keyword}"></c:out>'>
           			<input type="hidden" name="pageNum" value='<c:out value="${pageMaker.cri.pageNum }"></c:out>'>
           			<input type="hidden" name="amount" value='${pageMaker.cri.amount}'>
           			<input type="hidden" name="type" value="G">
           			<button class='btn search_btn'>검 색</button>                				
       			</div>
       		</form>
       	</div>
                	
       	<!-- 페이지 이름 인터페이스 영역 -->
       	<div class="pageMaker_wrap">
       		<ul class="pageMaker">
       			
       			<!-- 이전 버튼 -->
       			<c:if test="${pageMaker.prev }">
       				<li class="pageMaker_btn prev">
       					<a href="${pageMaker.pageStart -1}">이전</a>
       				</li>
       			</c:if>
       			
       			<!-- 페이지 번호 -->
       			<c:forEach begin="${pageMaker.pageStart }" end="${pageMaker.pageEnd }" var="num">
       				<li class="pageMaker_btn ${pageMaker.cri.pageNum == num ? 'active':''}">
       					<a href="${num}">${num}</a>
       				</li>	
       			</c:forEach>
       		
            	<!-- 다음 버튼 -->
            	<c:if test="${pageMaker.next}">
            		<li class="pageMaker_btn next">
            			<a href="${pageMaker.pageEnd + 1 }">다음</a>
            		</li>
            	</c:if>
            </ul>
       	</div>
       	
		 <form id="moveForm" action="/store/main" method="get">
			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
			<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
			<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
		</form>
	</div>
<script>
	$(document).ready(function(){
		
		/* 이미지 삽입 */
		$(".image_wrap").each(function(i, obj){
			
			const bobj = $(obj);
			
			const uploadPath = bobj.data("path");
			const uuid = bobj.data("uuid");
			const fileName = bobj.data("filename");
			
			const fileCallPath = encodeURIComponent(uploadPath + "/s_" + uuid + "_" + fileName);
			
			$(this).find("img").attr('src', '/display?fileName=' + fileCallPath);
			
		});
		
		/*등록 성공 이벤트*/
		let eResult = '<c:out value="${register_result}"/>';
		checkResult(eResult);
		function checkResult(result){
			if(result === ''){
				return;
			}
			
			alert("매장'"+ eResult + "'을 등록하였습니다.");
		}
		
		/*수정 성공 이벤트*/
		let modify_result = '${modify_result}';
		if(modify_result==1){
			alert("수정 완료되었습니다.");
		}
		
		/*삭제 성공 이벤트*/
		let delete_result = '${delete_result}';
		if(delete_result==1){
			alert("삭제 완료되었습니다.");
		}
		
	});
	
	let searchForm = $('#searchForm');
	let moveForm = $('#moveForm');
	
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
	
	
	/* 페이지 이동 버튼 */
	$(".pageMaker_btn a").on("click", function(e){
		
		e.preventDefault();
		
		moveForm.find("input[name='pageNum']").val($(this).attr("href"));
		
		moveForm.submit();
		
	});
	
	/*상품 조회 페이지*/
	$(".move").on("click", function(e){
		e.preventDefault();
		
		moveForm.append("<input type='hidden' name='st_id' value='"+$(this).attr("href")+"'>");
		moveForm.attr("action", "/store/storeDetail");
		moveForm.submit();
	});
	 
</script>	
</body>
</html>
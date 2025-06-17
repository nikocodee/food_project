<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/resources/css/search.css">
<link href="/resources/img/favicon.png" rel="icon" type="image/x-icon" />
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
<title>오늘 뭐 먹지?</title>
</head>
<body>
	<div class="container">
	<c:if test="${listCheck != 'empty' }">
		<div class="sidebar">
			<a class="back_logo" href="/main" style="margin:0; padding:0;">
			<img src="/resources/img/logo.jpg" style="margin:0; padding:0; width:160px;transform: translate(1px,-90px);"></a>
			<a href="/search" class="side_link">전체</a>
			<a href="/search?keyword=한식" class="side_link">한식</a>
			<a href="/search?keyword=양식" class="side_link">양식</a>
			<a href="/search?keyword=중식" class="side_link">중식</a>
			<a href="/search?keyword=일식" class="side_link">일식</a>
			<a href="/search?keyword=카페/디저트" class="side_link">카페/디저트</a>
		</div>	
		<c:forEach items="${list}" var="list">
		<div class="table">
			<div class="card">
					<a class="image_wrap" href='<c:out value="${list.st_id}"/>' data-st_id="${list.imageList[0].st_id}" data-path="${list.imageList[0].uploadPath}" data-uuid="${list.imageList[0].uuid}" data-filename="${list.imageList[0].fileName}">
						<img style="width:182px; height:122px;">
					</a>
	            <div class="words">
	            	<a class="move" href='<c:out value="${list.st_id}"/>' style="color:black;">
	            		<h2 style="font-size:1.1em;font-weight:600;"><c:out value="${list.st_name}"/></h2><br>
						<h3 style="font-size:1.0em;font-weight:500;"><c:out value="${list.st_type}"/></h3>
					</a>
	            </div>
	         </div> 
		</div>
		</c:forEach>
		</c:if>
		<c:if test="${listCheck == 'empty'}">
   			<div class="table_empty">
 				해당하는 내용을 찾을 수 없습니다.
 			</div>
 		</c:if>  
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
 		<form id="moveForm" action="/search" method="get">
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
		
		let moveForm = $('#moveForm');
		
		/* 페이지 이동 버튼 */
		$(".pageMaker_btn a").on("click", function(e){
			
			e.preventDefault();
			
			moveForm.find("input[name='pageNum']").val($(this).attr("href"));
			
			moveForm.submit();
			
		});
		/*매장 상세 조회 페이지*/
		$(".image_wrap").on("click", function(e){
			e.preventDefault();
			
			moveForm.append("<input type='hidden' name='st_id' value='"+$(this).attr("href")+"'>");
			moveForm.attr("action", "/storeInfo");
			moveForm.submit();
		});
		/*매장 상세 조회 페이지*/
		$(".move").on("click", function(e){
			e.preventDefault();
			
			moveForm.append("<input type='hidden' name='st_id' value='"+$(this).attr("href")+"'>");
			moveForm.attr("action", "/storeInfo");
			moveForm.submit();
		});
		
	});
	 
</script>	
</body>
</html>
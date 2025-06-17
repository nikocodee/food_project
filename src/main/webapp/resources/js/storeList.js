$(function(){
	
	//이 부분 세션 값 아이디 필요
	var st_manager = {id : sessionStorage.getItem("CUST_ID")};
	console.log(sessionStorage.getItem("CUST_ID"));
	var result = [];
	var storeCount = 0;
	var contextPath = getContext;
	
		//세션 id값을 보내 리스트 불러오기 위함 
		//현재의 임의로 입력(매장 리스트 보여줌) 
		$.ajax({
			url : "storeList",
			data : st_manager ,
			type : "post" ,
			success : function(data){
				result = data.storeList;
				storeCount = data.storeCount;
				var body = "";
				console.log(result);
				$.each(result,function(index,item){
					
					body += "<li class='store-list-frame'>";
					body += "<div class='store-list'>";
					body += "<input type='hidden' name='ST_CODE' value='"+item.st_CODE+"'>";
					body += "<span class='store-title'>";
					body += "<span class='store-title-subject'>"+item.st_NAME+"</span>";
					body += "<span class='store-title-category'> / 매장 카테고리</span></span>";
					body += "<span class='img-frame'>";
					// 이부분에 getContext를 어떻게 넣는지??
					body += "<img alt='사진없음' src='"+$("#getContextPath").val()+"/resources/img/store/"+item.st_CODE+".jpg'></span></div></li>";
				});
				$(".left-category > ul").prepend(body);
				$("#storeCount").append(storeCount);

				
			}, error : function(){
				alert("리스트를 가져올 수 없습니다.");
			}
		});
		
		//ajax로 어떻게 구현해야 하는지??
		$("#store-detail").hide();
		
		
		$(document).on("click", ".store-list-frame", function(idx){
				
				var st_code = $(this).find("input").val();
				
				$.ajax({
					type : "get",
					url : "reservation?ST_CODE="+st_code,
					success : function(data){
						
						var result = data.storeInfo;
						$("#store-detail").show();
						$("#managerIndex").hide();
						
						//store 디테일 부분 
						$(".store_title").html(result.st_NAME);
						
						$("#storeForm, #menuForm").find("input[name='ST_CODE']").attr("value",result.st_CODE);
						
						$("#storeForm").find("input[name='ST_NAME']").attr("value",result.st_NAME);
						$("#storeForm").find("input[name='ST_ADDRESSNO']").attr("value",result.st_ADDRESSNO);
						$("#storeForm").find("input[name='ST_ADDRESSBASIC']").attr("value",result.st_ADDRESSBASIC);
						$("#storeForm").find("input[name='ST_ADDRESSDETAIL']").attr("value",result.st_ADDRESSDETAIL);
						$("#storeForm").find("input[name='ST_ADDRESSEXTRA']").attr("value",result.st_ADDRESSEXTRA);
						$("#storeForm").find("input[name='ST_PHNO']").attr("value",result.st_PHNO);
						$("#storeForm").find("input[name='ST_STARTTIME']").attr("value",result.st_STARTTIME);
						$("#storeForm").find("input[name='ST_ENDTIME']").attr("value",result.st_ENDTIME);
						$("#storeForm").find("input[name='ST_CONTENT']").attr("value",result.st_CONTENT);
						
						$("#detailInfo").on("click",function(){
							map_view($("#storeForm").find("input[name='ST_ADDRESSBASIC']").val());
						});
						
						//매장 삭제 관련
						$(".deleteBtn").on("click",function(){
							
							if(confirm("정말 삭제하시겠습니까?") == true){
								$.ajax({
									type : "get",
									url : "storeDelete?ST_CODE="+result.st_CODE,
									success : function(deleteData){
										if(deleteData.deleteResult == 1){
											alert("삭제 성공");
											location.reload();
										}
									}, error : function(){
										alert("삭제 실패")
									}
								});
							} else {
								return;
							}
						});
					}, error : function(){
						alert("데이터를 불러오지 못했습니다.");
					}
				});
				
				//메뉴 리스트 ajax
				$.ajax({
					type : "get",
					url : "menu/menuList?ST_CODE="+st_code,
					success : function(data){
						menuResult = data.menuList;
						
						var body = "";
						
						$.each(menuResult,function(index,item){
							
							body += "<li class='menu-list-frame'>";
							body += "<input type='hidden' name='MENU_NUM' value='"+item.menu_NUM+"'>";
							body += "<img src='"+$("#getContextPath").val()+item.st_CODE+"/"+item.originalfile+".png' class='menu-mainPic'>";
							body += "<div class='menu-title'>"+item.menu_NAME+"</div></li>";
						});
						//불러온 데이터를 한번 날린다
						$(".menu-list-box").empty();
						$(".menu-list-box").prepend(body);
						
						//메뉴에 대한 정보를 모달창에 보여줄 수 있도록 함
						
						
					}, error : function(data){
						alert("메뉴 리스트 출력되지 않음");
					}
				});
				
				//메뉴 클릭 시,
				$(document).on("click",".menu-list-frame",function(){
					//모달창을 보여줄 수 있도록 함
					$('#menuDetailModal').show();
					
				    //팝업 Close 기능
				    $("#menuDetail_close").click(function() {
				        $('#menuDetailModal').hide();
				        $("#menuPicModifyBtn").css("display","inline-block");
						$("#menuPicUpdateBtn").css("display","none");
						$("#picUploadBtn").css("display","none");
						$("#uploadInfo").css("display","none");
						$(".upload-fileView").css("display","none");
						$(".menuInfoDisabled").attr("disabled", "disabled");
						$("#menuModifyBtn").css("display","inline-block");
						$("#menuUpdateBtn").css("display","none");
				     });
					var menu_num = $(this).find("input[name='MENU_NUM']").val();
					
					//메뉴 상세 정보 출력
					$.ajax({
							type : "get",
							url : "menu/menuDetail?MENU_NUM="+menu_num,
							success : function(menuData){
								var menuDTO = menuData.menuDetail
								$("#menuDetailForm,#menuPicForm").find("input[name='MENU_NUM']").attr("value",menuDTO.menu_NUM);
								$("#menuDetailForm").find("input[name='MENU_NAME']").attr("value",menuDTO.menu_NAME);
								$("#menuDetailForm").find("input[name='MENU_PRICE']").attr("value",menuDTO.menu_PRICE);
								$("#menuDetailForm").find("textarea[name='MENU_CONTENT']").html(menuDTO.menu_CONTENT);
							}, error : function(){
								alert("메뉴 상세 정보를 가져오지 못했습니다.");
							}
						});
					
					//메뉴 폼이 서브밋 될 때,
					$("#menuUpdateBtn").on("click",function(){
						$.ajax({
							type : "post",
							data : $("#menuDetailForm").serialize(),
							url : "menu/menuModify",
							success : function(data){
								if(data == 1){
									$(".menuInfoDisabled").attr("disabled", "disabled");
									$("#menuModifyBtn").css("display","inline-block");
									$("#menuUpdateBtn").css("display","none");
									$("#menuDetail_close").click();
								}
								location.reload();
							}, error : function(data){
								 alert("메뉴 수정 실패");
							}
						
						});
					});
					
					fileView_arr = new Array();
					originalFileNum = 0;
					fileCount = 0;
					totalCount = 5;
					fileNum = 0;
					modify_file = new Array();
					
					//메뉴 사진 정보 출력
					$.ajax({
							type : "get",
							url : "menu/picList?MENU_NUM="+menu_num,
							success : function(picdata){
								
								var picInfo = picdata.picList;
								
								var upLoad= "";
								var body = "";
								//넘어온 사진 정보가 있다면
								if(picInfo.length == 0){
									upLoad += "<p class='nopic'>현재 등록된 사진이 없습니다.</p>";
									upLoad += "<img alt='사진없음' src='"+$("#getContextPath").val()+"/resources/img/plus.png' id='picUploadBtn'>";
									upLoad += "<input type='file' name='MENU_PIC' multiple='multiple' style='display: none;' id='realPicUpload'>";
									upLoad += "<span id='uploadInfo'>※최대 5장까지 등록할 수 있습니다.※</span>";
									
									if($("#realPicUpload").val() != ""){
										$(".nopic").css("display","none");
									} else {
										$(".nopic").css("display","block");
									}
									
									$(".upload-fileView").empty();
									$(".bxslider").empty();
									$(".bx-wrapper").remove();
									$(".picAddFrame").empty();
									$(".picAddFrame").append(upLoad);
								} else {
									upLoad += "<img alt='사진없음' src='"+$("#getContextPath").val()+"/resources/img/plus.png' id='picUploadBtn'>";
									upLoad += "<input type='file' name='MENU_PIC' multiple='multiple' style='display: none;' id='realPicUpload'>";
									upLoad += "<span id='uploadInfo'>※최대 5장까지 등록할 수 있습니다.※</span>";
									
									body += "<div class='bxslider'>";
									$(".upload-fileView").empty();
									$.each(picInfo, function(idx, item){
										//사진을 보여줄 때, 저정된 파일 위치의 사진으로 보여줘야 하는지??
										body += "<div><img src='"+$("#getContextPath").val()+"/resources/upload"+item.savefolder+"/"+item.savefile+"' class='bx-img'></div>";
										/*body += "<div><img src='/fileUpload/upload"+item.savefolder+"/"+item.savefile+"' class='bx-img'></div>";*/
										
										//현재 사진의 대한 정보도 보여줄 수 있도록 함
										originalUpload = "";
										originalUpload += "<div id='originalFile"+originalFileNum+"' class='picDeleteBox'>"+item.originalfile;
										originalUpload += '<input type="hidden" name="SAVEFILE" value="'+item.savefile+'">';
										originalUpload += '<img src="'+$("#getContextPath").val()+'/resources/img/x.png" alt="사진없음" class="picDeleteBtn">';
										originalUpload += "</div>";
										
										$(".upload-fileView").prepend(originalUpload);
										originalFileNum++;
									});
										body += "</div>";
									$(".bxslider").empty();
									$(".bx-wrapper").remove();
									$(".picAddFrame").empty();
									$("#img-container").prepend(body);
									$(".picAddFrame").append(upLoad);
									
									$('.bxslider').bxSlider({
									    mode: 'fade',
									    captions: true,
									    slideWidth: 600
									 });
									 
									 //사진 삭제 시에 db와 함께 저장되어 있는 사진도 지워야 하는건지?
									 $(".picDeleteBox").on("click",function(){
										var savefile = $(this).find("input[name='SAVEFILE']").val();
										$(this).remove();
										
										$.ajax({
											type : "post",
											data : {"SAVEFILE" : savefile},
											url : "menu/menuPicDelete",
											success : function(deleteResult){
												console.log(deleteResult);
												if(deleteResult == 1){
													alert("사진이 삭제 되었습니다.");
													$("#menuPicUpdateBtn").css("display","none");
													$("#menuPicModifyBtn").css("display","inline-block");
													$(".picAddFrame").css("display","none");
													$(".upload-fileView").css("display","none");
												}
											}, error : function(){
												alert("사진이 삭제 되지 않았습니다.");
											}
										});
									});
								}
								
								$(document).on("change","#realPicUpload",function(){
									$(".upload-fileView").css("dispaly","block");
									var modifyFiles = $(this)[0].files;  //파일을 하나씩 
									
									//파일을 배열에 담을 수 있도록 함
									var modifyFilesArr = Array.prototype.slice.call(modifyFiles);
									
									console.log(modifyFilesArr);
									console.log(picInfo);
									
									if(fileCount + modifyFilesArr.length + picInfo.length > totalCount){
										alert("파일 업로드는 최대 "+totalCount+"까지 가능합니다.");
									} else {
										fileCount = fileCount + modifyFilesArr.length + picInfo.length ;
									}
									
									modifyFilesArr.forEach(function(file){
										var reader = new FileReader();
										reader.onload = function(){
											modify_file.push(file);
											var uploadFile = "";
											uploadFile += '<div id="file' + fileNum + '"class="addFile">'+file.name;
											uploadFile += '<img src="'+$("#getContextPath").val()+'/resources/img/x.png" alt="사진없음" class="picDeleteBtn">';
											uploadFile += '</div>';
											$(".upload-fileView").append(uploadFile);
											fileNum++;
										}
										reader.readAsDataURL(file);  //파일의 데이터 url을 문자열로 반환해줌
									});
									//다 작업이 끝났다면 초기화를 해준다.
									$("#realPicUpload").val("");
								});
								
								//파일 삭제 하기 위함 menuDelete
								$(document).on("click",".addFile",function(){
									$(this).remove();  //추가되는 배열에 들어가는 내용도 삭제해야 함...
									var idVal = $(this).attr("id"); //id 값을 가져올 수 있도록 함
									var no = idVal.replace(/^0-9/g,"");
									modify_file.splice(no,1);
									fileCount--;
								});
								
								
								/*function fileDelete(fileNum){
								var no = fileNum.replace(/^0-9/g,""); //파일 num만 남도록 함
								modify_file[no].is_delete = true;  //해당 num의 배열을 삭제함
								$("#"+fileNum).remove();
								fileCount--;
								console.log(modify_file);
								}*/
								
							}, error : function(){
								alert("메뉴 사진 정보를 가져오지 못했습니다.");
							}
						});
						
						//메뉴 수정 버튼 클릭 후, 변화
						$("#menuModifyBtn").on("click",function(){
							$(".menuInfoDisabled").removeAttr("disabled");
							$(this).css("display","none");
							$("#menuUpdateBtn").css("display","inline-block");
						});
						
						//메뉴 사진 수정 버튼 클릭 후, 변화
						$("#menuPicModifyBtn").on("click",function(){
							modal_openMenuDetail();
						});
						
						$("#menuDeleteBtn").on("click",function(){
							if(confirm("정말 삭제하시겠습니까?") == true){
								$.ajax({
									type : "get",
									url : "menu/menuDelete?MENU_NUM="+menu_num,
									success : function(result){
										if(result == 1){
											alert("메뉴를 삭제하였습니다.");
											$("#menuDetail_close").click();
										}
										//삭제 후 리로드가 될 수 있도록 함
										location.reload();
										
									}, error : function(){
										alert("메뉴 삭제 실패");
									}
							});
							}
							
						});
				});
		});
		
		//사진 업로드 (수정) 관련
		$(document).on("click","#picUploadBtn",function(){
			$("#realPicUpload").click();
		});
		
		
		//사진 수정 완료 버튼 클릭 시,
		$("#menuPicUpdateBtn").on("click",function(){
			var formdata = new FormData($("#menuPicForm")[0]);
			var MENU_NUM = $(this).find("input[name='MENU_NUM']").val();
			
			for(var i=0; i<modify_file.length; i++){
				formdata.append("image",modify_file[i]);
			}
			formdata.append("MENU_NUM",MENU_NUM);
			
			$.ajax({
				type : "post",
				data : formdata,
				url : "menu/savePic2",
				dataType : "json",
				processData : false,
				contentType : false,
				enctype : "multipart/form-data",
				success : function(result){
						alert("사진 수정이 완료되었습니다.");
						$("#menuPicUpdateBtn").css("display","none");
						$("#menuPicModifyBtn").css("display","inline-block");
				}, error : function(){
					alert("사진이 수정되지 않았습니다.");
				}
			});
			
			return false;
		});
		
		//js에서 getContex구하는 법
		
		function getContext(){
			var hostIndex = location.href.indexOf(location.host) + location.host.length;
			var contextPath = location.href.substring(hostIndex , location.href.valueOf("/",hostIndex+1));
			console.log(location.host);
			console.log(location.href);
			
			return contextPath;
		}
		
		function modal_openMenuDetail(){
			$("#menuPicModifyBtn").css("display","none");
			$("#menuPicUpdateBtn").css("display","inline-block");
			$("#picUploadBtn").css("display","block");
			$("#uploadInfo").css("display","block");
			$(".upload-fileView").css("display","block");
			$(".picAddFrame").css("display","block");
		}
		
		function modal_closeMenuDetail(){
        	$("#realPicUpload").val("");
		}
		
		/* 카카오 지도 function */
		function map_view(map_address){
			/* 카카오 지도 api */
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
			    mapOption = {
			        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
			        level: 3 // 지도의 확대 레벨
			    };  
			
			// 지도를 생성합니다    
			var map = new kakao.maps.Map(mapContainer, mapOption); 
			
			// 주소-좌표 변환 객체를 생성합니다
			var geocoder = new kakao.maps.services.Geocoder();
			
			// 주소로 좌표를 검색합니다
			geocoder.addressSearch( map_address , function(result, status) {
			
			    // 정상적으로 검색이 완료됐으면 
			     if (status === kakao.maps.services.Status.OK) {
			
			        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
			        
			        console.log(coords);
			
			        // 결과값으로 받은 위치를 마커로 표시합니다
			        var marker = new kakao.maps.Marker({
			            map: map,
			            position: coords
			        });
			
			        // 인포윈도우로 장소에 대한 설명을 표시합니다
			        var infowindow = new kakao.maps.InfoWindow({
			            content: '<div style="width:150px;text-align:center;padding:6px 0;">매장1</div>'
			        });
			        infowindow.open(map, marker);
			        
			        //지도 디자인의 변화(block, none)가 있을 시 map.relayout()을 통해 다시 map을 그려줄 수 있도록 함
					setTimeout(function(){ map.relayout(); }, 500);
					
					//중심점을 잡지 못함
					// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
			        map.setCenter(coords);
			    }
			});
		}
		
});


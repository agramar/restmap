<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>음식점 상세정보</title>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.1.0.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.form.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/restMap/normalize.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/restMap/starRating.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/restMap/starPoint.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/restMap/restDetail.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/restMap/mapWalker.css">
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=f40a84256f9289bc0afd4a350068c648&libraries=services"></script>

</head>
<body>

<div class="modal fade" id="insertMenuModal" tabindex="-1" role="dialog" aria-labelledby="insertMenuModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <form id="insertRestMenuForm">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="insertMenuModalLabel">메뉴 입력</h4>
      </div>
      <div class="modal-body">
          <!-- 히든 -->
          <div class="form-group">
          	<input type="hidden" class="form-control" id="restId" value="${restBoard.restId}" />
          	<input type="hidden" class="form-control" id="writerNo" value="${restBoard.writerNo}" />
          </div>
          <!-- non히든 places -->
          <div class="form-group">
            <label for="title" class="control-label">식당이름</label>
            <input type="text" class="form-control" id="title" value="${restBoard.title}" readonly />
          </div>
          <div class="form-group">
            <label for="writer" class="control-label">작성자</label>
            <input type="text" class="form-control" id="writer" value="${restBoard.writer}"  readonly />
          </div>
          
          <!-- non히든 직접입력 -->
          <div class="form-group">
            <label for="menuName" class="control-label">메뉴이름</label>
            <input type="text" class="form-control" id="menuName" required />
          </div>
          <div class="form-group">
            <label for="price" class="control-label">가격(원)</label>
            <input type="number" step=500 max=10000000 min=0 class="form-control" id="price" required />
          </div>
		  <div class="form-group">
	          <label for="attachFile" class="control-label">메뉴사진(최대업로드사이즈:10mb)</label>
	          <input type="file" id="attachFile" name="attachFile">
          </div>
          <div class="form-group">
              <label for="attachImage" class="control-label">이미지 미리보기</label>
	          <img id="attachImage" src="${pageContext.request.contextPath}/resources/images/restMap/default_post_img.png" alt="upload image" class="img-thumbnail" />
          </div>
          <div class="form-group">
	          <label for="recommend" class="control-label">메뉴추천</label><br>
	          <input type="checkbox" id="recommend"> 이 메뉴를 추천하시겠습니까?<br>
		  </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal" onclick="clearModal()">닫기</button>
        <button type="submit" class="btn btn-primary">등록</button>
      </div>
    </form>
    </div>
  </div>
</div>


<div class="content_container">
	<div class="left_content">
		<div class="common_info">
		
			<div class="common_info_title">
				<strong><c:out value="${restBoard.title}" /></strong>
				<span>Last Updated <fmt:formatDate value="${restBoard.regDate}" pattern="yyyy-MM-dd hh:mm:ss" /></span>
			</div>
			
			<div class="commmon_info_gallery">
					<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
						<!-- Indicators -->
						<ol class="carousel-indicators">
						</ol>

						<!-- Wrapper for slides -->
						<div class="carousel-inner" role="listbox">
						</div>

						<!-- Controls -->
						<a class="left carousel-control" href="#carousel-example-generic"
							role="button" data-slide="prev"> <span
							class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
							<span class="sr-only">Previous</span>
						</a> <a class="right carousel-control"
							href="#carousel-example-generic" role="button" data-slide="next">
							<span class="glyphicon glyphicon-chevron-right"
							aria-hidden="true"></span> <span class="sr-only">Next</span>
						</a>
					</div>
			</div>
			
			<div class="common_info_content">
				<div id="restDetailController">
					<button id="deleteDetailBtn" type="button" onclick="deleteDetail(${restBoard.restId}); return false;"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span></button>
					<button id="reloadDetailBtn" type="button" onclick="location.reload();"><span class="glyphicon glyphicon-refresh" aria-hidden="true"></span></button>
				</div>
				<div>작성자  : <c:out value="${restBoard.writer}" /></div>
				<div><c:out value="${restBoard.newAddress}" /></div>
				<div>(우) <c:out value="${restBoard.zipcode}" /> (지번) <c:out value="${restBoard.address}" /></div>
				<div><c:out value="${restBoard.phone}" /></div>
				<div>가격대  : <c:out value="${restBoard.minPrice}" />원 ~ <c:out value="${restBoard.maxPrice}" />원</div>
				<div>현위치와의 거리 : </div>
				<div>평균평점  : <c:out value="${restBoard.score}" /></div>
			</div>
		</div>
		
		<div class="detail_info">
			<div class="panel panel-default">
				<div class="panel-heading" role="tab" id="headingOne">
					<h4 class="panel-title">
						<a data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne"><Strong>음식점 정보</Strong></a>
					</h4>
				</div>
				<div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
					<div class="panel-body">
						<div>요약 : <c:out value="${restBoard.summary}"></c:out></div>
						<div>운영시간 : <c:out value="${restBoard.openingHours}"></c:out></div>
						<div>소개 : <c:out value="${restBoard.introduce}"></c:out></div>
						<div>카테고리 : <c:out value="${restBoard.categoryName}"></c:out></div>
						<div>휴일정보 : <c:out value="${restBoard.holidayName}"></c:out></div>
						<div>결제정보 : <c:out value="${restBoard.paymentName}"></c:out></div>
						<div>기타정보 : <c:out value="${restBoard.etcInfo}"></c:out></div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="menu_info">			
			<div class="panel panel-default">
				<div class="panel-heading" role="tab" id="headingTwo">
					<h6 class="panel-title">
						<a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo"><Strong>메뉴 정보</Strong></a>
					</h6>
				</div>
				<div id="collapseTwo" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingTwo">
					<div class="panel-body">
						<div id="menu_wrap" class="menu_wrap">

						</div>
						<div class="menu_controller">
							<div class="btn-group btn-group-xs" role="group" aria-label="...">
									<button type="button" class="btn btn-default"><span class="glyphicon glyphicon-triangle-left"></span></button>
									<button type="button" class="btn btn-default"><span class="glyphicon glyphicon-triangle-right"></span></button>
									<button type="button" data-toggle="modal" data-target="#insertMenuModal" class="btn btn-default"><span class="glyphicon glyphicon-pencil"></span></button>
							</div>
							<div class="menu_page"> <b>1</b> / <b>1</b> </div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="comment_wrap">
			<div class="comment_header">
				<form id="comment_form">
				<div id="comment_title">
					<strong>평점</strong>
					<div id="comment_overview">
					총  <b></b> 건
					</div>
				</div>
				<div id="star-point">
					<div class="star-input">
						<div class="input">
						    <input type="radio" name="star-input" id="p1" value="1"><label for="p1">1</label>
						    <input type="radio" name="star-input" id="p2" value="2"><label for="p2">2</label>
						    <input type="radio" name="star-input" id="p3" value="3"><label for="p3">3</label>
						    <input type="radio" name="star-input" id="p4" value="4"><label for="p4">4</label>
						    <input type="radio" name="star-input" id="p5" value="5"><label for="p5">5</label>
						    <input type="radio" name="star-input" id="p6" value="6"><label for="p6">6</label>
						    <input type="radio" name="star-input" id="p7" value="7"><label for="p7">7</label>
						    <input type="radio" name="star-input" id="p8" value="8"><label for="p8">8</label>
						    <input type="radio" name="star-input" id="p9" value="9"><label for="p9">9</label>
						    <input type="radio" name="star-input" id="p10" value="10"><label for="p10">10</label>
						</div>
						<output for="star-input">
						<b id="star-score">0</b>점
						</output>
					</div>
				</div>
				<div id="comment_size">
					<b>0</b> / 200자
				</div>
				<div id="comment_text_area_div">
					<textarea id="comment_text_area" class="form-control" rows="3" style="resize:none;" required ></textarea>
				</div>
				<div id="comment_button">
					<button type="submit" class="btn btn-primary">등록</button>
				</div>
				</form>
			</div>
			<div id="comment_list" class="comment_list">
			</div>
			<div id="comment_bottom">
				<div id="comment_list_extend">더보기 <span class="glyphicon glyphicon-triangle-bottom" aria-hidden="true"></span></div>
				<div id="comment_list_reduce">닫기 <span class="glyphicon glyphicon-triangle-top" aria-hidden="true"></span></div>
			</div>
		</div>
	</div>
	
	<div class="right_content">

		<div class="map_wrap">
			<div id="map" style="width:100%; height:100%; position:relative; overflow:hidden;"></div>
		</div>
		
		<div class="roadview_wrap">
			<div id="roadview" style="width:100%; height:100%; position:relative; overflow:hidden;"></div>
		</div>

			<div class="blog_wrap">
				<div role="tabpanel">
					<!-- Nav tabs -->
					<ul class="nav nav-tabs" role="tablist">
						<li role="presentation" class="active"><a href="#daum" aria-controls="daum" role="tab" data-toggle="tab">Daum</a></li>
						<li role="presentation"><a href="#naver" aria-controls="naver" role="tab" data-toggle="tab">Naver</a></li>
					</ul>
					<!-- Tab panes -->
					<div class="tab-content">
						<div role="tabpanel" class="tab-pane fade in active" id="daum">
						</div>
						<div role="tabpanel" class="tab-pane fade" id="naver">
						 	만드는중
						</div>
					</div>
				</div>
			</div>

		</div>
	
</div>

<div class="footer">
	<span>서비스 약관/정책 | 고객센터 | 권리침해 신고 | 로컬광고 신청</span>
	<span>본 콘텐츠의 저작권은 나 및 제공처에 있으며, 이를 이용하는 경우 저작권법 등에 따라 법적책임을 질 수 있습니다.</span>
	<span>Copyright © MLEC Corp. All rights reserved.</span>
</div>



<script>
//페이지 로딩시 함수 실행 부분
$(document).ready(function () {
	starRating();
	menuCount();
	menuList();
	commentCount();
	commentList();
	searchDaumBlog(qWord, pageno, viewCount, "accu");
	searchDaumImg(qWord, 1, 20, "accu");
// 	searchNaverBlog(qWord, viewCount, pageno, "sim");
});

var naverApiClientId = "eBcq8r2Sah0ZypmLJPDm";
var naverApiClientSecret = "f3zId0nEqL";
var daumApikey = "d4fbf41bea8918d0251b88c3f354d92c";
var qWord = "${restBoard.title}";

var latitude = ${restBoard.latitude};
var longitude = ${restBoard.longitude};
var distance = 0;

// 현재 위치 얻어내기
if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
        var lat = position.coords.latitude, // 위도
            lon = position.coords.longitude; // 경도
        var locPosition = new daum.maps.LatLng(lat, lon);
        roadMap(latitude, longitude, locPosition);
        roadView(latitude, longitude);
    });
} else {
	// 학원 좌표
    var locPosition = new daum.maps.LatLng(37.49463232407288, 127.02801594808544);
    roadMap(latitude, longitude, locPosition);
}


// 지도 생성
function roadMap(latitude, longitude, locPosition) {
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = { 
	    center: new daum.maps.LatLng(latitude, longitude), // 지도의 중심좌표
	    level: 3 // 지도의 확대 레벨
	};
	//지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
	var map = new daum.maps.Map(mapContainer, mapOption);
	//마커가 표시될 위치입니다 
	var markerPosition  = new daum.maps.LatLng(latitude, longitude);
	// 마커를 생성합니다
	var marker = new daum.maps.Marker({
	    position: markerPosition
	});
	// 마커가 지도 위에 표시되도록 설정합니다
	marker.setMap(map);
	// 현재 위치 좌표도 쏴주기
	var marker2 = new daum.maps.Marker({
	    position: locPosition
	});
// 	marker2.setMap(map);
}

// 로드뷰 생성
function roadView(latitude, longitude) {
	var roadviewContainer = document.getElementById('roadview'); //로드뷰를 표시할 div
	var roadview = new daum.maps.Roadview(roadviewContainer); //로드뷰 객체
	var roadviewClient = new daum.maps.RoadviewClient(); //좌표로부터 로드뷰 파노ID를 가져올 로드뷰 helper객체
	var position = new daum.maps.LatLng(latitude, longitude);
	// 특정 위치의 좌표와 가까운 로드뷰의 panoId를 추출하여 로드뷰를 띄운다.
	roadviewClient.getNearestPanoId(position, 50, function(panoId) {
	    roadview.setPanoId(panoId, position); //panoId와 중심좌표를 통해 로드뷰 실행
	});
	
	
	//지도위에 현재 로드뷰의 위치와, 각도를 표시하기 위한 map walker 아이콘 생성 클래스
	function MapWalker(position){

	    //커스텀 오버레이에 사용할 map walker 엘리먼트
	    var content = document.createElement('div');
	    var figure = document.createElement('div');
	    var angleBack = document.createElement('div');

	    //map walker를 구성하는 각 노드들의 class명을 지정 - style셋팅을 위해 필요
	    content.className = 'MapWalker';
	    figure.className = 'figure';
	    angleBack.className = 'angleBack';

	    content.appendChild(angleBack);
	    content.appendChild(figure);

	    //커스텀 오버레이 객체를 사용하여, map walker 아이콘을 생성
	    var walker = new daum.maps.CustomOverlay({
	        position: position,
	        content: content,
	        yAnchor: 1
	    });

	    this.walker = walker;
	    this.content = content;
	}

	//로드뷰의 pan(좌우 각도)값에 따라 map walker의 백그라운드 이미지를 변경 시키는 함수
	//background로 사용할 sprite 이미지에 따라 계산 식은 달라 질 수 있음
	MapWalker.prototype.setAngle = function(angle){

	    var threshold = 22.5; //이미지가 변화되어야 되는(각도가 변해야되는) 임계 값
	    for(var i=0; i<16; i++){ //각도에 따라 변화되는 앵글 이미지의 수가 16개
	        if(angle > (threshold * i) && angle < (threshold * (i + 1))){
	            //각도(pan)에 따라 아이콘의 class명을 변경
	            var className = 'm' + i;
	            this.content.className = this.content.className.split(' ')[0];
	            this.content.className += (' ' + className);
	            break;
	        }
	    }
	};

	//map walker의 위치를 변경시키는 함수
	MapWalker.prototype.setPosition = function(position){
	    this.walker.setPosition(position);
	};

	//map walker를 지도위에 올리는 함수
	MapWalker.prototype.setMap = function(map){
	    this.walker.setMap(map);
	};

	var mapWalker = null;

	//로드뷰의 초기화 되었을때 map walker를 생성한다.
	daum.maps.event.addListener(roadview, 'init', function() {

	 // map walker를 생성한다. 생성시 지도의 중심좌표를 넘긴다.
	 mapWalker = new MapWalker(mapCenter);
	 mapWalker.setMap(map); // map walker를 지도에 설정한다.

	 // 로드뷰가 초기화 된 후, 추가 이벤트를 등록한다.
	 // 로드뷰를 상,하,좌,우,줌인,줌아웃을 할 경우 발생한다.
	 // 로드뷰를 조작할때 발생하는 값을 받아 map walker의 상태를 변경해 준다.
	 daum.maps.event.addListener(roadview, 'viewpoint_changed', function(){

	     // 이벤트가 발생할 때마다 로드뷰의 viewpoint값을 읽어, map walker에 반영
	     var viewpoint = roadview.getViewpoint();
	     mapWalker.setAngle(viewpoint.pan);

	 });

	 // 로드뷰내의 화살표나 점프를 하였을 경우 발생한다.
	 // position값이 바뀔 때마다 map walker의 상태를 변경해 준다.
	 daum.maps.event.addListener(roadview, 'position_changed', function(){

	     // 이벤트가 발생할 때마다 로드뷰의 position값을 읽어, map walker에 반영 
	     var position = roadview.getPosition();
	     mapWalker.setPosition(position);
	     map.setCenter(position);

	 });
	});
};

























// 다음 이미지 검색 API()
function searchDaumImg(qWord1, pageno1, viewCount1, sort1) {
	pageno = pageno1;
	$.ajax({
		url: "https://apis.daum.net/search/image",
		dataType: "jsonp",
		type: "post",
		jsonp: "callback",
		data: {
			apikey: daumApikey,
			q: qWord1,
			output: "json",
			pageno: pageno1,
			result: viewCount1,
			sort: sort1
		}
	})
	.done(function (result) {
		console.dir(result);
		var r = result.channel; 
		makeDaumSearchImgList(r.item);
	});
};

function makeDaumSearchImgList(searchList) {
	var html = "";
	var html1 = "";
	var html2 = "";
	for (var i = 1; i <= searchList.length; i++) {
		if (i == 1) {
			html1 += "<li data-target='#carousel-example-generic' data-slide-to='" + i + "' class='active'></li>";
			html2 += "<div class='item active'>";
			html2 += "<img src='"+searchList[i-1].thumbnail+"'>";
			html2 += "<div class='carousel-caption'>"+"</div>";
			html2 += "</div>";	
		} else {
			html1 += "<li data-target='#carousel-example-generic' data-slide-to='" + i + "'></li>";
			html2 += "<div class='item'>";
			html2 += "<img src='"+searchList[i-1].thumbnail+"'>";
			html2 += "<div class='carousel-caption'>"+"</div>";
			html2 += "</div>";
		}
	};
	
	$(".carousel-indicators").append(html1);
	$(".carousel-inner").append(html2);
};




// 네이버 블로그 검색 API(보류중)
function searchNaverBlog(query, display, start, sort) {
	$.ajax({
		url: "https://openapi.naver.com/v1/search/blog.xml",
		dataType: "xml",
		type: "get",
		headers: {
			"X-Naver-Client-Id": naverApiClientId,
			"X-Naver-Client-Secret": naverApiClientSecret
		},
		data: {
			query: query,
			display: display,
			start: start,
			sort: sort
		}
	})
	.done(function (result) {
		console.dir(result)
	});
};


// 다음 블로그 검색 API
function searchDaumBlog(qWord1, pageno1, viewCount1, sort1) {
	pageno = pageno1;
	$.ajax({
		url: "https://apis.daum.net/search/blog",
		dataType: "jsonp",
		type: "post",
		jsonp: "callback",
		data: {
			apikey: daumApikey,
			q: qWord1,
			output: "json",
			pageno: pageno1,
			result: viewCount1,
			sort: sort1
		}
	})
	.done(function (result) {
		var r = result.channel; 
		makeDaumSearchList(r.item);
	});
};

// 블로그 검색 결과 태그 추가 함수
function makeDaumSearchList(searchList) {
	var html = "";
	// 리스트 태그 추가
	for (var i = 0; i < searchList.length; i++) {
		var title = escapeHtml(searchList[i].title);
		var description = escapeHtml(searchList[i].description);
			html += '<div class="media">';
			html += '	<div class="media-left media-top">';
			html += '		<a target="_blank" href="'+ searchList[i].link +'">';
// 			html += '			<img class="media-object" src="http://t1.daumcdn.net/thumb/C134x104/?fname=http://t1.daumcdn.net/local/review/efc2404db4972549d07453f9505ad198ab31aa50de8fc7b04576eab5976811d2" width="64px" height="64px">';
			html += '		</a>';
			html += '	</div>';
			html += '	<div class="media-body">';
			html += '		<a target="_blank" href="'+ searchList[i].link +'"><h6 class="media-heading">'+ title +'</h6></a>';
			html += '		<h>'+description+'</h>';
			html += '	</div>';
			html += '</div>';
	};
	$("#daum").html(html);
	daumSearchPagination();
};

// 블로그 대표 이미지 가져오기(네이버블로그 보류)
function getNaverBlogImgUrl() {
	// 태그 정보 가져오기	
}



var pageno = 1;
var viewCount = 4;
function daumSearchPagination() {
	var pagination = "<nav id='pg_nav'>";
		pagination += "<ul id='daumPagination' class='pagination pagination-sm'>";
	for (var i = 1; i <= 3; i++) {
		if (i == pageno) {
			pagination += "<li class='active'><a href='#a' onclick='searchDaumBlog(qWord, "+ i +", "+ viewCount+")'>"+ i +"</a></li>";
		} else {
			pagination += "<li><a href='#a' onclick='searchDaumBlog(qWord, "+ i +", "+ viewCount+")'>"+ i +"</a></li>";
		}
	}	
		pagination += "</ul>";
		pagination += "</nav>";
	$("#daum").append(pagination);
}


// html태그 변환
function escapeHtml(str) {
	str = str.replace(/&amp;/g, "&");
	str = str.replace(/&lt;/g, "<");
	str = str.replace(/&gt;/g, ">");
	str = str.replace("amp;", "&");
	return str;
}

// 메뉴 페이징 처리 변수
var mPageIdx = 1;
var mPageRow = 4;
var menuCnt = 0;
var menuPageCnt = 1;

// 메뉴 리스트 조회 AJAX
function menuList() {
	$.ajax({
		url: "${pageContext.request.contextPath}/restBoard/restMenuList.do",
		data: {
			restId: ${restBoard.restId},
			mPageIdx: mPageIdx,
			mPageRow: mPageRow			
		},
		dataType: "json"
	})
	.done(function (result) {
		makeRestMenuList(result);
		menuCount();
	});
};

// 메뉴 페이지수 카운트 AJAX
function menuCount() {
	$.ajax({
		url: "${pageContext.request.contextPath}/restBoard/restMenuCount.do",
		async: false,
		data: {
			restId: ${restBoard.restId}
		},
		dataType: "json"
	})
	.done(function (result) {
		menuCnt = result;
		if (menuCnt == 0) {
			menuPageCnt = 1;
		} else {
			menuPageCnt = Math.floor((menuCnt - 1) / mPageRow) + 1;
		}
		$(".menu_page > b").eq(0).html(mPageIdx);
		$(".menu_page > b").eq(1).html(menuPageCnt);
	});
};

//메뉴 삭제 AJAX
function menuDelete(menuId, fileId) {
	if(confirm("해당 메뉴를 삭제하시겠습니까?")){
		$.ajax({
			url: "${pageContext.request.contextPath}/restBoard/deleteRestMenu.do",
			data: {
				fileId: fileId,
				menuId: menuId
			},
			dataType: "json"
		})
		.done(menuList);
	};
}

// 메뉴 리스트 태그 생성 함수
function makeRestMenuList(result) {
	$("#menu_wrap").html("");
	for (var i = 0; i < result.length; i++) {
		var html = "";
		if (result[i].recommend == 1) {
			html += "<div style='background: #ffffaa;' class='menu_item'>";	
		} else {
			html += "<div class='menu_item'>";
		}
// 		if (comment.writerNo == ${user.userNo}) {
		html +=	"<div id='menu_remove" + i + "' class='close-classic'><span class='glyphicon glyphicon-remove'></span></div>";
// 		}
		html += "<img class='menu_img' src='${pageContext.request.contextPath}" + "/restBoard/imageDown.do?path=" + result[i].filePath +"' />";
		html += "<div class='menu_name'>" + result[i].menuName + "</div>";
		html += "<div class='menu_price'>" + result[i].price + "원</div>";
		html += "</div>";
		$("#menu_wrap").append(html);
		
		// 삭제 이벤트 등록
		(function (menuInfo, menuRemoveCnt) {
			$("#menu_remove" + menuRemoveCnt).click(function () {
				menuDelete(menuInfo.menuId, menuInfo.fileId);
			});
		})(result[i], i);
	}
	if (result.length == 0) {
		var html = "<b><center>해당 메뉴정보가 존재하지 않습니다 메뉴를 등록해주세요</center></b><br>";
		$("#menu_wrap").html(html);
	}
};

// 메뉴 버튼 이벤트
$(".menu_controller button").eq(1).on("click", function() {
	if (mPageIdx < menuPageCnt){
		mPageIdx++;
		menuList();
	} else {
		return false;
	}
});
$(".menu_controller button").eq(0).on("click", function() {
	if (mPageIdx > 1) {
		mPageIdx--;
		menuList();
	} else {
		return false;
	}
});

// 메뉴 등록 처리 AJAX
$("#insertRestMenuForm").submit(function (){
	var f = document.querySelector("#insertRestMenuForm");
	var recommendData = 0;
	if (f.recommend.checked) {
		recommendData = 1;
	};
	var fd = new FormData();
		fd.append("restId", f.restId.value);
		fd.append("writerNo", f.writerNo.value);
		fd.append("title", f.title.value);
		fd.append("writer", f.writer.value);
		fd.append("menuName", f.menuName.value);
		fd.append("price", f.price.value);
		fd.append("attachFile", $("#insertRestMenuForm input[name=attachFile]")[0].files[0]);
		fd.append("recommend", recommendData);
	$.ajax({
		url: "${pageContext.request.contextPath}/restBoard/restMenuInsert.do",
		data: fd,
		type: "POST",
		processData: false,
		contentType: false
	})
	.done(function (){
		alert("메뉴 등록에 성공 했습니다.");
		clearModal();
    	$('#insertMenuModal').modal('toggle');
    	menuList();
	});
	return false;
});

// 메뉴 등록 모달창 초기화
function clearModal() {
	$('#menuName').val("");
	$('#price').val("");
	$('#attachFile').val("");
	$('#recommended').checked = false;
	$('#attachImage').attr("src", "${pageContext.request.contextPath}/resources/images/restMap/default_post_img.png");
};

//이미지 유효성 체크
function img_validation(input) { 
	var image = input.value;
    if (image != "" ) {
        var ext = image.slice(image.lastIndexOf(".") + 1).toLowerCase();
        if (!(ext == "gif" || ext == "jpg" || ext == "png")) {
            alert("이미지 파일 (JPG, GIF, PNG) 만 업로드 가능합니다.");
            input.focus();
            return false;
        }
    }
    return true;
};

//이미지 미리보기
function readURL(input) {
    if (input.files && input.files[0]) {
    var reader = new FileReader();
    reader.onload = function (e) {
            $('#attachImage').attr('src', e.target.result);
        }
     reader.readAsDataURL(input.files[0]);
    }
};

//파일 업로드 이미지 미리보기 이벤트
$('#attachFile').on('change', function(){
	if(img_validation(this)) {
		readURL(this);
	} else {
		$(this).val("");
		$('#attachImage').attr('src', '${pageContext.request.contextPath}/resources/images/restMap/default_post_img.png');
	};
});

// 별점 이벤트
function starRating() {
	var $star = $(".star-input"), $result = $star.find("output>b");

	$(document).on("focusin", ".star-input>.input", function() {
			$(this).addClass("focus");
	})
	.on("focusout", ".star-input>.input", function() {
		var $this = $(this);
		setTimeout(function() {
			if ($this.find(":focus").length === 0) {
				$this.removeClass("focus");
			}
		}, 100);
	})
	.on("change", ".star-input :radio", function() {
		$result.text($(this).next().text());
	})
	.on("mouseover", ".star-input label", function() {
		$result.text($(this).text());
	})
	.on("mouseleave", ".star-input>.input", function() {
		var $checked = $star.find(":checked");
		if ($checked.length === 0) {
			$result.text("0");
		} else {
			$result.text($checked.next().text());
		}
	});
};

// 댓글창 글자수 제한
$("#comment_text_area").keyup(function () {
	var textArea = $("#comment_text_area");
	var commentSizeDiv = $("#comment_size > b");
	if (textArea.val().length >= 200) {
		alert("글자수 제한을 초과하였습니다.");
		$("#comment_text_area").val(textArea.val().substring(0,200)); 
	}
	commentSizeDiv.html($("#comment_text_area").val().length);
});

// 댓글 목록 조회 변수 설정
var pageIdx = 1;
var pageRow = 3;
var commentCnt = 0;
var commentDelCnt = 0;

// 댓글 확장 함수;
function commentListExtend() {
	pageIdx++;
	commentList();
};

// 댓글 접기 함수;
function commentListReduce() {
	pageIdx = 1;
	commentDelCnt = 0;
	$("#comment_list").html("");
	commentList();
};

// 댓글 확장 축소 클릭 이벤트
$("#comment_list_extend").on("click", commentListExtend);
$("#comment_list_reduce").on("click", commentListReduce);

// 댓글수 체크 함수(확장 축소 버튼 CSS)
function checkCommentCnt() {
	// 모든 댓글 다 불렀을경우
	if(pageIdx * pageRow >= commentCnt) {
		// 시작부분이냐
		if (pageIdx == 1) {
			$("#comment_bottom").css("display", "none");
		// 중간부분이냐
		} else {
			$("#comment_bottom").css("display", "inherit");
			$("#comment_list_extend").css("display", "none");
			$("#comment_list_reduce").css("width", "578px");
		}
	// 부를 댓글이 아직 남았을 경우
	} else {
		// 시작부분이냐
		if (pageIdx == 1) {
			$("#comment_bottom").css("display", "inherit"); 
			$("#comment_list_extend").css("display", "inherit");
			$("#comment_list_extend").css("width", "578px");
		// 중간부분이냐
		} else {
			$("#comment_bottom").css("display", "inherit"); 
			$("#comment_list_extend").css("display", "inherit");
			$("#comment_list_extend").css("width", "478px");
			$("#comment_list_reduce").css("width", "100px");
		}
	}
}


// 댓글수 카운트 AJAX
function commentCount() {
	$.ajax({
		url: "${pageContext.request.contextPath}/restBoard/restCommentCount.do",
		async: false,
		data: {
			restId: ${restBoard.restId}
		},
		dataType: "json"
	})
	.done(function (result) {
		commentCnt = result;
		$("#comment_overview > b").html(result);
		checkCommentCnt();
	});
};


// 댓글 삭제 AJAX
function commentDelete(commentId) {
	if(confirm("평점을 삭제하시겠습니까?")){
		$.ajax({
			url: "${pageContext.request.contextPath}/restBoard/deleteRestComment.do",
			data: {
				commentId: commentId
			},
			dataType: "json"
		})
		.done(function () {
			commentListReduce();
		});
	};
}


// 댓글 리스트 조회 AJAX
function commentList() {
	$.ajax({
		url: "${pageContext.request.contextPath}/restBoard/restCommentList.do",
		data: {
			restId: ${restBoard.restId},
			pageIdx: pageIdx,
			pageRow: pageRow			
		},
		dataType: "json"
	})
	.done(function (result) {
		makeRestCommentList(result);
		commentCount();
	});
};

// 댓글 리스트 태그 만들기
function makeRestCommentList(result) {
	for (var i = 0; i < result.length; i++) {
		commentDelCnt++;
		var html = "";
		var comment = result[i];
		var date = new Date(comment.regDate);
		var time = date.getFullYear() + "-" 
		         + date.getMonth() + "-" 
		         + date.getDate() + " "
		         + date.getHours() + ":"
		         + date.getMinutes() + ":"
		         + date.getSeconds();
		html += "<div id='one_comment'>";
		html += "<div class='one_comment_first_div'>";
		html += "<div class='star-rating'><span style='width: " + comment.score * 10 + "%;'></span></div>";
		html += "<div class='one_comment_score'>" + comment.score + ".0 / 10.0</div>";
		html += "</div>";
		html += "<div class='one_comment_second_div'>";
		html += "<div class='one_comment_content'><b>" + comment.content + "</b> ";
// 		if (comment.writerNo == ${user.userNo}) {
			html +=	"<a id='one_comment_delete"+commentDelCnt+"'>삭제</a></div>";
// 		}
		html += "<div class='one_comment_writer'"+i+"><b>" + comment.writerNo + "</b> | <b>" + time + "</b></div>";
		html += "</div>";
		html += "</div>";
		$("#comment_list").append(html);
		
		// 댓글 삭제 이벤트 등록
		(function (cmtId, cmtDelCnt) {
			$("#one_comment_delete" + cmtDelCnt).click(function () {
				commentDelete(cmtId, cmtDelCnt);
			});
		})(comment.commentId, commentDelCnt);
	}
	if (result.length == 0) {
		var html = "<b><center>댓글이 존재하지 않습니다.</center></b>";
		$("#comment_list").html(html);
	}
}

// 댓글 등록 처리
$("#comment_form").submit(function() {
	$.ajax({
		url: "${pageContext.request.contextPath}/restBoard/insertRestComment.do",
		type: "POST",
		data: {
			restId: ${restBoard.restId},
			writerNo: "1",
			score: $("#star-score").html(),
			content: $("#comment_text_area").val()
		},
		dataType: "json"
	})
	.done(function(result) {
		$("#comment_text_area").val("");
		commentListReduce();
	});
	return false;
});

// 식당 페이지 삭제
function deleteDetail(restId) {
	if (confirm("정말로 식당 정보를 삭제하시겠습니까?")) {
		location.href="${pageContext.request.contextPath}/restBoard/deleteRest.do?restId=" + restId;
	} else {
		return false;
	}
};

</script>
</body>
</html>
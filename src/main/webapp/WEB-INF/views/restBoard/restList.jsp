<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>음식점 리스트</title>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.1.0.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=f40a84256f9289bc0afd4a350068c648&libraries=services"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/restMap/map.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/restMap/search_overlay.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/restMap/restList_overlay.css">
</head>
<body>
<!-- 모달 식당 등록폼 DIV -->
<div class="modal fade" id="insertRestModal" tabindex="-1" role="dialog" aria-labelledby="insertRestModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      
      <form id="insertForm">
      
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="exampleModalLabel">신규 식당 등록</h4>
      </div>
      
      <div class="modal-body">
          <!-- 히든 -->
          <div class="form-group">
          	<input type="hidden" class="form-control" id="restId">
          	<input type="hidden" class="form-control" id="latitude">
          	<input type="hidden" class="form-control" id="longitude">
          	<input type="hidden" class="form-control" id="imageUrl">
          	<input type="hidden" class="form-control" id="writerNo">
          </div>
          	
          <!-- non히든 places -->
          <div class="form-group">
            <label for="title" class="control-label">식당이름</label>
            <input type="text" class="form-control" id="title" readonly>
          </div>
          <div class="form-group">
            <label for="address" class="control-label">주소</label>
            <input type="text" class="form-control" id="address" readonly>
          </div>
          <div class="form-group">
            <label for="newAddress" class="control-label">신주소</label>
            <input type="text" class="form-control" id="newAddress" readonly>
          </div>
          <div class="form-group">
            <label for="zipcode" class="control-label">우편번호</label>
            <input type="text" class="form-control" id="zipcode" readonly>
          </div>
          <div class="form-group">
            <label for="phone" class="control-label">전화번호</label>
            <input type="text" class="form-control" id="phone" readonly>
          </div>
            
          <!-- non히든 직접입력 -->
          <div class="form-group">
            <label for="writer" class="control-label">작성자</label>
            <input type="text" class="form-control" id="writer" readonly>
          </div>
          <div class="form-group">
            <label for="openingHours" class="control-label">이용시간</label>
            <input type="text" class="form-control" id="openingHours">
          </div>
          <div class="form-group">
            <label for="summary" class="control-label">요약</label>
            <input type="text" class="form-control" id="summary">
          </div> 
          <div class="form-group">
            <label for="introduce" class="control-label">소개</label>
            <textarea class="form-control" id="introduce"></textarea>
          </div> 
          <div class="form-group">
            <label for="categoryId" class="control-label">카테고리</label>
            <select id="categoryId" class="form-control">
            </select>
          </div>  
          <div class="form-group">
             <label for="holidayId" class="control-label">휴무일</label>
             <select id="holidayId" class="form-control">
           	 </select>
          </div>
          <div class="form-group">
            <label for="paymentId" class="control-label">결제정보</label>
            <select id="paymentId" class="form-control">
            </select>
          </div>
          <div class="form-group">
            <label for="etcInfo" class="control-label">기타정보</label>
            <input type="text" class="form-control" id="etcInfo">
          </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
        <button type="submit" class="btn btn-primary">등록</button>
      </div>
      
    </form>
    
    </div>
  </div>
</div>


<div class="container">

	<!-- 지도 DIV -->
	<div class="map_wrap">
	    <div id="map" style="width:100%; height:100%; position:relative; overflow:hidden;"></div>
	
	    <div id="menu_wrap_control" style="width:20px; height:20px;">
	    <button style="width:20px; height:20px;" type="button" id="searchCon" onclick="controlbt()" class="btn btn-default btn-lg">
	  	<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
		</button>
	    </div>
	    
	    <div id="menu_wrap" class="bg_white">
	        <div class="option">
	            <div>
	                <form onsubmit="searchPlaces(); return false;">
	                    키워드 : <input type="text" value="" id="keyword" size="15"> 
	                    <button type="submit">검색하기</button> 
	                </form>
	            </div>
	        </div>
	        <hr>
	        <ul id="placesList"></ul>
	        <div id="pagination"></div>
	    </div>
	</div>
	
	<!-- 리스트 DIV -->
	<div id="rest_list_wrap" class="rest_list_wrap">
		
	</div>

</div>


<script>
//default 경도 위도(학원좌표)
var defaultLat = 37.49463232407288;
var defaultLng = 127.02801594808544;

//HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
if (navigator.geolocation) {
    // GeoLocation을 이용해서 접속 위치를 얻어옵니다
    navigator.geolocation.getCurrentPosition(function(position) {
        defaultLat = position.coords.latitude, // 위도
        defaultLng = position.coords.longitude; // 경도
     });
}

// 검색창 변수 
var searchMenu = false;

// 마커를 담을 배열입니다
// 검색 마커
var markers = [];
// 리스트 마커
var restListMarkers = [];

// 오버레이 담을 객체
var overlay;

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new daum.maps.LatLng(defaultLat, defaultLng), // 지도의 중심좌표
        level: 2 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new daum.maps.Map(mapContainer, mapOption); 

//일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
var mapTypeControl = new daum.maps.MapTypeControl();

// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
// daum.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
map.addControl(mapTypeControl, daum.maps.ControlPosition.TOPRIGHT);

// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
var zoomControl = new daum.maps.ZoomControl();
map.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);

// 장소 검색 객체를 생성합니다
var ps = new daum.maps.services.Places();  

// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
var infowindow = new daum.maps.InfoWindow({zIndex:1});

// 키워드 검색을 요청하는 함수입니다
function searchPlaces() {

    var keyword = document.getElementById('keyword').value;

    if (!keyword.replace(/^\s+|\s+$/g, '')) {
        alert('키워드를 입력해주세요!');
        return false;
    }

    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
    ps.keywordSearch(keyword, placesSearchCB); 
}


// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
function placesSearchCB(status, data, pagination) {
    if (status === daum.maps.services.Status.OK) {
    	var isExist = false;
		for (var i = 0; i < data.places.length; i++) {
			if (data.places[i].category.startsWith('음식점')) {
				isExist = true;
				break;
			}
		}
		if (!isExist) {
			alert('검색 결과가 존재하지 않습니다.');
	        return;
		}
        // 정상적으로 검색이 완료됐으면
        // 검색 목록과 마커를 표출합니다
        displayPlaces(data.places);

        // 페이지 번호를 표출합니다
        displayPagination(pagination);

    } else if (status === daum.maps.services.Status.ZERO_RESULT) {
        alert('검색 결과가 존재하지 않습니다.');
        return;

    } else if (status === daum.maps.services.Status.ERROR) {
        alert('검색 결과 중 오류가 발생했습니다.');
        return;

    }
}


// 검색 결과 목록과 마커를 표출하는 함수입니다
function displayPlaces(places) {
	
    var listEl = document.getElementById('placesList'), 
    menuEl = document.getElementById('menu_wrap'),
    fragment = document.createDocumentFragment(), 
    bounds = new daum.maps.LatLngBounds(), 
    listStr = '';
    
    // 검색 결과 목록에 추가된 항목들을 제거합니다
    removeAllChildNods(listEl);

    // 지도에 표시되고 있는 마커를 제거합니다
    removeMarker();
    
    // 검색 자료중 카테고리가 음식점일 경우만
    var count=0;
    for ( var i=0; i<places.length; i++ ) {
		if (places[i].category.startsWith('음식점')) {
        
		// 마커를 생성하고 지도에 표시합니다
        var placePosition = new daum.maps.LatLng(places[i].latitude, places[i].longitude),
            marker = addMarker(placePosition, count), 
            itemEl = getListItem(count, places[i], marker); // 검색 결과 항목 Element를 생성합니다

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        bounds.extend(placePosition);
            
        // 검색결과에 이벤트 넣어주기
        (function(marker, places, placePosition) {
        	// 검색결과 관련 이벤트 함수
        	function searchAction() {
            	// 중심좌표 이동
            	map.panTo(placePosition);
            	// 오버레이 초기화
            	if (overlay) {
            		overlay.setMap(null);
            	};
            	// 오버레이 내용
            	var content = '<div class="wrap">' + 
                '    <div class="info">' + 
                '        <div class="title">' + 
                places.title + 
                '            <div class="close" onclick="closeOverlay()" title="닫기"></div>' + 
                '        </div>' + 
                '        <div class="body">' + 
                '            <div class="img">';
                if (places.imageUrl) {
                	content +=  '<img src="' + places.imageUrl  + '" width="73" height="70">';
                } else {
                	content +=  '<img src="http://cfile181.uf.daum.net/image/250649365602043421936D" width="73" height="70">';
                }
                content +=
                '           </div>' + 
                '            <div class="desc">' + 
                '                <div class="ellipsis">'+ places.newAddress + '</div>' + 
                '                <div class="jibun ellipsis">(지번)' + places.address + '</div>' + 
                '				 <div><button id="showModal'+count+'">맛집등록</button></div>'+
                '            </div>' + 
                '        </div>' + 
                '    </div>' +    
                '</div>';
                
                // 오버레이 객체 만들고 맵에 띄우기
            	overlay = new daum.maps.CustomOverlay({
            	    content: content,
            	    map: map,
            	    position: marker.getPosition()       
            	});
                overlay.setMap(map);
                // 식당 등록폼 모달 오픈 function
                $('#showModal'+count).click( function () {
                	// 중복체크
                	$.ajax({
                		url: "${pageContext.request.contextPath}/restBoard/selectRestId.do",
                		data: {restId: places.id},
                	})
                	.done(function (result){
                		console.dir(result);
                		if (result != 0) {
                			alert('이미 등록된 곳입니다'); 
                		} else {
                			// 모달 초기화
                			clearModal();
		                	// places 객체에 있는 정보 넣어주기
		                	$('#insertRestModal').find('#title').val(places.title);
		                	$('#insertRestModal').find('#restId').val(places.id);
		                	$('#insertRestModal').find('#latitude').val(places.latitude);
		                	$('#insertRestModal').find('#longitude').val(places.longitude);
		                	$('#insertRestModal').find('#imageUrl').val(places.imageUrl);
		                	$('#insertRestModal').find('#address').val(places.address);
		                	$('#insertRestModal').find('#newAddress').val(places.newAddress);
		                	$('#insertRestModal').find('#zipcode').val(places.zipcode);
		                	$('#insertRestModal').find('#phone').val(places.phone);
		                	$('#insertRestModal').find('#writer').val('김호동');
		                	$('#insertRestModal').find('#writerNo').val('1');
		                	// selectBOX 내용 DB에서 가져와 호출
		                	function codeList(param, targetDiv) {
		                		$.ajax({
		                    		url: "${pageContext.request.contextPath}/restBoard/codeListByCategory.do",
		                    		data: {codeCategory: param},
		                    		dataType: "JSON"
		                    	})
		                    	.done(function (result){
		                    		targetDiv.html("");
		                    		for (var i = 0; i < result.length; i++) {
		                    			targetDiv.append('<option value="'+result[i].codeId+'">'+result[i].codeValue+'</option>');
		                    		}
		                    	});
		                	}
		                	codeList('restCode', $('#categoryId'));
		                	codeList('holiCode', $('#holidayId'));
		                	codeList('payCode', $('#paymentId'));
		                   	$('#insertRestModal').modal('show');
                		}
                	});
                });
        	}
        	// 마커 이벤트 등록
            daum.maps.event.addListener(marker, 'click', searchAction);
            // 검색창 리스트 이벤트 등록
            itemEl.onclick = searchAction;
        })(marker, places[i], placePosition);
        fragment.appendChild(itemEl);
        count++;
		}
    }
    // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
    listEl.appendChild(fragment);
    menuEl.scrollTop = 0;
    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
    map.setBounds(bounds);
}

// 검색결과 항목을 Element로 반환하는 함수입니다
function getListItem(index, places) {
    var el = document.createElement('li'),
    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
                '<div class="info">' +
                '   <h5>' + places.title + '</h5>';
    if (places.newAddress) {
        itemStr += '    <span>' + places.newAddress + '</span>' +
                    '   <span class="jibun gray">' +  places.address  + '</span>';
    } else {
        itemStr += '    <span>' +  places.address  + '</span>'; 
    }
                 
      itemStr += '  <span class="tel">' + places.phone  + '</span>' +
                '</div>';           
    el.innerHTML = itemStr;
    el.className = 'item';
    return el;
}

// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
function addMarker(position, idx, title) {
    var imageSrc = 'http://i1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
        imageSize = new daum.maps.Size(36, 37),  // 마커 이미지의 크기
        imgOptions =  {
            spriteSize : new daum.maps.Size(36, 691), // 스프라이트 이미지의 크기
            spriteOrigin : new daum.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
            offset: new daum.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
        },
        markerImage = new daum.maps.MarkerImage(imageSrc, imageSize, imgOptions),
            marker = new daum.maps.Marker({
            position: position, // 마커의 위치
            image: markerImage 
        });

    marker.setMap(map); // 지도 위에 마커를 표출합니다
    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

    return marker;
}

// 지도 위에 표시되고 있는 마커를 모두 제거하는 함수
function removeMarker() {
    for ( var i = 0; i < markers.length; i++ ) {
        markers[i].setMap(null);
    }   
    markers = [];
}

// 지도 위에 표시되고 있는 리스트 마커를 모두 제거하는 함수
function removeRestListMarker() {
	console.dir(restListMarkers);
    for ( var i = 0; i < restListMarkers.length; i++ ) {
    	restListMarkers[i].setMap(null);
    }
    restListMarkers = [];
    console.dir(restListMarkers);
}

// 검색결과 목록 하단에 페이지번호를 표시는 함수
function displayPagination(pagination) {
    var paginationEl = document.getElementById('pagination'),
        fragment = document.createDocumentFragment(),
        i; 
    // 기존에 추가된 페이지번호를 삭제합니다
    while (paginationEl.hasChildNodes()) {
        paginationEl.removeChild (paginationEl.lastChild);
    }
    for (i=1; i<=pagination.last; i++) {
        var el = document.createElement('a');
        el.href = "#";
        el.innerHTML = i;
        if (i===pagination.current) {
            el.className = 'on';
        } else {
            el.onclick = (function(i) {
                return function() {
                    pagination.gotoPage(i);
                }
            })(i);
        }
        fragment.appendChild(el);
    }
    paginationEl.appendChild(fragment);
}


//커스텀 오버레이를 닫기 위해 호출되는 함수입니다 
function closeOverlay() {
    overlay.setMap(null);     
}

// 검색결과 목록의 자식 Element를 제거하는 함수입니다
function removeAllChildNods(el) {   
    while (el.hasChildNodes()) {
        el.removeChild (el.lastChild);
    }
};

// 모달창 초기화 함수
function clearModal() {
	$('#title').val("");
	$('#restId').val("");
	$('#latitude').val("");
	$('#longitude').val("");
	$('#imageUrl').val("");
	$('#address').val("");
	$('#newAddress').val("");
	$('#zipcode').val("");
	$('#phone').val("");
	$('#writer').val("");
	$('#writerNo').val("");
	$('#openingHours').val("");
	$('#introduce').val("");
	$('#summary').val("");
	$('#etcInfo').val("");
	$('#categoryId').empty();
	$('#holidayId').empty();
	$('#paymentId').empty();
};

// 버튼으로 장소검색 DIV 토글 함수
function controlbt() {
	// 초기화
	var listEl = document.getElementById('placesList');
	if (overlay) {
		overlay.setMap(null);     
	}
	var obj_bt = document.getElementById('searchCon'); //클릭 메뉴의 아이디 
	var obj = document.getElementById('menu_wrap'); //펼쳐질 박스의 아이디 
	if (obj.style.display == 'none') { //닫혀 있다면 
		removeAllChildNods(listEl);
		removeRestListMarker();
		obj.style.display = ''; //펼쳐주고 
		obj_bt.innerHTML = '<span class="glyphicon glyphicon-minus" aria-hidden="true"></span>'; //닫기 라고 표기하고 
		searchMenu = true;
	} else { //열려 있다면 
		removeMarker();
		obj.style.display = 'none'; //닫아 주고 
		obj_bt.innerHTML= '<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>'; //펼치기라고 표기 하고
	    // 기존에 추가된 페이지번호를 삭제합니다
		var paginationEl = document.getElementById('pagination');
	    while (paginationEl.hasChildNodes()) {
	        paginationEl.removeChild (paginationEl.lastChild);
	    }
	    searchMenu = false;
	}
};

// insertForm modal 등록 처리
$("#insertForm").submit(function (){
	var f = document.querySelector("#insertForm");
	$.ajax({
		url: "${pageContext.request.contextPath}/restBoard/insertRestBoard.do",
		type: "POST",
		data: {
			restId: f.restId.value,
			title: f.title.value,
			address: f.address.value,
			newAddress: f.newAddress.value,
			latitude: f.latitude.value,
			longitude: f.longitude.value,
			phone: f.phone.value,
			zipcode: f.zipcode.value,
			imageUrl: f.imageUrl.value,
			writer: f.writer.value,
			writerNo: f.writerNo.value,
			introduce: f.introduce.value,
			summary: f.summary.value,
			categoryId: f.categoryId.value,
			holidayId: f.holidayId.value,
			paymentId: f.paymentId.value,
			openingHours: f.openingHours.value,
			etcInfo: f.etcInfo.value					
		}
	})
	.done(function (){
		alert("식당 등록에 성공 했습니다.");
		// 모달 초기화
		clearModal();
    	// 모달창 닫기
    	$('#insertRestModal').modal('toggle');
	});
	return false;
});

// 지도 영영 변화시 이벤트
daum.maps.event.addListener(map, 'idle', selectRestListByBound);

// 화면 표시 영역에 있는 식당 리스트 얻어오는 함수
function selectRestListByBound () {
	// 검색창이 열려있을경우 수행 중지
	if (searchMenu) return;
	// 지도의 현재 영역을 얻어옵니다 
	var bounds = map.getBounds();
	// 영역의 남서쪽 좌표를 얻어옵니다 
    var swLatLng = bounds.getSouthWest(); 
    // 영역의 북동쪽 좌표를 얻어옵니다 
    var neLatLng = bounds.getNorthEast(); 
	
    var east = neLatLng.gb;
    var west = swLatLng.gb;
    var south = swLatLng.hb;
    var north = neLatLng.hb;
    
    // 얻은 정보로  ajax 요청해서 식당 리스트를 받아옴
    $.ajax({
		url: "${pageContext.request.contextPath}/restBoard/selectListByBound.do",
		type: "POST",
		async: false,
		dataType: "json",
		data: {
			east: east,
			west: west,
			south: south,
			north: north
		}
	})
	.done(function (result){
		console.dir(result);
    	// 오버레이 초기화 & 마커 초기화
    	if (overlay) {
    		overlay.setMap(null);
		}
		removeRestListMarker();
		// 마커 이미지의 이미지 주소입니다
		var imageSrc = "http://i1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
		// 마커 이미지의 이미지 크기 입니다
		var imageSize = new daum.maps.Size(24, 35); 
		// 마커 이미지를 생성합니다    
		var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize);
		// 리스트 DIV 초기화
	    $('#rest_list_wrap').empty();
		if (result.length == 0) {
			var listDiv = '<div class="rest_empty"><p>현재 위치에 식당이 없습니다.</p></div>';
			$('#rest_list_wrap').append(listDiv);
		} else {
		    for (var i = 0; i < result.length; i++) {
				
		    	// 좌표 객체 생성
		    	var makerPosition = new daum.maps.LatLng(result[i].latitude, result[i].longitude); 
		    	
		    	// 마커 
			    // 마커를 생성합니다
			    var restListMarker = new daum.maps.Marker({
			        map: map, // 마커를 표시할 지도
			        position: makerPosition, // 마커를 표시할 위치
			        title : result[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
			        image : markerImage // 마커 이미지 
			    });
			    restListMarker.setMap(map);
			    restListMarkers.push(restListMarker);
			    
		    	// 식당 리스트 div
		    	var listDiv = '<div id="rest_element'+i+'" class="rest_element">'
                if (result[i].imageUrl) {
                	listDiv +=  '<img src="' + result[i].imageUrl  + '" width="120" height="120">';
                } else {
                	listDiv +=  '<img src="http://cfile181.uf.daum.net/image/250649365602043421936D" width="120" height="120">';
                }
		    		listDiv += '<div id="rest_element_content">'
		    		listDiv += '<p><strong>' +result[i].title+'</strong></p>'
		    		if (result[i].summary) {
		    			listDiv += '<p>' + result[i].summary+ '</p>' 
		    		}
		    		listDiv += '<p>distance</p>' 
		    				+ '<p>price</p>' 
		    				+ '<p>score</p>' 
		    				+ '</div>'
		    				+ '</div>';
				$('#rest_list_wrap').append(listDiv);
				
				
				// 이벤트 등록
				(function(makerPosition, place) {
			    	// 리스트이벤트 추가 함수
			    	function listAction() {
				    	if (overlay) {
				    		overlay.setMap(null);
						}
			        	// 중심좌표 이동
			        	map.setCenter(makerPosition);

			        	// 오버레이 내용 HTML
						var content = '<div class="overlay_info">';
						content += '    <a href="${pageContext.request.contextPath}/restBoard/restDetail.do?restId='+place.restId+'" target="_blank"><strong>'+place.title+'</strong></a>';
						content += '    <div class="desc">';
						if (place.imageUrl) {
							content += '        <img src="'+place.imageUrl+'" alt="">';
						} else {
							content += '<img src="http://cfile181.uf.daum.net/image/250649365602043421936D">'
						}
						content += '        <span class="address">'+place.address+'</span>';
						content += '        <span class="newAddress">(신주소) '+place.newAddress+'</span>';
						content += '        <span class="telephone">(전화번호) '+place.phone+' (우편번호) '+place.zipcode+'</span>';
						content += '        <span class="distance">거리</span>';
						content += '        <span class="score">별점</span>';
						content += '        <button type="button" class="deleteBtn">삭제하기</button>';
						content += '        <button type="button" class="detailBtn">상세보기</button>';
						content += '    </div>';
						content += '</div>';
			        	
			            // 오버레이 객체 만들고 맵에 띄우기
			        	overlay = new daum.maps.CustomOverlay({
			        	    content: content,
			        	    map: map,
			        	    position: makerPosition,
			        	    xAnchor: 0.49, // 커스텀 오버레이의 x축 위치입니다. 1에 가까울수록 왼쪽에 위치합니다. 기본값은 0.5 입니다
			        	    yAnchor: 1.16 // 커스텀 오버레이의 y축 위치입니다. 1에 가까울수록 위쪽에 위치합니다. 기본값은 0.5 입니다
			        	});
			            overlay.setMap(map);
			    	}
		        	// 마커 이벤트 등록
		            daum.maps.event.addListener(restListMarker, 'click', listAction);
		            // 검색창 리스트 이벤트 등록
		            $('#rest_element' + i).on('click', listAction);
				})(makerPosition, result[i]);

		    }
		}
	});
}


//시작할때 검색창 닫아둔 상태로 시작
controlbt();

//현재 화면 리스트 얻어오기
selectRestListByBound();

</script>
</body>
</html>
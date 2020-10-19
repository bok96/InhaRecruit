<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" session="true" %>
<%@ page import="java.util.Calendar" %>

<!-- 현재 월의 마지막 주 계산 -->
<%
	Calendar calendar = Calendar.getInstance();
	calendar.set(Calendar.DATE, calendar.getActualMaximum(Calendar.DATE));
	int week = calendar.get(Calendar.WEEK_OF_MONTH);
%>

<html>
<head>
	<title>Inha Recruit</title>
	<link rel="stylesheet" href="resources/css/home.css">
	<link rel="stylesheet" href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
	<link rel="stylesheet" href="https://uicdn.toast.com/tui.chart/latest/tui-chart.min.css">
	<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.4.1.min.js"/>"></script>
    <script type="text/javascript" src="https://uicdn.toast.com/tui.code-snippet/v1.5.0/tui-code-snippet.min.js"></script>
    <script type="text/javascript" src="https://uicdn.toast.com/tui.pagination/v3.3.0/tui-pagination.js"></script>
    <script type="text/javascript" src="https://uicdn.toast.com/tui.chart/latest/raphael.js"></script>
    <script src="https://uicdn.toast.com/tui.chart/latest/tui-chart.min.js"></script>
    <script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
</head>
<body>
<script>
	// 브라우저 로딩시 실행되는 부분
	window.onload = function() {
		return;
	}
	
	function resetMenu() { // 보기(기본형, 그리드, 차트) 메뉴 초기화
		$("#result").hide();
		$("#bot-nav").hide();
		$("#grid").hide();
		$("#grid").html("");
		$("#chart").hide();
		$("#chart").html("");
		$("#date-menu").hide();
	}
	
	function basic() {
		resetMenu();
		$("#result").show();
		$("#bot-nav").show();
	}
	
	function grid() {
		if($("#grid").is(":visible")) {
			return false;
		}
		
		resetMenu();
		$("#grid").show();
		
		var grid = new tui.Grid({
			el: document.getElementById("grid"),
			data: 
				{
					api: {
						readData: { url: '/recruit/readData', method: 'GET'}
					}
				},
			scrollX: false,
			scrollY: false,
			pageOptions: {
				perPage: 10
			},
			pagination: true,
			columns: [
				{
					header: '제목',
					name: 'title',
					sortable: true,
					resizable: true
				},
				{
					header: '회사명',
					name: 'company',
					sortable: true,
					width: 140,
					align: 'center',
					resizable: true
				},
				{
					header: '지역',
					name: 'region',
					sortable: true,
					width: 85,
					align: 'center',
					resizable: true
				},
				{
					header: '직무',
					name: 'job',
					sortable: true,
					width: 130,
					align: 'center',
					resizable: true
				},
				{
					header: '기업형태',
					name: 'cotype',
					sortable: true,
					width: 65,
					align: 'center'
				},
				{
					header: '고용형태',
					name: 'emptype',
					sortable: true,
					width: 65,
					align: 'center'
				},
				{
					header: '연봉',
					name: 'salary',
					sortable: true,
					width: 50,
					align: 'center',
					resizable: true
				},
				{
					header: '마감일',
					name: 'd_date',
					sortable: true,
					width: 90,
					resizable: true
				}
			]
		});
	}
	
	function chart() {
		resetMenu();
		$("#chart").show();
		$("#date-menu").show();
	}
	
	function makeChart() {
		var date;
		var first;
		var second = [];
		var categories = [];
		
		// 차트 - 선택한 날짜, 대분류(직무, 지역, 기업형태, 고용형태) 설정
		date  = $("input[name=date]:checked").val();
		first = $("input[name=first]:checked").val();
		if(first == 0) {
			$("input[name=cbx-date-job]:checked").each(function() {
				second.push($(this).val());
			});
		} else if(first == 1) {
			$("input[name=cbx-date-region]:checked").each(function() {
				console.log($(this).val());
				second.push($(this).val());
			});
		} else if(first == 2) {
			$("input[name=cbx-date-cotype]:checked").each(function() {
				second.push($(this).val());
			});
		} else if(first == 3) {
			$("input[name=cbx-date-emptype]:checked").each(function() {
				second.push($(this).val());
			});
		} else {
			alert('에러가 발생했습니다.');
			return false;
		}
		
		if(second.length > 5) {
			alert('항목은 5개까지만 선택 가능합니다.');
			return false;
		} else if(second.length == 0) {
			alert('항목을 1개 이상 선택해주세요.');
			return false;
		}

		var infoJob = ["전체", "웹프로그래머", "시스템프로그래머", "네트워크·서버보안", "ERP·시스템분석", "데이터베이스·DBA", "웹디자인", "하드웨어·소프트웨어", "통신·모바일", "게임", "인공지능·빅데이터"]
		var infoRegion = { 0: "서울전체", 100: "경기전체", 200: "인천전체" };
		var infoCotype = ["전체", "대기업", "중견기업", "중소기업"]
		var infoEmptype = ["전체", "정규직", "계약직", "인턴"]
		
		
		// categories 리스트 세팅
		var categories;
		var week; // 마지막 주차 변수
		if(date == 0) { // 1일
			if(first==0) {
				for(var i=0 ; i<second.length ; i++) {
					categories.push(infoJob[second[i]]);
				}
			} else if(first==1) {
				for(var i=0 ; i<second.length ; i++) {
					categories.push(infoRegion[second[i]]);
				}		
			} else if(first==2) {
				for(var i=0 ; i<second.length ; i++) {
					categories.push(infoCotype[second[i]]);
				}
			} else if(first==3) {
				for(var i=0 ; i<second.length ; i++) {
					categories.push(infoEmptype[second[i]]);
				}
			}
		} else if(date==1) { // 1개월 [1주, 2주, 3주, 4주, 5주]
			week = <%=week%>;
			for(var i=1 ; i<week+1 ; i++) {
				categories.push(i.toString()+"주");
			}
		} else if(date==2) { // 3개월 [M-2월, M-1월, M월]
			categories.push("M-2월");
			categories.push("M-1월");
			categories.push("M월");
		} else if(date==3) { // 1년 [1월, 2월, ..., 11월, 12월]
			for(var i=1 ; i<13 ; i++) {
				categories.push(i.toString()+"월");
			}
		}
		console.log("categories : " + categories);
		
		var objParams = {
			"date" : date,
			"first" : first,
			"second" : second
		};

		objParams = JSON.stringify(objParams);
		console.log("서버단으로 넘기는 json data : " + objParams);
		
		var data = {};
		$.ajax({ // 차트 데이터 비동기식으로 변환
			url: "/recruit/chart",
	        type: "post",
	        data: {"objParams" : objParams},
	        async: false,
	        success: function(value) {
				data.series = value;
				console.log("서버단에서 넘어온 json data : " + console.log(value));
	        },
	        error: function(request, status, error) {
	          alert("code:" + request.status + "\nmessage:" + request.responseText + "\nerror:" + error);
	        }
		});
		data.categories = categories;
		console.log("최종 json : " + JSON.stringify(data));
		
		var container = document.getElementById('chart');

		var barOptions = {
				chart: {width: 900, height: 650, title: '오늘의 채용정보', format: '1,000'},
				yAxis: {title: '항목', tickInterval: 'auto'}, xAxis: {title: '채용정보수', suffix:'개'},
				series: {showLabel: true, tickInterval: 'auto'}
		};
		
		var chartOptionsMonth = {
			    chart: {width: 900, height: 650, title: '이번달 채용정보 차트', format: '1,000'},
			    yAxis: {title: '개수'}, xAxis: {title: '주차별', pointOnColumn: true, dateFormat: 'MMM'},
			    series: {showDot: false, zoomable: true}, tooltip: {suffix: '개'},
			    plot: {
			         bands: [
			             {
			                  range:['1', week],
			                  color: 'gray',
			                  opacity: 0.2
			             }
			         ]
			     }
		};
		
		var chartOptions3Months = {
			    chart: {width: 900, height: 650, title: '최근 3개월간 채용정보 차트', format: '1,000'},
			    yAxis: {title: '개수'}, xAxis: {title: '월별', pointOnColumn: true, dateFormat: 'MMM'},
			    series: {showDot: false, zoomable: true}, tooltip: {suffix: '개'},
			    plot: {
			         bands: [
			             {
			                  range:['1', '3'],
			                  color: 'gray',
			                  opacity: 0.2
			             }
			         ]
			     }
		};
		
		var chartOptionsYear = {
			    chart: {width: 900, height: 650, title: '월별 채용정보 차트', format: '1,000'},
			    yAxis: {title: '개수'}, xAxis: {title: '월별', pointOnColumn: true, dateFormat: 'MMM'},
			    series: {showDot: false, zoomable: true}, tooltip: {suffix: '개'},
			    plot: {
			         bands: [
			             {
			                  range:['1', '12'],
			                  color: 'gray',
			                  opacity: 0.2
			             }
			         ]
			     }
		};
		
		$(container).html(""); // 차트 reset
		
		if(date==0) {
			tui.chart.barChart(container, data, barOptions);
		} else if(date==1) {
			tui.chart.lineChart(container, data, chartOptionsMonth);
		} else if(date==2) {
			tui.chart.lineChart(container, data, chartOptions3Months);
		} else if(date==3) {
			tui.chart.lineChart(container, data, chartOptionsYear);
		}
	}
	
	// 차트 - 대분류 체크박스 체크시 발생하는 함수
	function dateCbxReset() {
		$("#div-date-job").hide();
		$("#div-date-region").hide();
		$("#div-date-cotype").hide();
		$("#div-date-emptype").hide();
	}
	function checkDateJob() { 
		dateCbxReset();
		$('#div-date-job').show();
	}
	function checkDateRegion() {
		dateCbxReset();
		$('#div-date-region').show();
	}
	function checkDateCotype() {
		dateCbxReset();
		$('#div-date-cotype').show();
	}
	function checkDateEmptype() {
		dateCbxReset();
		$('#div-date-emptype').show();
	}
	
	// 기본형 - 항목별 전체 체크박스 체크시 발생하는 함
	function checkJobAll() {
		$('input:checkbox[name=job]').each(function(index, item) {
			$(item).toggle(
				function() {$(item).attr("disabled", true);},
				function() {$(item).attr("disabled", false);}
			);
		});
	}
	function checkRegionAll0() {
		$('input:checkbox[name=region0]').each(function(index, item) {
			$(item).toggle(
				function() {$(item).attr("disabled", true);},
				function() {$(item).attr("disabled", false);}
			);
		});
	}
	function checkRegionAll1() {
		$('input:checkbox[name=region1]').each(function(index, item) {
			$(item).toggle(
				function() {$(item).attr("disabled", true);},
				function() {$(item).attr("disabled", false);}
			);
		});
	}
	function checkRegionAll2() {
		$('input:checkbox[name=region2]').each(function(index, item) {
			$(item).toggle(
				function() {$(item).attr("disabled", true);},
				function() {$(item).attr("disabled", false);}
			);
		});
	}
	function checkCoAll() {
		$('input:checkbox[name=cotype]').each(function(index, item) {
			$(item).toggle(
				function() {$(item).attr("disabled", true);},
				function() {$(item).attr("disabled", false);}
			);
		});
	}
	function checkEmpAll() {
		$('input:checkbox[name=emptype]').each(function(index, item) {
			$(item).toggle(
				function() {$(item).attr("disabled", true);},
				function() {$(item).attr("disabled", false);}
			);
		});
	}

	// 채용정보검색 - 함수
	function resetContents() {
		$(".left_content_1").attr("src", "resources/img/left_menus1.png");
		$(".left_content_2").attr("src", "resources/img/left_menus2.png");
		$(".left_content_3").attr("src", "resources/img/left_menus3.png");
		$(".left_content_4").attr("src", "resources/img/left_menus4.png");
	}
	function disableRightContents() {
		$("#jobDiv").hide();
		$("#regionDiv").hide();
		$("#cotypeDiv").hide();
		$("#emptypeDiv").hide();
	}
	function changeContents(obj) { // 직무별 전환
		if($(obj).is(".left_content_1")) {
			resetContents();
			$(obj).attr("src", "resources/img/left_menus1a.png");
			disableRightContents();
			$("#jobDiv").show();
		}
		else if($(obj).is(".left_content_2")) { // 지역별 전환
			resetContents();
			$(obj).attr("src", "resources/img/left_menus2a.png");
			disableRightContents();
			$("#regionDiv").show();
		}
		else if($(obj).is(".left_content_3")) { // 기업형태별 전환
			resetContents();
			$(obj).attr("src", "resources/img/left_menus3a.png");
			disableRightContents();
			$("#cotypeDiv").show();
		}
		else if($(obj).is(".left_content_4")) { // 고용형태별 전환
			resetContents();
			$(obj).attr("src", "resources/img/left_menus4a.png");
			disableRightContents();
			$("#emptypeDiv").show();
		}
	}
	
	// 채용 정보 검색
	function search() {
		var jobs = [];
		var regions = [];
		var cotypes = [];
		var emptypes = [];
		var count = 0;		// 구역 체크 확인 변수
		var totalcount = 0;	// 전체 체크 확인 변수
		
		var result = [];
		
		if(document.getElementsByName("job_all")[0].checked == true) { // 직업 전체 선택		*
			jobs.push("0");
			totalcount++;
		} else {
			$('input[name="job"]:checked').each(function(i) {
				count++;
				totalcount++;
				jobs.push($(this).val());
			});

			if(count == 0) {
				jobs.push("0");
			}
		}
		
		count = 0;
		
		if(document.getElementsByName("region0_all")[0].checked == true) { // 지역 전체 선택	*
			regions.push("0");
			count++;
			totalcount++;
		} else {
			$('input[name="region0"]:checked').each(function(i) {
				count++;
				totalcount++;
				regions.push($(this).val());
			});
		}
		
		if(document.getElementsByName("region1_all")[0].checked == true) { // 지역 전체 선택	*
			regions.push("100");
			count++;
			totalcount++;
		} else {
			$('input[name="region1"]:checked').each(function(i) {
				count++;
				totalcount++;
				regions.push($(this).val());
			});
		}
		
		if(document.getElementsByName("region2_all")[0].checked == true) { // 지역 전체 선택	*
			regions.push("200");
			count++;
			totalcount++;
		} else {
			$('input[name="region2"]:checked').each(function(i) {
				count++;
				totalcount++;
				regions.push($(this).val());
			});

			if(count == 0) {
				regions.push("0");
				regions.push("100");
				regions.push("200");
			}
		}
		
		count = 0;
		
		if(document.getElementsByName("cotype_all")[0].checked == true) { // 기업 전체 선택		*
			cotypes.push("0");
			totalcount++;
		} else {
			$('input[name="cotype"]:checked').each(function(i) {
				count++;
				totalcount++;
				cotypes.push($(this).val());
			});

			if(count == 0) {
				cotypes.push("0");
			}
		}
		
		count = 0;
		
		if(document.getElementsByName("emptype_all")[0].checked == true) { // 고용 전체 선택	*
			emptypes.push("0");
			totalcount++;
		} else {
			$('input[name="emptype"]:checked').each(function(i) {
				count++;
				totalcount++;
				emptypes.push($(this).val());
			});

			if(count == 0) {
				emptypes.push("0");
			}
		}
		
		if(totalcount == 0) {
			alert('한 종류 이상 선택해주세요.');
			return false;
		}
		
		var objParams = {
			"jobs" : jobs,
			"regions" : regions,
			"cotypes" : cotypes,
			"emptypes" : emptypes
		};
		
		var url = "/recruit?";
		
		if(jobs.length > 0) url += "jobs=";
		for (var i=0 ; i<jobs.length ; i++) {
			url += jobs[i];
			if(i < jobs.length-1) {
				url += ","
			} else {
				url += "&"
			}
		}
		
		if(regions.length > 0) url += "regions=";
		for (var i=0 ; i<regions.length ; i++) {
			url += regions[i];
			if(i < regions.length-1) {
				url += ","
			} else {
				url += "&"
			}
		}
		
		if(cotypes.length > 0) url += "cotypes=";
		for (var i=0 ; i<cotypes.length ; i++) {
			url += cotypes[i];
			if(i < cotypes.length-1) {
				url += ","
			} else {
				url += "&"
			}
		}
		
		if(emptypes.length > 0) url += "emptypes=";
		for (var i=0 ; i<emptypes.length ; i++) {
			url += emptypes[i];
			if(i < emptypes.length-1) {
				url += ","
			} else {
				url += "&"
			}
		}
		
		url += "page=1";
		location.href=url;
	}
</script>
	<%@ include file="/WEB-INF/views/include/header.jsp" %>
	<div id="container">
		<div id="sidebar">
			<c:if test="${member == null}">
				<a href="login"><img class="btn" src="resources/img/login.png"></a>
				<a href="find"><img src="resources/img/main_findAcc.png"></a><a href="join"><img src="resources/img/main_join.png"></a>
			</c:if>
			
			<c:if test="${member != null}">
				<div class="member"><p class="member-c">${member.email} 님 환영합니다.</p></div>
				<div class="member"><a href="logout">로그아웃</a></div>
			</c:if>
			
			<div id="notice">
				<div id="notice-contents">
					<table id="notice-table">
						<tr class="notice-th"><th><a href="notice?page=1">공지사항</a></th></tr>
						<c:forEach items="${noticeBoards}" var="item">
							<tr>
								<td><a href="/recruit/notice/${item.no}">${item.title}</a></td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</div>
		</div>
		<div id="contents">
			<div id="left_contents">
				<img class="left_content_1" src="resources/img/left_menus1a.png" onclick="changeContents(this);"><br/>
				<img class="left_content_2" src="resources/img/left_menus2.png"  onclick="changeContents(this);"><br/>
				<img class="left_content_3" src="resources/img/left_menus3.png"  onclick="changeContents(this);"><br/>
				<img class="left_content_4" src="resources/img/left_menus4.png"  onclick="changeContents(this);"><br/>
			</div>
			<div id="right_contents">
			<form>
				<div id="jobDiv" style="font-size: 100px; font-family:'NanumGothic'">
					<table>
						<tr><td><label for="cbx-job0"><input id="cbx-job0" name="job_all" type="checkbox" value="0" onclick="checkJobAll()"/>IT 계열 전체</label></td></tr>
						<tr><td><label for="cbx-job1"><input id="cbx-job1" name="job" type="checkbox" value="1"/>웹프로그래머</label></td></tr>
						<tr><td><label for="cbx-job2"><input id="cbx-job2" name="job" type="checkbox" value="2"/>시스템프로그래머</label></td></tr>
						<tr><td><label for="cbx-job3"><input id="cbx-job3" name="job" type="checkbox" value="3"/>네트워크·서버보안</label></td></tr>
						<tr><td><label for="cbx-job4"><input id="cbx-job4" name="job" type="checkbox" value="4"/>ERP·시스템분석</label></td></tr>
						<tr><td><label for="cbx-job5"><input id="cbx-job5" name="job" type="checkbox" value="5"/>데이터베이스·DBA</label></td></tr>
						<tr><td><label for="cbx-job6"><input id="cbx-job6" name="job" type="checkbox" value="6"/>웹디자인</label></td></tr>
						<tr><td><label for="cbx-job7"><input id="cbx-job7" name="job" type="checkbox" value="7"/>하드웨어·소프트웨어</label></td></tr>
						<tr><td><label for="cbx-job8"><input id="cbx-job8" name="job" type="checkbox" value="8"/>통신·모바일</label></td></tr>
						<tr><td><label for="cbx-job9"><input id="cbx-job9" name="job" type="checkbox" value="9"/>게임</label></td></tr>
						<tr><td><label for="cbx-job10"><input id="cbx-job10" name="job" type="checkbox" value="10"/>인공지능·빅데이터</label></td></tr>
					</table>
				</div>

				<div id="regionDiv" style="display: none; font-size: 15px; font-family: 'NanumGothic'">
					<p>서울</p>
					<table>
						<tr>
							<td><label for="cbx-region0"><input id="cbx-region0" name="region0_all" type="checkbox" value="0" onclick="checkRegionAll0()"/>전체</label></td>
							<td><label for="cbx-region1"><input id="cbx-region1" name="region0" type="checkbox" value="1"/>강남구</label></td>
							<td><label for="cbx-region2"><input id="cbx-region2" name="region0" type="checkbox" value="2"/>강동구</label></td>
							<td><label for="cbx-region3"><input id="cbx-region3" name="region0" type="checkbox" value="3"/>강북구</label></td>
							<td><label for="cbx-region4"><input id="cbx-region4" name="region0" type="checkbox" value="4"/>강서구</label></td>
						</tr>
						<tr>
							<td><label for="cbx-region5"><input id="cbx-region5" name="region0" type="checkbox" value="5"/>관악구</label></td>
							<td><label for="cbx-region6"><input id="cbx-region6" name="region0" type="checkbox" value="6"/>광진구</label></td>
							<td><label for="cbx-region7"><input id="cbx-region7" name="region0" type="checkbox" value="7"/>구로구</label></td>
							<td><label for="cbx-region8"><input id="cbx-region8" name="region0" type="checkbox" value="8"/>금천구</label></td>
							<td><label for="cbx-region9"><input id="cbx-region9" name="region0" type="checkbox" value="9"/>도봉구</label></td>
						</tr>
						<tr>
							<td><label for="cbx-region10"><input id="cbx-region10" name="region0" type="checkbox" value="10"/>동대문구</label></td>
							<td><label for="cbx-region11"><input id="cbx-region11" name="region0" type="checkbox" value="11"/>동작구</label></td>
							<td><label for="cbx-region12"><input id="cbx-region12" name="region0" type="checkbox" value="12"/>마포구</label></td>
							<td><label for="cbx-region13"><input id="cbx-region13" name="region0" type="checkbox" value="13"/>서대문구</label></td>
							<td><label for="cbx-region14"><input id="cbx-region14" name="region0" type="checkbox" value="14"/>서초구</label></td>
						</tr>
						<tr>
							<td><label for="cbx-region15"><input id="cbx-region15" name="region0" type="checkbox" value="15"/>성동구</label></td>
							<td><label for="cbx-region16"><input id="cbx-region16" name="region0" type="checkbox" value="16"/>성북구</label></td>
							<td><label for="cbx-region17"><input id="cbx-region17" name="region0" type="checkbox" value="17"/>송파구</label></td>
							<td><label for="cbx-region18"><input id="cbx-region18" name="region0" type="checkbox" value="18"/>양천구</label></td>
							<td><label for="cbx-region19"><input id="cbx-region19" name="region0" type="checkbox" value="19"/>영등포구</label></td>
						</tr>
						<tr>
							<td><label for="cbx-region20"><input id="cbx-region20" name="region0" type="checkbox" value="20"/>용산구</label></td>
							<td><label for="cbx-region21"><input id="cbx-region21" name="region0" type="checkbox" value="21"/>은평구</label></td>
							<td><label for="cbx-region22"><input id="cbx-region22" name="region0" type="checkbox" value="22"/>종로구</label></td>
							<td><label for="cbx-region23"><input id="cbx-region23" name="region0" type="checkbox" value="23"/>중구</label></td>
							<td><label for="cbx-region24"><input id="cbx-region24" name="region0" type="checkbox" value="24"/>중랑구</label></td>
						</tr>
						<tr>
							<td><label for="cbx-region25"><input id="cbx-region25" name="region0" type="checkbox" value="25"/>노원구</label></td>
						</tr>
					</table>
					<p>경기</p>
					<table>
						<tr>
							<td><label for="cbx-region100"><input id="cbx-region100" name="region1_all" type="checkbox" value="100" onclick="checkRegionAll1()"/>전체</label></td>
							<td><label for="cbx-region101"><input id="cbx-region101" name="region1" type="checkbox" value="101"/>가평군</label></td>
							<td><label for="cbx-region102"><input id="cbx-region102" name="region1" type="checkbox" value="102"/>고양시</label></td>
							<td><label for="cbx-region103"><input id="cbx-region103" name="region1" type="checkbox" value="103"/>과천시</label></td>
							<td><label for="cbx-region104"><input id="cbx-region104" name="region1" type="checkbox" value="104"/>광명시</label></td>
						</tr>
						<tr>
							<td><label for="cbx-region105"><input id="cbx-region105" name="region1" type="checkbox" value="105"/>광주시</label></td>
							<td><label for="cbx-region106"><input id="cbx-region106" name="region1" type="checkbox" value="106"/>구리시</label></td>
							<td><label for="cbx-region107"><input id="cbx-region107" name="region1" type="checkbox" value="107"/>군포시</label></td>
							<td><label for="cbx-region108"><input id="cbx-region108" name="region1" type="checkbox" value="108"/>김포시</label></td>
							<td><label for="cbx-region109"><input id="cbx-region109" name="region1" type="checkbox" value="109"/>남양주시</label></td>
						</tr>
						<tr>
							<td><label for="cbx-region110"><input id="cbx-region110" name="region1" type="checkbox" value="110"/>동두천시</label></td>
							<td><label for="cbx-region111"><input id="cbx-region111" name="region1" type="checkbox" value="111"/>부천시</label></td>
							<td><label for="cbx-region112"><input id="cbx-region112" name="region1" type="checkbox" value="112"/>성남시</label></td>
							<td><label for="cbx-region113"><input id="cbx-region113" name="region1" type="checkbox" value="113"/>시흥시</label></td>
							<td><label for="cbx-region114"><input id="cbx-region114" name="region1" type="checkbox" value="114"/>안산시</label></td>
						</tr>
						<tr>
							<td><label for="cbx-region115"><input id="cbx-region115" name="region1" type="checkbox" value="115"/>안성시</label></td>
							<td><label for="cbx-region116"><input id="cbx-region116" name="region1" type="checkbox" value="116"/>안양시</label></td>
							<td><label for="cbx-region117"><input id="cbx-region117" name="region1" type="checkbox" value="117"/>양주시</label></td>
							<td><label for="cbx-region118"><input id="cbx-region118" name="region1" type="checkbox" value="118"/>양평군</label></td>
							<td><label for="cbx-region119"><input id="cbx-region119" name="region1" type="checkbox" value="119"/>여주시</label></td>
						</tr>
						<tr>
							<td><label for="cbx-region120"><input id="cbx-region120" name="region1" type="checkbox" value="120"/>연천군</label></td>
							<td><label for="cbx-region121"><input id="cbx-region121" name="region1" type="checkbox" value="121"/>오산시</label></td>
							<td><label for="cbx-region122"><input id="cbx-region122" name="region1" type="checkbox" value="122"/>용인시</label></td>
							<td><label for="cbx-region123"><input id="cbx-region123" name="region1" type="checkbox" value="123"/>의왕시</label></td>
							<td><label for="cbx-region124"><input id="cbx-region124" name="region1" type="checkbox" value="124"/>의정부시</label></td>
						</tr>
						<tr>
							<td><label for="cbx-region125"><input id="cbx-region125" name="region1" type="checkbox" value="125"/>이천시</label></td>
							<td><label for="cbx-region126"><input id="cbx-region126" name="region1" type="checkbox" value="126"/>파주시</label></td>
							<td><label for="cbx-region127"><input id="cbx-region127" name="region1" type="checkbox" value="127"/>평택시</label></td>
							<td><label for="cbx-region128"><input id="cbx-region128" name="region1" type="checkbox" value="128"/>포천시</label></td>
							<td><label for="cbx-region129"><input id="cbx-region129" name="region1" type="checkbox" value="129"/>하남시</label></td>
						</tr>
						<tr>
							<td><label for="cbx-region130"><input id="cbx-region130" name="region1" type="checkbox" value="130"/>화성시</label></td>
							<td><label for="cbx-region131"><input id="cbx-region131" name="region1" type="checkbox" value="131"/>수원시</label></td>
						</tr>
					</table>
					<p>인천</p>
					<table>
						<tr>
							<td><label for="cbx-region200"><input id="cbx-region200" name="region2_all" type="checkbox" value="200" onclick="checkRegionAll2()"/>전체</label></td>
							<td><label for="cbx-region201"><input id="cbx-region201" name="region2" type="checkbox" value="201"/>강화군</label></td>
							<td><label for="cbx-region202"><input id="cbx-region202" name="region2" type="checkbox" value="202"/>계양구</label></td>
							<td><label for="cbx-region203"><input id="cbx-region203" name="region2" type="checkbox" value="203"/>미추홀구</label></td>
							<td><label for="cbx-region204"><input id="cbx-region204" name="region2" type="checkbox" value="204"/>남동구</label></td>
						</tr>
						<tr>
							<td><label for="cbx-region205"><input id="cbx-region205" name="region2" type="checkbox" value="205"/>동구</label></td>
							<td><label for="cbx-region206"><input id="cbx-region206" name="region2" type="checkbox" value="206"/>부평구</label></td>
							<td><label for="cbx-region207"><input id="cbx-region207" name="region2" type="checkbox" value="207"/>서구</label></td>
							<td><label for="cbx-region208"><input id="cbx-region208" name="region2" type="checkbox" value="208"/>연수구</label></td>
							<td><label for="cbx-region209"><input id="cbx-region209" name="region2" type="checkbox" value="209"/>옹진군</label></td>
						</tr>
						<tr>
							<td><label for="cbx-region210"><input id="cbx-region210" name="region2" type="checkbox" value="210"/>중구</label></td>
						</tr>
					</table>
				</div>
			
				<div id="cotypeDiv" style="display: none; font-size: 18px; font-family: 'NanumGothic'">
					<table>
						<tr><td><label for="cbx-cotype0"><input id="cbx-cotype0" name="cotype_all" type="checkbox" value="0" onclick="checkCoAll()"/>전체</label></td></tr>
						<tr><td><label for="cbx-cotype1"><input id="cbx-cotype1" name="cotype" type="checkbox" value="1"/>대기업</label></td></tr>
						<tr><td><label for="cbx-cotype2"><input id="cbx-cotype2" name="cotype" type="checkbox" value="2"/>중견기업</label></td></tr>
						<tr><td><label for="cbx-cotype3"><input id="cbx-cotype3" name="cotype" type="checkbox" value="3"/>중소기업</label></td></tr>
					</table>
				</div>
				
				<div id="emptypeDiv" style="display: none; font-size: 18px; font-family: 'NanumGothic'">
					<table>
						<tr><td><label for="cbx-emptype0"><input id="cbx-emptype0" name="emptype_all" type="checkbox" value="0" onclick="checkEmpAll()"/>전체</label></td></tr>
						<tr><td><label for="cbx-emptype1"><input id="cbx-emptype1" name="emptype" type="checkbox" value="1"/>정규직</label></td></tr>
						<tr><td><label for="cbx-emptype2"><input id="cbx-emptype2" name="emptype" type="checkbox" value="2"/>계약직</label></td></tr>
						<tr><td><label for="cbx-emptype3"><input id="cbx-emptype3" name="emptype" type="checkbox" value="3"/>인턴</label></td></tr>
					</table>
				</div>
				
				<div id="right_contents_fix">
					<input type="button" value="검색하기" onclick="return search();">
				</div>
			</form>
			</div>
		</div>
		
		<img src="resources/img/board_title.png">
		<div id="view_menu">
			<label for="radio-basic"><input id="radio-basic" type="radio" name="view" value="0" onclick="basic();" checked/>기본형 보기</label>
			<label for="radio-grid"> <input id="radio-grid"  type="radio" name="view" value="1" onclick="grid();"/>그리드 보기</label>
			<label for="radio-chart"><input id="radio-chart" type="radio" name="view" value="2" onclick="chart();"/>차트 보기</label>
			<hr>
			<div id="date-menu">
				<label for="cbx-date0"><input id="cbx-date0" type="radio" name="date" value="0" checked/>1일</label>
				<label for="cbx-date1"><input id="cbx-date1" type="radio" name="date" value="1"/>1개월</label>
				<label for="cbx-date2"><input id="cbx-date2" type="radio" name="date" value="2"/>3개월</label>
				<label for="cbx-date3"><input id="cbx-date3" type="radio" name="date" value="3"/>1년</label>
				<hr>
				<div id="date-menu-first">
					<label for="radio-date-job">    <input id="radio-date-job"     type="radio" name="first" value="0" onclick="checkDateJob()" checked/>직무</label>
					<label for="radio-date-region"> <input id="radio-date-region"  type="radio" name="first" value="1" onclick="checkDateRegion()"/>지역</label>
					<label for="radio-date-cotype"> <input id="radio-date-cotype"  type="radio" name="first" value="2" onclick="checkDateCotype()"/>기업형태</label>
					<label for="radio-date-emptype"><input id="radio-date-emptype" type="radio" name="first" value="3" onclick="checkDateEmptype()"/>고용형태</label>
				</div>
				<hr>
				<div id="date-menu-second">
					<div id="div-date-job">
						<label for="cbx-date-job1"> <input id="cbx-date-job1"  name="cbx-date-job" type="checkbox" value="1"/>웹프로그래머</label>
						<label for="cbx-date-job2"> <input id="cbx-date-job2"  name="cbx-date-job" type="checkbox" value="2"/>시스템프로그래머</label>
						<label for="cbx-date-job3"> <input id="cbx-date-job3"  name="cbx-date-job" type="checkbox" value="3"/>네트워크·서버보안</label>
						<label for="cbx-date-job4"> <input id="cbx-date-job4"  name="cbx-date-job" type="checkbox" value="4"/>ERP·시스템분석</label>
						<label for="cbx-date-job5"> <input id="cbx-date-job5"  name="cbx-date-job" type="checkbox" value="5"/>데이터베이스·DBA<br/></label>
						<label for="cbx-date-job6"> <input id="cbx-date-job6"  name="cbx-date-job" type="checkbox" value="6"/>웹디자인</label>
						<label for="cbx-date-job7"> <input id="cbx-date-job7"  name="cbx-date-job" type="checkbox" value="7"/>하드웨어·소프트웨어</label>
						<label for="cbx-date-job8"> <input id="cbx-date-job8"  name="cbx-date-job" type="checkbox" value="8"/>통신·모바일</label>
						<label for="cbx-date-job9"> <input id="cbx-date-job9"  name="cbx-date-job" type="checkbox" value="9"/>게임</label>
						<label for="cbx-date-job10"><input id="cbx-date-job10" name="cbx-date-job" type="checkbox" value="10"/>인공지능·빅데이터</label>
					</div>
					<div id="div-date-region">
						<label for="cbx-date-region0">  <input id="cbx-date-region0"   name="cbx-date-region" type="checkbox" value="0"/>서울전체</label>
						<label for="cbx-date-region100"><input id="cbx-date-region100" name="cbx-date-region" type="checkbox" value="100"/>경기전체</label>
						<label for="cbx-date-region200"><input id="cbx-date-region200" name="cbx-date-region" type="checkbox" value="200"/>인천전체</label>
					</div>
					<div id="div-date-cotype">
						<label for="cbx-date-cotype1"><input id="cbx-date-cotype1" name="cbx-date-cotype" type="checkbox" value="1"/>대기업</label>
						<label for="cbx-date-cotype2"><input id="cbx-date-cotype2" name="cbx-date-cotype" type="checkbox" value="2"/>중견기업</label>
						<label for="cbx-date-cotype3"><input id="cbx-date-cotype3" name="cbx-date-cotype" type="checkbox" value="3"/>중소기업</label>
					</div>
					<div id="div-date-emptype">
						<label for="cbx-date-emptype1"><input id="cbx-date-emptype1" name="cbx-date-emptype" type="checkbox" value="1"/>정규직</label>
						<label for="cbx-date-emptype2"><input id="cbx-date-emptype2" name="cbx-date-emptype" type="checkbox" value="2"/>계약직</label>
						<label for="cbx-date-emptype3"><input id="cbx-date-emptype3" name="cbx-date-emptype" type="checkbox" value="3"/>인턴</label>
					</div>
				</div>
				<input type="button" name="btn_chart" value="차트변환" onclick="return makeChart();"/>
			</div>
		</div>
		<div id="result">
			<c:if test="${recruitBoards ne null}">
				<c:forEach items="${recruitBoards}" var="item">
					<div class="recruit-contents">
						<div class="recruit-title" onclick="location.href='${item.link}'">${item.title}</div>
						<div class="recruit-details">
							<table>
								<tr>
									<td width=20%>${item.company}</td>
									<td width=20%>${item.region}</td>
									<td width=20%>${item.job}</td>
									<td width=10%>${item.cotype}</td>
									<td width=10%>${item.emptype}</td>
									<td width=20%>~${fn:split(item.deadline, ' ')[0]}</td>
								</tr>
							</table>
						</div>
					</div>
				</c:forEach>
				
			</c:if>
		</div>
		
		<div id="bot-nav">
			<ul>
				<c:if test="${param.page gt 10}">
					<li><a href="/recruit/?jobs=${jobs}&regions=${regions}&cotypes=${cotypes}&emptypes=${emptypes}&page=${paging.blockStartNum-1}">PREV</a></li>
				</c:if>
		        
		        <c:forEach var="i" begin="${paging.blockStartNum}" end="${paging.blockLastNum}">
		            <c:choose>
		                <c:when test="${i gt paging.lastPageNum}">
		
		                </c:when>
		                <c:when test="${i eq param.page}">
		                    <li class="selected">${i}</li>
		                </c:when>
		
		                <c:otherwise>
		                    <li><a href="/recruit?jobs=${jobs}&regions=${regions}&cotypes=${cotypes}&emptypes=${emptypes}&page=${i}">${i}</a></li>
		                </c:otherwise>
		            </c:choose>
		        </c:forEach>
		        <c:if test="${ paging.lastPageNum gt paging.blockLastNum }">
		            <li><a href="/recruit?jobs=${jobs}&regions=${regions}&cotypes=${cotypes}&emptypes=${emptypes}&page=${paging.blockLastNum+1}">NEXT</a></li>
		        </c:if>
			</ul>
		</div>
		
		<div id="grid"></div>
		
		<div id="chart"></div>
		
	</div>
	
</body>
</html>

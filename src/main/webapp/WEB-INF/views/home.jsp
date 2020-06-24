<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" session="true" %>
<html>
<head>
	<title>Inha Recruit</title>
	<link rel="stylesheet" href="resources/css/home.css">
	<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.4.1.min.js"/>"></script>
</head>
<body>
<script>
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
	
	function search() { // 채용 정보 검색
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
				<img class="left_content_2" src="resources/img/left_menus2.png" onclick="changeContents(this);"><br/>
				<img class="left_content_3" src="resources/img/left_menus3.png" onclick="changeContents(this);"><br/>
				<img class="left_content_4" src="resources/img/left_menus4.png" onclick="changeContents(this);"><br/>
			</div>
			<div id="right_contents">
			<form>
				<div id="jobDiv" style="font-size: 100px; font-family:'NanumGothic'">
					<table>
						<tr><td><input name="job_all" type="checkbox" value="0" onclick="checkJobAll()"/>IT 계열 전체</td></tr>
						<tr><td><input name="job" type="checkbox" value="1"/>웹프로그래머</td></tr>
						<tr><td><input name="job" type="checkbox" value="2"/>시스템프로그래머</td></tr>
						<tr><td><input name="job" type="checkbox" value="3"/>네트워크·서버보안</td></tr>
						<tr><td><input name="job" type="checkbox" value="4"/>ERP·시스템분석</td></tr>
						<tr><td><input name="job" type="checkbox" value="5"/>데이터베이스·DBA</td></tr>
						<tr><td><input name="job" type="checkbox" value="6"/>웹디자인</td></tr>
						<tr><td><input name="job" type="checkbox" value="7"/>하드웨어·소프트웨어</td></tr>
						<tr><td><input name="job" type="checkbox" value="8"/>통신·모바일</td></tr>
						<tr><td><input name="job" type="checkbox" value="9"/>게임</td></tr>
						<tr><td><input name="job" type="checkbox" value="10"/>인공지능·빅데이터</td></tr>
					</table>
				</div>

				<div id="regionDiv" style="display: none; font-size: 15px; font-family: 'NanumGothic'">
					<p>서울</p>
					<table>
						<tr>
							<td width="83px"><input name="region0_all" type="checkbox" value="0" onclick="checkRegionAll0()"/>전체</td>
							<td width="83px"><input name="region0" type="checkbox" value="1"/>강남구</td>
							<td width="83px"><input name="region0" type="checkbox" value="2"/>강동구</td>
							<td width="83px"><input name="region0" type="checkbox" value="3"/>강북구</td>
							<td width="83px"><input name="region0" type="checkbox" value="4"/>강서구</td>
						</tr>
						<tr>
							<td><input name="region0" type="checkbox" value="5"/>관악구</td>
							<td><input name="region0" type="checkbox" value="6"/>광진구</td>
							<td><input name="region0" type="checkbox" value="7"/>구로구</td>
							<td><input name="region0" type="checkbox" value="8"/>금천구</td>
							<td><input name="region0" type="checkbox" value="9"/>도봉구</td>
						</tr>
						<tr>
							<td><input name="region0" type="checkbox" value="10"/>동대문구</td>
							<td><input name="region0" type="checkbox" value="11"/>동작구</td>
							<td><input name="region0" type="checkbox" value="12"/>마포구</td>
							<td><input name="region0" type="checkbox" value="13"/>서대문구</td>
							<td><input name="region0" type="checkbox" value="14"/>서초구</td>
						</tr>
						<tr>
							<td><input name="region0" type="checkbox" value="15"/>성동구</td>
							<td><input name="region0" type="checkbox" value="16"/>성북구</td>
							<td><input name="region0" type="checkbox" value="17"/>송파구</td>
							<td><input name="region0" type="checkbox" value="18"/>양천구</td>
							<td><input name="region0" type="checkbox" value="19"/>영등포구</td>
						</tr>
						<tr>
							<td><input name="region0" type="checkbox" value="20"/>용산구</td>
							<td><input name="region0" type="checkbox" value="21"/>은평구</td>
							<td><input name="region0" type="checkbox" value="22"/>종로구</td>
							<td><input name="region0" type="checkbox" value="23"/>중구</td>
							<td><input name="region0" type="checkbox" value="24"/>중랑구</td>
						</tr>
						<tr>
							<td><input name="region0" type="checkbox" value="25"/>노원구</td>
						</tr>
					</table>
					<p>경기</p>
					<table>
						<tr>
							<td width="83px"><input name="region1_all" type="checkbox" value="100" onclick="checkRegionAll1()"/>전체</td>
							<td width="83px"><input name="region1" type="checkbox" value="101"/>가평군</td>
							<td width="83px"><input name="region1" type="checkbox" value="102"/>고양시</td>
							<td width="83px"><input name="region1" type="checkbox" value="103"/>과천시</td>
							<td width="83px"><input name="region1" type="checkbox" value="104"/>광명시</td>
						</tr>
						<tr>
							<td><input name="region1" type="checkbox" value="105"/>광주시</td>
							<td><input name="region1" type="checkbox" value="106"/>구리시</td>
							<td><input name="region1" type="checkbox" value="107"/>군포시</td>
							<td><input name="region1" type="checkbox" value="108"/>김포시</td>
							<td><input name="region1" type="checkbox" value="109"/>남양주시</td>
						</tr>
						<tr>
							<td><input name="region1" type="checkbox" value="110"/>동두천시</td>
							<td><input name="region1" type="checkbox" value="111"/>부천시</td>
							<td><input name="region1" type="checkbox" value="112"/>성남시</td>
							<td><input name="region1" type="checkbox" value="113"/>시흥시</td>
							<td><input name="region1" type="checkbox" value="114"/>안산시</td>
						</tr>
						<tr>
							<td><input name="region1" type="checkbox" value="115"/>안성시</td>
							<td><input name="region1" type="checkbox" value="116"/>안양시</td>
							<td><input name="region1" type="checkbox" value="117"/>양주시</td>
							<td><input name="region1" type="checkbox" value="118"/>양평군</td>
							<td><input name="region1" type="checkbox" value="119"/>여주시</td>
						</tr>
						<tr>
							<td><input name="region1" type="checkbox" value="120"/>연천군</td>
							<td><input name="region1" type="checkbox" value="121"/>오산시</td>
							<td><input name="region1" type="checkbox" value="122"/>용인시</td>
							<td><input name="region1" type="checkbox" value="123"/>의왕시</td>
							<td><input name="region1" type="checkbox" value="124"/>의정부시</td>
						</tr>
						<tr>
							<td><input name="region1" type="checkbox" value="125"/>이천시</td>
							<td><input name="region1" type="checkbox" value="126"/>파주시</td>
							<td><input name="region1" type="checkbox" value="127"/>평택시</td>
							<td><input name="region1" type="checkbox" value="128"/>포천시</td>
							<td><input name="region1" type="checkbox" value="129"/>하남시</td>
						</tr>
						<tr>
							<td><input name="region1" type="checkbox" value="130"/>화성시</td>
							<td><input name="region1" type="checkbox" value="130"/>수원시</td>
						</tr>
					</table>
					<p>인천</p>
					<table>
						<tr>
							<td width="83px"><input name="region2_all" type="checkbox" value="200" onclick="checkRegionAll2()"/>전체</td>
							<td width="83px"><input name="region2" type="checkbox" value="201"/>강화군</td>
							<td width="83px"><input name="region2" type="checkbox" value="202"/>계양구</td>
							<td width="83px"><input name="region2" type="checkbox" value="203"/>미추홀구</td>
							<td width="83px"><input name="region2" type="checkbox" value="204"/>남동구</td>
						</tr>
						<tr>
							<td><input name="region2" type="checkbox" value="205"/>동구</td>
							<td><input name="region2" type="checkbox" value="206"/>부평구</td>
							<td><input name="region2" type="checkbox" value="207"/>서구</td>
							<td><input name="region2" type="checkbox" value="208"/>연수구</td>
							<td><input name="region2" type="checkbox" value="209"/>옹진군</td>
						</tr>
						<tr>
							<td><input name="region2" type="checkbox" value="210"/>중구</td>
						</tr>
					</table>
				</div>
			
				<div id="cotypeDiv" style="display: none; font-size: 18px; font-family: 'NanumGothic'">
					<table>
						<tr><td><input name="cotype_all" type="checkbox" value="0" onclick="checkCoAll()"/>전체</td></tr>
						<tr><td><input name="cotype" type="checkbox" value="1"/>대기업</td></tr>
						<tr><td><input name="cotype" type="checkbox" value="2"/>중견기업</td></tr>
						<tr><td><input name="cotype" type="checkbox" value="3"/>중소기업</td></tr>
					</table>
				</div>
				
				<div id="emptypeDiv" style="display: none; font-size: 18px; font-family: 'NanumGothic'">
					<table>
						<tr><td><input name="emptype_all" type="checkbox" value="0" onclick="checkEmpAll()"/>전체</td></tr>
						<tr><td><input name="emptype" type="checkbox" value="1"/>정규직</td></tr>
						<tr><td><input name="emptype" type="checkbox" value="2"/>계약직</td></tr>
						<tr><td><input name="emptype" type="checkbox" value="3"/>인턴</td></tr>
					</table>
				</div>
				
				<div id="right_contents_fix">
					<input type="button" value="검색하기" onclick="return search();">
				</div>
			</form>
			</div>
		</div>
		
		<img src="resources/img/board_title.png">
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
		
	</div>
	
</body>
</html>

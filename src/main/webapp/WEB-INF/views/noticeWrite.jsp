<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" session="true" %>
<%@ page import = "com.inhatc.recruit.vo.NoticeBoard" %>
<%@ page import = "com.inhatc.recruit.vo.Paging" %>
<%@ page import = "java.util.ArrayList" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Inha Recruit : 공지사항</title>
	<link rel="stylesheet" href="/recruit/resources/css/noticeWrite.css">
	<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.4.1.min.js"/>"></script>
</head>
<script>
function check() {
	var title   = document.getElementById("title");
	var content = document.getElementById("content");
	
	if(title.value == '') {
		title.focus();
		return false;
	} else if(title.value.length > 30) {
		title.focus();
		return false;
	}
	
	if(content.value == '') {
		content.focus();
		return false;
	} else if(content.value.length > 2000) {
		content.focus();
		return false;
	}
	
	return true;
}
</script>
<body>
	<%@ include file="/WEB-INF/views/include/header.jsp" %>
	
	<form action="/recruit/notice/write" method="post" onsubmit="return check();">
		<div id="notice-container">
			<div id="notice-title">
				<input type="text" id="title" name="title"/>
			</div>
			<div id="notice-content">
				<textarea id="content" name="content"></textarea>
			</div>
		
		</div>
			
		<div id="bottom-bar">
			<input type="submit" value="등록">
		</div>
	</form>

</body>
</html>
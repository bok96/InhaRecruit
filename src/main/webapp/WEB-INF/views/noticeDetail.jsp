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
	<link rel="stylesheet" href="/recruit/resources/css/noticeDetail.css">
	<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.4.1.min.js"/>"></script>
</head>
<body>
	<%@ include file="/WEB-INF/views/include/header.jsp" %>
	
	<c:if test="${noticeBoard ne null}">
		<div id="notice-container">
			<div id="notice-title">
				<span>${noticeBoard.title}</span>
			</div>
			<div id="notice-date">
				<span>${fn:split(noticeBoard.date, ' ')[0]}</span>
			</div>
			<div id="notice-content">
				<span>${noticeBoard.content}</span>
			</div>
		</div>
		
		<div id="bottom-bar">
			<input type="button" value="목록" onclick="history.back(-1);">
		</div>
	</c:if>

</body>
</html>
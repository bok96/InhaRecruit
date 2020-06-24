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
	<link rel="stylesheet" href="resources/css/notice.css">
	<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.4.1.min.js"/>"></script>
</head>
<body>
	<%@ include file="/WEB-INF/views/include/header.jsp" %>

		<div id="board">
		<c:if test = "${noticeBoards ne null}">	
			<table>
				<tr><th width=80%>제목</th><th width=20%>작성일</th></tr>
			<c:forEach items="${noticeBoards}" var="item" varStatus="status">
				<tr>
					<td><a href="/recruit/notice/${item.no}">${item.title}</a></td>
					<td>${fn:split(item.date, ' ')[0]}</td>
				</tr>
			</c:forEach>
			</table>
		</c:if>
		</div>
		
		<c:if test="${member.email eq 'admin'}">
			<div id="admin">
				<input type="button" value="작성" onclick="location.href='/recruit/notice/write'">
			</div>
		</c:if>
		
		<div id="bot-nav2">
			<ul>
				<c:if test="${param.page gt 10}">
					<li><a href="/recruit/notice?page=${paging.blockStartNum-1}">PREV</a></li>
				</c:if>
		        
		        <c:forEach var="i" begin="${paging.blockStartNum}" end="${paging.blockLastNum}">
		            <c:choose>
		                <c:when test="${i gt paging.lastPageNum}">
		
		                </c:when>
		                <c:when test="${i eq param.page}">
		                    <li class="selected">${i}</li>
		                </c:when>
		
		                <c:otherwise>
		                    <li><a href="/recruit/notice?page=${i}">${i}</a></li>
		                </c:otherwise>
		            </c:choose>
		        </c:forEach>
		        <c:if test="${ paging.lastPageNum gt paging.blockLastNum }">
		            <li><a href="/recruit/notice?page=${paging.blockLastNum + 1}">NEXT</a></li>
		        </c:if>
			</ul>
		</div>
</body>
</html>
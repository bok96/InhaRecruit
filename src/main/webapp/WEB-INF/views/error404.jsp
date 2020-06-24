<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" session="true" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Inha Recruit : 에러</title>
	<link rel="stylesheet" type="text/css" href="resources/css/error.css">
	<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.4.1.min.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/resources/js/sha256.js"/>"></script>
</head>
<body>
<script>
</script>
	<%@ include file="/WEB-INF/views/include/header.jsp" %>
	<div id="error-container">
		<h1>에러가 발생했습니다.</h1>
		<input type="button" value="메인화면으로" onclick="location.href='/recruit'"/>
	</div>
</body>
</html>
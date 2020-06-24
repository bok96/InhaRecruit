<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" session="true" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Inha Recruit : 로그인</title>
	<link rel="stylesheet" type="text/css" href="resources/css/login.css">
	<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.4.1.min.js"/>"></script>
</head>
<body>
<script>
function validate() {
	var email = login.email.value;
	var pw    = login.pw.value;
	
	if (email == "") {
		$(".email-fb").html("이메일을 입력해주세요.");
		login.email.focus();
		return false;
	}
	else if (pw == "") {
		$(".pw-fb").html("패스워드를 입력해주세요.");
		login.pw.focus();
		return false;
    }
	
	return true;
}
</script>
	<%@ include file="/WEB-INF/views/include/header.jsp" %>
	<div id="login-container">
		<form id="login" onsubmit="return validate();" action="/recruit/login" method="post">
			<input type="text" id="email" name="email" placeholder="이메일">
			<label class="email-fb"></label>
			<input type="password" id="pw" name="pw" placeholder="비밀번호">
			<label class="pw-fb"></label>
			<input class="login-button" type="submit" value="로그인"/>
		</form>
		
		<div id="find">
			<span><a href="">ID/PW찾기</a></span>|
		    <span><a href="">회원가입</a></span>
		</div>
	</div>
</body>
</html>
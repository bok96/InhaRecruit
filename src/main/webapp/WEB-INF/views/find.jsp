<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" session="true" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Inha Recruit : ID/PW찾기</title>
	<link rel="stylesheet" type="text/css" href="resources/css/find.css">
	<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.4.1.min.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/resources/js/sha256.js"/>"></script>
</head>
<body>
<script>
var encryptNumber;
var isAuth;

function changePassword() {
	var email = document.getElementById("email");
	
	if (email.value == "") {
		$(".email-fb").html("이메일을 입력해주세요.");
		email.focus();
		return false;
	}
	
	var isExist = false;
	
	$.ajax({
        type: "POST",
        url: "/recruit/join/emailCheck?email="+email.value,
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        async: false,
        datatype: "json",
        success: function(data) {
        	if(data === true) {
        		isExist = true;
            } else {
            	$(".email-fb").css("color", "red");
            	$(".email-fb").css("font-size", "85%");
            	$(".email-fb").html("존재하지 않는 아이디입니다.");
            }
        },
        error: function(request, status, error) {
          alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        }
	});
	
	if(!isExist) return false;
	
	var isSent = false;
		
	$.ajax({
	    type: "POST",
	    url: "/recruit/sendMail?email="+email.value,
	    contentType: "application/x-www-form-urlencoded; charset=utf-8",
	    async: false,
	    datatype: "json",
	    success: function(data) {
	      	$(".email-fb").css("color", "forestgreen");
        	$(".email-fb").css("font-size", "85%");
        	$(".email-fb").html("인증번호가 발송되었습니다.");
        	$(email).attr("readonly", true);
        	isSent = true;
        	$("#auth").show();
        	encryptNumber = data;
	    },
	    error: function(request, status, error) {
	    	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	    	}
	    });
}

function authCheck() {
	var authNumber = document.getElementById("authNumber");
	var correct   = sha256(authNumber.value);
	if(correct == encryptNumber) {
		$(authNumber).attr("disabled", true);
		$(".authNumber-fb").css("color", "forestgreen");
		$(".authNumber-fb").css("font-size", "85%");
		$(".authNumber-fb").html("인증되었습니다.");
		$("#password").show();
		isAuth = true;
	} else {
		$(".authNumber-fb").css("color", "red");
		$(".authNumber-fb").css("font-size", "85%");
		$(".authNumber-fb").html("잘못된 인증번호입니다.");
		authNumber.focus();
		return;
	}
}

function changePw() {
	var realEmail = document.getElementById("realEmail");
	var email     = document.getElementById("email");
	
	$(realEmail).val(email.value);
	
	var pw1 = document.getElementById("pw1");
	var pw2 = document.getElementById("pw2");
	var re_pw = /^[a-zA-Z0-9#!@$%^&*]{8,20}$/;
	
	if(!re_pw.test(pw1.value)) {
		$(".pw1-fb").css("color", "red");
		$(".pw1-fb").css("font-size", "85%");
		$(".pw1-fb").html("8~20자의 대·소문자, 숫자, 특수문자만 가능합니다.");
		pw1.focus();
		return false;
	} else if(pw1.value != pw2.value) {
		$(".pw2-fb").css("color", "red");
		$(".pw2-fb").css("font-size", "85%");
		$(".pw2-fb").html("비밀번호가 일치하지 않습니다.");
		pw2.focus();
		return false;
	}
}

</script>
	<%@ include file="/WEB-INF/views/include/header.jsp" %>
	<div id="login-container">
		<input type="text" id="email" placeholder="이메일">
		<label class="email-fb"></label>
		<input class="login-button" type="button" value="인증번호전송" onclick="changePassword();"/>
		
		<div id="auth">
			<input type="text" id="authNumber" placeholder="인증번호입력">
			<label class="authNumber-fb"></label>
			<input class="login-button" type="button" value="인증번호확인" onclick="authCheck();"/>
		</div>
		
		<div id="password">
		<form action="/recruit/find" method="post" onsubmit="return changePw();">
			<input type="text" id="realEmail" name="email" style="display:none;">
			<input type="password" id="pw1" name="pw1" placeholder="패스워드">
			<label class="pw1-fb"></label>
			<input type="password" id="pw2" name="pw2" placeholder="패스워드 재확인">
			<label class="pw2-fb"></label>
			<input class="login-button" type="submit" value="패스워드변경"/>
		</form>
		
		</div>
		
	</div>
</body>
</html>
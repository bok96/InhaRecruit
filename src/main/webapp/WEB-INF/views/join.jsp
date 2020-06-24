<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" session="true" %>
<html>
<head>
	<title>Inha Recruit : 회원가입</title>
	<link rel="stylesheet" href="resources/css/join.css">
	<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.4.1.min.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/resources/js/sha256.js"/>"></script>
<script>
	var encryptNumber;
	var isCheck;
	var isAuth;
	
	function changeCheckSign(obj) { // 체크표시 아이콘 및 테두리 설정
		$(obj).css("background", "url(resources/img/icon_check.png)");
		$(obj).css("background-position", "top right");
		$(obj).css("background-repeat", "no-repeat");
		$(obj).css("border", "2px inset");
	}
	
	function changeCrossSign(obj) { // 엑스표시 아이콘 및 테두리 설정
		$(obj).css("background", "url(resources/img/icon_cross.png)");
		$(obj).css("background-position", "top right");
		$(obj).css("background-repeat", "no-repeat");
		$(obj).css("border", "2px inset red");
	}
	
	function errorStatus(obj, text) { // 피드백 라벨 설정
		$(obj).css("color", "red");
		$(obj).css("font-size", "85%");
		$(obj).html(text);
	}
	
	function emailValidate(obj) {
		var email = obj.value;
		var re_email = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		
		if(re_email.test(email)) {
			changeCheckSign(obj);
			$("#email-fb").html("");
			return true;
		} else {
			changeCrossSign(obj);
			errorStatus("#email-fb", "잘못된 이메일 형식입니다.");
			obj.focus();
			return false;
		}
	}
	
	function pwValidate(obj) {
		var pw = obj.value;
		var pw2 = document.getElementById("pw2");
		var re_pw = /^[a-zA-Z0-9#!@$%^&*]{8,20}$/;
		
		if((pw != pw2.value) && (pw2.value != "")) {
			changeCrossSign(pw2);
			errorStatus("#pw2-fb", "비밀번호가 일치하지 않습니다.");
		}
		if(pw == pw2.value) {
			changeCheckSign(pw2);
			$("#pw2-fb").html("");
		}
		
		if(re_pw.test(pw)) {
			changeCheckSign(obj);
			$("#pw-fb").html("");
			return true;
		} else {
			changeCrossSign(obj);
			errorStatus("#pw-fb", "8~20자의 대·소문자, 숫자, 특수문자만 가능합니다.");
			obj.focus();
			return false;
		}
	}
	
	function pw2Validate(obj) {
		var pw  = document.getElementById("pw").value;
		var pw2 = document.getElementById("pw2").value;
		
		if(pw2 == "") {
			changeCrossSign(obj);
			errorStatus("#pw2-fb", "비밀번호가 일치하지 않습니다.");
			obj.focus();
			return false;
		} else if(pw == pw2) {
			changeCheckSign(obj);
			$("#pw2-fb").html("");
			return true;
		} else {
			changeCrossSign(obj);
			errorStatus("#pw2-fb", "비밀번호가 일치하지 않습니다.");
			obj.focus();
			return false;
		}
	}
	
	function nameValidate(obj) {
		var name = obj.value;
		var re_name = /^[가-힣]{2,10}$/; // 이름 정규식 (완성된 한글, 2자 이상 10자 이하)
		
		if(re_name.test(name)) {
			changeCheckSign(obj);
			$("#name-fb").html("");
			return true;
		} else {
			changeCrossSign(obj);
			errorStatus("#name-fb", "2~10자의 완성된 한글만 가능합니다.");
			obj.focus();
			return false;
		}
	}
	
	function birthValidate(obj) {
		maxLengthCheck(obj);
		
		var birth = obj.value;
		var re_birth = /^(19[0-9][0-9]|20\d{2})(0[0-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])$/;
		
		if(re_birth.test(birth)) {
			changeCheckSign(obj);
			$("#birth-fb").html("");
			return true;
		} else {
			changeCrossSign(obj);
			errorStatus("#birth-fb", "8자리의 정상적인 생년월일만 가능합니다.");
			obj.focus();
			return false;
		}
	}
	
	function hpValidate(obj) {
		maxLengthCheck(obj);
		
		var hp = obj.value;
		var re_hp = /^(010)\d{4}\d{4}$/u; // 연락처 정규식 (숫자만, 반드시 11자)
		
		if(re_hp.test(hp)) {
			changeCheckSign(obj);
			$("#hp-fb").html("");
			return true;
		} else {
			changeCrossSign(obj);
			errorStatus("#hp-fb", "11자리의 정상적인 연락처만 가능합니다.");
			obj.focus();
			return false;
		}
	}
	
	function emailCheck() { // 이메일 중복확인
		var isExist = true;
		
		var email = document.getElementById("email");
		if(!emailValidate(email)) { // 이메일이 유효한지 확인
			return;
		}
		
		$.ajax({
	        type: "POST",
	        url: "/recruit/join/emailCheck?email="+email.value,
	        contentType: "application/x-www-form-urlencoded; charset=utf-8",
	        async: false,
	        datatype: "json",
	        success: function(data) {
	        	if(data === true) {
	        		changeCrossSign(email);
	        		errorStatus("#email-fb", "이미 사용중인 아이디입니다.");
	            } else {
	            	$("#email-fb").css("color", "forestgreen");
	        		$("#email-fb").css("font-size", "85%");
	        		$("#email-fb").html("사용 가능한 아이디입니다.");
	        		isCheck = true;
	        		isExist = false;
	            }
	        },
	        error: function(request, status, error) {
	          alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	        }
		});
		
		if(isExist) {
			return;
		}
		
		var authSendBtn = document.getElementById("authButton");
		var authSendBtnFb = document.getElementById("authSend-fb");
		$(email).attr("readonly", true);
		$(authSendBtn).show();
		$(authSendBtnFb).show();
	}
	
	function emailAuthSend() {
		var email = document.getElementById("email");
		var isSent = false;
		
		$.ajax({
	        type: "POST",
	        url: "/recruit/sendMail?email="+email.value,
	        contentType: "application/x-www-form-urlencoded; charset=utf-8",
	        async: true,
	        datatype: "json",
	        success: function(data) {
	        	$("#authSend-fb").css("color", "forestgreen");
        		$("#authSend-fb").css("font-size", "85%");
        		$("#authSend-fb").html("인증번호가 발송되었습니다.");
        		isSent = true;
        		var authInput = document.getElementById("emailAuthInput");
    			var authInputFb = document.getElementById("auth-fb");
    			var authBtn = document.getElementById("emailAuthBtn");
    			var authBtnFb = document.getElementById("authBtn-fb");
    			$(authInput).show();
    			$(authInput).attr("disabled", false);
    			$(authInputFb).show();
    			$(authBtn).show();
    			$(authBtnFb).show();
    			encryptNumber = data;
	        },
	        error: function(request, status, error) {
	          alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	        }
		});
	}
	
	function emailAuth() { // 이메일 인증번호 확인
		var authInput = document.getElementById("emailAuthInput");
		var correct   = sha256(authInput.value);
		if(correct == encryptNumber) {
			$(authInput).attr("disabled", true);
			changeCheckSign("emailAuthInput");
			$("#auth-fb").css("color", "forestgreen");
    		$("#auth-fb").css("font-size", "85%");
    		$("#auth-fb").html("인증되었습니다.");
    		$("#authSend-fb").html("");
    		changeCheckSign("#emailAuthInput");
    		isAuth = true;
		} else {
			changeCrossSign("emailAuthInput");
			errorStatus("#auth-fb", "잘못된 인증번호입니다.");
			authInput.focus();
			return;
		}
			
	}
	
	function maxLengthCheck(obj) { // 길이수 초과 방지
		if (obj.value.length > obj.maxLength){
	        obj.value = obj.value.slice(0, obj.maxLength);
	    }
	}
	
	function join() {
		var email = document.getElementById("email");
		var auth  = document.getElementById("emailAuthInput");
		var pw    = document.getElementById("pw");
		var pw2   = document.getElementById("pw2");
		var name  = document.getElementById("name");
		var birth = document.getElementById("birth");
		var hp    = document.getElementById("hp");
		
		if(!isCheck) {
			changeCrossSign(email);
    		errorStatus("#email-fb", "중복확인을 해주세요.");
    		return false;
		}
		if(!isAuth) {
			changeCrossSign(auth);
    		errorStatus("#authSend-fb", "인증을 진행하세요.");
    		return false;
		}
		
		if(pwValidate(pw) && pw2Validate(pw2) && nameValidate(name) && birthValidate(birth) && hpValidate(hp)) {
			alert('회원가입이 완료되었습니다');
			return true;
		} else {
			return false;
		}
	}
</script>
</head>
<body>
	<%@ include file="/WEB-INF/views/include/header.jsp" %>

	<div id="join-menu">
		<form name="userinfo" onsubmit="return join();" action="/recruit/join" method="post">
			<label class="title-label">이메일</label>
			<input class="login-input" id="email" name="email" type="text" maxlength="84" placeholder="이메일" maxlength="84" style="width: 240px;" oninput="emailValidate(this);"/>
			<label id="email-fb"></label>
			<input class="join-button" type="button" value="중복확인" style="width: 80px;" onclick="emailCheck();"/>
			<input class="join-button" id="authButton" type="button" value="인증번호 발송" style="display: none;" onclick="emailAuthSend();"/>
			<label id="authSend-fb" style="display: none;"></label>
			<input class="login-input" id="emailAuthInput" type="number" maxlength="8" placeholder="인증번호입력" style="display: none;" oninput="maxLengthCheck(this)"/>
			<label id="auth-fb" style="display: none;"></label>
			<input class="join-button" id="emailAuthBtn" type="button" value="이메일 인증확인" style="display: none;" onclick="emailAuth();"/>
			<label id="authBtn-fb" style="display: none;"></label>
			<label class="title-label">비밀번호</label>
			<input class="login-input" id="pw" name="pw" type="password" maxlength="20" placeholder="비밀번호" oninput="pwValidate(this);"/>
			<label id="pw-fb"></label>
			<label class="title-label">비밀번호 재확인</label>
			<input class="login-input" id="pw2" type="password" maxlength="20" placeholder="비밀번호 재확인" oninput="pw2Validate(this);"/>
			<label id="pw2-fb"></label>
			<label class="title-label">이름</label>
			<input class="login-input" id="name" name="name" type="text" maxlength="10" placeholder="이름" oninput="nameValidate(this);"/>
			<label id="name-fb"></label>
			<label class="title-label">생년월일</label>
			<input class="login-input" id="birth" name="birth" type="number" maxlength="8" placeholder="생년월일(8자리 숫자만 입력)" oninput="birthValidate(this);"/>
			<label id="birth-fb"></label>
			<label class="title-label">연락처</label>
			<input class="login-input" id="hp" name="hp" type="number" maxlength="11" placeholder="연락처(11자리 숫자만 입력)" oninput="hpValidate(this);"/>
			<label id="hp-fb"></label>
			<input class="join-button" type="submit" value="회원가입"/>
		</form>
	</div>
</body>
</html>
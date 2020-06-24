package com.inhatc.recruit;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.inhatc.recruit.encrypt.SHA256;

@Controller
public class MailController {

	@Autowired
	private JavaMailSender mailSender;

	// mailSending 코드
	@RequestMapping(value = "/sendMail", method=RequestMethod.POST)
	public @ResponseBody String mailSending(HttpServletRequest request) {
		
		int randomNumber = (int)(Math.random()*100000000);
		String randomNumberStr = String.format("%08d", randomNumber);
		String encryptNumber = SHA256.encSHA256(randomNumberStr);
		System.out.println("인증번호 랜덤 난수 : " + randomNumberStr);
		System.out.println("인증번호 암호화 값 : " + encryptNumber);
		
		
		String setfrom = "pidyuben";
		String tomail = request.getParameter("email");
		String title = "Inha Recruit 인증번호입니다."; // 제목
		String content = "Inha Recruit 인증번호는 " + randomNumber + " 입니다."; // 내용

		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message,
					true, "UTF-8");

			messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
			messageHelper.setTo(tomail); // 받는사람 이메일
			messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
			messageHelper.setText(content); // 메일 내용

			mailSender.send(message);
		} catch (Exception e) {
			System.out.println(e);
		}

		return encryptNumber;
	}
}
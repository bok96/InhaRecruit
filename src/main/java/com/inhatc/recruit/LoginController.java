package com.inhatc.recruit;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.inhatc.recruit.encrypt.SHA256;
import com.inhatc.recruit.svc.MemberService;
import com.inhatc.recruit.vo.Member;

@Controller
public class LoginController {
	
	@Autowired
	MemberService memberService;
	
	@RequestMapping(value="login", method=RequestMethod.GET)
	public String joinGet(Model model, HttpServletRequest request) {
		return "login";
	}
	
	@RequestMapping(value="login", method=RequestMethod.POST)
	public String joinPost(Model model, HttpServletRequest request, HttpSession session) {
		String email = request.getParameter("email");
		String pw    = request.getParameter("pw");
		
		pw = SHA256.encSHA256(pw);
		
		Member member = memberService.searchMemberByEmail(email);
		
		if(email.equals(member.getEmail()) && pw.equals(member.getPw())) {
			session.setAttribute("member", member);
			return "redirect:/";
		} else {
			session.setAttribute("isLogin", false);
			return "login";
		}
		
	}
}
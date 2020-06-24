package com.inhatc.recruit;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.inhatc.recruit.encrypt.SHA256;
import com.inhatc.recruit.svc.MemberService;
import com.inhatc.recruit.vo.Member;

@Controller
public class FindController {
	
	@Autowired
	MemberService memberService;
	
	@RequestMapping(value="find", method=RequestMethod.GET)
	public String joinGet(Model model, HttpServletRequest request) {
		return "find";
	}
	
	@RequestMapping(value="find", method=RequestMethod.POST)
	public String FindPost(Model model, HttpServletRequest request, HttpSession session) {
		String email = request.getParameter("email");
		String pw    = request.getParameter("pw1");
		
		pw = SHA256.encSHA256(pw);
		
		System.out.println("Email : " + email + ", 변경할 패스워드 : " + pw);
		
		Member member = memberService.searchMemberByEmail(email);
		boolean isUpdated = memberService.updateMember(member, pw);
		
		if(isUpdated) {
			return "redirect:/";
		} else {
			session.setAttribute("isUpdated", false);
			return "find";
		}
		
	}
}
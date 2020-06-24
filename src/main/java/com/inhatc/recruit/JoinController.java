package com.inhatc.recruit;

import javax.servlet.http.HttpServletRequest;

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
public class JoinController {
	
	@Autowired
	MemberService memberService;
	
	@RequestMapping(value="join", method=RequestMethod.GET)
	public String joinGet(Model model, HttpServletRequest request) {
		return "join";
	}
	
	@RequestMapping(value="join", method=RequestMethod.POST)
	public String joinPost(Model model, HttpServletRequest request) {
		String email = request.getParameter("email");
		String pw    = request.getParameter("pw");
		String name  = request.getParameter("name");
		int birth    = Integer.parseInt(request.getParameter("birth"));
		String hp    = request.getParameter("hp");
		
		pw = SHA256.encSHA256(pw);
		
		Member member = new Member();
		member.setEmail(email);
		member.setPw(pw);
		member.setName(name);
		member.setBirth(birth);
		member.setHp(hp);
		
		boolean isSuccess = memberService.insertMember(member);
		if(isSuccess) {
			System.out.println("회원가입 성공");
		} else {
			System.out.println("회원가입 실패");
		}
		
		return "redirect:/";
	}
	
	@RequestMapping(value="/join/emailCheck", method=RequestMethod.POST)
	public @ResponseBody boolean emailCheck(Model model, HttpServletRequest request) {
		String email = request.getParameter("email");
		System.out.println("received data : " + email);
		
		boolean isExist = true;
		
		Member member = memberService.searchMemberByEmail(email);
		
		if(member == null) {
			isExist = false;
		}
		
		return isExist;
	}
}
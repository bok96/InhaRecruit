package com.inhatc.recruit;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.inhatc.recruit.svc.NoticeService;
import com.inhatc.recruit.vo.Member;
import com.inhatc.recruit.vo.NoticeBoard;
import com.inhatc.recruit.vo.Paging;

@Controller
public class NoticeController {
	
	@Autowired
	NoticeService noticeService;
	
	@RequestMapping(value="notice", method=RequestMethod.GET)
	public String noticeGet(Model model, HttpServletRequest request,
			@RequestParam(value="page", defaultValue="1") int page) {
		
		List<NoticeBoard> noticeBoards = noticeService.searchBoards(page, 10);
		int total = noticeService.getCount();
		
		HttpSession session = request.getSession();
		
		Paging paging = new Paging();
		paging.makeLastPageNum(total);
		paging.makeLastBlockNum(total);
		paging.makeBlock(page);
		
		session.setAttribute("noticeBoards", noticeBoards);
		session.setAttribute("paging", paging);
		
		return "notice";
	}

	@RequestMapping(value="notice/{boardNo}", method=RequestMethod.GET)
	public String noticeDetailGet(Model model, HttpServletRequest request,
								@PathVariable int boardNo) {
		
		NoticeBoard noticeBoard = noticeService.searchBoardByNo(boardNo);
		
		HttpSession session = request.getSession();
		
		session.setAttribute("noticeBoard", noticeBoard);
		
		return "noticeDetail";
	}
	
	@RequestMapping(value="notice/write", method=RequestMethod.GET)
	public String noticeWriteGet(Model model, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		String loginId = null;
		if(session.getAttribute("member") != null)
			loginId = ((Member)session.getAttribute("member")).getEmail();
		
		if(loginId == null || !loginId.equals("admin"))
			return "redirect:/";
		
		return "noticeWrite";
	}
	
	@RequestMapping(value="notice/write", method=RequestMethod.POST)
	public String noticeWritePost(Model model, HttpServletRequest request) {
		
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		
		HttpSession session = request.getSession();
		String loginId = ((Member)session.getAttribute("member")).getEmail();
		
		if(loginId == null || !loginId.equals("admin"))
			return "redirect:/";
		
		noticeService.insertBoard(title, content);
		
		return "redirect:/notice";
	}
}
package com.inhatc.recruit;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.inhatc.recruit.svc.NoticeService;
import com.inhatc.recruit.svc.SearchRecruitService;
import com.inhatc.recruit.vo.ExRecruitBoard;
import com.inhatc.recruit.vo.NoticeBoard;
import com.inhatc.recruit.vo.Paging;
import com.inhatc.recruit.vo.RecruitBoard;

@Controller
public class HomeController {
	
	@Autowired
	SearchRecruitService searchRecruitService;
	@Autowired
	NoticeService noticeService;

	@RequestMapping(value="/", method = RequestMethod.GET)
	public String home(Model model, HttpServletRequest request,
			@RequestParam(value="page", defaultValue="1") int page,
			@RequestParam(value="jobs", defaultValue="0") String jobs,
			@RequestParam(value="regions", defaultValue="0,100,200") String regions,
			@RequestParam(value="cotypes", defaultValue="0") String cotypes,
			@RequestParam(value="emptypes", defaultValue="0") String emptypes) {
		
		System.out.println("직무 : " + jobs);
		System.out.println("지역 : " + regions);
		System.out.println("기업 : " + cotypes);
		System.out.println("고용 : " + emptypes);
		
		List<RecruitBoard> recruitBoards = searchRecruitService.searchRecruitBoards(jobs, regions, cotypes, emptypes, page);
		List<ExRecruitBoard> exRecruitBoards = new ArrayList<ExRecruitBoard>();
		for (int i=0 ; i<recruitBoards.size(); i++) {
			ExRecruitBoard temp = new ExRecruitBoard(recruitBoards.get(i).getNo(), recruitBoards.get(i).getTitle(),
					recruitBoards.get(i).getCompany(), recruitBoards.get(i).getRegion(), recruitBoards.get(i).getJob(),
					recruitBoards.get(i).getCotype(), recruitBoards.get(i).getEmptype(), recruitBoards.get(i).getSalary(),
					recruitBoards.get(i).getLink(), recruitBoards.get(i).getDeadline());
			exRecruitBoards.add(temp);
		}
		
		int total = searchRecruitService.getCount(jobs, regions, cotypes, emptypes);
		Paging paging = new Paging();
		
		paging.makeLastPageNum(total);
		paging.makeLastBlockNum(total);
		paging.makeBlock(page);
		
		List<NoticeBoard> noticeBoards = noticeService.searchBoards(1, 3);
		
		HttpSession session = request.getSession();
		session.setAttribute("recruitBoards", exRecruitBoards);
		session.setAttribute("jobs", jobs);
		session.setAttribute("regions", regions);
		session.setAttribute("cotypes", cotypes);
		session.setAttribute("emptypes", emptypes);
		session.setAttribute("paging", paging);
		session.setAttribute("noticeBoards", noticeBoards);
		
		return "home";
	}
	
	@RequestMapping(value="/", method=RequestMethod.POST)
	public String home(Model model, HttpServletRequest request,
					   @RequestParam(value="page", defaultValue="0") String page) {
		
		
		return "home";
	}
	
	@RequestMapping(value="/logout", method=RequestMethod.GET)
	public String logout(Model model, HttpServletRequest request,
					   @RequestParam(value="page", defaultValue="0") String page) {
		
		HttpSession session = request.getSession();
		session.removeAttribute("member");
		
		return "redirect:/";
	}
}

package com.inhatc.recruit;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
	
	//Grid Ajax Method
	@RequestMapping(value="/readData", method=RequestMethod.GET, produces="application/text; charset=utf8")
	public @ResponseBody String readData(Model model, HttpServletRequest request,
			@RequestParam(value="page", defaultValue="1") int page) {
		System.out.println("!!" + request.getRequestURL() + "!!");
		System.out.println("perPage : " + request.getParameter("perPage"));
		System.out.println("page : " + request.getParameter("page"));
		
		List<RecruitBoard> recruitBoards = searchRecruitService.searchRecruitBoards("0", "0,100,200", "0", "0", Integer.parseInt(request.getParameter("page")));;
		List<ExRecruitBoard> exRecruitBoards = new ArrayList<ExRecruitBoard>();
		for (int i=0 ; i<recruitBoards.size(); i++) {
			ExRecruitBoard temp = new ExRecruitBoard(recruitBoards.get(i).getNo(), recruitBoards.get(i).getTitle(),
					recruitBoards.get(i).getCompany(), recruitBoards.get(i).getRegion(), recruitBoards.get(i).getJob(),
					recruitBoards.get(i).getCotype(), recruitBoards.get(i).getEmptype(), recruitBoards.get(i).getSalary(),
					recruitBoards.get(i).getLink(), recruitBoards.get(i).getDeadline());
			exRecruitBoards.add(temp);
		}
		
		JSONObject Atemp = new JSONObject();
		Atemp.put("result", true);
		JSONObject data = new JSONObject();
		JSONArray tempJArray = new JSONArray();
		for (int i=0 ; i<exRecruitBoards.size() ; i++) {
			JSONObject obj = new JSONObject();
			obj.put("title", exRecruitBoards.get(i).getTitle());
			obj.put("company", exRecruitBoards.get(i).getCompany());
			obj.put("region", exRecruitBoards.get(i).getRegion());
			obj.put("job", exRecruitBoards.get(i).getJob());
			obj.put("cotype", exRecruitBoards.get(i).getCotype());
			obj.put("emptype", exRecruitBoards.get(i).getEmptype());
			obj.put("salary", exRecruitBoards.get(i).getSalary());
			obj.put("d_date", exRecruitBoards.get(i).getDeadline());
			tempJArray.add(obj);
		}
		data.put("contents", tempJArray);
		JSONObject pagination = new JSONObject();
		pagination.put("page", page);
		
		int total = searchRecruitService.getCount("0", "0,100,200", "0", "0");
		pagination.put("totalCount", total);
		
		data.put("pagination", pagination);
		Atemp.put("data", data);
		System.out.println(Atemp.toJSONString());
		return Atemp.toJSONString();
	}
	
	@RequestMapping(value="/chart", method=RequestMethod.POST)
	@ResponseBody
	public List<Map> makeChart(@RequestParam Map<String, Object> objParams) {
		String jsonData = (String)objParams.get("objParams");
		JSONParser parser = new JSONParser();
		JSONObject obj = null;
		try {
			obj = (JSONObject)parser.parse(jsonData);
		} catch (Exception e) {
			System.out.println(e);
			return null;
		}
		int date  = Integer.parseInt(obj.get("date").toString());
		int first = Integer.parseInt(obj.get("first").toString());
		List<String> second = new ArrayList<String>();
		JSONArray a = (JSONArray)obj.get("second");
		for(int i=0 ; i<a.size(); i++) {
			second.add((String)a.get(i));
		}
		
		List<Map> result = searchRecruitService.makeChart(date, first, second);

		return result;
	}
}
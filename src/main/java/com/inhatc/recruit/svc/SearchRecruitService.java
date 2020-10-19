package com.inhatc.recruit.svc;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.inhatc.recruit.dao.RecruitDAO;
import com.inhatc.recruit.vo.RecruitBoard;

@Service
public class SearchRecruitService {
	
	@Autowired
	RecruitDAO dao;
	
	public List<RecruitBoard> searchRecruitBoards(String jobs, String regions, String cotypes, String emptypes, int page) {
		
		List<Integer> jobs_list = new ArrayList<Integer>();
		List<Integer> regions_list = new ArrayList<Integer>();
		List<Integer> cotypes_list = new ArrayList<Integer>();
		List<Integer> emptypes_list = new ArrayList<Integer>();
		
		if(!jobs.equals("")) {
			String[] temp = jobs.split(",");
			for (int i=0 ; i<temp.length ; i++) {
				jobs_list.add(Integer.parseInt(temp[i]));
			}
		}
		if(!regions.equals("")) {
			String[] temp = regions.split(",");
			for (int i=0 ; i<temp.length ; i++) {
				regions_list.add(Integer.parseInt(temp[i]));
			}
		}
		if(!cotypes.equals("")) {
			String[] temp = cotypes.split(",");
			for (int i=0 ; i<temp.length ; i++) {
				cotypes_list.add(Integer.parseInt(temp[i]));
			}
		}
		if(!emptypes.equals("")) {
			String[] temp = emptypes.split(",");
			for (int i=0 ; i<temp.length ; i++) {
				emptypes_list.add(Integer.parseInt(temp[i]));
			}
		}
		
		System.out.println("직무 리스트 : " + jobs_list);
		System.out.println("지역 리스트 : " + regions_list);
		System.out.println("기업 리스트 : " + cotypes_list);
		System.out.println("고용 리스트 : " + emptypes_list);
		
		List<RecruitBoard> recruitBoards = dao.searchRecruit(jobs_list, regions_list, cotypes_list, emptypes_list, page);
		
		return recruitBoards;
	}
	
	public int getCount(String jobs, String regions, String cotypes, String emptypes) {
		List<Integer> jobs_list = new ArrayList<Integer>();
		List<Integer> regions_list = new ArrayList<Integer>();
		List<Integer> cotypes_list = new ArrayList<Integer>();
		List<Integer> emptypes_list = new ArrayList<Integer>();
		
		if(!jobs.equals("")) {
			String[] temp = jobs.split(",");
			for (int i=0 ; i<temp.length ; i++) {
				jobs_list.add(Integer.parseInt(temp[i]));
			}
		}
		if(!regions.equals("")) {
			String[] temp = regions.split(",");
			for (int i=0 ; i<temp.length ; i++) {
				regions_list.add(Integer.parseInt(temp[i]));
			}
		}
		if(!cotypes.equals("")) {
			String[] temp = cotypes.split(",");
			for (int i=0 ; i<temp.length ; i++) {
				cotypes_list.add(Integer.parseInt(temp[i]));
			}
		}
		if(!emptypes.equals("")) {
			String[] temp = emptypes.split(",");
			for (int i=0 ; i<temp.length ; i++) {
				emptypes_list.add(Integer.parseInt(temp[i]));
			}
		}
		
		return dao.getCount(jobs_list, regions_list, cotypes_list, emptypes_list);
	}
	
	@SuppressWarnings("serial")
	public List<Map> makeChart(int date, int first, List<String> second) {
		//input example) date : 0, first : 0, second : [0,1,2,3,4]
		List<Map> result = new ArrayList<Map>();

		List<Integer> list = new ArrayList<Integer>(); // 데이터 담을 리스트
		String[] startDate = new String[12];
		String[] endDate   = new String[12];
		
		Date today = new Date();
		SimpleDateFormat sdf     = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat sdfYear = new SimpleDateFormat("yyyy"); 
		
		// 대분류 필드명 세팅
		String strFirst = null;
		if(first == 0) {
			strFirst = "job";
		} else if(first == 1) {
			strFirst = "region";
		}  else if(first == 2) {
			strFirst = "cotype";
		}  else if(first == 3) {
			strFirst = "emptype";
		}
		
		int loopMax = 0; // 날짜 반복 횟수 (1일 : 1, 1개월 : 5-6, 3개월 : 3, 1년 : 12)
		Calendar cal = Calendar.getInstance();
		if(date == 0) { 
			loopMax = 1;
			startDate[0] = sdf.format(today).toString() + " 00:00:00";
			endDate[0]   = sdf.format(today).toString() + " 23:59:59";
		} else if(date == 1) {
			loopMax = 5;
			int intMonth = today.getMonth();
			for (int week=1 ; week<cal.getMaximum(Calendar.WEEK_OF_MONTH) ; week++) {
				cal.set(Calendar.WEEK_OF_MONTH, week);
				 
				cal.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
				int startDay = cal.get(Calendar.DAY_OF_MONTH);
				 
				cal.set(Calendar.DAY_OF_WEEK, Calendar.SATURDAY);
				int endDay = cal.get(Calendar.DAY_OF_MONTH);
				 
				if (week == 1 && startDay >= 7) {
					startDay = 1;
				}
				if (week == cal.getMaximum(Calendar.WEEK_OF_MONTH) - 1 && endDay <= 7) {
					endDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
					loopMax = week; // 반복 횟수를 마지막 주차로 세팅
				}
				startDate[week-1] = sdfYear.format(today) + "-" + (intMonth+1) + "-" + startDay;
				endDate[week-1]   = sdfYear.format(today) + "-" + (intMonth+1) + "-" + endDay;
				System.out.println(week + "주 : " + startDate[week-1] + " ~ " + endDate[week-1]);
			}
		} else if(date == 2) {
			loopMax = 3;
			for(int i=0 ; i<loopMax ; i++) {
				Calendar todayCal = Calendar.getInstance();
				todayCal.set(today.getYear(), today.getMonth()-(2-i), today.getDate());
				startDate[i] = sdfYear.format(today) + "-" + (today.getMonth()-(2-i)+1) + "-1";
				endDate[i]   = sdfYear.format(today) + "-" + (today.getMonth()-(2-i)+1) + "-" + todayCal.getActualMaximum(Calendar.DAY_OF_MONTH);
				System.out.println("today : " + today + "startDate : " + startDate[i] + "|endDate : " + endDate[i]);
			}
		} else if(date == 3) {
			loopMax = 12;
			for (int i=1 ; i<loopMax+1 ; i++) {
				Calendar todayCal = Calendar.getInstance();
				todayCal.set(today.getYear(), i-1, today.getDate());
				startDate[i-1] = sdfYear.format(today) + "-" + i + "-1";
				endDate[i-1]   = sdfYear.format(today) + "-" + i + "-" + todayCal.getActualMaximum(Calendar.DAY_OF_MONTH);
			}
		}
		
		final Map<String, String> jobDataset = new HashMap<String, String>() {
			{ put("0", "전체"); put("1", "웹프로그래머"); put("2", "시스템프로그래머"); put("3", "네트워크서버보안"); put("4", "ERP시스템분석"); put("5", "데이터베이스DBA"); put("6", "웹디자인"); put("7", "하드웨어소프트웨어"); put("8", "통신모바일"); put("9", "게임"); put("10", "인공지능빅데이터"); }
		};
		final Map<String, String> regionDataset = new HashMap<String, String>() {
			{ put("0", "서울전체"); put("100", "경기전체"); put("200", "인천전체"); }
		};
		final Map<String, String> cotypeDataset = new HashMap<String, String>() {
			{ put("0", "전체"); put("1", "대기업"); put("2", "중견기업"); put("3", "중소기업"); }
		};
		final Map<String, String> emptypeDataset = new HashMap<String, String>() {
			{ put("0", "전체"); put("1", "정규직"); put("2", "계약직"); put("3", "인턴"); }
		};
		final List<Map> dataset = new ArrayList<Map>() {
			{ add(jobDataset); add(regionDataset); add(cotypeDataset); add(emptypeDataset); }
		};
		
		if(date == 0) { // 1일
			Map<String, Object> map = new HashMap<String, Object>();
			for(int i=0 ; i<second.size(); i++) {
				list.add(dao.chartData(startDate[0], endDate[0], strFirst, Integer.parseInt(second.get(i))));
			}
			map.put("name", "채용정보수");
			map.put("data", list);
			result.add(map);
		} else { // 1개월, 3개월, 1년
			for (int i=0 ; i<second.size(); i++) { // 체크된 소분류의 개수만큼 loop
				list = new ArrayList<Integer>();
				Map<String, Object> map = new HashMap<String, Object>();
				
				for(int j=0 ; j<loopMax ; j++) {   // 날짜 배열에 값이 들어가있는 개수만큼 loop
					list.add(dao.chartData(startDate[j], endDate[j], strFirst, Integer.parseInt(second.get(i))));
					System.out.println("검색값(" + j + ") " + startDate[j] + " " + endDate[j] + " " + strFirst + second.get(i));
				}
				map.put("name", dataset.get(first).get(second.get(i)));
				map.put("data", list);
				result.add(map);
			}
		}
		return result;
	}
}
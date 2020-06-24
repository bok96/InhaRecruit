package com.inhatc.recruit.vo;

import java.util.HashMap;

public class ExRecruitBoard {
	int no;
	String title;
	String company;
	String region;
	String job;
	String cotype;
	String emptype;
	int salary;
	String link;
	String deadline;
	
	public ExRecruitBoard() {
		
	}
	
	public ExRecruitBoard(int no, String title, String company, int region, int job, int cotype, int emptype, int salary, String link, String deadline) {
		this.no = no;
		this.title = title;
		this.company = company;
		this.region = changeRegion(region);
		this.job = changeJob(job);
		this.cotype = changeCotype(cotype);
		this.emptype = changeEmptype(emptype);
		this.salary = salary;
		this.link = link;
		this.deadline = deadline;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getRegion() {
		return region;
	}

	public void setRegion(String region) {
		this.region = region;
	}

	public String getJob() {
		return job;
	}

	public void setJob(String job) {
		this.job = job;
	}

	public String getCotype() {
		return cotype;
	}

	public void setCotype(String cotype) {
		this.cotype = cotype;
	}

	public String getEmptype() {
		return emptype;
	}

	public void setEmptype(String emptype) {
		this.emptype = emptype;
	}

	public int getSalary() {
		return salary;
	}

	public void setSalary(int salary) {
		this.salary = salary;
	}

	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}

	public String getDeadline() {
		return deadline;
	}

	public void setDeadline(String deadline) {
		this.deadline = deadline;
	}
	
	private String changeRegion(int region) {
		HashMap<Integer, String> region_dict = new HashMap<Integer, String>();
		int[] region_code = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,
							 100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,
							 200,201,202,203,204,205,206,207,208,209,210};
		String[] region_name = {"서울 전지역", "서울 강남구", "서울 강동구", "서울 강북구", "서울 강서구", "서울 관악구", "서울 광진구", "서울 구로구", "서울 금천구", "서울 도봉구", "서울 동대문구", "서울 동작구", "서울 마포구", "서울 서대문구", "서울 서초구", "서울 성동구",
				"서울 성북구", "서울 송파구", "서울 양천구", "서울 영등포구", "서울 용산구", "서울 은평구", "서울 종로구", "서울 중구", "서울 중랑구", "서울 노원구",
				"경기 전지역", "경기 가평군", "경기 고양시", "경기 과천시", "경기 광명시", "경기 광주시", "경기 구리시", "경기 군포시", "경기 김포시", "경기 남양주시", "경기 동두천시", "경기 부천시", "경기 성남시", "경기 시흥시", "경기 안산시",
				"경기 안성시", "경기 안양시", "경기 양주시", "경기 양평군", "경기 여주시", "경기 연천군", "경기 오산시", "경기 용인시", "경기 의왕시", "경기 의정부시", "경기 이천시", "경기 파주시", "경기 평택시", "경기 포천시", "경기 하남시", "경기 화성시", "경기 수원시",
				"인천 전지역", "인천 강화군", "인천 계양구", "인천 미추홀구", "인천 남동구", "인천 동구", "인천 부평구", "인천 서구", "인천 연수구", "인천 옹진군", "인천 중구"};
		
		for (int i=0 ; i<region_code.length ; i++) {
			if (i >= region_name.length) break;
			region_dict.put(region_code[i], region_name[i]);
		}
		
		return region_dict.get(region);
	}
	
	private String changeJob(int job) {
		HashMap<Integer, String> job_dict = new HashMap<Integer, String>();
		int[] job_code = {0,1,2,3,4,5,6,7,8,9,10};
		String[] job_name = {"전체", "웹 프로그래머", "시스템 프로그래머", "네트워크·서버보안", "ERP·시스템분석", "데이터베이스·DBA", "웹 디자인", "하드웨어·소프트웨어",
				"통신·모바일", "게임", "인공지능·빅데이터"};
		
		for (int i=0 ; i<job_code.length ; i++) {
			if (i >= job_name.length) break;
			job_dict.put(job_code[i], job_name[i]);
		}
		
		return job_dict.get(job);
	}
	
	private String changeCotype(int cotype) {
		HashMap<Integer, String> cotype_dict = new HashMap<Integer, String>();
		int[] cotype_code = {0,1,2,3};
		String[] cotype_name = {"전체", "대기업", "중견기업", "중소기업"};
		
		for (int i=0 ; i<cotype_code.length ; i++) {
			if (i >= cotype_name.length) break;
			cotype_dict.put(cotype_code[i], cotype_name[i]);
		}
		
		return cotype_dict.get(cotype);
	}
	
	private String changeEmptype(int emptype) {
		HashMap<Integer, String> emptype_dict = new HashMap<Integer, String>();
		int[] emptype_code = {0,1,2,3};
		String[] emptype_name = {"전체", "정규직", "계약직", "인턴"};
		
		for (int i=0 ; i<emptype_code.length ; i++) {
			if (i >= emptype_name.length) break;
			emptype_dict.put(emptype_code[i], emptype_name[i]);
		}
		
		return emptype_dict.get(emptype);
	}
}

package com.inhatc.recruit.vo;

public class RecruitBoard {
	int no;
	String title;
	String company;
	int region;
	int job;
	int cotype;
	int emptype;
	int salary;
	String link;
	String deadline;
	
	public RecruitBoard() {
		
	}
	
	public RecruitBoard(int no, String title, String company, int region, int job, int cotype, int emptype, int salary, String link, String deadline) {
		this.no = no;
		this.title = title;
		this.company = company;
		this.region = region;
		this.job = job;
		this.cotype = cotype;
		this.emptype = emptype;
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

	public int getRegion() {
		return region;
	}

	public void setRegion(int region) {
		this.region = region;
	}

	public int getJob() {
		return job;
	}

	public void setJob(int job) {
		this.job = job;
	}

	public int getCotype() {
		return cotype;
	}

	public void setCotype(int cotype) {
		this.cotype = cotype;
	}

	public int getEmptype() {
		return emptype;
	}

	public void setEmptype(int emptype) {
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
}

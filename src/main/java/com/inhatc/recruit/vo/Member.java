package com.inhatc.recruit.vo;

public class Member {
	private String email;
	private String pw;
	private String name;
	private int birth;
	private String hp;
	private String joindate;
	
	public Member() {
	}
	
	public Member(String email, String pw, String name, int birth, String hp, String joindate) {
		this.email = email;
		this.pw = pw;
		this.name = name;
		this.birth = birth;
		this.hp = hp;
		this.joindate = joindate;
	}
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getBirth() {
		return birth;
	}
	public void setBirth(int birth) {
		this.birth = birth;
	}
	public String getHp() {
		return hp;
	}
	public void setHp(String hp) {
		this.hp = hp;
	}
	public String getJoindate() {
		return joindate;
	}
	public void setJoindate(String joindate) {
		this.joindate = joindate;
	}
	
	
}

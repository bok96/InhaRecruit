package com.inhatc.recruit.vo;

public class NoticeBoard {
	int no;
	String title;
	String content;
	String date;
	
	public NoticeBoard() {
		
	}
	
	public NoticeBoard(int no, String title, String content, String date) {
		this.no = no;
		this.title = title;
		this.content = content;
		this.date = date;
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
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
}

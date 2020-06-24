package com.inhatc.recruit.svc;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.inhatc.recruit.dao.NoticeDAO;
import com.inhatc.recruit.vo.NoticeBoard;

@Service
public class NoticeService {
	
	@Autowired
	NoticeDAO dao;
	
	public List<NoticeBoard> searchBoards(int page, int max) {
		List<NoticeBoard> noticeBoard = dao.searchBoard(page, max);
		
		if(noticeBoard.isEmpty())
			return null;
		else
			return noticeBoard;
	}
	
	public int getCount() {
		int count = 0;
		
		try {
			count = dao.getCount();
		} catch(Exception e) {
			System.out.println(e);
		}
		
		return count;
	}
	
	public NoticeBoard searchBoardByNo(int no) {
		NoticeBoard noticeBoard = null;
		
		noticeBoard = dao.searchBoardByNo(no);
		
		return noticeBoard;
	}
	
	public int insertBoard(String title, String content) {
		int count = 0;
		
		NoticeBoard noticeBoard = new NoticeBoard(0, title, content, "");
		count = dao.insertBoard(noticeBoard);
		
		return count;
	}
}
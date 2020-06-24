package com.inhatc.recruit.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.inhatc.recruit.vo.NoticeBoard;

@Repository
public class NoticeDAO {
	
	private JdbcTemplate template;
	
	@Autowired
	private NoticeDAO(DataSource ds) {
		this.template = new JdbcTemplate(ds);
	}
	
	public List<NoticeBoard> searchBoard(final int page, final int max) {
		List<NoticeBoard> noticeBoards = null;
		
		String sql = "SELECT * FROM NOTICE_BOARD ORDER BY NO DESC LIMIT ?, ?";
		
		System.out.println("완성된 문장 : " + sql);
		
		noticeBoards = template.query(sql, new PreparedStatementSetter() {
			@Override
			public void setValues(PreparedStatement pstmt) throws SQLException {
				pstmt.setInt(1, (page-1)*10);
				pstmt.setInt(2, max);
			}
			
		}, new RowMapper<NoticeBoard>() {
			@Override
			public NoticeBoard mapRow(ResultSet rs, int rowNum) throws SQLException {
				NoticeBoard noticeBoard = new NoticeBoard();
				
				noticeBoard.setNo(rs.getInt("no"));
				noticeBoard.setTitle(rs.getString("title"));
				noticeBoard.setContent(rs.getString("content"));
				noticeBoard.setDate(rs.getString("date"));
				
				return noticeBoard;
			}
		});
		
		System.out.println(noticeBoards.size());
		
		return noticeBoards;
	}
	
	public int getCount() throws SQLException{
	    return template.queryForObject("SELECT COUNT(*) FROM NOTICE_BOARD", Integer.class);
	}
	
	public NoticeBoard searchBoardByNo(final int no) {
		List<NoticeBoard> noticeBoards = null;
		
		String sql = "SELECT * FROM NOTICE_BOARD WHERE NO = ?";
		
		System.out.println("완성된 문장 : " + sql);
		
		noticeBoards = template.query(sql, new PreparedStatementSetter() {
			@Override
			public void setValues(PreparedStatement pstmt) throws SQLException {
				pstmt.setInt(1, no);
			}
			
		}, new RowMapper<NoticeBoard>() {
			@Override
			public NoticeBoard mapRow(ResultSet rs, int rowNum) throws SQLException {
				NoticeBoard noticeBoard = new NoticeBoard();
				
				noticeBoard.setNo(rs.getInt("no"));
				noticeBoard.setTitle(rs.getString("title"));
				noticeBoard.setContent(rs.getString("content"));
				noticeBoard.setDate(rs.getString("date"));
				
				return noticeBoard;
			}
		});

		if(noticeBoards.isEmpty())
			return null;
		else
			return noticeBoards.get(0);
	}
	
public int insertBoard(NoticeBoard noticeBoard) {
		
		int insertCount = 0;
		
		String sql = "INSERT INTO NOTICE_BOARD(TITLE, CONTENT) VALUES(?, ?)";
		insertCount = template.update(sql, noticeBoard.getTitle(), noticeBoard.getContent());
		
		return insertCount;
	}
}
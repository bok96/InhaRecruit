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

import com.inhatc.recruit.vo.RecruitBoard;

@Repository
public class RecruitDAO {
	
	private JdbcTemplate template;
	
	@Autowired
	private RecruitDAO(DataSource ds) {
		this.template = new JdbcTemplate(ds);
	}
	
	/*
	public int insertMember(Member member) {
		
		int insertCount = 0;
		
		String sql = "INSERT INTO MEMBER(EMAIL, PW, NAME, BIRTH, HP) VALUES(?, ?, ?, ?, ?)";
		insertCount = template.update(sql, member.getEmail(), member.getPw(), member.getName(), member.getBirth(), member.getHp());
		
		return insertCount;
	}*/
	
	public List<RecruitBoard> searchRecruit(final List<Integer> jobs, final List<Integer> regions,
											final List<Integer> cotypes, final List<Integer> emptypes,
											int page) {
		List<RecruitBoard> recruitBoards = null;
		
		String sql = "SELECT * FROM RECRUIT_BOARD WHERE ";

		if(jobs.get(0) == 0) {
			sql += "JOB LIKE '%' AND ";
		} else {
			sql += "JOB IN (";
			for(int i=0 ; i<jobs.size(); i++) {
				sql += jobs.get(i);
				if(i != jobs.size()-1) sql += ",";
			}
			sql += ") AND ";
		}
		
		if(cotypes.get(0) == 0) {
			sql += "COTYPE LIKE '%' AND ";
		} else {
			sql += "COTYPE IN (";
			for(int i=0 ; i<cotypes.size(); i++) {
				sql += cotypes.get(i);
				if(i != cotypes.size()-1) sql += ",";
			}
			sql += ") AND ";
		}
		
		if(emptypes.get(0) == 0) {
			sql += "EMPTYPE LIKE '%' AND ";
		} else {
			sql += "EMPTYPE IN (";
			for(int i=0 ; i<emptypes.size(); i++) {
				sql += emptypes.get(i);
				if(i != emptypes.size()-1) sql += ",";
			}
			sql += ") AND ";
		}
		
		sql += "(REGION IN (";
		
		boolean seoulAll = false;
		boolean gyeongAll = false;
		boolean IncheonAll = false;
		
		for(int i=0 ; i<regions.size(); i++) {
			if(regions.get(i) == 0)
				seoulAll = true;
			if(regions.get(i) == 100)
				gyeongAll = true;
			if(regions.get(i) == 200)
				IncheonAll = true;
			
			sql += regions.get(i);
			if(i != regions.size()-1) sql += ",";
		}
		
		sql += ") ";

		if(seoulAll)
			sql += "OR REGION < 100 ";
		if(gyeongAll)
			sql += "OR REGION LIKE '1__' ";
		if(IncheonAll)
			sql += "OR REGION LIKE '2__' ";
		
		sql += ") ";
		
		sql += "ORDER BY NO DESC LIMIT " + (page-1)*10 + ", 10";
		
		System.out.println("완성된 문장 : " + sql);
		
		recruitBoards = template.query(sql, new PreparedStatementSetter() {
			@Override
			public void setValues(PreparedStatement pstmt) throws SQLException {

			}
		}, new RowMapper<RecruitBoard>() {
			@Override
			public RecruitBoard mapRow(ResultSet rs, int rowNum) throws SQLException {
				RecruitBoard recruitBoard = new RecruitBoard();

				recruitBoard.setNo(rs.getInt("no"));
				recruitBoard.setTitle(rs.getString("title"));
				recruitBoard.setCompany(rs.getString("company"));
				recruitBoard.setRegion(rs.getInt("region"));
				recruitBoard.setJob(rs.getInt("job"));
				recruitBoard.setCotype(rs.getInt("cotype"));
				recruitBoard.setEmptype(rs.getInt("emptype"));
				recruitBoard.setSalary(rs.getInt("salary"));
				recruitBoard.setLink(rs.getString("link"));
				recruitBoard.setDeadline(rs.getString("d_date"));
				
				return recruitBoard;
			}
			
		});
		
		System.out.println(recruitBoards.size());
		
		return recruitBoards;
	}
	
	public int getCount(final List<Integer> jobs, final List<Integer> regions,
						final List<Integer> cotypes, final List<Integer> emptypes) {
		
		String sql = "SELECT * FROM RECRUIT_BOARD WHERE ";

		if(jobs.get(0) == 0) {
			sql += "JOB LIKE '%' AND ";
		} else {
			sql += "JOB IN (";
			for(int i=0 ; i<jobs.size(); i++) {
				sql += jobs.get(i);
				if(i != jobs.size()-1) sql += ",";
			}
			sql += ") AND ";
		}
		
		if(cotypes.get(0) == 0) {
			sql += "COTYPE LIKE '%' AND ";
		} else {
			sql += "COTYPE IN (";
			for(int i=0 ; i<cotypes.size(); i++) {
				sql += cotypes.get(i);
				if(i != cotypes.size()-1) sql += ",";
			}
			sql += ") AND ";
		}
		
		if(emptypes.get(0) == 0) {
			sql += "EMPTYPE LIKE '%' AND ";
		} else {
			sql += "EMPTYPE IN (";
			for(int i=0 ; i<emptypes.size(); i++) {
				sql += emptypes.get(i);
				if(i != emptypes.size()-1) sql += ",";
			}
			sql += ") AND ";
		}
		
		sql += "(REGION IN (";
		
		boolean seoulAll = false;
		boolean gyeongAll = false;
		boolean IncheonAll = false;
		
		for(int i=0 ; i<regions.size(); i++) {
			if(regions.get(i) == 0)
				seoulAll = true;
			if(regions.get(i) == 100)
				gyeongAll = true;
			if(regions.get(i) == 200)
				IncheonAll = true;
			
			sql += regions.get(i);
			if(i != regions.size()-1) sql += ",";
		}
		
		sql += ") ";

		if(seoulAll)
			sql += "OR REGION < 100 ";
		if(gyeongAll)
			sql += "OR REGION LIKE '1__' ";
		if(IncheonAll)
			sql += "OR REGION LIKE '2__' ";
		
		sql += ") ";
		
		List<RecruitBoard> recruitBoards = template.query(sql, new PreparedStatementSetter() {
			@Override
			public void setValues(PreparedStatement pstmt) throws SQLException {

			}
		}, new RowMapper<RecruitBoard>() {
			@Override
			public RecruitBoard mapRow(ResultSet rs, int rowNum) throws SQLException {
				RecruitBoard recruitBoard = new RecruitBoard();

				recruitBoard.setNo(rs.getInt("no"));
				recruitBoard.setTitle(rs.getString("title"));
				recruitBoard.setCompany(rs.getString("company"));
				recruitBoard.setRegion(rs.getInt("region"));
				recruitBoard.setJob(rs.getInt("job"));
				recruitBoard.setCotype(rs.getInt("cotype"));
				recruitBoard.setEmptype(rs.getInt("emptype"));
				recruitBoard.setSalary(rs.getInt("salary"));
				recruitBoard.setLink(rs.getString("link"));
				recruitBoard.setDeadline(rs.getString("d_date"));
				
				return recruitBoard;
			}
			
		});
		
		return recruitBoards.size();
	}
}
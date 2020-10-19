package com.inhatc.recruit.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
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
		
		// System.out.println("완성된 문장 : " + sql);
		
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
				recruitBoard.setDeadline(rs.getString("d_date").split(" ")[0]); // 시분초 단위 절삭
				
				return recruitBoard;
			}
			
		});
		
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
	
	public int chartData(String startDate, String endDate, String first, int second) {
		int result = 0;
		//System.out.println(startDate + "/" + endDate + "/" + first + "/" + second);
		String sql = null;
		sql = "SELECT COUNT(*) FROM RECRUIT_BOARD WHERE (WRITE_DATE BETWEEN ? AND ?) AND " + first + " = ?";
		//System.out.println("차트 SQL : " + sql);
		if(first.equals("region")) {
			if(second == 0)
				sql = "SELECT COUNT(*) FROM RECRUIT_BOARD WHERE (WRITE_DATE BETWEEN ? AND ?) AND " + first + " < 100";
			else if(second == 100)
				sql = "SELECT COUNT(*) FROM RECRUIT_BOARD WHERE (WRITE_DATE BETWEEN ? AND ?) AND " + first + " LIKE '1__'";
			else if(second == 200)
				sql = "SELECT COUNT(*) FROM RECRUIT_BOARD WHERE (WRITE_DATE BETWEEN ? AND ?) AND " + first + " LIKE '2__'";
		}
		
		if(first.equals("region")) {
			result = template.queryForObject(sql, new Object[] {startDate, endDate}, Integer.class);
		} else {
			result = template.queryForObject(sql, new Object[] {startDate, endDate, second}, Integer.class);
		}
		System.out.println(result);
		
		return result;
	}
}
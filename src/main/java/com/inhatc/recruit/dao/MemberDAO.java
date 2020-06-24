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

import com.inhatc.recruit.vo.Member;

@Repository
public class MemberDAO {
	
	private JdbcTemplate template;
	
	@Autowired
	private MemberDAO(DataSource ds) {
		this.template = new JdbcTemplate(ds);
	}
	
	public int insertMember(Member member) {
		
		int insertCount = 0;
		
		String sql = "INSERT INTO MEMBER(EMAIL, PW, NAME, BIRTH, HP) VALUES(?, ?, ?, ?, ?)";
		insertCount = template.update(sql, member.getEmail(), member.getPw(), member.getName(), member.getBirth(), member.getHp());
		
		return insertCount;
	}
	
	public int updateMember(Member member, String pw) {
		int updateCount = 0;
		
		String sql = "UPDATE MEMBER SET PW = ? WHERE EMAIL = ?";
		updateCount = template.update(sql, pw, member.getEmail());
		
		return updateCount;
	}
	
	public List<Member> searchMember(final String email) {
		List<Member> members = null;
		
		String sql = "SELECT * FROM MEMBER WHERE EMAIL = ?";
		
		members = template.query(sql, new PreparedStatementSetter() {
			@Override
			public void setValues(PreparedStatement pstmt) throws SQLException {
				pstmt.setString(1, email);
			}
		}, new RowMapper<Member>() {
			@Override
			public Member mapRow(ResultSet rs, int rowNum) throws SQLException {
				Member member = new Member();
				
				member.setEmail(rs.getString("email"));
				member.setPw(rs.getString("pw"));
				member.setName(rs.getString("name"));
				member.setBirth(rs.getInt("birth"));
				member.setHp(rs.getString("hp"));
				member.setJoindate(rs.getString("joindate"));
				
				return member;
			}
			
		});
		
		return members;
	}
}
package com.inhatc.recruit.svc;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.inhatc.recruit.dao.MemberDAO;
import com.inhatc.recruit.vo.Member;

@Service
public class MemberService {
	
	@Autowired
	MemberDAO dao;
	
	public boolean insertMember(Member member) {
		boolean isSuccess = false;
		int insertCount = dao.insertMember(member);
		
		if(insertCount != 0) {
			isSuccess = true;
		}
		
		return isSuccess;
	}
	
	public boolean updateMember(Member member, String pw) {
		boolean isSuccess = false;
		
		int updateCount = dao.updateMember(member, pw);
		
		if(updateCount != 0) {
			isSuccess = true;
		}
		
		return isSuccess;
	}
	
	public Member searchMemberByEmail(String email) {
		List<Member> members = dao.searchMember(email);
		
		if(members.isEmpty()) return null;
		else return members.get(0);
	}
}
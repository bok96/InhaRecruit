package com.inhatc.recruit.svc;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.inhatc.recruit.dao.RecruitDAO;
import com.inhatc.recruit.vo.RecruitBoard;

@Service
public class SearchRecruitService {
	
	@Autowired
	RecruitDAO dao;
	
	public List<RecruitBoard> searchRecruitBoards(String jobs, String regions, String cotypes, String emptypes, int page) {
		
		List<Integer> jobs_list = new ArrayList<Integer>();
		List<Integer> regions_list = new ArrayList<Integer>();
		List<Integer> cotypes_list = new ArrayList<Integer>();
		List<Integer> emptypes_list = new ArrayList<Integer>();
		
		if(!jobs.equals("")) {
			String[] temp = jobs.split(",");
			for (int i=0 ; i<temp.length ; i++) {
				jobs_list.add(Integer.parseInt(temp[i]));
			}
		}
		if(!regions.equals("")) {
			String[] temp = regions.split(",");
			for (int i=0 ; i<temp.length ; i++) {
				regions_list.add(Integer.parseInt(temp[i]));
			}
		}
		if(!cotypes.equals("")) {
			String[] temp = cotypes.split(",");
			for (int i=0 ; i<temp.length ; i++) {
				cotypes_list.add(Integer.parseInt(temp[i]));
			}
		}
		if(!emptypes.equals("")) {
			String[] temp = emptypes.split(",");
			for (int i=0 ; i<temp.length ; i++) {
				emptypes_list.add(Integer.parseInt(temp[i]));
			}
		}
		
		System.out.println("직무 리스트 : " + jobs_list);
		System.out.println("지역 리스트 : " + regions_list);
		System.out.println("기업 리스트 : " + cotypes_list);
		System.out.println("고용 리스트 : " + emptypes_list);
		
		List<RecruitBoard> recruitBoards = dao.searchRecruit(jobs_list, regions_list, cotypes_list, emptypes_list, page);
		
		return recruitBoards;
	}
	
	public int getCount(String jobs, String regions, String cotypes, String emptypes) {
		List<Integer> jobs_list = new ArrayList<Integer>();
		List<Integer> regions_list = new ArrayList<Integer>();
		List<Integer> cotypes_list = new ArrayList<Integer>();
		List<Integer> emptypes_list = new ArrayList<Integer>();
		
		if(!jobs.equals("")) {
			String[] temp = jobs.split(",");
			for (int i=0 ; i<temp.length ; i++) {
				jobs_list.add(Integer.parseInt(temp[i]));
			}
		}
		if(!regions.equals("")) {
			String[] temp = regions.split(",");
			for (int i=0 ; i<temp.length ; i++) {
				regions_list.add(Integer.parseInt(temp[i]));
			}
		}
		if(!cotypes.equals("")) {
			String[] temp = cotypes.split(",");
			for (int i=0 ; i<temp.length ; i++) {
				cotypes_list.add(Integer.parseInt(temp[i]));
			}
		}
		if(!emptypes.equals("")) {
			String[] temp = emptypes.split(",");
			for (int i=0 ; i<temp.length ; i++) {
				emptypes_list.add(Integer.parseInt(temp[i]));
			}
		}
		
		return dao.getCount(jobs_list, regions_list, cotypes_list, emptypes_list);
	}
}
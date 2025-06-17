package com.kimi.service;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kimi.mapper.MemberMapper;
import com.kimi.model.MemberVO;

@Service
public class MemberServiceImpl implements MemberService{
	@Autowired
	MemberMapper membermapper;
	
	@Override
	public void memberJoin(MemberVO member) throws Exception{
		membermapper.memberJoin(member);
	}
	
	@Override
	public int idCheck(String id) throws Exception{
		return membermapper.idCheck(id);
	}
	
	@Override
	public MemberVO memberLogin(MemberVO member) throws Exception{
		return membermapper.memberLogin(member);
	}
	
	@Override
	public MemberVO memberInfo(String id) throws Exception{
		MemberVO info = membermapper.memberInfo(id);
		
		return info;
	}
	
	@Override
	public int memberModify(MemberVO member) throws Exception{
		int result = membermapper.memberModify(member);
		
		return result;
	}
	
	@Override
	public void modifyPw(String id, String newpw) {
		membermapper.modifyPw(id, newpw);
	}
	
	@Override
	public int deleteMember(MemberVO member) throws Exception{
		int result = membermapper.deleteMember(member);
		return result;
	}
}

package com.kimi.mapper;

import org.apache.ibatis.annotations.Param;

import com.kimi.model.MemberVO;

public interface MemberMapper {
	public void memberJoin(MemberVO member);
	
	public int idCheck(String id);
	
	public MemberVO memberLogin(MemberVO member);
	
	public MemberVO memberInfo(String id);
	
	public int memberModify(MemberVO member);
	
	public void modifyPw(@Param("id") String id, @Param("newpw") String newpw);
	
	public int deleteMember(MemberVO member);
	
}

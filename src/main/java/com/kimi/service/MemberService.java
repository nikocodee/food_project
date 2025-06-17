package com.kimi.service;

import org.apache.ibatis.annotations.Param;

import com.kimi.model.MemberVO;

public interface MemberService {
	public void memberJoin(MemberVO member) throws Exception;
	
	public int idCheck(String id) throws Exception;
	
	public MemberVO memberLogin(MemberVO member) throws Exception;
	
	public MemberVO memberInfo(String id) throws Exception;
	
	public int memberModify(MemberVO member) throws Exception;
	
	public void modifyPw(@Param("id") String id, @Param("newpw") String newpw);
	
	public int deleteMember(MemberVO member) throws Exception;
}

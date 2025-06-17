package com.kimi.model;

import lombok.Data;

@Data
public class MemberVO {
	private String id;
	private String pw;
	private String name;
	private String tel;
	private String mail;
	private String addr1;
	private String addr2;
	private String addr3;
	private int adminCk;
	private String regdate;
}

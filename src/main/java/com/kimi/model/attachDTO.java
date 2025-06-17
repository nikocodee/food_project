package com.kimi.model;

import lombok.Data;

@Data
public class attachDTO {
	/* 경로 */
	private String uploadPath;
	
	/* uuid */
	private String uuid;
	
	/* 파일 이름 */
	private String fileName;
	
	/*매장 id*/
	private int st_id;
	
	/*메뉴 id*/
	private int mn_id;
	
}
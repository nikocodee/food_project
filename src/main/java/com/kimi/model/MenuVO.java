package com.kimi.model;


import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class MenuVO {
	private int mn_id; /*메뉴 번호*/
	private int st_id; /*매장 번호*/
	private String mn_name; /*메뉴 이름*/
	private String mn_price; /*메뉴 가격*/
	private String mn_content; /*메뉴 정보*/
	private Date regdate; /*등록일자*/
	private Date updatedate; /*수정일자*/
	
	/*이미지 정보*/
	private List<attachDTO> imageList;
	private attachDTO image;
}

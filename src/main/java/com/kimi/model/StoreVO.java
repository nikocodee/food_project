package com.kimi.model;

import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class StoreVO {
	private int st_id;  /*매장 id*/
	private String st_name; /*매장 이름*/
	private String st_biznum; /*사업자번호*/
	private String st_type; /*매장 카테고리*/
	private String st_tel; /*매장 전화번호*/
	private String st_time1; /*운영시간(시작)*/
	private String st_time2; /*운영시간(끝)*/
	private String st_addr1; /*매장 주소*/
	private String st_addr2;
	private String st_addr3;
	private String st_info; /*매장 소개*/
	private Date regdate; /*등록일자*/
	private Date updateDate; /*수정일자*/
	
	/* 이미지 정보 */
	private List<attachDTO> imageList;
	private attachDTO image;
}

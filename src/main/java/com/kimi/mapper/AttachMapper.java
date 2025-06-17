package com.kimi.mapper;

import java.util.List;

import com.kimi.model.attachDTO;

public interface AttachMapper {
	
	/* 매장 이미지 데이터 반환 */
	public List<attachDTO> getAttachList(int st_id);
	
	/* 메뉴 이미지 데이터 반환 */
	public List<attachDTO> getMenuAttachList(int mn_id);
}

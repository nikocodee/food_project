package com.kimi.mapper;

import java.util.List;

import com.kimi.model.Criteria;
import com.kimi.model.MenuVO;
import com.kimi.model.attachDTO;

public interface MenuMapper {
	
	/*메뉴 리스트*/
	public List<MenuVO> mnList(Criteria cri);
	
	/*메뉴 총 개수*/
	public int mnGetTotal(Criteria cri);
	
	/*메뉴 등록*/
	public void menuRegister(MenuVO menu);
	
	/*이미지 등록*/
	public void imageRegister(attachDTO dto);
}

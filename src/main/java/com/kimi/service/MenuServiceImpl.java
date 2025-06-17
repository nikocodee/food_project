package com.kimi.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kimi.mapper.AttachMapper;
import com.kimi.mapper.MenuMapper;
import com.kimi.model.MenuVO;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class MenuServiceImpl implements MenuService {
	
	@Autowired
	private MenuMapper menuMapper;
	
	@Autowired
	private AttachMapper attachMapper;
	
	@Transactional
	@Override
	public void menuRegister(MenuVO menu) {
		menuMapper.menuRegister(menu);
		
		if(menu.getImageList() == null || menu.getImageList().size() <= 0) {
			return;
		}
		
		menu.getImageList().forEach(attach -> {
			attach.setMn_id(menu.getMn_id());
			
			menuMapper.imageRegister(attach);
			
			log.info(menu);
			
		});
	}
}

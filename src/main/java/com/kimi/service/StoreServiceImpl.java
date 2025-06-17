package com.kimi.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kimi.mapper.AttachMapper;
import com.kimi.mapper.StoreMapper;
import com.kimi.model.Criteria;
import com.kimi.model.StoreVO;
import com.kimi.model.attachDTO;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class StoreServiceImpl implements StoreService {
	@Autowired
	private StoreMapper storeMapper;
	
	@Autowired
	private AttachMapper attachMapper;
	
	@Override
	public List<StoreVO> storeList(Criteria cri) {
		
		List<StoreVO> list = storeMapper.storeList(cri);
		
		list.forEach(store -> {
			
			int st_id = store.getSt_id();
			
			List<attachDTO> imageList = attachMapper.getAttachList(st_id);
			
			store.setImageList(imageList);
			
		});
		
		return list;
	}
	
	@Override
	public int storeGetTotal(Criteria cri){
		log.info("storeGetTotal()..............");
		return storeMapper.storeGetTotal(cri);
	}
	
	@Override
	public List<StoreVO> getCate1(){
		log.info("getCategory().........");
		
		return storeMapper.getCate1();
	}
	@Override
	public List<StoreVO> getCate2(){
		log.info("getCategory().........");
		
		return storeMapper.getCate2();
	}
	@Override
	public List<StoreVO> getCate3(){
		log.info("getCategory().........");
		
		return storeMapper.getCate3();
	}
	@Override
	public List<StoreVO> getCate4(){
		log.info("getCategory().........");
		
		return storeMapper.getCate4();
	}
	@Override
	public List<StoreVO> getCate5(){
		log.info("getCategory().........");
		
		return storeMapper.getCate5();
	}
	
	
	@Transactional
	@Override
	public void storeRegister(StoreVO store) {
		log.info("(Service)storeRegister..........");
		
		storeMapper.storeRegister(store);
		
		if(store.getImageList() == null || store.getImageList().size() <= 0) {
			return;
		}
		
		store.getImageList().forEach(attach -> {
			attach.setSt_id(store.getSt_id());
			
			storeMapper.imageRegister(attach);
			
			log.info(store);
			
		});
	}
	
	@Override
	public StoreVO StoreDetail(int st_id) {
		log.info("StoreDetail......."+st_id);
		return storeMapper.StoreDetail(st_id);
	}
	
	@Override
	public List<attachDTO> getAttachInfo(int st_id){
		log.info("getAttachInfo........");
		
		return storeMapper.getAttachInfo(st_id);
	}
	
	@Transactional
	@Override
	public int storeModify(StoreVO store) {
		
		int result = storeMapper.storeModify(store);
		
		if(result == 1 && store.getImageList() != null && store.getImageList().size() > 0) {
			
			storeMapper.deleteImageAll(store.getSt_id());
			
			store.getImageList().forEach(attach -> {
				
				attach.setSt_id(store.getSt_id());
				storeMapper.imageRegister(attach);
				
			});
			
		}
		
		return result;
	}
	
	@Transactional
	@Override
	public int storeDelete(int st_id) {
		log.info("storeDelete............");
		
		storeMapper.deleteImageAll(st_id);
		
		return storeMapper.storeDelete(st_id);
	}

}

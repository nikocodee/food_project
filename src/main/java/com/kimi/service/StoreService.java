package com.kimi.service;

import java.util.List;

import com.kimi.model.Criteria;
import com.kimi.model.StoreVO;
import com.kimi.model.attachDTO;

public interface StoreService {
	
	public List<StoreVO> storeList(Criteria cri);
	
	/* 상품 총 개수 */
	public int storeGetTotal(Criteria cri);
	
	public List<StoreVO> getCate1();
	
	public List<StoreVO> getCate2();
	
	public List<StoreVO> getCate3();
	
	public List<StoreVO> getCate4();
	
	public List<StoreVO> getCate5();
	
	public void storeRegister(StoreVO store);
	
	/* 매장 조회 페이지 */
	public StoreVO StoreDetail(int st_id);
	
	/*매장 정보 수정*/
	public int storeModify(StoreVO store);
	
	/*매장 정보 삭제*/
	public int storeDelete(int st_id);
	
	/* 지정 상품 이미지 정보 얻기 */
	public List<attachDTO> getAttachInfo(int st_id);
}

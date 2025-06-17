package com.kimi.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.kimi.model.Criteria;
import com.kimi.model.StoreVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class StoreMapperTests {
	
	@Autowired
	private StoreMapper mapper;
	
//	@Test
//	public void storeList() throws Exception {
//		
//		Criteria cri = new Criteria(3,10); //3페이지, 5개행 표시
//		//cri.setKeyword("테스트");
//		
//		List<StoreVO> list = mapper.storeList(cri);
//		
//		for(int i = 0; i <list.size(); i++) {
//			System.out.println("list" + i + ".........." + list.get(i));
//		}
//		
//	}
	
	@Test
	public void storeModify() {
		StoreVO store = new StoreVO();
		
		store.setSt_id(127);
		store.setSt_name("수정테스트");
		store.setSt_biznum("128-12-103222");
		store.setSt_type("한식");
		store.setSt_tel("010-128-1234");
		store.setSt_time1("2323");
		store.setSt_time2("3434");
		store.setSt_addr1("테스트1");
		store.setSt_addr2("테스트2");
		store.setSt_addr3("테스트3");
		store.setSt_info("테스트내용");
		
		mapper.storeModify(store);
	}
	
	/* 지정 상품 이미지 삭제 */
	@Test
	public void deleteImageAllTest() {
		
		int st_id = 28;
		
		mapper.deleteImageAll(st_id);
		
	}
}

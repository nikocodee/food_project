package com.kimi.service;

import static org.junit.Assert.*;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.kimi.model.StoreVO;
import com.kimi.model.attachDTO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class StoreServiceTests {
	
	@Autowired
	private StoreService service;
	
	@Test
	public void test() {
		
	}
	/* 상품 등록 & 상품 이미지 등록 테스트 */
	@Test
	public void storeRegisterTests() {
		
		StoreVO store = new StoreVO();
		
		store.setSt_name("테스트");
		store.setSt_type("한식");
		store.setSt_tel("02-1234-5567");
		store.setSt_biznum("123-12-8989");
		store.setSt_addr1("테스트");
		store.setSt_addr2("테스트");
		store.setSt_addr3("테스트");
		store.setSt_info("테스트내용");
		store.setSt_time1("12:00");
		store.setSt_time2("00:00");
		
		List<attachDTO> imageList = new ArrayList<attachDTO>();
		
		attachDTO image1 = new attachDTO();
		attachDTO image2 = new attachDTO();
		
		image1.setFileName("test Image 4");
		image1.setUploadPath("test image 3");
		image1.setUuid("test55");
		
		image2.setFileName("test Image 2");
		image2.setUploadPath("test image 3");
		image2.setUuid("test88");
		
		imageList.add(image1);
		imageList.add(image2);
		
		store.setImageList(imageList);
		
		service.storeRegister(store);
		
		System.out.println("등록된vo:" + store);
		
 	}

}

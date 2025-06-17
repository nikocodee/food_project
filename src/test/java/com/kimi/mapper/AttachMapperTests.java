package com.kimi.mapper;

import static org.junit.Assert.*;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class AttachMapperTests {
	
	@Autowired
	private AttachMapper mapper;
	
	@Test
	public void getAttachList() {
		
		int st_id = 33;
		System.out.println("이지미 정보 : " + mapper.getAttachList(st_id));
	}

}

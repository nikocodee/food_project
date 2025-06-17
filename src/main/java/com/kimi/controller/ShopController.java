package com.kimi.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.kimi.mapper.AttachMapper;
import com.kimi.model.Criteria;
import com.kimi.model.PageDTO;
import com.kimi.model.StoreVO;
import com.kimi.model.attachDTO;
import com.kimi.service.StoreService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class ShopController {
	
	@Autowired
	private AttachMapper attachMapper;
	
	@Autowired
	private StoreService storeService;
	
	@RequestMapping(value="/main", method=RequestMethod.GET)
	public void mainPageGET(Model model,Criteria cri) {
		log.info("메인 페이지 진입");
		model.addAttribute("list", storeService.storeList(cri));
		model.addAttribute("cate1", storeService.getCate1());
		model.addAttribute("cate2", storeService.getCate2());
		model.addAttribute("cate3", storeService.getCate3());
		model.addAttribute("cate4", storeService.getCate4());
		model.addAttribute("cate5", storeService.getCate5());
	}
	
	@GetMapping("/search")
	public String searchGET(Criteria cri, Model model) {
		log.info("cri : " + cri);
		
		List<StoreVO> list = storeService.storeList(cri);
		log.info("pre list : " + list);
		
		if(!list.isEmpty()) {
			model.addAttribute("list", list);
			log.info("list : " + list);
		} else {
			model.addAttribute("listcheck", "empty");
			
			return "search";
		}
		
		model.addAttribute("pageMaker", new PageDTO(cri, storeService.storeGetTotal(cri)));
		
		return "search";
	}
	
	@GetMapping("/storeInfo")
	public void goodsGetInfoGET(int st_id, Criteria cri, Model model) {
		
		/* 목록 페이지 조건 정보 */
		model.addAttribute("cri", cri);
		/* 조회 페이지 정보 */
		model.addAttribute("storeInfo", storeService.StoreDetail(st_id));
	}
	
	@GetMapping("/display")
	public ResponseEntity<byte[]> getImage(String fileName){
		log.info("getImage()......."+fileName);
		
		File file = new File("c:\\upload\\" + fileName);
		
		ResponseEntity<byte[]> result = null;
		
		try {
			
			HttpHeaders header = new HttpHeaders();
			
			header.add("content-type", Files.probeContentType(file.toPath()));
			
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
			
		}catch(IOException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	/* 이미지 정보 반환 */
	@GetMapping(value="/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<attachDTO>> getAttachList(int st_id){
		
		log.info("getAttachList.........." + st_id);
		
		return new ResponseEntity<List<attachDTO>>(attachMapper.getAttachList(st_id), HttpStatus.OK);
		
	}
}

package com.kimi.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.imageio.ImageIO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kimi.model.Criteria;
import com.kimi.model.MenuVO;
import com.kimi.model.PageDTO;
import com.kimi.model.attachDTO;
import com.kimi.service.MenuService;
import com.kimi.service.StoreService;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnails;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;

@Controller
@Log4j
@RequestMapping(value = "/menu")
public class MenuController {
	
	@Autowired
	private MenuService menuService;
	
	@Autowired
	private StoreService storeService;
	
	@GetMapping("/main")
	public void mainGET(Criteria cri, Model model) {
		log.info("메뉴 페이지 진입");
		
		/* 상품 리스트 데이터 */
		List list = storeService.storeList(cri);
		
		if(!list.isEmpty()) {
			model.addAttribute("list", list);
		} else {
			model.addAttribute("listCheck", "empty");
			return;
		}
		
		/* 페이지 인터페이스 데이터 */
		model.addAttribute("pageMaker", new PageDTO(cri, storeService.storeGetTotal(cri)));
	}
	
	/*메뉴 등록*/
	@GetMapping("/register")
	public void menuRegisterGET() {
		log.info("메뉴 등록 페이지 진입");
	}
	@PostMapping("/register")
	public String menuRegister(MenuVO menu, RedirectAttributes rttr) {
		
		log.info("menuRegister...." + menu);
		
		menuService.menuRegister(menu);
		
		rttr.addFlashAttribute("register_result", menu.getMn_name());
		
		return "redirect:/menu/main";
	}
	
	/*매장 검색 팝업창*/
	@GetMapping("/storePop")
	public void storePopGET(Criteria cri, Model model) throws Exception{
		log.info("storePopGET.....");
		
		cri.setAmount(5);
		
		/* 상품 리스트 데이터 */
		List list = storeService.storeList(cri);
		
		if(!list.isEmpty()) {
			model.addAttribute("list", list);
		} else {
			model.addAttribute("listCheck", "empty");
			return;
		}
		
		/* 페이지 인터페이스 데이터 */
		model.addAttribute("pageMaker", new PageDTO(cri, storeService.storeGetTotal(cri)));
	}
	
	/* 첨부 파일 업로드 */
	@PostMapping(value="/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<attachDTO>> uploadAjaxActionPOST(MultipartFile[] uploadFile){
		log.info("uploadAjaxActionPOST...........");
		String uploadFolder = "C:\\upload";
		
		/*날짜 폴더 경로*/
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		String datePath = str.replace("-", File.separator);
		
		/* 폴더 생성 */
		File uploadPath = new File(uploadFolder, datePath);
		
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		
		/* 이미저 정보 담는 객체 */
		List<attachDTO> list = new ArrayList();
		
		// 향상된 for
		for(MultipartFile multipartFile : uploadFile) {
			
			/*이미지 정보 객체*/
			attachDTO dto = new attachDTO();
			
			/* 파일 이름 */
			String uploadFileName = multipartFile.getOriginalFilename();
			
			/* 파일 위치, 파일 이름을 합친 File 객체 (원본이미지)*/
			File saveFile = new File(uploadPath, uploadFileName);
			
			/* 파일 저장 */
			try {
				multipartFile.transferTo(saveFile);
				
				File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);
				
				BufferedImage bo_image = ImageIO.read(saveFile);
				
				//비율
				double ratio = 3;
				//넓이 높이
				int width = (int)(bo_image.getWidth() / ratio);
				int height = (int)(bo_image.getHeight() / ratio);
				
				Thumbnails.of(saveFile)
				.size(width, height)
				.toFile(thumbnailFile);
			}catch(Exception e) {
				e.printStackTrace();
			}
			
			list.add(dto);
		}
		
		ResponseEntity<List<attachDTO>> result = new ResponseEntity<List<attachDTO>>(list, HttpStatus.OK);
		return result;
	}
	
}

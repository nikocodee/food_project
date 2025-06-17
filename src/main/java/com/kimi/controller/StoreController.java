package com.kimi.controller;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.net.URLDecoder;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kimi.model.Criteria;
import com.kimi.model.PageDTO;
import com.kimi.model.StoreVO;
import com.kimi.model.attachDTO;
import com.kimi.service.MenuService;
import com.kimi.service.StoreService;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnails;
import org.springframework.http.MediaType;

@Controller
@Log4j
@RequestMapping(value = "/store")
public class StoreController {
	
	@Autowired
	private StoreService storeService;
	
	@RequestMapping(value="/main", method=RequestMethod.GET)
	public void joinGET(Criteria cri, Model model) throws Exception{
		log.info("매장관리 페이지 진입");
		
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
	
	/* 매장 등록 */
	@RequestMapping(value="/register", method=RequestMethod.GET)
	public void storeRegisterGET() throws Exception{
		log.info("매장 등록 페이지 접속");
	}
	
	@RequestMapping(value="/register", method=RequestMethod.POST)
	public String storeRegisterPOST(StoreVO store, RedirectAttributes rttr) throws Exception{
		log.info("매장 등록 페이지 접속"+store);
		
		storeService.storeRegister(store);
		
		rttr.addFlashAttribute("register_result", store.getSt_name());
		
		return "redirect:/store/main";
	}
	
	/* 첨부 파일 업로드 */
	@PostMapping(value="/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<attachDTO>> uploadAjaxActionPOST(MultipartFile[] uploadFile) {
		
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
			dto.setFileName(uploadFileName);
			dto.setUploadPath(datePath);
			
			/* uuid 적용 파일 이름 */
			String uuid = UUID.randomUUID().toString();
			dto.setUuid(uuid);
			
			uploadFileName = uuid + "_" + uploadFileName;
			
			/* 파일 위치, 파일 이름을 합친 File 객체 (원본이미지)*/
			File saveFile = new File(uploadPath, uploadFileName);
			
			/* 파일 저장 */
			try {
				multipartFile.transferTo(saveFile);
				
				/* 썸네일 생성(ImageIO) */
//				File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);
//				
//				BufferedImage bo_image = ImageIO.read(saveFile);
//				
//				/*비율 넓이 높이*/
//				double ratio = 3;
//				int width = (int)(bo_image.getWidth() / ratio);
//				int height = (int)(bo_image.getHeight() / ratio);
//				
//				BufferedImage bt_image = new BufferedImage(width, height, BufferedImage.TYPE_3BYTE_BGR);
//								
//				Graphics2D graphic = bt_image.createGraphics();
//				
//				graphic.drawImage(bo_image, 0, 0, width, height, null);
//					
//				ImageIO.write(bt_image, "jpg", thumbnailFile);
				
				/* 방법 2 */
				File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);
				
				BufferedImage bo_image = ImageIO.read(saveFile);
				//비율 
				double ratio = 3;
				//넓이 높이
				int width = (int) (bo_image.getWidth() / ratio);
				int height = (int) (bo_image.getHeight() / ratio);
				
				Thumbnails.of(saveFile)
				.size(width, height)
				.toFile(thumbnailFile);
				
			} catch (Exception e) {
				e.printStackTrace();
			} 
			
			list.add(dto);
		}
		
		//기본 for
//		for(int i = 0; i < uploadFile.length; i++) {
//			log.info("-----------------------------------------------");
//			log.info("파일 이름 : " + uploadFile[i].getOriginalFilename());
//			log.info("파일 타입 : " + uploadFile[i].getContentType());
//			log.info("파일 크기 : " + uploadFile[i].getSize());			
//		}
		
		ResponseEntity<List<attachDTO>> result = new ResponseEntity<List<attachDTO>>(list, HttpStatus.OK);
		return result;
	}
	
	/* 이미지 파일 삭제 */
	@PostMapping("/deleteFile")
	public ResponseEntity<String> deleteFile(String fileName){
		
		log.info("deleteFile........" + fileName);
		
		File file = null;
		
		try {
			
			file = new File("c:\\upload\\" + URLDecoder.decode(fileName, "UTF-8"));
			file.delete();
			
			/* 원본 파일 삭제 */
			String originFileName = file.getAbsolutePath().replace("s_", "");
			log.info("originFileName : " + originFileName);
			
			file = new File(originFileName);
			
			file.delete();
			
		} catch(Exception e) {
			e.printStackTrace();
			
			return new ResponseEntity<>("fail", HttpStatus.NOT_IMPLEMENTED);
		}
		
		return new ResponseEntity<String>("success", HttpStatus.OK);
	}
	
	@GetMapping({"/storeDetail", "/storeModify"})
	public void goodsGetInfoGET(int st_id, Criteria cri, Model model) {
		log.info("storeGetInfo..........."+st_id);
		
		/* 목록 페이지 조건 정보 */
		model.addAttribute("cri", cri);
		/* 조회 페이지 정보 */
		model.addAttribute("storeInfo", storeService.StoreDetail(st_id));
	}
	
	@PostMapping("/storeModify")
	public String storeModigyPOST(StoreVO store, RedirectAttributes rttr) {
		log.info("storeModifyPOST........." + store);
		
		int result = storeService.storeModify(store);
		
		rttr.addFlashAttribute("modify_result", result);
		
		return "redirect:/store/main";
	}
	
	@GetMapping("/storeDelete")
	public String storeDeletePOST(int st_id, RedirectAttributes rttr) {
		log.info("storeDeletePOST.....");
		
		List<attachDTO> fileList = storeService.getAttachInfo(st_id);

		if(fileList != null) {
			
			List<Path> pathList = new ArrayList<Path>();
			
			fileList.forEach(store -> {
				
				//원본 이미지
				Path path = Paths.get("c:\\upload", store.getUploadPath(), store.getUuid() + "_" + store.getFileName());
				pathList.add(path);
				
				//썸네일 이미지
				path = Paths.get("c:\\upload", store.getUploadPath(), "s_" + store.getUuid() + "_" + store.getFileName());
				pathList.add(path);
				
			});
			
			pathList.forEach(path -> {
				path.toFile().delete();
			});
		}
		
		int result = storeService.storeDelete(st_id);
		
		rttr.addFlashAttribute("delete_result", result);
		
		return "redirect:/store/main";
	}
	
	/*상풍 검색*/
//	@GetMapping("/search")
//	public String SearchGET(Criteria cri, Model model) {
//		log.info("cri : " + cri);
//		
//		List<StoreVO> list = storeService.searchList(cri);
//		log.info("pre list : " + list);
//		if(!list.isEmpty()) {
//			model.addAttribute("list", list);
//			log.info("list : " + list);
//		} else {
//			model.addAttribute("listcheck", "empty");
//			
//			return "search";
//		}
//		
//		model.addAttribute("pageMaker", new PageDTO(cri, storeService.storeGetTotal(cri)));
//		
//		return "search";
//	}
}

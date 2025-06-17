package com.kimi.controller;

import java.io.PrintWriter;
import java.net.URLDecoder;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.JavaScriptUtils;

import com.kimi.model.MemberVO;
import com.kimi.service.MemberService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping(value = "/member")
public class MemberController {
	
	@Autowired
	private MemberService memberservice;
	
	@Autowired
	private BCryptPasswordEncoder pwEncoder;
	
	@Autowired
	private JavaMailSender mailSender;
	
	@RequestMapping(value="/join", method=RequestMethod.GET)
	public void joinGET() {
		log.info("회원가입 페이지 진입");
	}
	
	@RequestMapping(value="/join", method=RequestMethod.POST)
	public String joinPOST(MemberVO member) throws Exception{
		
		String rawPw = "";
		String encodePw = "";
		
		rawPw = member.getPw();
		encodePw = pwEncoder.encode(rawPw);
		member.setPw(encodePw);
		
		memberservice.memberJoin(member);
		
		return "redirect:/main";
	}
	
	@RequestMapping(value="/memberIdChk", method=RequestMethod.POST)
	@ResponseBody
	public String memberIdChkPOST(String id) throws Exception{
		
		int result = memberservice.idCheck(id);
		
		log.info("결과값 = " +result);
		
		if(result != 0) {
			return "fail";
		}else {
			return "success";
		}
	}
	
	  /* 이메일 인증 */
    @RequestMapping(value="/mailCheck", method=RequestMethod.GET)
    @ResponseBody
    public String mailCheckGET(String mail) throws Exception{
        
        /* 뷰(View)로부터 넘어온 데이터 확인 */
        log.info("이메일 데이터 전송 확인");
        log.info("인증번호 : " + mail);
        
        /*인증번호 생성*/
        Random random = new Random();
        int checkNum = random.nextInt(888888) + 111111;     
        log.info("인증번호 : " + checkNum);
        
        /* 이메일 보내기 */
        String setFrom = "kjki93@naver.com";
        String toMail = mail;
        String title = "회원가입 인증 이메일 입니다.";
        String content = 
                "홈페이지를 방문해주셔서 감사합니다." +
                "<br><br>" + 
                "인증 번호는 " + checkNum + "입니다." + 
                "<br>" + 
                "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";
        

        try {
            
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
            helper.setFrom(setFrom);
            helper.setTo(toMail);
            helper.setSubject(title);
            helper.setText(content,true);
            mailSender.send(message);
            
        }catch(Exception e) {
            e.printStackTrace();
        }
        
        String num = Integer.toString(checkNum);
        
        return num;
    }
    
    @RequestMapping(value="/login.do", method=RequestMethod.GET)
    public void loginGET(){
    	log.info("로그인 페이지 진입");
    }
    
    @RequestMapping(value="/login.do" , method=RequestMethod.POST)
    @ResponseBody
    public String loginPOST(HttpServletRequest request,@RequestBody MemberVO member, RedirectAttributes rttr) throws Exception{
    	log.info("login 메서드 진입");
    	log.info("전달된 데이터 : " + member);
    	String strResult = "0"; // 성공:1, 실패:0
    	
    	HttpSession session = request.getSession();
    	String rawPw = "";
    	String encodePw = "";
    	
    	MemberVO lvo = memberservice.memberLogin(member);
    	
    	log.info(lvo);
    	
    	if(lvo != null) {  //일치하는 아이디 존재시
			rawPw = member.getPw(); //사용자 제출한 비번
			encodePw = lvo.getPw(); //db에 저장된 인코딩된 비번
			
			if(true == pwEncoder.matches(rawPw, encodePw)) { //일치여부판단
				session.setAttribute("member", lvo);
				session.setAttribute("id"  , lvo.getId());
				session.setAttribute("name", lvo.getName());
				strResult = "1";
			}
    	}
    	
    	return strResult;
    }
    
    @GetMapping("/pw_modify")
    public void passwdGET() {
    	log.info("비밀번호 변경 진입");
    }
    
    @RequestMapping(value="/pw_modify" , method=RequestMethod.POST)
    public ResponseEntity<String> passwd(String pw, String newpw, String newpwco, HttpSession session, HttpServletResponse response) throws Exception{
    	
    	String id = (String) session.getAttribute("id");
    	MemberVO dbMemberVO = memberservice.memberInfo(id);
    	
    	boolean isPasswdRight = BCrypt.checkpw(pw, dbMemberVO.getPw());
    	
    	if(isPasswdRight == false) {
    		HttpHeaders headers = new HttpHeaders();
    		headers.add("Content-Type", "text/html; charset=UTF-8");
    		
//    		String str = JavaScriptUtils.back("현재 비밀번호가 틀렸습니다.");
//    		System.out.println("<script>alert('현재 비밀번호가 틀렸습니다.'); window.history.back();</script>");
    		response.setContentType("text/html; charset=utf-8");
    		PrintWriter w = response.getWriter();
	        w.write("<script>alert('현재 비밀번호가 틀렸습니다.');location.href='/member/pw_modify';</script>");
	        w.flush();
	        w.close();
    
    		return new ResponseEntity<String>(headers, HttpStatus.OK);
    	}	
    	
    	if(newpw.equals(newpwco) == false) {
    		HttpHeaders headers = new HttpHeaders();
    		headers.add("Content-Type", "text/html; charset=UTF-8");
    		
//    		String str = JavaScriptUtils.back("현재 비밀번호가 틀렸습니다.");
//    		System.out.println("<script>alert('새 비밀번호와 새 비밀번호 확인이 서로 일치하지 않습니다.'); window.history.back();</script>");
    		response.setContentType("text/html; charset=utf-8");
    		PrintWriter w = response.getWriter();
    		w.write("<script>alert('새 비밀번호와 새 비밀번호 확인이 서로 일치하지 않습니다.');location.href='/member/pw_modify';</script>");
    		w.flush();
    		w.close();
    
    		return new ResponseEntity<String>(headers, HttpStatus.OK);
    	}	
    	
    	String hashpw = BCrypt.hashpw(newpw, BCrypt.gensalt());
    	memberservice.modifyPw(id, hashpw);
    	
    	HttpHeaders headers = new HttpHeaders();
    	headers.add("Content-Type", "text/html; charset=UTF-8");
    	
//    	System.out.println("<script>alert('비밀번호 변경 완료'); location.href='/memeber/logout.do';</script>");
    	response.setContentType("text/html; charset=utf-8");
		PrintWriter w = response.getWriter();
    	w.write("<script>alert('비밀번호가 변경되었습니다. 다시 로그인 해주세요.');location.href='/member/logout.do';</script>");
    	w.flush();
    	w.close();
    	
    	return new ResponseEntity<String>(headers, HttpStatus.OK);
    }
    

    	
    	
    	
    	
    	
    	
    	//    	String strResult = "0";
//    	
//    	HttpSession session = request.getSession();
//    	String rawPw = "";
//    	String encodePw = "";
//    	
//    	MemberVO lvo = memberservice.memberJoin(member);
//    	
//    	log.info(lvo);
//    	
//    	if(lvo != null) {  //일치하는 아이디 존재시
//			rawPw = member.getPw(); //사용자 제출한 비번
//			encodePw = lvo.getPw(); //db에 저장된 인코딩된 비번
//		
//	    	if(true == pwEncoder.matches(rawPw, encodePw)) { //일치여부판단
//	    		String pw = URLDecoder.decode(encodePw, "UTF-8");
//				session.setAttribute("pw", pw);
//				
//				memberservice.pwModify(member);
//				
//				strResult = "1";
//			}
//    	} 	
//		return strResult;
    
    
    /* 메인페이지 로그아웃 */
    @RequestMapping(value="/logout.do", method=RequestMethod.GET)
    public String logoutMainGET(HttpServletRequest request) throws Exception{
        
    	HttpSession session = request.getSession();
    	session.invalidate();
    	
    	return "redirect:/main";
    }
    
    /* 메인페이지 로그아웃 */
    @RequestMapping(value="/logout.do", method=RequestMethod.POST)
    @ResponseBody //ajax
    public void logoutMainPOST(HttpServletRequest request) throws Exception{
        
    	HttpSession session = request.getSession();
    	session.invalidate();
    	
//    	return "redirect:/main"; ajax 비동기 로그아웃
    }
    
    /*회원정보 페이지*/
    @RequestMapping(value={"/info","/info_modify"}, method=RequestMethod.GET)
    public void memberInfo(HttpSession session, Model model) throws Exception{
    	log.info("회원정보 페이지 진입");
    	
    	String id = (String)session.getAttribute("id");
    	
    	MemberVO vo = memberservice.memberInfo(id);
    	
    	model.addAttribute("info", vo);
    	
    }
    @PostMapping("/info_modify")
    public String memberModify(MemberVO member, RedirectAttributes rttr) throws Exception {
    	int result = memberservice.memberModify(member);
    	rttr.addFlashAttribute("info_modify", result);
    	
    	return "redirect:/member/info";
    }
    
    
    /*회원탈퇴*/
    @RequestMapping(value = "/info_delete", method = RequestMethod.GET)
    public String deleteMember(HttpServletRequest request, MemberVO member, RedirectAttributes rttr) throws Exception {
    	HttpSession session = request.getSession();
    	session.getAttribute(member.getId());
    	
    	log.info("delete member.....");
    	int result = memberservice.deleteMember(member);
    	
    	log.info(result);
    	rttr.addFlashAttribute("info_delete", result); 
    	
    	session.invalidate();
    	
    	return "redirect:/main"; 
    }
    
}

package org.dodream.mybatis;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.dodream.join.CustomUserDetailsService;
import org.dodream.join.UserAuthDAO;
import org.dodream.join.UserAuthVO;
import org.dodream.upload.FileValidater;
import org.dodream.upload.UploadVO;
import org.json.simple.*;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/board/")
public class BbsController {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate; // 설정파일에 빈으로 등록되었기 때문에 생성자나 Setter 없이 자동으로 주입
	
	@Autowired
	private BbsService svc;
	
	@RequestMapping(value="inputForm", method=RequestMethod.GET)
	public String boardInputForm(BbsVO bbs, Authentication auth, HttpSession session) {
		session.setAttribute("userID", auth.getName());
		return "/board/boardInputForm";
	}
    
	@RequestMapping(value="recent", method=RequestMethod.POST)
	public String boardInsert(Model model, BbsVO vo, Authentication auth) {
		boolean input = svc.input(vo);
		
		if(input==true){
			Bbs bbs = svc.getRecent(vo.getAuthor());
			model.addAttribute("recentRead", bbs);
			model.addAttribute("userID", auth.getName());
		}
		return "board/boardRecent";
	}
	
	@RequestMapping("read")
	public String getBoard(Model model, @RequestParam("num") int num, Authentication auth) {
	    Bbs bbs = svc.read(num);
	    model.addAttribute("read", bbs);
		return "board/boardRead";
	}
	 
	@RequestMapping("edit")
	public String boardEdit(Model model, @RequestParam("num") int num) {
		BbsDAO dao = sqlSessionTemplate.getMapper(BbsDAO.class);
		BbsVO board = dao.read(num);
		model.addAttribute("boardRead", board);
		return "/board/boardEdit";
	}

	@RequestMapping(value="update", method=RequestMethod.POST)
	@ResponseBody
	public boolean boardUpdate(Model model, BbsVO bbs) {
		BbsDAO dao = sqlSessionTemplate.getMapper(BbsDAO.class);
		int n = dao.update(bbs);
		
		boolean updated;
		if(n==0){
			updated = false;
		}
		else{
			updated = true;
		}
		return updated;
	}
	
	@RequestMapping(value="delete", method=RequestMethod.POST)
	@ResponseBody
	public boolean boardDelete(Model model, @RequestParam("num") int num, Authentication auth) {
		BbsDAO dao = sqlSessionTemplate.getMapper(BbsDAO.class);
		int n = dao.delete(num);
		boolean deleted;
		if(n==0){
			deleted = false;
		}
		else{
			deleted = true;
		}
		return deleted;
	}
	
	@RequestMapping(value="repl", method=RequestMethod.POST)
    @ResponseBody
	public String replSave(Model model, BbsVO vo, Authentication auth) {
		boolean input = svc.saveRepl(vo);
		JSONObject job = new JSONObject();
		job.put("replSaved", input);
		return job.toJSONString();
	}
	
	@RequestMapping("listPage") 
	public String listPage(Model model,@RequestParam(defaultValue="1") int page) { 
		BbsDAO dao = sqlSessionTemplate.getMapper(BbsDAO.class); 
		Bbs b = dao.listPage(page);  
		model.addAttribute("b", b); 
		return "board/boardListPage"; 
	}
	
	@RequestMapping(value="search", method=RequestMethod.POST) 
    @ResponseBody
    public String getPage(@RequestParam("category") String cat, @RequestParam("keyword") String kw){
	   BbsDAO dao = sqlSessionTemplate.getMapper(BbsDAO.class);
       List<BbsVO> list = dao.search(cat, kw);
       JSONArray jarr = new JSONArray();
       for(int i=0; i<list.size(); i++){
	       JSONObject joj = new JSONObject();
	       joj.put("num",list.get(i).getNum());
	       joj.put("title",list.get(i).getTitle());
	       joj.put("contents",list.get(i).getContents());
	       joj.put("author",list.get(i).getAuthor());
	       jarr.add(joj);
       }
       return jarr.toJSONString();
	}
 
	@RequestMapping("download")
	@ResponseBody
	public byte[] getImage(HttpServletResponse response, 
						   @RequestParam("filename") String filename) throws IOException {
		File file = new File("D:/upload/"+filename);
	    byte[] bytes = org.springframework.util.FileCopyUtils.copyToByteArray(file);
	 
	    //한글은 http 헤더에 사용할 수 없기때문에 파일명은 영문으로 인코딩하여 헤더에 적용한다
	    String fn = new String(file.getName().getBytes(), "iso_8859_1");
	 
	    response.setHeader("Content-Disposition", "attachment; filename=\"" + fn + "\"");
	    response.setContentLength(bytes.length);
	    response.setContentType("image/jpeg");
	    return bytes;
	}   
}
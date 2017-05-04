package org.dodream.upload;

import java.io.*;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletResponse;

import org.dodream.mybatis.BbsVO;
import org.springframework.beans.factory.annotation.Autowired;  
import org.springframework.stereotype.Controller;  
import org.springframework.validation.BindingResult;  
import org.springframework.web.bind.annotation.ModelAttribute;  
import org.springframework.web.bind.annotation.RequestMapping;  
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;  
import org.springframework.web.servlet.ModelAndView;  
 
@Controller 
public class UploadController {  
    @Autowired
    private FileValidater fileValidator;
    
    @RequestMapping(value="/uploadForm", method=RequestMethod.GET)  
    public String getUploadForm(@ModelAttribute("uploadVO") UploadVO uploadVO, BindingResult result) {  
         return "upload/uploadForm";  
    }  
    
    @RequestMapping(value="/fileUpload", method=RequestMethod.POST)  
    public ModelAndView fileUploaded(@ModelAttribute("bbs") BbsVO bbs, BindingResult result) {  
    	fileValidator.validate(bbs, result);
    	System.out.println(result);
    	if (result.hasErrors()) {
    		return new ModelAndView("upload/uploadForm");  
    	}  
    
	    // ���ε�� ������ ������ ��η� �̵��Ѵ�
	    List<MultipartFile> list = bbs.getFile();   
	    
	    InputStream inputStream = null;  
	    OutputStream outputStream = null;  
	    
	    for(int i=list.size()-1;i>=0;i--)
	    {
	        MultipartFile file = list.get(i);
	        // ������ ������ ��� �ִ� ��쿡�� ����Ʈ���� �����Ѵ�
	        if(file.getSize()==0) {
	            list.remove(i);
	            continue;
	        }
	        String fileName = file.getOriginalFilename();
	        String newFname = getFname(fileName);
	        try {
	            inputStream = file.getInputStream();
	        
	            File newFile = new File("D:/upload/" + newFname);
	            if (!newFile.exists()) {
	                newFile.createNewFile();
	            }
	            outputStream = new FileOutputStream(newFile);
	            int read = 0;
	            byte[] bytes = new byte[1024];
	        
	            while ((read = inputStream.read(bytes)) != -1) {
	                outputStream.write(bytes, 0, read);
	            }
	        } catch (IOException e) {
	            e.printStackTrace();
	        } finally {
	            try {
	                if(inputStream!=null) inputStream.close();
	                if(outputStream!=null) outputStream.close();
	            } catch (IOException e) {
	                e.printStackTrace();
	            }
	        }
	    }
	    return new ModelAndView("upload/uploadedFile");
    }
    
    private String getFname(String originFile){
		File dir = new File("D:/upload");
		String[] files = dir.list();
		String newFile = null;
		
		for(int i=0; i<files.length; i++){
			if(files[i].equals(originFile)){
				String tmp = originFile.split("\\.")[0];
				String ext = originFile.split("\\.")[1];
				tmp += new Date().getTime()+"."+ext;
				newFile = tmp;
				return newFile;
			}
		}
		return originFile;
	}
 
	@RequestMapping("/download")
	@ResponseBody
	public byte[] getImage(HttpServletResponse response, 
			@RequestParam String filename) throws IOException {
		File file = new File("D:/upload/"+filename);
	    byte[] bytes = org.springframework.util.FileCopyUtils.copyToByteArray(file);
	 
	    //�ѱ��� http ����� ����� �� ���⶧���� ���ϸ��� �������� ���ڵ��Ͽ� ����� �����Ѵ�
	    String fn = new String(file.getName().getBytes(), "iso_8859_1");
	 
	    response.setHeader("Content-Disposition", "attachment; filename=\"" + fn + "\"");
	    response.setContentLength(bytes.length);
	    response.setContentType("image/jpeg");
	    return bytes;
	}   
}
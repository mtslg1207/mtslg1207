package org.dodream.mybatis;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.dodream.upload.FileValidater;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

@Service
public class BbsService {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public boolean input(BbsVO bbs){
		BbsDAO dao = sqlSessionTemplate.getMapper(BbsDAO.class);
		int n = dao.insert(bbs);
		if(n == 0){
			return false;
		}
	    
	    for(int i=bbs.getFile().size()-1;i>=0;i--)
	    {
	        MultipartFile files = bbs.getFile().get(i);
	        if(files.getSize()==0) {
	        	bbs.getFile().remove(i);
	            continue;
	        }
	        
	        FileVO file = new FileVO();
	        String fname = files.getOriginalFilename();
	        String newFname = getFname(fname);
	        
	        file.setAuthor(bbs.getAuthor());
	        file.setOriginName(fname);
	        file.setSaveName(newFname);
	        
	        InputStream input = null;
	        OutputStream output = null;
	        try {
	        	input = files.getInputStream();
	        	File f = new File("D:/upload/" + newFname);
	        	output = new FileOutputStream(f);
	        	
	        	byte[] bytes = new byte[1024];
	        	int read = 0;
	        	while ((read = input.read(bytes)) != -1) {
	                output.write(bytes, 0, read);
	                output.flush();
	            }
	        	
	            if(dao.upload(file) <= 0){
	            	return false;
	            }
	        } catch (IOException e) {
	            e.printStackTrace();
	        } finally {
	            try {
	                input.close();
	                output.close();
	            } catch (IOException e) {
	                e.printStackTrace();
	            }
	        }
	    }
	    return true;
	}
	
	public Bbs getRecent(String userId){
		BbsDAO dao = sqlSessionTemplate.getMapper(BbsDAO.class);
		BbsVO bList = dao.recent(userId);
		List<FileVO> fList = dao.recentFile(userId);
		
		Bbs bbs = new Bbs();
		bbs.setBbs(bList);
		bbs.setFile(fList);
		return bbs;
	}
	
	public Bbs read(int num){
		BbsDAO dao = sqlSessionTemplate.getMapper(BbsDAO.class);
		BbsVO vo = dao.read(num);
		List<FileVO> files = dao.readFile(num);
		
		Bbs bbs = new Bbs();
		bbs.setBbs(vo);
		bbs.setFile(files);
		return bbs;
	}
	
	public boolean saveRepl(BbsVO bbs){
		BbsDAO dao = sqlSessionTemplate.getMapper(BbsDAO.class);
		int n = dao.insert(bbs);
		if(n > 0){
			return true;
		}
		else{
			return false;
		}
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
}
package org.dodream.upload;

import org.dodream.mybatis.BbsVO;
import org.springframework.stereotype.Service;
import org.springframework.validation.Errors; 
import org.springframework.validation.Validator; 
 
@Service("fileValidator")
public class FileValidater implements Validator { 
 
    public boolean supports(Class<?> arg0) {
        return false;
    }
 
    public void validate(Object uploadedFile, Errors errors) { 
        BbsVO file = (BbsVO) uploadedFile; 
           
        for(int i=0; i<file.getFile().size(); i++){
        	if (file.getFile().get(i).getSize() != 0) {   // 파일이 한개라도 있다면 (내용, 크기가 있는 것이 있다면) 
        		return;
        	}
        }
        errors.rejectValue("file", "uploadForm.selectFile", "Please select a file!");
    }
}
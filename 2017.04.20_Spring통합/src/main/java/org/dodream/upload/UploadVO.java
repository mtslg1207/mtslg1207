package org.dodream.upload;

import java.util.List;
import org.springframework.web.multipart.MultipartFile;

public class UploadVO {
	private int num;
	private String originName;
	private String saveName;
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getOriginName() {
		return originName;
	}
	public void setOriginName(String originName) {
		this.originName = originName;
	}
	public String getSaveName() {
		return saveName;
	}
	public void setSaveName(String saveName) {
		this.saveName = saveName;
	}
}
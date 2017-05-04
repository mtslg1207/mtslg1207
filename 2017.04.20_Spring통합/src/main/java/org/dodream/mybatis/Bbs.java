package org.dodream.mybatis;

import java.util.List;
import org.dodream.upload.UploadVO;

public class Bbs {
	private List<BbsVO> list;
	private List<FileVO> file;
	private BbsVO bbs;
	private int totalPages;
	private int page;
	private PageUtilBean pageBean;
	
	public List<BbsVO> getList() {
		return list;
	}
	public void setList(List<BbsVO> list) {
		this.list = list;
	}
	public List<FileVO> getFile() {
		return file;
	}
	public void setFile(List<FileVO> file) {
		this.file = file;
	}
	public BbsVO getBbs() {
		return bbs;
	}
	public void setBbs(BbsVO bbs) {
		this.bbs = bbs;
	}
	public int getTotalPages() {
		return totalPages;
	}
	public void setTotalPages(int totalPages) {
		this.totalPages = totalPages;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public PageUtilBean getPageBean() {
		return pageBean;
	}
	public void setPageBean(PageUtilBean pageBean) {
		this.pageBean = pageBean;
	}
}
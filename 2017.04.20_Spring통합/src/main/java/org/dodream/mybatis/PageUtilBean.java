package org.dodream.mybatis;

public class PageUtilBean {
	private int totalPages;
	private int currPage;
	private int rowsPerPage;
	private int numsPerPage;
	private int rows;

	public int getTotalPages() {
		return totalPages;
	}
	public void setTotalPages(int totalPages) {
		this.totalPages = totalPages;
	}
	public int getcurrPage() {
		return currPage;
	}
	public void setcurrPage(int currPage) {
		this.currPage = currPage;
	}
	public int getRowsPerPage() {
		return rowsPerPage;
	}
	public void setRowsPerPage(int rowsPerPage) {
		this.rowsPerPage = rowsPerPage;
	}
	public int getNumsPerPage() {
		return numsPerPage;
	}
	public void setNumsPerPage(int numsPerPage) {
		this.numsPerPage = numsPerPage;
	}
	public int getrows() {
		return rows;
	}
	public void setrows(int rows) {
		this.rows = rows;
	}
}
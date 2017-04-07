package kr.co.restmap.domain;

import java.util.Date;

public class RestMenuVO {
	private int menuId;
	private int restId;
	private int fileId;
	private String filePath;
	private int writerNo;
	private String writer;
	private String menuName;
	private int price;
	private int recommend;
	private Date regDate;
	

	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public void setRestId(int restId) {
		this.restId = restId;
	}
	public int getMenuId() {
		return menuId;
	}
	public void setMenuId(int menuId) {
		this.menuId = menuId;
	}
	public int getRestId() {
		return restId;
	}
	public void setRestid(int restId) {
		this.restId = restId;
	}
	public int getFileId() {
		return fileId;
	}
	public void setFileId(int fileId) {
		this.fileId = fileId;
	}
	public int getWriterNo() {
		return writerNo;
	}
	public void setWriterNo(int writerNo) {
		this.writerNo = writerNo;
	}
	public String getMenuName() {
		return menuName;
	}
	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getRecommend() {
		return recommend;
	}
	public void setRecommend(int recommend) {
		this.recommend = recommend;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	
	@Override
	public String toString() {
		return "RestMenu [menuId=" + menuId + ", restId=" + restId + ", fileId=" + fileId + ", writerNo=" + writerNo
				+ ", menuName=" + menuName + ", price=" + price + ", recommend=" + recommend + ", regDate=" + regDate
				+ "]";
	}
	
}

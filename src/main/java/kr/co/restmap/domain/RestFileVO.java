package kr.co.restmap.domain;

import java.util.Date;

public class RestFileVO {
	private int fileId;
	private String oriFileName;
	private String realFileName;
	private String filePath;
	private long fileSize;
	private Date regDate;
	
	public int getFileId() {
		return fileId;
	}
	public void setFileId(int fileId) {
		this.fileId = fileId;
	}
	
	public String getOriFileName() {
		return oriFileName;
	}
	public void setOriFileName(String oriFileName) {
		this.oriFileName = oriFileName;
	}
	public String getRealFileName() {
		return realFileName;
	}
	public void setRealFileName(String realFileName) {
		this.realFileName = realFileName;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public long getFileSize() {
		return fileSize;
	}
	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	@Override
	public String toString() {
		return "RestFile [fileId=" + fileId + ", oriFileName=" + oriFileName + ", realFileName=" + realFileName
				+ ", filePath=" + filePath + ", fileSize=" + fileSize + ", regDate=" + regDate + "]";
	}
}

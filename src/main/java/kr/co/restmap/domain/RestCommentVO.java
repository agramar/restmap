package kr.co.restmap.domain;

import java.util.Date;

public class RestCommentVO {
	private int commentId;
	private int restId;
	private int writerNo;
	private String writer;
	private int score;
	private String content;
	private Date regDate;
	
	@Override
	public String toString() {
		return "RestComment [commentId=" + commentId + ", restId=" + restId + ", writerNo=" + writerNo + ", score="
				+ score + ", content=" + content + ", regDate=" + regDate + "]";
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public int getCommentId() {
		return commentId;
	}
	public void setCommentId(int commentId) {
		this.commentId = commentId;
	}
	public int getRestId() {
		return restId;
	}
	public void setRestId(int restId) {
		this.restId = restId;
	}
	public int getWriterNo() {
		return writerNo;
	}
	public void setWriterNo(int writerNo) {
		this.writerNo = writerNo;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
}

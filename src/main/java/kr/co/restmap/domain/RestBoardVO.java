package kr.co.restmap.domain;

import java.util.Date;

public class RestBoardVO {
	private int restId;
	private String title;
	private String address;
	private String newAddress;
	private String latitude;
	private String longitude;
	private String phone;
	private String zipcode;
	private String imageUrl;
	private String writer;
	private String introduce;
	private String summary;

	private int categoryId;
	private int holidayId;
	private int paymentId;
	private String openingHours;
	private String etcInfo;
	private int viewCount;
	private Date regDate;
	
	private double distance;
	private double score;
	private int maxPrice;
	private int minPrice;
	
	private String categoryName;
	private String holidayName;
	private String paymentName;
	
	private int writerNo;
	
	public String getHolidayName() {
		return holidayName;
	}
	public void setHolidayName(String holidayName) {
		this.holidayName = holidayName;
	}
	public int getWriterNo() {
		return writerNo;
	}
	public void setWriterNo(int writerNo) {
		this.writerNo = writerNo;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public String getHolidatName() {
		return holidayName;
	}
	public void setHolidatName(String holidayName) {
		this.holidayName = holidayName;
	}
	public String getPaymentName() {
		return paymentName;
	}
	public void setPaymentName(String paymentName) {
		this.paymentName = paymentName;
	}
	public double getDistance() {
		return distance;
	}
	public void setDistance(double distance) {
		this.distance = distance;
	}
	public double getScore() {
		return score;
	}
	public void setScore(double score) {
		this.score = score;
	}
	public int getMaxPrice() {
		return maxPrice;
	}
	public void setMaxPrice(int maxPrice) {
		this.maxPrice = maxPrice;
	}
	public int getMinPrice() {
		return minPrice;
	}
	public void setMinPrice(int minPrice) {
		this.minPrice = minPrice;
	}
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
	}
	public int getRestId() {
		return restId;
	}
	public void setRestId(int restId) {
		this.restId = restId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getNewAddress() {
		return newAddress;
	}
	public void setNewAddress(String newAddress) {
		this.newAddress = newAddress;
	}
	public String getLatitude() {
		return latitude;
	}
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public String getLongitude() {
		return longitude;
	}
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public String getImageUrl() {
		return imageUrl;
	}
	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getIntroduce() {
		return introduce;
	}
	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}
	public int getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}
	public int getHolidayId() {
		return holidayId;
	}
	public void setHolidayId(int holidayId) {
		this.holidayId = holidayId;
	}
	public int getPaymentId() {
		return paymentId;
	}
	public void setPaymentId(int paymentId) {
		this.paymentId = paymentId;
	}
	public String getOpeningHours() {
		return openingHours;
	}
	public void setOpeningHours(String openingHours) {
		this.openingHours = openingHours;
	}
	public String getEtcInfo() {
		return etcInfo;
	}
	public void setEtcInfo(String etcInfo) {
		this.etcInfo = etcInfo;
	}
	public int getViewCount() {
		return viewCount;
	}
	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	@Override
	public String toString() {
		return "RestBoardVO [restId=" + restId + ", title=" + title + ", address=" + address + ", newAddress="
				+ newAddress + ", latitude=" + latitude + ", longitude=" + longitude + ", phone=" + phone + ", zipcode="
				+ zipcode + ", imageUrl=" + imageUrl + ", writer=" + writer + ", introduce=" + introduce + ", summary="
				+ summary + ", categoryId=" + categoryId + ", holidayId=" + holidayId + ", paymentId=" + paymentId
				+ ", openingHours=" + openingHours + ", etcInfo=" + etcInfo + ", viewCount=" + viewCount + ", regDate="
				+ regDate + ", distance=" + distance + ", score=" + score + ", maxPrice=" + maxPrice + ", minPrice="
				+ minPrice + "]";
	}
	
}











package kr.co.restmap.domain;

public class MapBoundVO {
	private String east;
	private String west;
	private String south;
	private String north;
	
	public String getEast() {
		return east;
	}
	public void setEast(String east) {
		this.east = east;
	}
	public String getWest() {
		return west;
	}
	public void setWest(String west) {
		this.west = west;
	}
	public String getSouth() {
		return south;
	}
	public void setSouth(String south) {
		this.south = south;
	}
	public String getNorth() {
		return north;
	}
	public void setNorth(String north) {
		this.north = north;
	}
	@Override
	public String toString() {
		return "MapBoundVO [east=" + east + ", west=" + west + ", south=" + south + ", north=" + north + "]";
	}
	
}

package kr.co.restmap.service;

import java.util.List;
import java.util.Map;

import kr.co.restmap.domain.MapBoundVO;
import kr.co.restmap.domain.RestBoardVO;
import kr.co.restmap.domain.RestCodeVO;
import kr.co.restmap.domain.RestCommentVO;
import kr.co.restmap.domain.RestFileVO;
import kr.co.restmap.domain.RestMenuVO;

public interface RestBoardService {
	
	/** 코드 테이블에서 카테고리별 코드정보 가져오는 기능 */ 
	public List<RestCodeVO> selectRestCodeByCodeCategory(String codeCategory) throws Exception;
	
	/** rest_board 테이블에 식당정보 입력하는 기능 */ 
	public void insertRestBoard(RestBoardVO restBoard) throws Exception;

	/** restId 중복체크 */
	public List<RestBoardVO> selectRestId(int restId);
	
	/** 범위내의 등록된 식당 리스트 구해오기 */
	public List<RestBoardVO> selectRestListByBound(MapBoundVO mapBound);
	
	/** 상세페이지 식당 기본 정보 불러오기 */
	public RestBoardVO restDetail(int restId);
	
	/** 상세페이지 식당 코멘트 리스트 불러오기(페이징) */
	public List<RestCommentVO> selectRestCommentListByRestId(Map<String, Object> map);
	
	/** 코멘트 카운트 가져오기 */
	public int selectRestCommentCountByRestId(int restId);
	
	/** 상세페이지 식당 코멘트 입력하기 */
	public void insertRestComment(RestCommentVO restComment);

	/** 상세페이지 식당 코멘트 인덱스로 삭제하기  */
	public void deleteRestComment(int restId);
	
	/** 상세페이지 식당 메뉴 등록 */
	public void insertRestMenu(RestFileVO restFile, RestMenuVO restMenu);

	/** 상세페이지 식당 메뉴 리스트 불러오기(페이징) */
	public List<RestMenuVO> selectRestMenuListByRestId(Map<String, Object> map);

	/** 상세페이지 식당 메뉴 카운트 가져오기 */
	public int selectRestMenuCountByRestId(int restId);

	/** 상세페이지 식당 메뉴 및 파일 삭제 */
	public void deleteRestMenu(int menuId, int fileId);

	/** 식당 페이지 정보 삭제 */
	public void deleteRestBoard(int restId);

	
}

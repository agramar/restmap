package kr.co.restmap.persistence;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.restmap.domain.MapBoundVO;
import kr.co.restmap.domain.RestBoardVO;
import kr.co.restmap.domain.RestCodeVO;
import kr.co.restmap.domain.RestCommentVO;
import kr.co.restmap.domain.RestFileVO;
import kr.co.restmap.domain.RestMenuVO;

@Repository
public class RestBoardDAO {

	@Autowired
	protected SqlSessionTemplate sqlSessionTemplate;
	
	private static final String namespace = "kr.co.restMap.restBoardMapper"; 

	public List<RestCodeVO> selectRestCodeByCodeCategory(String codeCategory) {
		return sqlSessionTemplate.selectList(namespace + ".selectRestCodeByCodeCategory", codeCategory);
	}

	public void insertRestBoard(RestBoardVO restBoard) {
		sqlSessionTemplate.insert(namespace + ".insertRestBoard", restBoard);
	}

	public List<RestBoardVO> selectRestId(int restId) {
		return sqlSessionTemplate.selectList(namespace + ".selectRestId", restId);
	}

	public List<RestBoardVO> selectRestListByBound(MapBoundVO mapBound) {
		return sqlSessionTemplate.selectList(namespace + ".selectRestListByBound", mapBound);
	}
	
	public RestBoardVO selectOneRestByRestId(int restId) {
		return sqlSessionTemplate.selectOne(namespace + ".selectOneRestByRestId", restId);
	}
	
	public List<RestCommentVO> selectRestMenuListByRestId(int restId) {
		return sqlSessionTemplate.selectList(namespace + ".selectRestMenuListByRestId", restId);
	}
	
	public List<RestCommentVO> selectRestCommentListByRestId(Map<String, Object> map) {
		return sqlSessionTemplate.selectList(namespace + ".selectRestCommentListByRestId", map);
	}
	
	public int selectRestCommentCountByRestId(int restId) {
		return sqlSessionTemplate.selectOne(namespace + ".selectRestCommentCountByRestId", restId);
	}
	
	public void insertRestComment(RestCommentVO restComment) {
		sqlSessionTemplate.insert(namespace + ".insertRestComment", restComment);
	}

	public void deleteRestComment(int commentId) {
		sqlSessionTemplate.delete(namespace + ".deleteRestComment", commentId);
	}

	public int insertRestFile(RestFileVO restFile) {
		sqlSessionTemplate.insert(namespace + ".insertRestFile", restFile);
		return restFile.getFileId();
	}

	public void insertRestMenu(RestMenuVO restMenu) {
		sqlSessionTemplate.insert(namespace + ".insertRestMenu", restMenu);
	}

	public List<RestMenuVO> selectRestMenuListByRestId(Map<String, Object> map) {
		return sqlSessionTemplate.selectList(namespace + ".selectRestMenuListByRestId", map);
	}

	public int selectRestMenuCountByRestId(int restId) {
		return sqlSessionTemplate.selectOne(namespace + ".selectRestMenuCountByRestId", restId);
	}
	
	public void deleteRestMenu(int menuId) {
		sqlSessionTemplate.delete(namespace + ".deleteRestMenu", menuId);
	}
	
	public void deleteRestFile(int fileId) {
		sqlSessionTemplate.delete(namespace + ".deleteRestFile", fileId);
	}

	public void deleteRestBoardByRestId(int restId) {
		sqlSessionTemplate.delete(namespace + ".deleteRestBoardByRestId", restId);
	}

	public void deleteRestMenuByRestId(int restId) {
		sqlSessionTemplate.delete(namespace + ".deleteRestMenuByRestId", restId);		
	}

	public void deleteRestCommentByRestId(int restId) {
		sqlSessionTemplate.delete(namespace + ".deleteRestCommentByRestId", restId);
	}
	
	
}

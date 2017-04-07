package kr.co.restmap.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.restmap.domain.MapBoundVO;
import kr.co.restmap.domain.RestBoardVO;
import kr.co.restmap.domain.RestCodeVO;
import kr.co.restmap.domain.RestCommentVO;
import kr.co.restmap.domain.RestFileVO;
import kr.co.restmap.domain.RestMenuVO;
import kr.co.restmap.persistence.RestBoardDAO;

@Service
public class RestBoardServiceImpl implements RestBoardService {
	
	@Autowired
	private RestBoardDAO restBoardDao;
	
	@Override
	public List<RestCodeVO> selectRestCodeByCodeCategory(String codeCategory) throws Exception {
		return restBoardDao.selectRestCodeByCodeCategory(codeCategory);
	}

	@Override
	public void insertRestBoard(RestBoardVO restBoard) throws Exception {
		restBoardDao.insertRestBoard(restBoard);
	}

	@Override
	public List<RestBoardVO> selectRestId(int restId) {
		return restBoardDao.selectRestId(restId);
	}

	@Override
	public List<RestBoardVO> selectRestListByBound(MapBoundVO mapBound) {
		return restBoardDao.selectRestListByBound(mapBound);
	}

	@Override
	public RestBoardVO restDetail(int restId) {
		return restBoardDao.selectOneRestByRestId(restId);
	}

	@Override
	public List<RestCommentVO> selectRestCommentListByRestId(Map<String, Object> map) {
		return restBoardDao.selectRestCommentListByRestId(map);
	}
	
	@Override
	public void insertRestComment(RestCommentVO restComment) {
		restBoardDao.insertRestComment(restComment);
	}

	@Override
	public int selectRestCommentCountByRestId(int restId) {
		return restBoardDao.selectRestCommentCountByRestId(restId);
	}

	@Override
	public void deleteRestComment(int commentId) {
		restBoardDao.deleteRestComment(commentId);
	}

	@Override
	public void insertRestMenu(RestFileVO restFile, RestMenuVO restMenu) {
		if (restFile != null) {
			int fileId = restBoardDao.insertRestFile(restFile);
			restMenu.setFileId(fileId);
		};
		restBoardDao.insertRestMenu(restMenu);
	}

	@Override
	public List<RestMenuVO> selectRestMenuListByRestId(Map<String, Object> map) {
		return restBoardDao.selectRestMenuListByRestId(map);
	}

	@Override
	public int selectRestMenuCountByRestId(int restId) {
		return restBoardDao.selectRestMenuCountByRestId(restId);
	}

	@Override
	public void deleteRestMenu(int menuId, int fileId) {
		restBoardDao.deleteRestMenu(menuId);
		if (fileId != 0) {
			restBoardDao.deleteRestFile(fileId);
		};
	}

	@Override
	public void deleteRestBoard(int restId) {
		restBoardDao.deleteRestBoardByRestId(restId);
		restBoardDao.deleteRestMenuByRestId(restId);
		restBoardDao.deleteRestCommentByRestId(restId);
	}


	
	
}

package kr.co.restmap.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import kr.co.restmap.domain.MapBoundVO;
import kr.co.restmap.domain.RestBoardVO;
import kr.co.restmap.domain.RestCodeVO;
import kr.co.restmap.domain.RestCommentVO;
import kr.co.restmap.domain.RestFileVO;
import kr.co.restmap.domain.RestMenuVO;
import kr.co.restmap.service.RestBoardService;

@Controller
@RequestMapping("/restBoard")
public class RestBoardController {
	
	@Inject
	private RestBoardService service;
	
	@Inject
	private ServletContext servletContext;
	
	@RequestMapping("/restList.do")
	public void restList() {}
	
	@RequestMapping("/restDetail.do")
	public void restDetail(int restId, Model model) throws Exception {
		model.addAttribute("restBoard", service.restDetail(restId));
	}
	
	@RequestMapping("/deleteRest.do")
	public ModelAndView deleteRest(int restId) throws Exception {
		service.deleteRestBoard(restId);
		return new ModelAndView("redirect:/restBoard/restList.do");
	}
	
	@RequestMapping("/codeListByCategory.do")
	@ResponseBody
	public List<RestCodeVO> codeListByCategoryAjax(String codeCategory) throws Exception {
		return service.selectRestCodeByCodeCategory(codeCategory);
	}
	
	@RequestMapping("/insertRestBoard.do")
	@ResponseBody
	public String insertRestBoardAjax(RestBoardVO restBoard) throws Exception {
		service.insertRestBoard(restBoard);
		return "{}";
	}
	
	@RequestMapping("/selectRestId.do")
	@ResponseBody
	public int selectRestIdAjax(int restId) throws Exception {
		return service.selectRestId(restId).size();
	}
	
	@RequestMapping("/selectListByBound.do")
	@ResponseBody
	public List<RestBoardVO> selectListByBound(MapBoundVO mapBound) throws Exception {
		List<RestBoardVO> list = service.selectRestListByBound(mapBound);
		return list;
	}
	
	// 댓글 등록
	@RequestMapping("/insertRestComment.do")
	@ResponseBody
	public String insertRestComment(RestCommentVO restComment) throws Exception {
		service.insertRestComment(restComment);
		
		return "{}";
	}
	
	// 댓글 삭제
	@RequestMapping("/deleteRestComment.do")
	@ResponseBody
	public String deleteRestComment(int commentId) throws Exception {
		service.deleteRestComment(commentId);
		return "{}";
	}
	
	// 댓글 리스트
	@RequestMapping("/restCommentList.do")
	@ResponseBody
	public List<RestCommentVO> selectRestCommentListByRestId(int restId, int pageIdx, int pageRow) throws Exception {
		int start = (pageIdx-1)*pageRow; 
		Map<String, Object> map = new HashMap<>();
		map.put("restId", restId);
		map.put("start", start);
		map.put("pageRow", pageRow);
		List<RestCommentVO> list = service.selectRestCommentListByRestId(map);
		return list;
	}
	
	// 코멘트 카운트
	@RequestMapping("/restCommentCount.do")
	@ResponseBody
	public int selectRestCommentCountByRestId(int restId){
		int commentCnt = service.selectRestCommentCountByRestId(restId);
		return commentCnt;
	}
	
	// 메뉴 카운트
	@RequestMapping("/restMenuCount.do")
	@ResponseBody
	public int selectRestMenuCountByRestId(int restId){
		int menuCnt = service.selectRestMenuCountByRestId(restId);
		return menuCnt;
	}
	
	@RequestMapping("/deleteRestMenu.do")
	@ResponseBody
	public String deleteRestMenu(int menuId, int fileId) throws Exception {
		service.deleteRestMenu(menuId, fileId);
		return "{}";
	}
	
	// 메뉴 리스트
	@RequestMapping("/restMenuList.do")
	@ResponseBody
	public List<RestMenuVO> selectRestMenuListByRestId(int restId, int mPageIdx, int mPageRow) throws Exception {
		int start = (mPageIdx-1)*mPageRow; 
		Map<String, Object> map = new HashMap<>();
		map.put("restId", restId);
		map.put("start", start);
		map.put("pageRow", mPageRow);
		List<RestMenuVO> list = service.selectRestMenuListByRestId(map);
		return list;
	}
			
	// 메뉴 등록(사진 + 메뉴내용)
	@RequestMapping(value="/restMenuInsert.do", method=RequestMethod.POST)
	@ResponseBody
	public String insertRestMenu(MultipartHttpServletRequest mRequest) throws Exception {
		// 1. 파일 업로드 처리
		// 실행되는 웹어플리케이션의 실제 경로 가져오기
		String uploadFolder = "/upload/";
		String uploadDir = servletContext.getRealPath(uploadFolder);
		
		// 경로 없으면 생성
		File f = new File(uploadDir);
		if (!f.exists()) f.mkdirs();

		
		RestFileVO restFile = null;
		// 파일정보 처리
		Iterator<String> iter = mRequest.getFileNames();
		while (iter.hasNext()) {
			String formFileName = iter.next();
			// 폼에서 파일을 선택하지 않아도 객체 생성됨
			MultipartFile mFile = mRequest.getFile(formFileName);
			// 원본 파일명
			String oriFileName = mFile.getOriginalFilename();
			// 파일TABLE에 업로드파일정보 입력
			
			if (oriFileName != null && !oriFileName.equals("")) {
				// 확장자 처리
				String ext = "";
				// 뒤쪽에 있는 . 의 위치
				int index = oriFileName.lastIndexOf(".");
				if (index != -1) {
					// 파일명에서 확장자명(.포함)을 추출
					ext = oriFileName.substring(index);
				}
				// 파일 사이즈
				long fileSize = mFile.getSize();
				// 고유한 파일명 만들기
				String realFileName = "restmenu-" + UUID.randomUUID().toString() + ext;
				// 임시저장된 파일을 원하는 경로에 저장
				String filePath = uploadDir + realFileName;
				mFile.transferTo(new File(filePath));
				// 파일 정보 객체 생성
				restFile = new RestFileVO();
				restFile.setOriFileName(oriFileName);
				restFile.setRealFileName(realFileName);
				restFile.setFilePath(uploadFolder + realFileName);
				restFile.setFileSize(fileSize);
			}

		}
		// 메뉴TABLE에 메뉴정보 입력
		RestMenuVO restMenu = new RestMenuVO();
		restMenu.setRestId(Integer.parseInt(mRequest.getParameter("restId")));
		restMenu.setMenuName(mRequest.getParameter("menuName"));
		restMenu.setWriterNo(Integer.parseInt(mRequest.getParameter("writerNo")));
		restMenu.setWriter(mRequest.getParameter("writer"));
		restMenu.setRecommend(Integer.parseInt(mRequest.getParameter("recommend")));
		restMenu.setPrice(Integer.parseInt(mRequest.getParameter("price")));
		service.insertRestMenu(restFile, restMenu);
		return "{}";
	}
	
	// 이미지 다운 컨트롤러
	@RequestMapping("/imageDown.do")
	public void downloadImage(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String path = request.getParameter("path");
		servletContext = request.getServletContext();
		String uploadPath = servletContext.getRealPath("");
		
		String defaultPath = "upload/default-user-bg.jpg";			
		
		File f = new File(uploadPath + path);
		if (!f.exists() || f.isDirectory()) {
			f = new File(uploadPath + defaultPath);
			path = defaultPath;
		};
		
		switch (path.split("\\.")[1]) {
			case "png" :
				response.setHeader("Content-Type", "image/png");
				break;
			case "gif" :
				response.setHeader("Content-Type", "image/gif");
				break;
			case "jpg" :
				response.setHeader("Content-Type", "image/jpg");
				break;
		};

		FileInputStream fis = new FileInputStream(f);
		BufferedInputStream bis = new BufferedInputStream(fis);

		OutputStream out = response.getOutputStream();
		BufferedOutputStream bos = new BufferedOutputStream(out);

		while (true) {
			int ch = bis.read();
			if (ch == -1)
				break;

			bos.write(ch);
		}

		bis.close();
		fis.close();
		bos.close();
		out.close();
	}
	
}
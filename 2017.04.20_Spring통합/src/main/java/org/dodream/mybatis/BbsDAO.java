package org.dodream.mybatis;

import java.util.*;
import org.apache.ibatis.annotations.Param;
import org.dodream.upload.UploadVO;
import org.springframework.stereotype.Repository;

@Repository
public interface BbsDAO {
	public int insert(BbsVO bbs);
	public int upload(FileVO file);
	public BbsVO read(int num);
	public List<FileVO> readFile(int num);
	public BbsVO recent(String userId);
	public List<FileVO> recentFile(String userId);
	public int update(BbsVO bbs);
	public int delete(int num);
	public Bbs listPage(int page);
	public List<BbsVO> search(@Param("category") String cat, @Param("keyword") String kw);
}
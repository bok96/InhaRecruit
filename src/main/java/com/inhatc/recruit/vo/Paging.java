package com.inhatc.recruit.vo;

public class Paging {
    private final static int pageCount = 10;
    private int blockStartNum = 0;
    private int blockLastNum = 0;
    private int lastPageNum = 0;
    private int lastBlockNum = 0;

    public int getBlockStartNum() {
        return blockStartNum;
    }
    public void setBlockStartNum(int blockStartNum) {
        this.blockStartNum = blockStartNum;
    }
    public int getBlockLastNum() {
        return blockLastNum;
    }
    public void setBlockLastNum(int blockLastNum) {
        this.blockLastNum = blockLastNum;
    }
    public int getLastPageNum() {
        return lastPageNum;
    }
    public void setLastPageNum(int lastPageNum) {
        this.lastPageNum = lastPageNum;
    }
	public int getLastBlockNum() {
		return lastBlockNum;
	}
	public void setLastBlockNum(int lastBlockNum) {
		this.lastBlockNum = lastBlockNum;
	}

    // block을 생성
    // 현재 페이지가 속한 block의 시작 번호, 끝 번호를 계산
    public void makeBlock(int curPage){
        int blockNum = 0;

        blockNum = (int)Math.floor((curPage-1)/ pageCount);
        blockStartNum = (pageCount * blockNum) + 1;
        blockLastNum = blockStartNum + (pageCount-1);
    }

    // 총 페이지의 마지막 번호
	public void makeLastPageNum(int total) {
    	if(total%pageCount == 0) { // 총 게시물이 10의 배수일 때
    		lastPageNum = (int)Math.floor(total/pageCount);
    		if(lastPageNum == 0) lastPageNum = 1;
    	}
        else {
            lastPageNum = (int)Math.floor(total/pageCount) + 1;
        }
    }
	
	public void makeLastBlockNum(int total) {
    	if(total%(pageCount*pageCount) == 0) { // 총 게시물이 10*10의 배수일 때
    		lastBlockNum = (int)Math.floor(total/(pageCount*pageCount));
    	}
        else {
            lastBlockNum = (int)Math.floor(total/(pageCount*pageCount)) + 1;
        }
	}
	
	/************************************************************************/
	
	public void makeLastPageNumColumn(int total) {
    	if(total%pageCount == 0) { // 총 게시물이 10의 배수일 때
    		lastPageNum = (int)Math.floor(total/pageCount);
    		if(lastPageNum == 0) lastPageNum = 1;
    	}
        else {
            lastPageNum = (int)Math.floor(total/pageCount) + 1;
        }
    }
	
	public void makeLastBlockNumColumn(int total) {
    	if(total%(pageCount*pageCount) == 0) { // 총 게시물이 10*10의 배수일 때
    		lastBlockNum = (int)Math.floor(total/(pageCount*pageCount));
    	}
        else {
            lastBlockNum = (int)Math.floor(total/(pageCount*pageCount)) + 1;
        }
	}

    /* 검색을 했을 때 총 페이지의 마지막 번호
    public void makeLastPageNum(String kwd) {
        BoardDAO dao = new BoardDAO();
        int total = dao.getCount(kwd);

        if( total % pageCount == 0 ) {
            lastPageNum = (int)Math.floor(total/pageCount);
        }
        else {
            lastPageNum = (int)Math.floor(total/pageCount) + 1;
        }
    } */
}
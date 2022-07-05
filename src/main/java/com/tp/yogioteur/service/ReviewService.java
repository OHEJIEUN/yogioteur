package com.tp.yogioteur.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public interface ReviewService {
	
		// 리뷰 목록
		public void ReviewList(HttpServletRequest request, Model model);
		
		
		
		// 사진 목록(사진보기)
		public ResponseEntity<byte[]> display(Long reImageNo, String type);
		
		
		// 리뷰 삽입
		public void ReviewSave(MultipartHttpServletRequest multipartRequest, HttpServletResponse response);
		
		// 리뷰 삭제
		public void removeReview(HttpServletRequest request, HttpServletResponse response);
	
		// 리뷰 하나
		public void ReviewOne(Long reviewNo, Model medel);
		
		// 첨부 파일 삭제
		public void removeReImage(Long reImageNo);
		
		// 리뷰 수정
		public void changeReview(MultipartHttpServletRequest multipartRequest, HttpServletResponse response);
		
		public void ReviewReservation(Long roomNo, Model model);
}
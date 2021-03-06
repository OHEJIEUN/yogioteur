<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../resources/js/jquery-3.6.0.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="../resources/css/reviewList.css?afterafter">
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<script>
	
	$(function(){
		$('.slideImgs').slick({
			 infinite: true,
			 slidesToShow: 2,
			  slidesToScroll: 2,
			  prevArrow : "<button type='button' class='slick-prev'><i class='fa-solid fa-angle-left fa-2x'></i></button>",
		      nextArrow : "<button type='button' class='slick-next'><i class='fa-solid fa-angle-right fa-2x'></i></button>"
		});
	})
	

	// 리뷰수정
	function fnReviewModify(mb){
		location.href='/review/reviewChangePage?reviewNo=' + $(mb).data('review_no');
	}
	//댓글 저장
	function fnReviewReply(bn){
		location.href='/reply/reviewReplySavePage?reviewNo=' + $(bn).data('review_no');
	}
	// 리뷰삭제
	 function fnReviewRemove(reviewNo){      
	       if(confirm('리뷰를 삭제할까요?')){
	          location.href='/review/reviewRemove?reviewNo=' + reviewNo;
	       }
	 }
	
	//댓글 수정
	function fnReviewReplyModify(mr){
		location.href='/reply/reviewReplyChangePage?replyNo=' + $(mr).data('reply_no')+'&reviewNo='+$(mr).data('review_no') ;
	}
	 // 댓글 삭제
	 function fnReviewReplyRemove(rpn){
		 if(confirm('댓글을 삭제할까요?')){
	          location.href='/reply/reviewReplyRemove?replyNo=' + $(rpn).data('reply_no');
	       }
	 }
	 
	
	 
</script>

</head>
<body>

   <jsp:include page="../layout/header.jsp"></jsp:include>
   
   <h1 class="rivewListTitle">리뷰목록</h1>
   
   <div class="reviewListView">

	  <br><br>
	   
	   <c:forEach items="${reviews}" var="review">
	   		
	   		<div id = "ReviewListONE">
	   			<div class="memberReview">
	   				<div class="reviewbox"> 
	   				<span class="usericon"><i class="fa-solid fa-face-smile fa-2x"></i></span>  &nbsp; &nbsp;
	   				<span class="reviewTitleName"> ${review.reviewTitle}</span><br>
	   					<div class="ReviewNomal">
		   					<c:forEach var="i" begin="1" end="5">
		   						<c:if test="${review.reviewRevNo ge i}">
			   						<span id="staro">★</span>					
		   						</c:if>
		   						<c:if test="${review.reviewRevNo lt i}">
			   						<span id="staro">☆</span>					
		   						</c:if>	
		   					</c:forEach>
	   						<br>
	   						<div class="reveiwName"><i class="fa-solid fa-user">&nbsp;</i>${review.memberName}<br></div>
	   						<div class="roomName">${review.roomName} ${review.rtType}</div><br>
	   						<div class="reviewContent">${review.reviewContent}</div><br>
	   					</div>
	   		
						<div class="slideImgs">
							<c:forEach var="reImage" items="${reImages}">
									<c:if test="${review.reviewNo eq reImage.reviewNo}">
										<div class="slideImg"><img alt="${reImage.reImageOrigin}" src="/review/display?reImageNo=${reImage.reImageNo}" width="365px" height="265px"></div>					
									</c:if>
							</c:forEach>
						</div>
						
						<div class="reviewCreated">${review.reviewCreated}</div>
						<br>
						<div class="ListBtn">
							<c:if test="${loginMember.memberId eq review.memberId || loginMember.memberId eq 'admin12'}">
				   				<input type="button" value="삭제" name="reviewRemoveBtn" onclick="fnReviewRemove(${review.reviewNo})">					
							</c:if>
							
							<c:if test = "${loginMember.memberId eq review.memberId}">
								<input type="button" value="리뷰 수정" name="reviewModifyBtn" data-review_no="${review.reviewNo}" onclick="fnReviewModify(this)">
				   			</c:if>
				   			
				   			<c:if test = "${loginMember.memberId eq 'admin12'}">
				   				<input type="button" value="댓글달기" id ="reviewReplyBtn" data-review_no="${review.reviewNo}" onclick="fnReviewReply(this)">
				   			</c:if>
						</div>
			   			<br><br>
	   				</div>
	   			</div>
					<c:forEach items="${reviewReplies}" var="reviewReply">
		   					<c:if test="${review.reviewNo eq reviewReply.reviewNo}">
					   		<div class="adminicon">Yogioteur Hotel <i class="fa-solid fa-hotel fa-2x"></i> </div>
					   			<div class="adminReply">		
			   						<div id="adminReplyList" >
					   					<div>
											${reviewReply.replyContent}
					   					</div>					
					   				</div>		   					   						
		   						</div>
									<div class="reviewReplyBtn">
										<c:if test = "${loginMember.memberId eq 'admin12'}">		   					
								   			<input type="button" id="reviewReplyRemoveBtn" value="댓글 삭제" data-reply_no="${reviewReply.replyNo}" onclick="fnReviewReplyRemove(this)">
								   			<input type="button" id="reviewReplyModifyBtn" value="댓글 수정" data-reply_no="${reviewReply.replyNo}" data-review_no="${review.reviewNo}" onclick="fnReviewReplyModify(this)">
					   					</c:if>
									</div>
		   					</c:if>
					</c:forEach>
	   		 </div>
	   </c:forEach>
   </div>
   
   
   <div class="paging">${paging}</div>
   <br><br>
   <jsp:include page="../layout/footer.jsp"></jsp:include>
   
</body>
</html>
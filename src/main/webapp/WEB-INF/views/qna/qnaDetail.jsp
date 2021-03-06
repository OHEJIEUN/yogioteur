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
<link rel="stylesheet" href="../resources/css/qnaDetail.css?af">

<script>
 
	$(function(){
		
		$('.reply_link').on('click', function(){
			//$('.reply_form').addClass('blind');
	    	$(this).parent().parent().next().toggleClass('blind');
		});
		
		fnTextareaLimitQnaReply();
		fnQnaReplyCheck();
	})
	
	function fnTextareaLimitQnaReply(){
		$('.qnaReplyContent').on('keyup', function(){
			$('.qnaReplyContent_cnt').html("(" + $(this).val().length+" / 300)");
			
			if($(this).val().length > 300){
				$(this).val($(this).val().substring(0,300));
				$('.qnaReplyContent_cnt').html("(300 / 300)" );
			}
			
		})
		
		$('.qnaReplyContentAdd').on('keyup', function(){
			$('.qnaReplyContentAdd_cnt').html("(" + $(this).val().length+" / 300)");
			
			if($(this).val().length > 300){
				$(this).val($(this).val().substring(0,300));
				$('.qnaReplyContentAdd_cnt').html("(300 / 300)" );
			}
			
		})
		
		
	}
	
	function fnQnaReplyCheck(){
		
		$('.qnaReplyData').on('submit', function(ev){
			if($('.memberId').val() == '' ){
				alert('로그인 후 작성가능합니다.');
				ev.preventDefault();
				return false;
			} 
			else if($('#qnaReplyContent').val() == ''){
				alert('댓글을 작성해주세요');
				ev.preventDefault();
				return false;
			} 
			return true;
		})
		
		
		$('.replyadd').on('submit', function(ev){
			 
			if($('.memberId').val() == '' ){
				alert('로그인 후 작성가능합니다.');
				ev.preventDefault();
				return false;
			} else if($(this).find('.qnaReplyContentAdd').val() == ''){
				alert('댓글을 작성해주세요');
				ev.preventDefault();
				return false;
			}
			return true;
		})
	}
    
	
	function fnRemoveA(qnaReplyNo, qnaNo){      
		
        if(confirm('게시글을 삭제할까요?')){
           location.href='/qnaReply/qnaReplyRemove?qnaReplyNo=' + qnaReplyNo +'&qnaNo=' +qnaNo;
        }
  }
	

	
</script>


</head>
<body>
   
   <jsp:include page="../layout/header.jsp"></jsp:include>
   
   <div class="qnaDetailOne">
   
	  <h1>QnA 상세보기</h1>
	  
	  <a class="toQnaList" href="/qna/qnaList">목록으로</a>
	  
	  <div class="qnaDeatilName"><i class="fa-solid fa-user"></i>  ${qna.memberName}</div>
	  <hr>
		
		 	
		  		<div class="qnaDatailDate">
		  			작성일 	: ${qna.qnaCreated}
		  		<c:if test="${qna.qnaCreated < qna.qnaModified}<br>">
		  			수정일 : ${qna.qnaModified}<br>
		  		</c:if>
		  		</div>
		  		<div class="qnaDetailTitle">${qna.qnaTitle}</div>
		  		<div class="qnaDetailHit">조회수 : ${qna.qnaHit}<br><br></div>
		  		
		  		<div class="qnaDetailContent">${qna.qnaContent}</div><br>
		 		
		 		<c:if test="${loginMember.memberId eq qna.memberId}">	 		
			 		<a class="qnaDtailA"  href="/qna/qnaUpdatePage?qnaNo=${qna.qnaNo}">수정하기</a>
		 		</c:if>
		 	
		 	<br><br>
		 	
		 	<form class="qnaReplyData" method="post" action="/qnaReply/qnaReplySave">
		 		<input type="hidden" name="qnaNo" value="${qna.qnaNo}">
			  	<input type="hidden" id="memberId" class="memberId" name="memberId" value="${loginMember.memberId}">		  
			  	<input type="hidden" name="memberName" value="${loginMember.memberName}">		  
			  	<textarea rows="10" cols="50" class="qnaReplyContent" id="qnaReplyContent" name="qnaReplyContent"></textarea><br>
			  	<div class ="qnaReplyContent_cnt">
				  	<div class="qnaReplyContent_cnt" id="qnaReplyContent_cnt">(0 / 300)</div><br>
			  	</div>
				  	<button id="qnaReplyAddBtn">댓글 달기</button>
			</form>
		 	
			
		 
		  
		  <br><br>
		
		 <c:forEach items="${qnaReplies}" var="qnaReply">
		 	<table class="replyTable" >
				<tbody>
			 		<c:if test="${qnaReply.qnaReplyState == -1}">
						<tr>
							<td>이름 : ${qnaReply.memberName}</td>
							<td>삭제된 댓글입니다</td>
						</tr>
					</c:if>
					<c:if test="${qnaReply.qnaReplyState == 1}">
						<tr>
							<td width="20%">이름 : ${qnaReply.memberName}</td>
							<td>
								<!-- Depth만큼 들여쓰기(Depth 1 == Space 2) -->
								<c:forEach begin="1" end="${qnaReply.qnaReplyDepth}" step="1">&nbsp;&nbsp;&nbsp;&nbsp;</c:forEach>
								<!-- 댓글은 re 표시 -->
								<c:if test="${qnaReply.qnaReplyDepth gt 0}"><i class="fa-solid fa-l"></i></c:if>
								<!-- 내용 -->
								<c:if test="${qnaReply.qnaReplyContent.length() gt 200}">								
									${qnaReply.qnaReplyContent.substring(0, 200)}
								</c:if>
								<c:if test="${qnaReply.qnaReplyContent.length() le 200}">								
									${qnaReply.qnaReplyContent}
								</c:if>
								<!-- 답글달기(if 있으면 1단 댓글만 허용, if 없으면 다단 댓글 허용) -->
													
							</td>
							<td width="16%">${qnaReply.qnaReplyCreated}</td>
							<td width="6%"><a class="reply_link">답글</a></td>	
							<td width="6%">
								<c:if test = "${loginMember.memberId eq qnaReply.memberId || loginMember.memberId eq 'admin12'}">
									<input type="button" class="replayDel2Btn" value="삭제" onclick="fnRemoveA(${qnaReply.qnaReplyNo}, ${qna.qnaNo})">
								</c:if>
							</td>
						</tr>
						<tr class="reply_form blind">
							<td colspan="5">
								<form class="replyadd" action="/qnaReply/qnaReplySaveSecond" method="post">
									<input type="hidden" name="qnaNo" value="${qna.qnaNo}" >
									<input type="hidden" id="memberId" class="memberId" name="memberId" value="${loginMember.memberId}" readonly>
									<input type="text" class="memberName" name="memberName" value="${loginMember.memberName}"  readonly>&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="text" class="qnaReplyContentAdd" id="qnaReplyContentAdd" name="qnaReplyContent" placeholder="댓글을 입력해주세요">
									<div class="qnaReplyContentAdd_cnt" id="qnaReplyContentAdd_cnt">(0 / 300)</div>
					
									<!-- 원글의 Depth, GroupNo, GroupOrd -->
									<input type="hidden" name="qnaReplyDepth" value="${qnaReply.qnaReplyDepth}">
									<input type="hidden" name="qnaReplyGroupNo" value="${qnaReply.qnaReplyGroupNo}">
									<input type="hidden" name="qnaReplyGroupOrd" value="${qnaReply.qnaReplyGroupOrd}">
									<button class="replyAdd2Btn">답글달기</button>
								</form>
							</td>
						</tr>
					</c:if>
				</tbody>
		 	 </table>
		 </c:forEach>   			
	</div>		   		
	   <br><br>
	  <jsp:include page="../layout/footer.jsp"></jsp:include>
	  	
	    
  		
</body>
</html>
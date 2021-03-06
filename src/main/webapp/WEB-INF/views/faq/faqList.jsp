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
<link href="https://fonts.googleapis.com/css2?family=Kaushan+Script&family=Pacifico&display=swap" rel="stylesheet">
<link rel="stylesheet" href="../resources/css/faq.css">

   

<script>
   
   $(function(){
      fnListSelect();
      fnOpenCloseAnswer();
   })
   function fnRemove(no){      
         if(confirm('삭제할까요?')){
            location.href='/faq/remove?faqNo=' + $(no).data('faq_no');
         }
   }
   
   function fnListSelect(){
      $('#faqListSel').on('click', function(){
         location.href="/faq/faqList";
      })
   }
   
   
   function fnOpenCloseAnswer(a){
      const answerId = 'ans_'+$(a).data('faq_detail_no');
      const btnIcon = 'que_'+$(a).data('faq_detail_no');
       if(document.getElementById(answerId).style.display == 'block') {
         document.getElementById(answerId).style.display = 'none';
         document.getElementById(btnIcon).innerHTML = '<i class="fa-solid fa-angle-down"></i>';
         
         
       } else {
         document.getElementById(answerId).style.display = 'block';
         document.getElementById(btnIcon).innerHTML = '<i class="fa-solid fa-angle-up"></i>';
         
       }
   }
    
</script>

</head>
<body>
   <div class="faqListOne">
	   <c:if test = "${loginMember.memberId eq 'admin12'}">
		   <a class="faqA" href="/faq/faqSavePage">새글작성</a>   	
	   </c:if>
	   
	   <input type="button" value="목록보기" id="faqListSel">
	   
	      <div id="faqUl">
	            <c:forEach items="${faqs}" var="faq">
	               <div class="listOne">
	                  <div class = "question" >
	                     ${faq.faqTitle}
	                     	<c:if test = "${loginMember.memberId eq 'admin12'}">
	                     		<button type="button" class="faqDelBtn" value="삭제" data-faq_no = "${faq.faqNo}" onclick="fnRemove(this)"><i class="fa-solid fa-x"></i></button>
	                     	</c:if>
	                     	<button type="button" class="faqDetailBtn" id="que_${faq.faqNo}" data-faq_detail_no = "${faq.faqNo}" onclick="fnOpenCloseAnswer(this)" value = "상세내용 보기"><i class="fa-solid fa-angle-down"></i></button>               
	                  </div>
	                  <div class ="answer" id="ans_${faq.faqNo}" style="display:none;">${faq.faqContent}</div>
	               </div>
	             
	            </c:forEach>
	      </div>
   
   		<br>
         <div class="noList">${paging}</div>
        <br>    
   </div>

	
</body>
</html>
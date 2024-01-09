<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.ArrayList,dto.BookBean"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
<title>書籍検索システム</title>
</head>
<body>
<main class="m-5">
		<div class="container　ml-5 mr-5">
			<div class="row justify-content-center">
				<div class="col-6">
					<%
						//渡されたidに基づく商品詳細を取得
						BookBean book = (BookBean) request.getAttribute("book");
						if(book != null){
					%>
					<a href="edit" class="mb-3" style="display: inline-block">
						<div class="border text-center" style="width: 50px;">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-left" viewBox="0 0 16 16">
			  					<path fill-rule="evenodd" d="M15 8a.5.5 0 0 0-.5-.5H2.707l3.147-3.146a.5.5 0 1 0-.708-.708l-4 4a.5.5 0 0 0 0 .708l4 4a.5.5 0 0 0 .708-.708L2.707 8.5H14.5A.5.5 0 0 0 15 8z"/>
							</svg>
						</div>
					</a>
					<br>
					<h2>書籍情報編集</h2>
					<br>
							<div id="error-message-container" class="alert alert-danger d-none"></div>
							<!-- ここから入力フォーム  -->
							<form action="edit" method="post">

								<div class="mb-3">
								    <label for="janCd" class="form-label">JANコード</label>
								    <input type="text" class="form-control" id="janCd" name="janCd" maxlength="13" required value="<%= book.getJanCd() %>" >
								    <% String janCd = (String)request.getAttribute("janCd");
									 if (janCd != null) {
							 	 	%>
						              <div class="d-flex flex-wrap" style="display: flex; justify-content: start; margin-bottom: 30px; color: #FF0000;">
											<%= janCd %>
									  </div>
								  <% } %>
							 	</div>

								<div class="mb-3">
								    <label for="isbnCd" class="form-label">ISBNコード</label>
								    <input type="text" class="form-control" id="isbnCd" name="isbnCd" maxlength="13" required value="<%= book.getIsbnCd() %>" >
								    <% String isbnCd = (String)request.getAttribute("isbnCd");
									 if (isbnCd != null) {
							 	 	%>
						              <div class="d-flex flex-wrap" style="display: flex; justify-content: start; margin-bottom: 30px; color: #FF0000;">
											<%= isbnCd %>
									  </div>
								  <% } %>
							 	</div>

								<div class="mb-3">
								    <label for="bookNm" class="form-label">書籍名称</label>
								    <input type="text" class="form-control" id="bookNm" name="bookNm" maxlength="500" required value="<%= book.getBookNm() %>" >
								    <% String bookNm = (String)request.getAttribute("bookNm");
									 if (bookNm != null) {
							 	 	%>
						              <div class="d-flex flex-wrap" style="display: flex; justify-content: start; margin-bottom: 30px; color: #FF0000;">
											<%= bookNm %>
									  </div>
								  <% } %>
							 	</div>

								<div class="mb-3">
								    <label for="bookKana" class="form-label">書籍名称カナ</label>
								    <input type="text" class="form-control" id="bookKana" name="bookKana" maxlength="500" required value="<%= book.getBookKana() %>" >
								    <% String bookKana = (String)request.getAttribute("bookKana");
									 if (bookKana != null) {
							 	 	%>
						              <div class="d-flex flex-wrap" style="display: flex; justify-content: start; margin-bottom: 30px; color: #FF0000;">
											<%= bookKana %>
									  </div>
								  <% } %>
							 	</div>

								<div class="mb-3">
								    <label for="price" class="form-label">金額</label>
								    <input type="text" class="form-control" id="price" name="price" maxlength="11" required value="<%= NumberFormat.getNumberInstance().format(book.getPrice()) %>" >
								    <% String price = (String)request.getAttribute("price");
									 if (price != null) {
							 	 	%>
						              <div class="d-flex flex-wrap" style="display: flex; justify-content: start; margin-bottom: 30px; color: #FF0000;">
											<%= price %>
									  </div>
								  <% } %>
							 	</div>

								<div class="mb-3">
								    <label for="issueDate" class="form-label">発行日</label>
								    <input type="date" class="form-control" id="issueDate" name="issueDate" maxlength="11" required value="<%= book.getIssueDate() %>" >
								    <% String issueDate = (String)request.getAttribute("issueDate");
									 if (issueDate != null) {
							 	 	%>
						              <div class="d-flex flex-wrap" style="display: flex; justify-content: start; margin-bottom: 30px; color: #FF0000;">
											<%= issueDate %>
									  </div>
								  <% } %>
							 	</div>


							 	<br>
							 	<input type=hidden name="crJanCd" value=<%= book.getJanCd() %>>
								<button type=submit class="btn btn-primary">更新する</button>
							</form>
						<% } %>
				</div>
			</div>
		</div>
</main>
<script src="./js/script.js"></script>
</body>
</html>






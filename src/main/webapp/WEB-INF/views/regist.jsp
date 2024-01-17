<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.ArrayList,dto.BookBean"%>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.sql.Date" %>
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
					<a href="edit" class="mb-3" style="display: inline-block">
						<div class="border text-center" style="width: 50px;">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-left" viewBox="0 0 16 16">
			  					<path fill-rule="evenodd" d="M15 8a.5.5 0 0 0-.5-.5H2.707l3.147-3.146a.5.5 0 1 0-.708-.708l-4 4a.5.5 0 0 0 0 .708l4 4a.5.5 0 0 0 .708-.708L2.707 8.5H14.5A.5.5 0 0 0 15 8z"/>
							</svg>
						</div>
					</a>
					<br>
					<h2>書籍登録</h2>
					<br>
					<div class="col-6 d-flex justify-content-end mb-3">
						<button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#registAllBook">
						    一括登録はこちら
						</button>
					 </div>
					<%
						BookBean book = (BookBean) request.getAttribute("book");
					%>
							<div id="error-message-container" class="alert alert-danger d-none"></div>
							<!-- ここから入力フォーム  -->
							<form action="regist" method="post">
								<div class="mb-3">
								<!-- バリデーション確認のため、敢えてrequired消してます -->
								    <label for="janCd" class="form-label">JANコード</label>
								    <input type="text" class="form-control" id="janCd" name="janCd" maxlength="13" value="<%= book.getJanCd() != null ? book.getJanCd() : "" %>" >
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
								    <input type="text" class="form-control" id="isbnCd" name="isbnCd" maxlength="13" required value="<%= book.getIsbnCd() != null ? book.getIsbnCd() : "" %>" >
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
								    <input type="text" class="form-control" id="bookNm" name="bookNm" maxlength="500" required value="<%= book.getBookNm() != null ? book.getBookNm() : "" %>" >
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
								    <input type="text" class="form-control" id="bookKana" name="bookKana" maxlength="500" required value="<%= book.getBookKana() != null ? book.getBookKana() : "" %>" >
								    <% String bookKana = (String)request.getAttribute("bookKana");
									 if (bookKana != null) {
							 	 	%>
						              <div class="d-flex flex-wrap" style="display: flex; justify-content: start; margin-bottom: 30px; color: #FF0000;">
											<%= bookKana %>
									  </div>
								  <% } %>
							 	</div>

								<div class="mb-3">
								<!-- バリデーション確認のため、敢えてrequired消してます -->
								    <label for="price" class="form-label">金額</label>
								    <%
								    String crPrice = (String) NumberFormat.getNumberInstance().format(book.getPrice());
								    %>
								    <input type="text" class="form-control" id="price" name="price" maxlength="11" value="<%= crPrice.equals("-1") ? "" : crPrice %>" >
								    <% String price = (String)request.getAttribute("price");
									 if (price != null) {
							 	 	%>
						              <div class="d-flex flex-wrap" style="display: flex; justify-content: start; margin-bottom: 30px; color: #FF0000;">
											<%= price %>
									  </div>
								  <% } %>
							 	</div>

								<div class="mb-3">
									<%
								    DateTimeFormatter formatter1 = DateTimeFormatter.ofPattern("yyyy-MM-dd");
									String formattedIssueDate = null;
									if(book.getIssueDate() != null){
								    LocalDate issueDate = book.getIssueDate();
								    formattedIssueDate = issueDate.format(formatter1);
									}
								    %>
								    <label for="issueDate" class="form-label">発行日</label>
								    <input type="date" class="form-control" id="issueDate" name="issueDate" maxlength="11" required value="<%=formattedIssueDate != null ? formattedIssueDate : ""%>" >
								    <% String issuedDate = (String)request.getAttribute("issueDate");
									 if (issuedDate != null) {
							 	 	%>
						              <div class="d-flex flex-wrap" style="display: flex; justify-content: start; margin-bottom: 30px; color: #FF0000;">
											<%= issuedDate %>
									  </div>
								  <% } %>
							 	</div>


							 	<br>
							 	<% String crJanCd = (String) request.getAttribute("crJanCd"); %>
							 	<input type=hidden name="crJanCd" value=<%= crJanCd %>>
								<button type=submit class="btn btn-primary">登録する</button>
							</form>
				</div>
			</div>
		</div>

		<!-- モーダルウィンドウ1 -->
		<div class="modal fade" id="registAllBook" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered w-100">
				<div class="modal-content" id="modalWindow" style="width:100%;">
					<div class="modal-header">
						<small class="ms-2">一括登録</small>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<form action="registBulk" method="post" enctype="multipart/form-data">
					<div class="modal-body p-5 d-flex flex-wrap">
					    <small>
					        参照するExcelファイルを選択してください(2MB.xlmxのみ)
					    </small>
					        <input type="file" name="file" accept=".csv, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet">
					</div>
					<div class="modal-footer">
						<button type="submit" class="btn btn-outline-danger"
							style="border-radius: 5px;">
							OK
						</button>
					</div>
					</form>
				</div>
			</div>
		</div>

</main>
<script src="./js/script.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
</body>
</html>






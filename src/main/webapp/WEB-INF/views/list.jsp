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
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
<link rel="stylesheet"  href="./css/style.css">
<style>
.arrow:hover{opacity: 0.7;}
</style>
<title>書籍検索システム</title>
</head>
<body>
	<main>
		<div class="container mt-5">
			<div class="row">
					<div class="col-12">
						<div class="justify-content-center">
							<div>
								<form action="edit" method="get">
									<div class="mb-4" style="display: flex; align-items: end;">
									    <h5 class="mb-0 me-3"><strong>書籍検索システム</strong></h5>
									</div>
										<h6>商品をダブルクリックで編集</h6>
									<!-- 各種メッセージ -->
									<%
									    // リクエストからmessage属性を取得
									    String message = (String) request.getAttribute("message");
									    // messageがnullでない場合にのみ表示
									    if (message != null) {
									%>
									        <div class="alert alert-danger" role="alert">
									            <%= message %>
									        </div>
									<%
									    }
									%>

									<div class="overflow-auto border" style="height: 80vh; border-radius:5px;">
										<%
										 ArrayList<BookBean> bookList = (ArrayList<BookBean>) request.getAttribute("bookList");
								   		 if(bookList != null && bookList.size() > 0){
									   	%>
											<table class="table table-borderless st-tbl1 text-center" id="itemTable">
												<thead>
												    <tr>
												      <th scope="col" class="text-nowrap py-4 ps-4"><small>#</small></th>
												      <th scope="col" class="text-nowrap py-4"><small>JANコード</small></th>
												      <th scope="col" class="text-nowrap py-4"><small>ISBNコード</small></th>
												      <th scope="col" class="text-nowrap py-4"><small>書籍名称</small></th>
												      <th scope="col" class="text-nowrap py-4"><small>書籍名称カナ</small></th>
												      <th scope="col" class="text-nowrap py-4"><small>価格</small></th>
												      <th scope="col" class="text-nowrap py-4"><small>発行日</small></th>
												      <th scope="col" class="text-nowrap py-4"><small>登録日時</small></th>
												      <th scope="col" class="text-nowrap py-4"><small>更新日時</small></th>
												    </tr>
												</thead>
												<tbody>
												<%
												int counter = 1;
												for(BookBean book : bookList){
													DateTimeFormatter formatter1 = DateTimeFormatter.ofPattern("yyyy/MM/dd");
													DateTimeFormatter formatter2 = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm");

												%>
													<tr style="cursor: pointer;" onclick="changeColor(this)"
														ondblclick="location.href='edit?janCd=<%=book.getJanCd()%>'">
														<td class="ps-4" style="vertical-align: middle;">
															<small><%=counter%></small>
														</td>
														<td class="td" style="width: 60px; vertical-align: middle;">
															<small><%=book.getJanCd()%></small>
														</td>
														<td style="vertical-align: middle;">
															<small><%=book.getIsbnCd()%></small>
														</td>
														<td style="vertical-align: middle;">
															<small><%=book.getBookNm()%></small>
														</td>
														<td style="vertical-align: middle;">
															<small><%=book.getBookKana()%></small>
														</td>
														<td style="vertical-align: middle;">
															<small><%=NumberFormat.getNumberInstance().format(book.getPrice())%></small>
														</td>
														<td style="vertical-align: middle;" class="text-nowrap">
															<%
															LocalDate issueDate = new java.sql.Date(book.getIssueDate().getTime()).toLocalDate();
														    LocalDateTime issueDateTime = issueDate.atStartOfDay();
														    String formattedIssueDate = issueDateTime.format(formatter1);
															%>
															<small><%=formattedIssueDate%></small>
														</td>
														<td style="vertical-align: middle;">
															<%
															LocalDateTime createDateTime = book.getCreateDate();
															String formattedCreateDate = "";
															if (createDateTime != null) {
															    formattedCreateDate = createDateTime.format(formatter2);
															}
															%>
															<small><%=formattedCreateDate%></small>
														</td>
														<td class="pe-4" style="vertical-align: middle;">
															<%
															String formattedUpdateDate = "";
															if (book.getUpdateDate() != null) {
															    LocalDateTime updateDateTime = book.getUpdateDate();
															    formattedUpdateDate = updateDateTime.format(formatter2);
															%>
															<small><%=formattedUpdateDate%></small>
															<% } else { %>
															<small>-</small>
															<% } %>
														</td>
													</tr>
												<%
												 counter++;
												}
												%>
												</tbody>
											</table>
										<%
										} else {
										%>
											<div class="d-flex justify-content-center align-items-center" style="height:100%;">
												<p class="mb-0" style="color: lightgray;">該当する本がありません</p>
											</div>
										<%
										}
										%>
									</div>
									<br>
						</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>
	<script src="./js/script.js"></script>
</body>
</html>
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
							<div class="mb-4" style="display: flex; align-items: end;">
							    <h5 class="mb-0 me-3"><strong>書籍検索システム</strong></h5>
							</div>
							<div class="row mb-3">
							  <div class="col-6">
							    <h6>商品をダブルクリックで編集</h6>
							  </div>
							  <div class="col-6 d-flex justify-content-end mb-3">
							    <a href="regist" class="btn btn-primary">新規登録</a>
							  </div>
							</div>

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
							<div class="modal-footer d-flex justify-content-start">
								<button type="button" class="btn btn-outline-danger" id="selectAll">全て選択</button>
							</div>
									<div class="overflow-auto border" style="height: 70vh; border-radius:5px;">
										<%
										 ArrayList<BookBean> bookList = (ArrayList<BookBean>) request.getAttribute("bookList");
								   		 if(bookList != null && bookList.size() > 0){
									   	%>
											<table class="table table-borderless st-tbl1 text-center" id="itemTable">
												<thead>
												    <tr>
												      <th scope="col" class="text-nowrap py-4 ps-4"><small>#</small></th>
												      <th scope="col" class="text-nowrap py-4 ps-4"><small>No.</small></th>
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
												<form action="delete" method="post">
												<%
												int counter = 1;
												for(BookBean book : bookList){
													DateTimeFormatter formatter1 = DateTimeFormatter.ofPattern("yyyy/MM/dd");
													DateTimeFormatter formatter2 = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm");

												%>
													<tr style="cursor: pointer;" onclick="changeColor(this)"
														ondblclick="location.href='edit?janCd=<%=book.getJanCd()%>'">
														<td class="pe-4" style="vertical-align: middle;">
															<!-- チェックボックス -->
															<input type="checkbox" name="bookStatus" id="item_<%=book.getJanCd()%>" value="<%=book.getJanCd()%>">
														</td>
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
															LocalDate issueDate = book.getIssueDate();
														    String formattedIssueDate = issueDate.format(formatter1);
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
												<!-- モーダルウィンドウ1 -->
												<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
													<div class="modal-dialog modal-dialog-centered w-100">
														<div class="modal-content" id="modalWindow" style="width:100%;">
															<div class="modal-header">
																<small class="ms-2">アイテムの削除</small>
																<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
															</div>
															<div class="modal-body p-5 d-flex flex-wrap">
																<small>
																	チェックした商品を削除します。<br>
																	本当によろしいですか。
																</small>
															</div>
															<div class="modal-footer">
																<button type="submit" class="btn btn-outline-danger"
																	style="border-radius: 5px;">
																	OK
																</button>
															</div>
														</div>
													</div>
												</div>

												</form>
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
							<button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
							    削除
							</button>
					</div>
				</div>
			</div>
		</div>

		<!--　完了モーダル -->
		<%
	    String showModalString = (String) request.getAttribute("showModal");
	    Boolean showModal = Boolean.parseBoolean(showModalString);
	    String successMsg = (String) request.getAttribute("successMsg");
		%>
			<div id="modalTrigger" data-show-modal="<%= showModal %>"></div>
			<!-- ポップアップ１：オプションを追加 -->
			<div class="modal fade" id="modalOptionAdd" tabindex="-1"
				aria-labelledby="modalLabel" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header">
							<small class="modal-title" id="modalLabel">更新結果</small>
						</div>
						<!-- フォーム内容 -->
						<div class="modal-body">
							<div class="mb-3">
								<%= successMsg %>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-success" data-bs-dismiss="modal">確認</button>
						</div>
						<!-- フォームここまで -->
					</div>
				</div>
			</div>

		<!-- モーダルウィンドウここまで -->
	</main>
	<script src="./js/script.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
</body>
</html>
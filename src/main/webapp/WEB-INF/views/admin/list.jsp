<%@page import="dto.ItemCategoryBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.ArrayList,dto.ItemBean,dto.ItemCategoryBean"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
<link rel="stylesheet"  href="./css/deleteItemIndex.css">
<style>
.arrow:hover{opacity: 0.7;}
</style>
<title>donko</title>
</head>
<body>
	<%@include file= "../component/adminheader.jsp" %>
	<%@include file= "../component/adminheaderTopSpace.jsp" %>
	<main>
		<div class="container mt-5">
			<div class="row">
					<div class="col-3 d-flex flex-wrap">
						<!-- ここから入力フォーム  -->
						<form action="deleteItemIndex" method="get">
								<div class="mx-1 mb-4">
									<%
									    ArrayList<ItemCategoryBean> categoryList = (ArrayList<ItemCategoryBean>) request.getAttribute("categoryList");
									    Integer itemDelFlg = (Integer) request.getAttribute("itemDelFlg");
									    String categoryName = (String) request.getAttribute("categoryName");
									    String sortOrder = (String) request.getAttribute("order");
									    String keyword = (String) request.getAttribute("keyword");
									%>
									<!-- カテゴリでソート -->
									<label for="category-select" class="form-label"><small>カテゴリ選択：</small></label>
									<select class="form-select" id="category-select" name="itemCategoryName">
									    <%
									        if(categoryList != null && itemDelFlg != null && !categoryName.isEmpty()){
									            for(ItemCategoryBean category : categoryList){
									                boolean isSelected = category.getItemCategoryName().equals(categoryName);
									    %>
									                <option value="<%= category.getItemCategoryName() %>" <%= isSelected ? "selected" : "" %>><%= category.getItemCategoryName() %></option>
									    <%
									            }
									        }
									    %>
									</select>
								</div>
								<div class="mx-1 mb-4">
									<!-- 削除フラグでソート -->
									<label for="delFlg-select" class="form-label"><small>現在の表示：</small></label>
										<div id="delFlg-select">
										    <div class="form-check">
										        <input class="form-check-input" type="radio" name="itemDelFlg" id="delFlgAll" value="2" <%= itemDelFlg == 2 ? "checked" : "" %>>
										        <label class="form-check-label" for="delFlgAll">全て</label>
										    </div>
										    <div class="form-check">
										        <input class="form-check-input" type="radio" name="itemDelFlg" id="delFlgActive" value="0" <%= itemDelFlg == 0 ? "checked" : "" %>>
										        <label class="form-check-label" for="delFlgActive">販売中</label>
										    </div>
										    <div class="form-check">
										        <input class="form-check-input" type="radio" name="itemDelFlg" id="delFlgInactive" value="1" <%= itemDelFlg == 1 ? "checked" : "" %>>
										        <label class="form-check-label" for="delFlgInactive">停止中</label>
										    </div>
										</div>
								</div>
								<div class="mx-1 mb-4">
									<label for="order-select" class="form-label"><small>並び順：</small></label>
								    <div id="order-select">
								        <div class="form-check">
								            <input class="form-check-input" type="radio" name="order" id="orderAsc" value="asc" <%= "asc".equals(sortOrder) ? "checked" : "" %>>
								            <label class="form-check-label" for="orderAsc">昇順</label>
								        </div>
								        <div class="form-check">
								            <input class="form-check-input" type="radio" name="order" id="orderDesc" value="desc" <%= "desc".equals(sortOrder) ? "checked" : "" %>>
								            <label class="form-check-label" for="orderDesc">降順</label>
								        </div>
								    </div>
							    </div>
							    <div class="mx-1 mb-4">
								    <!-- キーワード検索の入力ボックス -->
								    <label for="keyword-search" class="form-label">キーワード検索：</label>
								    <input type="text" class="form-control" id="keyword-search" name="keyword" placeholder=<%= keyword == null ? "キーワードを入力" : "" %>>
								</div>
								<div class="m-1 d-flex align-items-center">
									<button type="submit" class="button-purple w-100 mt-5 py-2" style="border-radius:5px;">
										絞り込む
									</button>
								</div>
						</form>
					</div>

					<div class="col-9">
						<!-- 各種メッセージ -->
						<%
						    // リクエストからmessage属性を取得
						    String message = (String) request.getAttribute("message");
						    // messageがnullでない場合にのみ表示
						    if (message != null) {
						%>
						        <div class="alert alert-success" role="alert">
						            <%= message %>
						        </div>
						<%
						    }
						%>
						<!-- 商品一覧を掲載 -->
						<div class="justify-content-center">
							<div>
								<!-- ここから削除切り替えフォーム  -->
								<form action="deleteItemIndex" method="post">
									<div class="mb-4" style="display: flex; align-items: end;">
									    <h5 class="mb-0 me-3"><strong>削除商品一覧</strong></h5>
									    <small class="mx-3" style="vertical-align: middle;">
									  		ダブルクリックで商品を編集
									    </small>
								   		<%
								   		if(keyword != null && !keyword.equals("")){
										%>
											<div class="col-lg-3 border mt-2 ms-auto px-3 py-2 w-auto" style="display: inline-flex; align-items: center; border-radius:5%; box-shadow:5px 5px 5px lightgray;">
												<p class="mb-0" style="display: flex; align-items: center;">キーワード検索：　<%= keyword %></p>
											</div>
										<% 
										}	
								   		%>
									</div>

									<div class="overflow-auto border" style="height: 68vh; border-radius:5px;">
										<%
									    ArrayList<ItemBean> itemList = (ArrayList<ItemBean>) request.getAttribute("itemList");
									   	if(itemList != null && itemList.size() > 0){
									   	%>	
									   		<div id="top"></div>
											<table class="table table-borderless st-tbl1 text-center" id="itemTable">
												<thead>
												    <tr>
												      <th scope="col" class="text-nowrap py-4 ps-4"><small>ID</small></th>
												      <th scope="col" class="text-nowrap py-4"><small>画像</small></th>
												      <th scope="col" class="text-nowrap py-4"><small>商品名</small></th>
												      <th scope="col" class="text-nowrap py-4"><small>カテゴリ</small></th>
												      <th scope="col" class="text-nowrap py-4"><small>オプション1</small></th>
												      <th scope="col" class="text-nowrap py-4"><small>オプション2</small></th>
												      <th scope="col" class="text-nowrap py-4"><small>金額</small></th>
												      <th scope="col" class="text-nowrap py-4"><small>在庫数</small></th>
												      <th scope="col" class="text-nowrap py-4"><small>ステータス</small></th>
												      <th scope="col" class="text-nowrap py-4 pe-4"></th>
												    </tr>
												</thead>
												<tbody>
												<%
												for(ItemBean item : itemList){
												%>
													<tr style="cursor: pointer;" onclick="changeColor(this)"
														ondblclick="location.href='editItemInfo1?itemId=<%=item.getItemId()%>'">
														<td class="ps-4" style="vertical-align: middle;">
															<!-- ID --> <small><%=item.getItemId()%></small>
														</td>
														<td class="td" style="width: 60px; vertical-align: middle;">
															<span class="card" style="width: 60px; height: 60px;">
																<img src="./images/<%=item.getImageFileName()%>.jpg"
																class="card-img-top" alt="<%=item.getImageFileName()%>"
																style="object-fit: cover; height: 100%; display: block;">
														</span>
														</td>
														<td style="vertical-align: middle;">
															<!-- 商品名 --> <small><%=item.getItemName()%></small>
														</td>
														<td style="vertical-align: middle;">
															<!-- カテゴリー --> <small><%=item.getItemCategoryName()%></small>
														</td>
														<td style="vertical-align: middle;">
															<!-- オプション1 --> <small><%=item.getItemFirstOptionValue()%></small>
														</td>
														<td style="vertical-align: middle;">
															<!-- オプション2 -->
															<%
															if (item.getItemSecondOptionValue() != null && !item.getItemSecondOptionValue().isEmpty()) {
															%>
																<small><%=item.getItemSecondOptionValue()%></small>
															<%
															} else {
															%>
																 -
															<%
															}
															%>
														</td>
														<td style="vertical-align: middle;" class="text-nowrap">
															<!-- 金額 -->
															<%
		 													NumberFormat formatter = NumberFormat.getInstance();
		 													String formattedPrice = formatter.format(item.getItemPrice());
		 													%>
		 													<small>￥ <%=formattedPrice%></small>
														</td>
														<td style="vertical-align: middle;">
															<!-- 在庫 -->
															<small><%=item.getItemStock()%></small>
														</td>
														<td style="vertical-align: middle;">
															<!-- ステータス -->
															<%
															 if (item.isDeleted()) {
															 %> <small class="mb-0" style="color: #CCC;">停止中</small> <%
															 } else {
															 %> <small class="mb-0" style="color: royalblue;">販売中</small> <%
															 }
															 %>
														</td>
														<td class="pe-4" style="vertical-align: middle;">
															<!-- チェックボックス --> <input type="checkbox" name="itemStatus"
															id="item_<%=item.getItemId()%>"
															value="<%=item.getItemId()%>">
														</td>
													</tr>
												<%
												}
												%>
												</tbody>
											</table>
											<% 
											if(itemList.size() > 7) {
											%>
											<span id="back">
											    <a href="#top"  style="text-decoration:none;">
											      <div class="d-flex justify-content-center border mb-3 mx-auto" 
											           style="width:95%; height:50px; line-height:50px; background-color:lightsteelblue; border-radius:5px;">
														<small class="mb-0 text-dark">一覧のトップへ戻る
															<svg
																xmlns="http://www.w3.org/2000/svg" width="16" height="16"
																fill="currentColor" class="bi bi-arrow-up-circle"
																viewBox="0 0 16 16">
									 							 <path fill-rule="evenodd"
																	d="M1 8a7 7 0 1 0 14 0A7 7 0 0 0 1 8zm15 0A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-7.5 3.5a.5.5 0 0 1-1 0V5.707L5.354 7.854a.5.5 0 1 1-.708-.708l3-3a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1-.708.708L8.5 5.707V11.5z" />
															</svg>
														</small>
													</div>
											    </a>
											</span>
											<% 
											}
											%>
										<%
										} else {
										%>
											<div class="d-flex justify-content-center align-items-center" style="height:100%;">
												<p class="mb-0" style="color: lightgray;">該当する商品がありません</p>
											</div>
										<%
										}
										%>
									</div>
									<br>

									<input type=hidden name="itemCategoryName" value="<%=categoryName%>">
										<div class="row">
										    <div class="d-flex flex-wrap justify-content-end text-center">
										    	<small class="mb-0 me-3">ステータス<br>切り替え</small>
										        <button type="button" class="button-light-purple px-3 py-1" data-bs-toggle="modal" data-bs-target="#staticBackdrop" style="border-radius: 40px;">
												    実行
												</button>
										    </div>
										</div>
										<!-- モーダルウィンドウ -->
										<div class="modal fade" id="staticBackdrop"
											data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
											aria-labelledby="staticBackdropLabel" aria-hidden="true">
											<div class="modal-dialog modal-dialog-centered w-100">
												<div class="modal-content" id="modalWindow" style="width:100%;">
													<div class="modal-header">
														<small class="ms-2">ステータス切り替え</small>
														<button type="button" class="btn-close"
															data-bs-dismiss="modal" aria-label="Close"></button>
													</div>
													<div class="modal-body p-5 d-flex flex-wrap">
														<small>
															商品のステータスを切り替えます。<br>
															本当によろしいですか。
														</small>
													</div>
													<!-- 発送するボタン -->
													<div class="modal-footer">
															<button type="submit" class="button-purple px-3 py-2"
																style="border-radius: 5px;">
																OK
															</button>
													</div>
												</div>
											</div>
										</div>
								</form>
							</div>
					</div>
			</div>
		</div>
	</main>
	<script src="./js/deleteItemScript.js"></script>
</body>
</html>
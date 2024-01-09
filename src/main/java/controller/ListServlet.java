package controller;

import java.io.IOException;
import java.util.ArrayList;

import dto.BookBean;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.SelectBookList;

@WebServlet("/list")
public class ListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ListServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		//メッセージを取得
		String message = request.getParameter("message");

		//本の一覧を取得
		ArrayList<BookBean> bookList = SelectBookList.selectBookList();
		if(bookList == null) {
			message = "本の一覧の取得に失敗しました";
		}

		request.setAttribute("bookList", bookList);
		request.setAttribute("message", message);

		String view = "/WEB-INF/views/list.jsp";
		request.getRequestDispatcher(view).forward(request, response);

	}

	//ソートを実行
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
//		ItemBean newItem = new ItemBean();
//		//カテゴリーを取得
//		newItem.setItemCategoryName(request.getParameter("itemCategoryName"));
//		//選択済みの商品ステータスを全て取得、配列に格納
//		String[] itemStatus = request.getParameterValues("itemStatus");
//
//		//選択済みの商品のステータスを切り替えるサーブレット
//		//返却値によって切り替え0→成功、1→ボタン押して、2→失敗ページへ
//		switch(Item.deleteItem(itemStatus)) {
//			case 0:
//				ItemManagementHelper.deleteItemRedirect(response, newItem, "販売ステータスを切り替えました");
//				break;
//			case 1:
//				ItemManagementHelper.deleteItemRedirect(response, newItem, "商品を選択してください");
//				break;
//			case 2:
//				ErrorHandling.transitionToErrorPage(request,response,"ステータスの切り替えに失敗しました","adminTopPage","管理者ページに");
//				break;
//		}
	}

}

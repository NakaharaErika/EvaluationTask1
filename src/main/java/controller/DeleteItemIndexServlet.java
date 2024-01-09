package controller;

import java.io.IOException;
import java.util.ArrayList;

import bean.ItemBean;
import bean.ItemCategoryBean;
import classes.ErrorHandling;
import classes.Item;
import classes.ItemCategory;
import classes.ItemManagementHelper;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/deleteItemIndex")
public class DeleteItemIndexServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public DeleteItemIndexServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String admin = (String) session.getAttribute("admin");
		if (admin == null) {
			response.sendRedirect("adminSignin");
			return;
		}

		// ヘッダーに表示する値を取得
		String disp = "/adminheader";
	    RequestDispatcher dispatch = request.getRequestDispatcher(disp);
	    dispatch.include(request, response);
		
		//カテゴリーを取得
		String itemCategoryName = request.getParameter("itemCategoryName");
		//表示方法を取得
		Integer sortParam = Integer.parseInt(request.getParameter("itemDelFlg"));
		//メッセージを取得
		String message = request.getParameter("message");
		//並び順を取得
		String sortOrder = request.getParameter("order");
		// キーワードを取得
	    String keyword = request.getParameter("keyword");

		//カテゴリー一覧を取得
		ArrayList<ItemCategoryBean> categoryList = ItemCategory.getItemCategoryList();
		if(categoryList == null) {
			//取得情報の不備があれば、エラー画面に遷移
			ErrorHandling.transitionToErrorPage(request,response,"カテゴリ一覧の取得に失敗しました","adminTopPage","管理者ページに");
			return;
		}

		//配列に「全ての商品」という項目を追加
		ItemCategoryBean allItem = new ItemCategoryBean();
		allItem.setItemCategoryName("全ての商品");
		categoryList.add(allItem);

		request.setAttribute("categoryName", itemCategoryName);
		request.setAttribute("categoryList", categoryList);
		request.setAttribute("message", message);

		//以下、ソートSQL
		ArrayList<ItemBean> itemList = Item.getItemAndOptionListByDelFlg(sortParam, itemCategoryName, sortOrder, keyword);
		if(itemList == null) {
			//取得情報の不備があれば、エラー画面に遷移
			ErrorHandling.transitionToErrorPage(request,response,"商品一覧の取得に失敗しました","adminTopPage","管理者ページに");
			return;
		}

		request.setAttribute("itemList", itemList);
		request.setAttribute("itemDelFlg", sortParam);
		request.setAttribute("order", sortOrder);
		request.setAttribute("keyword", keyword);

		String view = "/WEB-INF/views/admin/deleteItemIndex.jsp";
		request.getRequestDispatcher(view).forward(request, response);

	}

	//ソートを実行
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ItemBean newItem = new ItemBean();
		//カテゴリーを取得
		newItem.setItemCategoryName(request.getParameter("itemCategoryName"));
		//選択済みの商品ステータスを全て取得、配列に格納
		String[] itemStatus = request.getParameterValues("itemStatus");

		//選択済みの商品のステータスを切り替えるサーブレット
		//返却値によって切り替え0→成功、1→ボタン押して、2→失敗ページへ
		switch(Item.deleteItem(itemStatus)) {
			case 0:
				ItemManagementHelper.deleteItemRedirect(response, newItem, "販売ステータスを切り替えました");
				break;
			case 1:
				ItemManagementHelper.deleteItemRedirect(response, newItem, "商品を選択してください");
				break;
			case 2:
				ErrorHandling.transitionToErrorPage(request,response,"ステータスの切り替えに失敗しました","adminTopPage","管理者ページに");
				break;
		}
	}

}

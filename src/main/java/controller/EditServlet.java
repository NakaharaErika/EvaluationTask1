package controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.sql.Date;

import dto.BookBean;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.CheckParam;
import model.SelectBook;
import model.UpdateBook;

@WebServlet("/edit")
public class EditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public EditServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		BookBean book = new BookBean();

		//jancdを取得
		String janCd = request.getParameter("janCd");
		if(janCd == null) {
			response.sendRedirect("list");
			return;
		}

		book.setJanCd(janCd);
		//janCdからアイテム情報を取得
		book = SelectBook.selectBook(book);

		request.setAttribute("book", book);
		String view = "/WEB-INF/views/edit.jsp";
		request.getRequestDispatcher(view).forward(request, response);

	}

	//ソートを実行
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		BookBean newBook = new BookBean();
		//カテゴリーを取得
		newBook.setJanCd(request.getParameter("janCd"));
		newBook.setIsbnCd(request.getParameter("isbnCd"));
		newBook.setBookNm(request.getParameter("bookNm"));
		newBook.setBookKana(request.getParameter("bookKana"));
		String price = request.getParameter("price");
		newBook.setIssueDate(Date.valueOf(request.getParameter("issueDate")));
		String crJanCd = request.getParameter("crJanCd");
		newBook = CheckParam.checkParam(newBook, price);

		String rowMessage = null;
		switch(UpdateBook.updateBook(newBook, crJanCd)) {
			case 0:
				rowMessage = "更新に失敗しました";
				break;
			case 1:
				rowMessage = "重複するJANコードは登録できません";
				break;
			case 2:
				rowMessage = "更新に成功しました";
				break;
		}
		String message = URLEncoder.encode(rowMessage, "UTF-8");
		request.setAttribute("message", message);
		String redirectURL = "list?message=" + message;
		response.sendRedirect(redirectURL);
	}

}

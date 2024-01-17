package controller;

import java.io.IOException;

import dto.BeanValidation;
import dto.BookBean;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.CheckParam;
import model.SelectBook;
import model.SendList;
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

		request.setAttribute("crJanCd", janCd);
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
		newBook.setPrice(CheckParam.checkPrice(request.getParameter("price")));
		newBook.setIssueDate(CheckParam.checkDate(request.getParameter("issueDate")));
		String crJanCd = request.getParameter("crJanCd");

		if(BeanValidation.validate(request, "book", newBook)) {
			String view = "/WEB-INF/views/edit.jsp";
			request.setAttribute("crJanCd", crJanCd);
			request.getRequestDispatcher(view).forward(request, response);
			return;
		}

		String message = null;
		switch(UpdateBook.updateBook(newBook, crJanCd)) {
			case 0:
				message = "更新に失敗しました";
				break;
			case 1:
				message = "重複するJANコードは登録できません";
				break;
			case 2:
				String successMsg = "更新に成功しました";
				String showModal = "true";
				request.setAttribute("successMsg", successMsg);
				request.setAttribute("showModal", showModal);
				break;
		}

		request.setAttribute("message", message);

		SendList.sendList(request, response, message);
	}

}

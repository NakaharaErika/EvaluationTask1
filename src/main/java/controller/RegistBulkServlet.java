package controller;

import java.io.IOException;
import java.sql.Date;

import dto.BeanValidation;
import dto.BookBean;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.CheckParam;
import model.InsertBook;
import model.SendList;

@WebServlet("/regist")
public class RegistBulkServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public RegistBulkServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		BookBean newBook = new BookBean();
		request.setAttribute("book", newBook);

		String view = "/WEB-INF/views/regist.jsp";
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

		if(BeanValidation.validate(request, "book", newBook)) {
			String view = "/WEB-INF/views/edit.jsp";
			request.setAttribute("crJanCd", crJanCd);
			request.getRequestDispatcher(view).forward(request, response);
			return;
		}

		String message = null;
		switch(InsertBook.insertBook(newBook)) {
			case 0:
				message = "登録に失敗しました";
				break;
			case 1:
				message = "重複するJANコードは登録できません";
				break;
			case 2:
				String successMsg = "登録に成功しました";
				String showModal = "true";
				request.setAttribute("successMsg", successMsg);
				request.setAttribute("showModal", showModal);
				break;
		}

		request.setAttribute("message", message);

		SendList.sendList(request, response, message);
	}

}

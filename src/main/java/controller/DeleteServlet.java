package controller;

import java.io.IOException;
import java.util.ArrayList;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.DeleteBook;
import model.SendList;

@WebServlet("/delete")
public class DeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public DeleteServlet() {
		super();
	}

//	protected void doGet(HttpServletRequest request, HttpServletResponse response)
//			throws ServletException, IOException {
//
//	}

	//ソートを実行
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String message = null;
		String[] bookStatus = request.getParameterValues("bookStatus");
		if(bookStatus == null) {
			message = "削除する書籍を選択してください";
			SendList.sendList(request, response, message);
			return;
		}

		//失敗したコードをArrayListに格納
		ArrayList<String> delBookList = DeleteBook.deleteBook(bookStatus);
		if(delBookList == null) {
			message = "DBエラーが発生しました";
			SendList.sendList(request, response, message);
			return;
		}

		int bookStatusLength = bookStatus.length;
		int falseBookListLength = delBookList.size();

		if(falseBookListLength > 0) {
			message = falseBookListLength + " 件の削除に失敗しました。 \n  JANコード：" + String.join(", ", delBookList);

		} else {
			int trueCount = bookStatusLength - falseBookListLength;
			String successMsg = bookStatusLength + " 件中" + trueCount + " 件の削除に成功しました";
			String showModal = "true";
			request.setAttribute("successMsg", successMsg);
			request.setAttribute("showModal", showModal);
		}

		SendList.sendList(request, response, message);
	}

}

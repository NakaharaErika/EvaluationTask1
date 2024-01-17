package controller;

import java.io.IOException;
import java.io.InputStream;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;

import dto.BeanValidation;
import dto.BookBean;
import dto.BookProcessing;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.CheckParam;
import model.InsertBookBulk;
import model.SendList;

@MultipartConfig
@WebServlet("/registBulk")
public class RegistBulkServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public RegistBulkServlet() {
		super();
	}

//	protected void doGet(HttpServletRequest request, HttpServletResponse response)
//			throws ServletException, IOException {
//
//	}

	//ソートを実行
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		Part filePart = request.getPart("file"); // フォームからファイルを取得
		InputStream fileContent = filePart.getInputStream();
		Workbook workbook = WorkbookFactory.create(fileContent);
		Sheet sheet = workbook.getSheetAt(0);

		BookProcessing result = new BookProcessing();

		int numberOfRows = sheet.getLastRowNum();
		// シートの行をループ処理
		for (Row row : sheet) {
		    // 最初の行（ヘッダー）をスキップ
		    if (row.getRowNum() == 0) {
		        continue;
		    }

		    BookBean rowData = new BookBean();
		    rowData.setJanCd(CheckParam.checkString(row.getCell(0)));
		    rowData.setIsbnCd(CheckParam.checkString(row.getCell(1)));
		    rowData.setBookNm(CheckParam.checkString(row.getCell(2)));
		    rowData.setBookKana(CheckParam.checkString(row.getCell(3)));
		    rowData.setPrice(CheckParam.checkInt(row.getCell(4)));
		    rowData.setIssueDate(CheckParam.checkDate(row.getCell(5)));

		    if (BeanValidation.validate(request, "book", rowData)) {
		        result.addErrorEntry(rowData.getJanCd());
		    } else {
		        result.addSuccessfulEntry(rowData);
		    }
		}
		workbook.close();

		//DBに登録
		result = InsertBookBulk.insertBookBulk(result);
		String message = null;
		if(result == null) {
			message = "DBエラーが発生しました";
			SendList.sendList(request, response, message);
			return;
		}

		int falseBookListLength = result.getErrorEntries().size();

		if(falseBookListLength > 0) {
			message = falseBookListLength + " 件の登録に失敗しました。 <br>  JANコード：" + String.join(", ", result.getErrorEntries());

		} else {
			int trueCount = numberOfRows - falseBookListLength;
			String successMsg = numberOfRows + " 件中" + trueCount + " 件登録しました";
			String showModal = "true";
			request.setAttribute("successMsg", successMsg);
			request.setAttribute("showModal", showModal);
		}

		request.setAttribute("message", message);
		SendList.sendList(request, response, message);
	}

}

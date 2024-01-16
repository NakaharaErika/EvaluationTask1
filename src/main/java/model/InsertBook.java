package model;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dao.DatabaseConnection;
import dao.GeneralDao;
import dto.BookBean;

public class InsertBook {

	//書籍を更新する
	public static int insertBook(BookBean book) {
			StringBuilder sb = new StringBuilder();

				sb.append("INSERT INTO "													);
				sb.append(	"BOOK " 														);
				sb.append(	"(JAN_CD, ISBN_CD, BOOK_NM, BOOK_KANA, PRICE, ISSUE_DATE, "		);
				sb.append(	"CREATE_DATETIME, UPDATE_DATETIME)"								);
				sb.append("VALUES "															);
				sb.append("(?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP, NULL);"					);

				final String SQL = sb.toString();

				List<Object> params = new ArrayList<>();
				params.add(book.getJanCd());
				params.add(book.getIsbnCd());
				params.add(book.getBookNm());
				params.add(book.getBookKana());
				params.add(book.getPrice());
				params.add(book.getIssueDate());
				int updatedRows = 0;
				//SQL接続
				try (Connection conn = DatabaseConnection.getConnection()){

						updatedRows = GeneralDao.executeUpdate(conn, SQL, params);
						updatedRows += updatedRows;
				} catch (SQLException e) {
					if(e.getSQLState().startsWith("23")) { // 主キー制約違反
	                    return 1;
	                }
				} catch (ClassNotFoundException e) {
				e.printStackTrace();
				return 0;
				}

		return updatedRows;
	}
}

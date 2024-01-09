package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
	
	private static final String DB_URL = "jdbc:mysql://localhost/donko";
	private static final String DB_USER = "root";
	private static final String DB_PASSWORD = "";
	private static final String DB_JDBC_DRIVER = "com.mysql.jdbc.Driver";
	
	public static Connection getConnection() throws ClassNotFoundException, SQLException {

		//JDBCドライバーの読み込み
		Class.forName(DB_JDBC_DRIVER);
		//データベース接続を確立
		Connection conn =  DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
		//SQLのオートコミット機能をオフにする(トランザクション処理)
		conn.setAutoCommit(false);
		
		return conn;
	}
}

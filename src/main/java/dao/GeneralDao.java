package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class GeneralDao {
	
	//Insert、Update、Deleteに使うUpdateメソッドの実装
	public static int executeUpdate(Connection conn, String sql, List<Object> paramList) throws SQLException {

		PreparedStatement statement = conn.prepareStatement(sql);
		setParameter(statement, paramList);
		return statement.executeUpdate();

	}
	
	//Selectに使うQueryメソッドの実装
	public static ResultSet executeQuery(Connection conn, String sql, List<Object> paramList) throws SQLException {

		PreparedStatement statement = conn.prepareStatement(sql);
		setParameter(statement, paramList);
		return statement.executeQuery();

	}

	public static void setParameter(PreparedStatement statement, List<Object> paramList) throws SQLException {

		for (int i = 0; i < paramList.size(); i++) {
			statement.setObject(i + 1, paramList.get(i));
		}
	}
}

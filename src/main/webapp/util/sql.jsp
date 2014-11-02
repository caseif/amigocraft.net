<%@ page import="java.io.*" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>

<%!
	public java.sql.Connection getConnection(String db) throws ClassNotFoundException, IOException, SQLException {
		String url = "jdbc:mysql://192.168.1.6/" + db;
		String username = "site";
		String pass = new BufferedReader(new InputStreamReader(new FileInputStream("/etc/sql.secret"))).readLine();
		Class.forName("com.mysql.jdbc.Driver");
		return DriverManager.getConnection(url, username, pass);
	}
%>
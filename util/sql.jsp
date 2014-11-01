<%@ page import="java.io.*" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.sql.*" %>

<%!
Exception exception = null;

public java.sql.Connection getConnection(String db){
	String url = "jdbc:mysql://192.168.1.6/" + db;
	String username = "site";
	try {
		String pass = new BufferedReader(new InputStreamReader(new FileInputStream("/etc/sql.secret"))).readLine();
		Class.forName("com.mysql.jdbc.Driver");
		return DriverManager.getConnection(url, username, pass);
	}
	catch (ClassNotFoundException | IOException | SQLException ex){
		exception = ex;
		return null;
	}
}
%>
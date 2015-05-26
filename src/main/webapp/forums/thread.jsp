<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%@ include file="/templates/header.jsp" %>
<%@ include file="/util/sql.jsp" %>
<%
	Connection conn = null;
	PreparedStatement st = null;
	ResultSet rs = null;
	try {
		conn = getConnection("amigocraft");
		st = conn.prepareStatement("SELECT * FROM forums WHERE id = '" + request.getParameter("id") + "' AND parent IS NULL");
		rs = st.executeQuery();
		if (rs.next()){
			request.setAttribute("title", rs.getString("title"));
			request.setAttribute("content", rs.getString("content"));
			request.setAttribute("time", new SimpleDateFormat("MMMM dd yyyy 'at' hh:mm aa").format(rs.getLong("time") * 1000L));
			request.setAttribute("author", rs.getString("author"));
			request.setAttribute("category", rs.getString("category"));
			request.setAttribute("sticky", rs.getBoolean("sticky"));
			request.setAttribute("locked", rs.getBoolean("locked"));
			request.setAttribute("views", rs.getInt("views"));
			request.setAttribute("replies", rs.getInt("replies"));
			ResultSet rs2 = conn.prepareStatement("SELECT mcname FROM login WHERE username = '" +
					rs.getString("author") + "'").executeQuery();
			if (rs2.next()){
				request.setAttribute("mcname", rs2.getString("mcname"));
			}
			else {
				request.setAttribute("mcname", "Steve");
			}
		}
		else {
			response.sendError(404, "The requested thread does not exist");
		}
	}
	catch (Exception ex){
		response.sendError(500, ex.getClass().getCanonicalName() + ": " + ex.getMessage());
	}
	finally {
		if (conn != null){
			try {
				conn.close();
			}
			catch (Exception ex){
				response.sendError(500, ex.getClass().getCanonicalName() + ": " + ex.getMessage());
			}
		}
	}
%>
<div id="pagetitle">
	<a href="./?lc=${category}&lt=${param["id"]}&ltt=${title}">Forum Categories</a>
	&#8594;
	<a href="category.jsp?c=${category}&lt=${param["id"]}&ltt=
	<%= URLEncoder.encode((String)request.getAttribute("title")) %>
	">${category}</a>
	&#8594;
	${title}
</div>
<div id="thread">
	<div id="op">
		<div class="avatar">
			<img src="https://visage.gameminers.com/head/64/${mcname}.png" alt="${author}">
		</div>
		<div id="op-body">
			<div id="op-header">
				${title}
			</div>
			<div id="op-content">
				${content}
			</div>
			<div id="op-sig">
				Posted by ${author} on ${time}
			</div>
		</div>
	</div>
</div>
<%@ include file="/templates/footer.jsp" %>

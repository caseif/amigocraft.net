<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.util.Calendar" %>

<%@ include file="/templates/header.jsp" %>
<%@ include file="/util/misc.jsp" %>
<%@ include file="/util/sql.jsp" %>

<%
	if (request.getParameter("c") == null){
		response.sendRedirect("/forums/");
	}
%>

			<div id="pagetitle">
				<%
					String lastUrl = "./?lc=" + request.getParameter("c");
					if (request.getParameter("lt") != null && request.getParameter("ltt") != null){
						lastUrl += "&lt=" + request.getParameter("lt");
						lastUrl += "&ltt=" + URLEncoder.encode(request.getParameter("ltt"));
					}
					request.setAttribute("lastUrl", lastUrl);
				%>
				<a href="${lastUrl}">Forum Categories</a>
				&#8594;
				${param["c"]}
				<%
					if (request.getParameter("lt") != null) {
						out.println(" &#8594; <a href=\"thread.jsp?id=" +
								request.getParameter("lt") + "\">" + request.getParameter("ltt") + "</a>");
					}
				%>
			</div>
			<div id="threads">
				<%
					Connection conn = null;
					PreparedStatement st = null;
					ResultSet rs = null;
					try {
						conn = getConnection("amigocraft");
						st = conn.prepareStatement("SELECT * FROM forums WHERE category = '" + request.getParameter("c") + "' AND parent IS NULL ORDER BY sticky DESC, updated DESC");
						rs = st.executeQuery();
						int posts = 0;
						while (rs.next()) {
							int id = rs.getInt("id");
							String title = rs.getString("title");
							long time = rs.getLong("time");
							Calendar cal = Calendar.getInstance();
							String formattedDate = new SimpleDateFormat("MMMM dd yyyy 'at' hh:mm aa").format(time * 1000L);
							String author = rs.getString("author");
							PreparedStatement userSt = conn.prepareStatement("SELECT * FROM login WHERE username = '" + author + "'");
							ResultSet userRs = userSt.executeQuery();
							String mcname;
							if (userRs.next()) {
								mcname = userRs.getString("mcname");
							}
							else {
								mcname = "Steve";
							}
				%>
				<div class="peek-thread">
					<div class="avatar">
						<img src="http://cravatar.eu/head/<%= mcname %>/50.png">
						<!-- not intended for public use yet and I don't want to kill the server -->
						<!--<img src="http://tar.lapis.blue/head/50/<%= mcname %>?angle=30">-->
					</div>
					<div class="post-info">
						<span class="peek-title">
							<a href="/forums/thread.jsp?id=<%= id %>">
								<%= title %>
							</a>
						</span>
						<span class="peek-footer">
							<%= "Posted by " + author + " on " + formattedDate %>
						</span>
					</div>
				</div>
				<%
							posts += 1;
						}
						if (posts == 0) {
							out.println("No posts matching the given criteria were found.");
						}
					}
					catch (Exception ex) {
						response.sendError(500, exceptionToString(ex));
					}
					finally {
						try {
							if (conn != null) {
								conn.close();
							}
						}
						catch (Exception ex) {
							response.sendError(500, exceptionToString(ex));
						}
					}
				%>
			</div>
<%@ include file="/templates/footer.jsp" %>
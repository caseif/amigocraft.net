<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.util.Calendar" %>

<%@ include file="/templates/header.jsp" %>
<%@ include file="/util/misc.jsp" %>
<%@ include file="/util/sql.jsp" %>
			<div id="pagetitle">
				<a href="/forums/?last=${param["c"]}">Forum Categories</a>
				&nbsp;&#8594;&nbsp;
				${param["c"]}
			</div>
			<div id="threads">
				<%
					Connection conn = null;
					PreparedStatement st = null;
					ResultSet rs = null;
					try {
						conn = getConnection("amigocraft");
						st = conn.prepareStatement("SELECT * FROM forums WHERE category = '" + request.getParameter("c") + "' AND parent IS NULL ORDER BY updated DESC");
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
					<div class="peek-avatar">
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
							out.println("No posts matching the criteria were found");
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
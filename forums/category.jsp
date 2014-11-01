<%@ page import="java.text.SimpleDateFormat" %>

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
					while (rs.next()){
						int id = rs.getInt("id");
						String title = rs.getString("title");
						long time = rs.getLong("time");
						Calendar cal = Calendar.getInstance();
						String formattedDate = new SimpleDateFormat("MMMM dd yyyy 'at' hh:mm aa").format(time * 1000L);
						String author = rs.getString("author");
				%>
				<div class="peek-thread">
					<div class="peek-avatar">
						<img src="http://cravatar.eu/head/<%= author %>/50.png">
						<!-- not intended for public use yet and I don't want to kill the server -->
						<!--<img src="http://tar.lapis.blue/head/64/<%= author %>?angle=30">-->
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
			if (posts == 0){
				out.println("No posts matching the criteria were found");
			}
		}
		catch (Exception ex){
			response.sendError(500, exceptionToString(ex));
		}
		finally {
			try {
				conn.close();
			}
			catch (Exception ex){
				response.sendError(500, exceptionToString(ex));
			}
		}
	%>
			</div>
<%@ include file="/templates/footer.jsp" %>
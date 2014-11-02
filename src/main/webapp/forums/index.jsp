<%@ include file="/templates/header.jsp" %>
<div id="pagetitle">
	Forum Categories
	<%
		if (request.getParameter("lc") != null) {
			out.println(" &#8594; <a href=\"category.jsp?c=" + request.getParameter("lc") +
					(request.getParameter("lt") != null && request.getParameter("ltt") != null ?
							"&lt=" + request.getParameter("lt") + "&ltt=" + URLEncoder.encode(request.getParameter("ltt")) :
							"") +
					"\">" + request.getParameter("lc") + "</a>");
		}
		if (request.getParameter("lt") != null && request.getParameter("ltt") != null) {
			out.println(" &#8594; <a href=\"thread.jsp?id=" + request.getParameter("lt") + "\">" +
					request.getParameter("ltt") + "</a>");
		}
	%>
</div>
<div id="categories">
	<%
		String[] cats = new String[]{
				"News",
				"General Discussion",
				"Suggestions",
				"Complaints",
				"Problem Reporting",
				"Feedback",
				"Ban Appeals",
				"Offtopic"
		};
		for (String cat : cats) {
			out.println("<div class=\"category\">");
			out.println("<a href=\"category.jsp?c=" + cat + "\">");
			out.println(cat);
			out.println("</a>");
			out.println("</div>");
		}
	%>
</div>
<%@ include file="/templates/footer.jsp" %>
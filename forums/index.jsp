<%@ include file="/templates/header.jsp" %>
<div id="pagetitle">
	Forum Categories
	<%
	if (request.getParameter("last") != null){
		out.println(" &nbsp;&#8594;&nbsp; <a href=\"category.jsp?c=" + request.getParameter("last") + "\">" + request.getParameter("last") + "</a>");
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
		for (String cat : cats){
			out.println("<div class=\"category\">");
			out.println(	"<a href=\"category.jsp?c=" + cat + "\">");
			out.println(		cat);
			out.println(	"</a>");
			out.println("</div>");
		}
	%>
</div>
<%@ include file="/templates/footer.jsp" %>
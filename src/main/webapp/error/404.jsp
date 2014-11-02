<%@ page isErrorPage="true" %>

<%
	// this is extremely irresponsible, but my bleeding server configuration is already slightly insane, so screw it
	if (((String)request.getAttribute("javax.servlet.error.request_uri")).contains("bleeding/bleeding/")){
		response.sendRedirect(((String)request.getAttribute("javax.servlet.error.request_uri")).replace("bleeding/bleeding/", ""));
	}
%>

<%@ include file="/templates/header.jsp" %>
<meta content="noindex" name="robots">
<div id="pagetitle">404 Not Found</div>
The requested resource can't be found. Here's what the server says:
<br><br>
<span style="font-family:Courier New,monospace;">
	${requestScope['javax.servlet.error.message']}
</span>
<br><br>
If you think there should be something here, <a href="mailto:mproncace@gmail.com">shoot me an email</a> so I can fix it.
<%@ include file="/templates/footer.jsp" %>
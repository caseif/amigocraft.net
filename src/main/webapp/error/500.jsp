<%@ page isErrorPage="true" %>

<%@ include file="/templates/header.jsp" %>
<meta content="noindex" name="robots">
<div id="pagetitle">500 Internal Server Error</div>
A 500 error occurs when something in our code breaks. Here's what the server says:
<br><br>
<span style="font-family:Courier New,monospace;">
	<%
		out.print(request.getAttribute("javax.servlet.error.exception_type"));
		if (((String)request.getAttribute("javax.servlet.error.message")).isEmpty()){
			out.print(": " + ((String)request.getAttribute("javax.servlet.error.message")));
		}
		((Throwable)request.getAttribute("javax.servlet.error.exception")).printStackTrace(new java.io.PrintWriter(out));
	%>
</span>
<br><br>
I recommend <a href="mailto:mproncace@gmail.com">shooting me an email</a> so I can fix it. :)
<%@ include file="/templates/footer.jsp" %>
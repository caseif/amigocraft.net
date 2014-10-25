<%
session.removeAttribute("username");
Cookie cookie = new Cookie("username", null);
cookie.setPath("/");
cookie.setMaxAge(-1);
response.addCookie(cookie);
response.sendRedirect(request.getParameter("rd") != null ? request.getParameter("rd") : "/");
%>
<%@ include file="/templates/header.jsp" %>
<div id="pagetitle">Log Out</div>
<%@ include file="/templates/footer.jsp" %>
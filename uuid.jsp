<%@ include file="/util/mojang.jsp" %>
<%
out.println(getUUID(request.getParameter("user").toString()));
%>
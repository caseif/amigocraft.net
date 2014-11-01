<%@ page import="org.apache.commons.validator.EmailValidator" %>

<%@ include file="/templates/header.jsp" %>
<%@ include file="/util/sql.jsp" %>
<%@ include file="/util/crypto.jsp" %>
<%@ include file="/util/mojang.jsp" %>
<div id="pagetitle">Register</div>
<%
String err = null;
boolean suc = false;
if (user != null){
	response.sendRedirect(request.getParameter("rd") != null ? request.getParameter("rd") : "/");
	return;
}
if (request.getParameter("submit") != null){
	String username = request.getParameter("username").toString();
	String password = request.getParameter("password").toString();
	String email = request.getParameter("email").toString();
	String mcname = request.getParameter("mcname").toString();
	if (username != null){
		if (password != null){
			if (email != null){
				if (username.length() <= 20){
					if (password.length() >= 8){
						if (email.length() <= 50){
							if (mcname.isEmpty() || (mcname.length() >= 2 && mcname.length() <= 16)){
								if (EmailValidator.getInstance().isValid(email)){
									Connection conn = null;
									PreparedStatement st = null;
									ResultSet rs = null;
									try {
										conn = getConnection("amigocraft");
										st = conn.prepareStatement("SELECT * FROM login WHERE username = '" + username + "'");
										rs = st.executeQuery();
										if (!rs.next()){
											st = conn.prepareStatement("SELECT * FROM login WHERE email = '" + email+ "'");
											rs = st.executeQuery();
											if (!rs.next()){
													UUID uuid = getUUID(mcname);
												if (mcname.isEmpty() || uuid != null){
													st = conn.prepareStatement("SELECT * FROM login WHERE mcuuid = '" +
															(uuid != null ? uuid.toString() : "spaghetti") + "'");
													rs = st.executeQuery();
													if (mcname.isEmpty() || !rs.next()){
													String salt = new BigInteger(130, new SecureRandom()).toString(64); // generate a salt for the new password
													String hash = sha256(salt + password);
														st = conn.prepareStatement("INSERT INTO login (username, password, salt, email, mcname, mcuuid) " +
																"VALUES ('" + username + "', '" + hash + "', '" + salt + "', '" + email + "', " +
																(mcname.isEmpty() ? "null" : "'" + mcname) + "', '" +
																(mcname.isEmpty() ? "null" : uuid.toString()) + "')");
														st.executeUpdate();
														suc = true;
													}
													else {
														err = "The specified Minecraft user is already associated with an account! Are you trying to <a href='login.jsp'>log in?</a>";
													}
												}
												else {
													err = "The specified Minecraft username does not exist!";
												}
											}
											else {
												err = "The specified email address is already associated with an account! Are you trying to <a href='login.jsp'>log in?</a>";
											}
										}
										else {
											err = "The specified username has already been registered! Are you trying to <a href='login.jsp'>log in?</a>";
										}
									}
									catch (Exception ex){
										ex.printStackTrace();
										err = "An internal error occurred; please try again later.<br>    " +
										ex.getClass().getCanonicalName() +
										(ex.getMessage() != null ? "<br>    \"" + ex.getMessage() + "\"" : "");
									}
								}
								else {
									err = "You must enter a valid email address";
								}
							}
							else {
								err = "You must enter a valid Minecraft username";
							}
						}
						else {
							err = "Your email address must be 50 characters or less";
						}
					}
					else {
						err = "Your password must be at least 8 characters long!";
					}
				}
				else {
					err = "Your username must be 20 characters or less";
				}
			}
			else {
				err = "You must enter an email address";
			}
		}
		else {
			err = "You must enter a password";
		}
	}
	else {
		err = "You must enter a username";
	}
}
%>
<%
if (!suc){ //TODO: probably revise this at some point
%>
<form action="register.jsp?rd=<%= request.getParameter("rd") != null ? request.getParameter("rd") : "/" %>" method="post">
	<%
	if (err != null){
		out.println("<span id='formerror'>Error: " + err + "</span>");
	}
	%>
	<table>
		<tbody>
			<tr>
				<td>
					Username<span style="color:red">*</span>
				</td>
				<td>
					<input type="text" name="username" value="${param["username"]}" required />
				</td>
			</tr>
			<tr>
				<td>
					Password<span style="color:red">*</span>
				</td>
				<td>
					<input type="password" name="password" value="" required />
				</td>
			</tr>
			<tr>
				<td>
					Email<span style="color:red">*</span>
				</td>
				<td>
					<input type="text" name="email" value="${param["email"]}" required />
				</td>
			</tr>
			<tr>
				<td>
					Minecraft Username
				</td>
				<td>
					<input type="text" name="mcname" value="${param["mcname"]}" />
				</td>
			</tr>
			<tr>
				<td>
					<input type="submit" name="submit" value="Register" />
				</td>
			</tr>
		</tbody>
	</table>
</form>
<%
}
else {
%>
	You have been successfully registered. You may now log in <a href="/login/login.jsp">here.</a>
<%
}
%>
<%@ include file="/templates/footer.jsp" %>

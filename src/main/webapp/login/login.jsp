<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.math.BigInteger" %>
<%@ page import="java.security.SecureRandom" %>

<%@ include file="/templates/header.jsp" %>
<%@ include file="/util/sql.jsp" %>
<%@ include file="/util/crypto.jsp" %>

<div id="pagetitle">Log In</div>
<%
	String err = null;
	String suc = null;
	if (user != null) {
		response.sendRedirect(request.getParameter("rd") != null ? request.getParameter("rd") : "/");
		return;
	}
	if (request.getParameter("submit") != null) {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		boolean staySignedIn = request.getParameter("staysignedin") != null;
		int period = 1;
		String unit = "";
		if (staySignedIn) { // no need to validate period and units if the box isn't checked
			String periodStr = request.getParameter("period");
			try {
				period = Integer.parseInt(periodStr);
			}
			catch (NumberFormatException ex) {
				err = "Sign-in period must be a number!";
				return;
			}
			unit = request.getParameter("unit");
		}
		// input validity checks
		if (username == null) {
			err = "You must enter a username!";
			return;
		}
		if (password == null) {
			err = "You must enter your password!";
			return;
		}
		if (period <= 0) {
			err = "Sign-in period must be greater than 0!";
			return;
		}
		if (unit == null) {
			err = "Stop that."; // come on, no ordinary user is gonna mess this up
			return;
		}
		Connection conn = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			conn = getConnection("amigocraft");
			st = conn.prepareStatement("SELECT * FROM login WHERE username = '" + username + "'");
			rs = st.executeQuery();
			if (!rs.next()) {
				err = "Unrecognized username!";
			}
			else {
				String md5pass = rs.getString("md5pass");
				if (md5pass != null) { // we need to update the encrypted hash
					String salt1 = new BufferedReader(new InputStreamReader(new FileInputStream("/etc/salt1.secret"))).readLine();
					String salt2 = new BufferedReader(new InputStreamReader(new FileInputStream("/etc/salt2.secret"))).readLine();
					String suppliedPassHash = md5(md5(salt1 + password + salt2, response), response);
					if (suppliedPassHash.equals(md5pass)) { // it matches, we can sign them in
						String salt = new BigInteger(130, new SecureRandom()).toString(64); // generate a salt for the new password
						String newHash = sha256(salt + password);
						st = conn.prepareStatement("UPDATE login SET password = '" + newHash + "', salt = '" + salt + "', md5pass = null WHERE username = '" + username + "'");
						st.executeUpdate();
					}
					else {
						err = "Incorrect password!";
					}
				}
				else {
					String hash = rs.getString("password");
					if (sha256(rs.getString("salt") + password).equals(hash)) { // password matches, sign them in
						Cookie userCookie = new Cookie("user", username);
						userCookie.setPath("/");
						if (staySignedIn) {
							int age = period;
							switch (unit) {
								case "hours":
									age *= 60 * 60;
									break;
								case "days":
									age *= 60 * 60 * 24;
									break;
								case "weeks":
									age *= 60 * 60 * 24 * 7;
									break;
								case "ever":
									// In theory, this should make the cookie expire in 2038. In practice, it lasts until 2047. Kinda odd.
									age = Integer.MAX_VALUE - (int)(System.currentTimeMillis() / 1000 - 3600); // subtract an hour just in case
								default:
									age *= 60;
									break;
							}
							userCookie.setMaxAge(age);
						}
						response.addCookie(userCookie);
						response.sendRedirect(request.getParameter("rd"));
					}
					else {
						err = "Incorrect password!";
					}
				}
			}
		}
		catch (Exception ex) {
			response.sendError(500, ex.getClass().getCanonicalName() + ": " + ex.getMessage());
		}
	}
%>
<form action="login.jsp?rd=<%= request.getParameter("rd") != null ? request.getParameter("rd") : "/" %>" method="post">
	<%
		if (err != null) {
			out.println("<span id='formerror'>Error: " + err + "</span>");
		}
	%>
	<table>
		<tbody>
			<tr>
				<td>
					Username
				</td>
				<td>
					<input type="text" name="username" placeholder="Notch" required/>
				</td>
			</tr>
			<tr>
				<td>
					Password
				</td>
				<td>
					<input type="password" name="password"
						   placeholder="&#8226;&#8226;&#8226;&#8226;&#8226;&#8226;&#8226;&#8226;" required/>
				</td>
			</tr>
			<tr>
				<td>
					<label>
						<input type="checkbox" name="staysignedin"/>
						Stay signed in for
					</label>
				</td>
				<td>
					<input type="number" name="period" value="60" min="1" max="999"/>
					<select name="unit">
						<option value="minutes" selected>minutes</option>
						<option value="hours">hours</option>
						<option value="days">days</option>
						<option value="weeks">weeks</option>
						<option value="ever">ever</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>
					<input type="submit" name="submit" value="Submit"/>
				</td>
			</tr>
		</tbody>
	</table>
</form>
<%@ include file="/templates/footer.jsp" %>
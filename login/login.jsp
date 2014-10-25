<%@ include file="/templates/header.jsp" %>
<%@ include file="/sqlutil.jsp" %>

<%@ page import="java.math.BigInteger" %>
<%@ page import="java.security.MessageDigest" %>
<%@ page import="java.security.NoSuchAlgorithmException" %>
<%@ page import="java.security.SecureRandom" %>

<div id="pagetitle">Log In</div>
<%!
public String md5(String str){
	try {
		byte[] hash = MessageDigest.getInstance("MD5").digest(str.getBytes());
		StringBuffer hexString = new StringBuffer();
		for (int i = 0; i < hash.length; i++) {
			if ((0xff & hash[i]) < 0x10) {
				hexString.append("0" + Integer.toHexString((0xFF & hash[i])));
			}
            else {
				hexString.append(Integer.toHexString(0xFF & hash[i]));
			}
        }
        return hexString.toString();
	}
	catch (NoSuchAlgorithmException ex){
		exception = ex;
		return null;
	}
}

public String sha256(String str){
	try {
		byte[] hash = MessageDigest.getInstance("SHA-256").digest(str.getBytes());
		StringBuffer hexString = new StringBuffer();
		for (int i = 0; i < hash.length; i++) {
			if ((0xff & hash[i]) < 0x10) {
				hexString.append("0" + Integer.toHexString((0xFF & hash[i])));
			}
            else {
				hexString.append(Integer.toHexString(0xFF & hash[i]));
			}
        }
        return hexString.toString();
	}
	catch (NoSuchAlgorithmException ex){
		exception = ex;
		return null;
	}
}
%>
<%
String err = null;
String suc = null;
if (username != null){
	response.sendRedirect(request.getParameter("rd") != null ? request.getParameter("rd") : "/");
	return;
}
if (request.getParameter("submit") != null){
	String user = request.getParameter("username");
	String password = request.getParameter("password");
	boolean staySignedIn = request.getParameter("staysignedin") != null;
	int period = 1;
	String unit = "";
	if (staySignedIn){ // no need to validate period and units if the box isn't checked
		String periodStr = request.getParameter("period");
		try {
			period = Integer.parseInt(periodStr);
		}
		catch (NumberFormatException ex){
			err = "Sign-in period must be a number!";
			return;
		}
		unit = request.getParameter("unit");
	}
	// input validity checks
	if (user == null){
		err = "You must enter a username!";
		return;
	}
	if (password == null){
		err = "You must enter your password!";
		return;
	}
	if (period <= 0){
		err = "Sign-in period must be greater than 0!";
		return;
	}
	if (unit == null){
		err = "Stop that."; // come on, no ordinary user is gonna mess this up
		return;
	}
	Connection conn = null;
	PreparedStatement st = null;
	ResultSet rs = null;
	try {
		conn = getConnection("jsptest");
		if (exception != null){
			err = "An internal error occurred:<br>    " + exception.getClass().getCanonicalName() + (exception.getMessage() != null ? "<br>    \"" + exception.getMessage() + "\"" : "");
		}
		else {
			st = conn.prepareStatement("SELECT * FROM login WHERE username = '" + user + "'");
			rs = st.executeQuery();
			if (!rs.next()){
				err = "Unrecognized username!";
			}
			else {
				String md5pass = rs.getString("md5pass");
				if (md5pass != null){ // we need to update the encrypted hash
					String salt1 = new BufferedReader(new InputStreamReader(new FileInputStream("/etc/salt1.secret"))).readLine();
					String salt2 = new BufferedReader(new InputStreamReader(new FileInputStream("/etc/salt2.secret"))).readLine();
					String suppliedPassHash = md5(md5(salt1 + password + salt2));
					if (exception == null){
						if (suppliedPassHash.equals(md5pass)){ // it matches, we can sign them in
							String salt = new BigInteger(130, new SecureRandom()).toString(64); // generate a salt for the new password
							String newHash = sha256(salt + password);
							st = conn.prepareStatement("UPDATE login SET password = '" + newHash + "', salt = '" + salt + "', md5pass = null WHERE username = '" + user + "'");
							st.executeUpdate();
						}
						else {
							err = "Incorrect password!";
						}
					}
					else {
						err = "An internal error occurred; please try again later.<br>    " + exception.getClass().getCanonicalName() + (exception.getMessage() != null ? "<br>    \"" + exception.getMessage() + "\"" : "");
					}
				}
				else {
					String hash = rs.getString("password");
					if (sha256(rs.getString("salt") + password).equals(hash)){ // password matches, sign them in
						session.setAttribute("userid", rs.getInt("id"));
						session.setAttribute("username", user);
						if (staySignedIn){
							Cookie usernameCookie = new Cookie("username", user);
							usernameCookie.setPath("/");
							int age = period;
							switch (unit){
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
									age = Integer.MAX_VALUE - (int)(System.currentTimeMillis() / 1000 - 12600); // subtract 14 hours to avoid overflow in extreme timezones
								default:
									age *= 60;
									break;
							}
							usernameCookie.setMaxAge(age);
							response.addCookie(usernameCookie);
						}
						response.sendRedirect(request.getParameter("rd"));
					}
					else {
						err = "Incorrect password!";
					}
				}
			}
		}
	}
	catch (Exception ex){
		ex.printStackTrace();
		err = "An internal error occurred; please try again later.<br>    " + ex.getClass().getCanonicalName() + (ex.getMessage() != null ? "<br>    \"" + ex.getMessage() + "\"" : "");
	}
}
%>
<form action="login.jsp?rd=<%= request.getParameter("rd") != null ? request.getParameter("rd") : "/" %>" method="post">
	<%
	if (err != null){
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
					<input type="text" name="username" placeholder="Notch" required />
				</td>
			</tr>
			<tr>
				<td>
					Password
				</td>
				<td>
					<input type="password" name="password" placeholder="&#8226;&#8226;&#8226;&#8226;&#8226;&#8226;&#8226;&#8226;" required />
				</td>
			</tr>
			<tr>
				<td>
					<label>
						<input type="checkbox" name="staysignedin" />
						Stay signed in for
					</label>
				</td>
				<td>
					<input type="number" name="period" value="60" min="1" max="999" />
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
					<input type="submit" name="submit" value="Submit" />
				</td>
			</tr>
		</tbody>
	</table>
</form>
<%@ include file="/templates/footer.jsp" %>
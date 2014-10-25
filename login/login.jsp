<%@ include file="/templates/header.jsp" %>
<%@ include file="/sqlutil.jsp" %>
<div id="pagetitle">Log In</div>
<%
String err = null;
if (request.getParameter("submit") != null){
	String username = request.getParameter("username");
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
	if (username == null){
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
			// do stuff
		}
	}
	catch (Exception ex){
		ex.printStackTrace();
		err = "An internal error occurred; please try again later.<br>    " + ex.getClass().getCanonicalName() + (ex.getMessage() != null ? "<br>    \"" + ex.getMessage() + "\"" : "");
	}
}
%>
<form action="login.jsp" method="post">
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
					<input type="password" name="password" required />
				</td>
			</tr>
			<tr>
				<td>
					<input type="checkbox" name="staysignedin" />
					Stay signed in for
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
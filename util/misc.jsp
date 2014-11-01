<%!
	public String exceptionToString(Exception ex) {
		return ex.getClass().getCanonicalName() + ": " + ex.getMessage();
	}
%>
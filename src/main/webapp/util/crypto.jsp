<%@ page import="java.math.BigInteger" %>
<%@ page import="java.security.MessageDigest" %>
<%@ page import="java.security.NoSuchAlgorithmException" %>
<%@ page import="java.security.SecureRandom" %>

<%!
	public String md5(String str, HttpServletResponse response) throws NoSuchAlgorithmException {
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

	public String sha256(String str) throws NoSuchAlgorithmException {
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
%>
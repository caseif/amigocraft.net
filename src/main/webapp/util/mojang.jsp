<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.DataOutputStream" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.io.PrintWriter" %>

<%@ page import="java.net.URL" %>
<%@ page import="java.net.URLConnection" %>

<%@ page import="java.util.UUID" %>

<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONObject" %>

<%!
public UUID getUUID(String user){
	try {	
		URL		 url;
		URLConnection    urlConn;
		DataOutputStream cgiInput;
	
		// URL of target page script.
		url = new URL("https://api.mojang.com/profiles/minecraft");
		urlConn = url.openConnection();
	
		urlConn.setDoInput(true);
		urlConn.setDoOutput(true);
		urlConn.setUseCaches(false);
		urlConn.setRequestProperty("Content-Type", "application/json");
		
		cgiInput = new DataOutputStream(urlConn.getOutputStream());
		String content = "[\"" + user + "\"]";
		cgiInput.writeBytes(content);
		cgiInput.flush();
		cgiInput.close();
	
		BufferedReader cgiOutput = 
			new BufferedReader(new InputStreamReader(urlConn.getInputStream()));
		JSONArray json = new JSONArray(cgiOutput.readLine());
		if (json.length() == 0){
			return null;
		}
		JSONObject first = (JSONObject)json.get(0);
		return UUID.fromString(addDashes((String)first.get("id")));
	}
	catch (Exception ex){
		return null;
	}
}

public String addDashes(String uuid){
	return 	uuid.substring(0, 8) + "-" +
			uuid.substring(8, 12) + "-" +
			uuid.substring(12, 16) + "-" +
			uuid.substring(16, 20) + "-" +
			uuid.substring(20, 32);
}
%>
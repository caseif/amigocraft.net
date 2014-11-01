<!-- BEGIN STANDARD HEADER -->
<%
String user = null;
if (session.getAttribute("user") != null){
	user = (String)session.getAttribute("user");
}
else {
	if (request.getCookies() != null){
		for (Cookie c : request.getCookies()){
			if (c.getName().equals("user") && c.getValue() != null && !c.getValue().isEmpty()){
				user = c.getValue();
				break;
			}
		}
	}
}
%>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Amigocraft</title>
		<link rel="stylesheet" type="text/css" href="/css/main.css">
		<link rel="icon" type="image/png" href="/img/icon.png">
		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
		<%
		if (request.getRequestURL().toString().contains("donate"))
			out.println("<link rel='stylesheet' type='text/css' href='http://buycraft.net/assets/popup/style.css' />");
		%>
		<script type="text/javascript" src="http://buycraft.net/assets/popup/script.js"></script>
		<script type="text/javascript" src="/js/blur.js"></script>
		<script type="text/javascript">
		//<![CDATA[
		window.__CF=window.__CF||{};window.__CF.AJS={"ga_key":{"ua":"UA-29395328-1","ga_bs":"1"}};
		//]]>
		</script>
		<script type="text/javascript">
		if (getCookie("js") == null){
			document.cookie = "js=enabled;path=/";
		}

		$('html').blurjs({
			source: 'html',
			radius: 5,
			overlay: 'rgba(255, 255, 255, 0.5)'
		});

		function getCookie(c_name){
			var c_value = document.cookie;
			var c_start = c_value.indexOf(" " + c_name + "=");
			if (c_start == -1){
				c_start = c_value.indexOf(c_name + "=");
			}
			if (c_start == -1){
				c_value = null;
			}
			else {
				c_start = c_value.indexOf("=", c_start)+ 1;
				var c_end = c_value.indexOf(";", c_start);
				if (c_end == -1){
					c_end = c_value.length;
				}
				c_value = unescape(c_value.substring(c_start,c_end));
			}
			return c_value;
		}

		$(document).ready(setTimeout(function() {
			$('#footer').width($('#container').width());
			var contentHeight = $('#header').height() + $('#main-content').height();
			console.log('container: ' + $('#container').height());
			console.log('window: ' + $(window).height());
			console.log('margin: ' + ($(window).height() - $('#container').height()));
			var margin = $(window).height() - $('#container').height();
			if (margin > 0){
				$('#main-content').css('margin-bottom', margin + 16);
			}
		}, 50)); // I've spent 30 minutes trying to fix the CSS, so I'm giving up and just sticking in a delay
		</script>
	</head>
	<body>
		<div id="container">
			<div id="header">
				<div id="loginbar">
					<%
					if (user == null){
					%>
						<a href="/login/register.jsp?rd=
						<%= request.getRequestURI().toString().replace("/bleeding", "") %>
						">Register</a>
						<a href="/login/login.jsp?rd=
						<%= request.getRequestURI().toString().replace("/bleeding", "") %>
						">Login</a>
					<%
					}
					else {
					%>
					<a href="/login/logout.jsp?rd=
						<%= request.getRequestURI().toString().replace("/bleeding", "") %>
						">Logout</a>
					<%
					}
					%>
				</div>
				<div id="banner">
					<div id="logo">
						<img src="/img/block_small.png" alt="Amigocraft" width=85 height=85>
					</div>
					Amigocraft
				</div>
				<div id="linkbar">
					<span class="link"><a href="/">Home</a></span>
					<span class="link"><a href="/forums/">Forums</a></span>
					<span class="link"><a href="/donate/">Donate</a></span>
					<span class="link"><a href="/servers/">Servers</a></span>
					<span class="link"><a href="/downloads/">Downloads</a></span>
					<span class="link"><a href="/tos/">ToS</a></span>
					<span class="link"><a href="/help/">Help</a></span>
				</div>
			</div>
			<div id="main-content">
<!-- END STANDARD HEADER -->
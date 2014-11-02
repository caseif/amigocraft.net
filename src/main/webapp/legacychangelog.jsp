<%@ include file="/templates/header.jsp" %>
<div id="pagetitle">Legacy Site Changelog</div>
This is the site's legacy changelog file. It chronicles all notable (e.g. not things like "change title indentation") changes made to the website since October of 2013 up until the coversion to JSP in [TBA]. Revisions which skip a few numbers include changes made in each one of those revisions.
<br>
<ul>
	<li>Revision 38 (10/3/14, v3.7.1)</li>
	<ul>
		<li>Fix header font in IE</li>
		<li>Correct link color and formatting in post title in Firefox and IE</li>
	</ul>
</ul>
<ul>
	<li>Revision 37 (9/12/14, v3.7.0)</li>
	<ul>
		<li>Redesign forum threads</li>
	</ul>
</ul>
<ul>
	<li>Revision 36 (9/7/14, v3.6.1)</li>
	<ul>
		<li>Merge home feed with forums</li>
	</ul>
</ul>
<ul>
	<li>Revision 35 (9/6/14, v3.6.0)</li>
	<ul>
		<li>Rewrite SQL backend to use mysqli*</li>
		<li>Change display limit to 5 per page on home feed</li>
		<li>Cravatars now display helmets</li>
	</ul>
</ul>
<ul>
	<li>Revision 34 (3/19/14, v3.5.3)</li>
	<ul>
		<li>Swap banner and links bar background because Spring</li>
		<li>Remove banner snow also because Spring</li>
		<li>Remove blueish tint from body background are you seeing the pattern</li>
		<li>Add customization page to <a href="/theme.jsp">themes page</a></li>
		<li>Allow customization of background</li>
	</ul>
</ul>
<ul>
	<li>Revision 33 (3/1/14, v3.5.1)</li>
	<ul>
		<li>Implement <a href="http://cravatar.eu/">Cravatars</a> instead of <a href="http://gravatar.com/">Gravatars</a></li>
		<li>Replace Amigocraft banner with fancy-looking text</li>
		<li>Add "Servers" page</li>
		<li>Remove Live Map link in header</li>
	</ul>
</ul>
<ul>
	<li>Revision 32 (2/19/14, v3.5.0)</li>
	<ul>
		<li>Add basic markdown implementation</li>
		<li>Fix forums/delete.php CSS</li>
		<li>Update (fix) dark theme</li>
		<li>Revamp blockquotes to look more like Reddit's</li>
	</ul>
</ul>
<ul>
	<li>Revision 30 (2/12/14, v3.4.4)</li>
	<ul>
		<li>Minor tweaks to alert system (grey bar at top of page)*</li>
	</ul>
</ul>
<ul>
	<li>Revision 29 (1/26/14, v3.4.3)</li>
	<ul>
		<li>Add cryptocurency addresses to footer/donate page</li>
	</ul>
</ul>
<ul>
	<li>Revision 28 (1/19/14, v3.4.2)</li>
	<ul>
		<li>MySQL security improvements*</li>
	</ul>
</ul>
<ul>
	<li>Revision 27 (1/15/14, v3.4.1)</li>
	<ul>
		<li>Retire "Retro" theme (it's still available via direct URL)</li>
	</ul>
</ul>
<ul>
	<li>Revision 26 (1/3/14, v3.4.0)</li>
	<ul>
		<li>Lots of behind-the-scenes changes to validate several pages*</li>
	</ul>
</ul>
<ul>
	<li>Revision 24 (12/23/13, v3.3.0)</li>
	<ul>
		<li>Add toggleable snow to banner</li>
		<li>Change background of links in header to snowy grass</li>
		<li>Add Christmas icon just a day in advance</li>
	</ul>
</ul>
<ul>
	<li>Revision 23 (12/12/13, v3.2.8)</li>
	<ul>
		<li>Implement required fields in registration form (MC name, first name, and birthday are no longer required)</li>
		<li>Improve login page's response to bad logins (now it actually displays something)</li>
		<li>Decrease size of social icons</li>
	</ul>
</ul>
<ul>
	<li>Revision 21 (11/27/2013, v3.2.7)</li>
	<ul>
		<li>Add Thanksgiving and dynamic Hannukah icons with less than 10 minutes to spare</li>
		<li>Implement GeoIP for holiday icons (e.g. Thanksgiving icon only appears in U.S.)</li>
		<li>Move holiday icon script to separate file from header.php*</li>
	</ul>
</ul>
<ul>
	<li>Revision 20 (11/14/2013, v3.2.3)</li>
	<ul>
		<li>Refactor posts.php to thread.php*</li>
		<li>Replace header redirects with Javascript (header used as fallback when JS is disabled)*</li>
		<li>Modify stylization of thread.php</li>
		<li>Fix a bunch of little errors*</li>
	</ul>
</ul>
<ul>
	<li>Revision 16 (11/13/2013, v3.2.2.3)</li>
	<ul>
		<li>Change banner image at top of page</li>
	</ul>
</ul>
<ul>
	<li>Revision 15 (11/12/2013, v3.2.2.2)</li>
	<ul>
		<li>Add hover effect to social media icons</li>
	</ul>
</ul>
<ul>
	<li>Revision 14 (11/11/2013, v3.2.2.1)</li>
	<ul>
		<li>Change font of post content to Georgia</li>
	</ul>
</ul>
<ul>
	<li>Revision 13 (11/10/2013, v3.2.2)</li>
	<ul>
		<li>Change (decrease) font size almost everywhere</li>
		<li>Allow admins special permissions on forums*</li>
	</ul>
</ul>
<ul>
	<li>Revision 11 (11/9/2013, v3.2.0)</li>
	<ul>
		<li>Combine original posts and comments into same SQL table*</li>
		<li>Convert date/time storage of posts to Unix timestamp*</li>
		<li>Display time of each post on category page</li>
		<li>Fix post editing</li>
		<li>Implement sticky posts</li>
		<li>Fix delete button on feed*</li>
		<li>Improve thread creation button</li>
	</ul>
</ul>
<ul>
	<li>Revision 6 (10/29/2013, v3.1.5)</li>
	<ul>
		<li>Fix blockquotes</li>
		<li>Revamp forum category management (all categories are accessed via a single PHP page)*</li>
		<li>Remove text formatting from forum post titles</li>
		<li>Re-add "Edit" button to home page feed*</li>
		<li>Add Halloween surprise</li>
	</ul>
</ul>
<ul>
	<li>Revision 3 (10/28/2013, v3.1.2)</li>
	<ul>
		<li>Add blockquote support</li>
		<li>Fix newlines in forum posts</li>
		<li>Remove "To-do List" link from header</li>
		<li>Add revision number and link to changelog to footer</li>
	</ul>
</ul>
<ul>
	<li>Revision 1 (10/27/2013 v3.1.0)</li>
	<ul>
		<li>Change global font from Helvetica to Tahoma</li>
	</ul>
</ul>
*Invisible to normal users
<%@ include file="/templates/footer.jsp" %>
<%@ page import="java.io.*, java.util.*, com.jeantessier.dependency.*" %>
<%@ page errorPage="errorpage.jsp" %>

<!--
    Copyright (c) 2001-2003, Jean Tessier
    All rights reserved.
    
    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions
    are met:
    
    	* Redistributions of source code must retain the above copyright
    	  notice, this list of conditions and the following disclaimer.
    
    	* Redistributions in binary form must reproduce the above copyright
    	  notice, this list of conditions and the following disclaimer in the
    	  documentation and/or other materials provided with the distribution.
    
    	* Neither the name of Jean Tessier nor the names of his contributors
    	  may be used to endorse or promote products derived from this software
    	  without specific prior written permission.
    
    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
    "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
    LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
    A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR
    CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
    EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
    PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
    PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
    LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
    NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
    SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-->

<html>

<head>
<link rel="stylesheet" type="text/css" href="style.css" />
<title>Dependency Metrics <%= application.getInitParameter("name") %></title>
</head>

<!-- Reading the parameters and setting up the forms -->

<%
    String scope_includes = request.getParameter("scope-includes");
    if (scope_includes == null) {
	scope_includes = "//";
    }

    String scope_excludes = request.getParameter("scope-excludes");
    if (scope_excludes == null) {
	scope_excludes = "";
    }

    boolean package_scope = "on".equals(request.getParameter("package-scope"));
    if (request.getParameter("submit") == null) {
	package_scope = true;
    }

    boolean class_scope = "on".equals(request.getParameter("class-scope"));
    if (request.getParameter("submit") == null) {
	class_scope = true;
    }

    boolean feature_scope = "on".equals(request.getParameter("feature-scope"));
    if (request.getParameter("submit") == null) {
	feature_scope = true;
    }

    String filter_includes = request.getParameter("filter-includes");
    if (filter_includes == null) {
	filter_includes = "//";
    }

    String filter_excludes = request.getParameter("filter-excludes");
    if (filter_excludes == null) {
	filter_excludes = "";
    }

    boolean package_filter = "on".equals(request.getParameter("package-filter"));
    if (request.getParameter("submit") == null) {
	package_filter = true;
    }

    boolean class_filter = "on".equals(request.getParameter("class-filter"));
    if (request.getParameter("submit") == null) {
	class_filter = true;
    }

    boolean feature_filter = "on".equals(request.getParameter("feature-filter"));
    if (request.getParameter("submit") == null) {
	feature_filter = true;
    }

    boolean list_elements = "on".equals(request.getParameter("list-elements"));
    if (request.getParameter("submit") == null) {
	list_elements = false;
    }
%>

<body>

<form action="<%= request.getRequestURI() %>" method="post">

<table border="0" cellpadding="5"><tr><td colspan="2">

<p class="title">
<code><%= application.getInitParameter("name") %></code><br />
</p>

</td></tr><tr><td colspan="2">

<table frame="border" rules="cols" class="controls" width="100%"><tr>

<th class="navigation"><a href="query.jsp">Dependency graph</a></th>
<th class="navigation"><a href="closure.jsp">Transitive closure</a></th>
<th class="currentnavigation">Dependency metrics</th>

</tr></table>

</td></tr><tr><td colspan="2">

<table frame="border" rules="groups" class="controls">

    <colgroup span="2" />
    <colgroup span="2" />

    <tbody>
    <tr>
	<td colspan="2">
	    <b>Count programming elements</b>
	</td>
	<td colspan="2">
	    <b>Count dependencies</b>
	</td>
    </tr>
    <tr>
	<td align="center" colspan="2">
	    <input type="checkbox" name="package-scope" <%= package_scope ? "checked" : "" %> onMouseOver="window.status='Count packages'" onMouseOut="window.status=''">&nbsp;package
	    <input type="checkbox" name="class-scope" <%= class_scope ? "checked" : "" %> onMouseOver="window.status='Count classes (with their package)'" onMouseOut="window.status=''">&nbsp;class
	    <input type="checkbox" name="feature-scope" <%= feature_scope ? "checked" : "" %> onMouseOver="window.status='Count methods and fields (with their class and package)'" onMouseOut="window.status=''">&nbsp;feature
	</td>
	<td align="center" colspan="2">
	    <input type="checkbox" name="package-filter" <%= package_filter ? "checked" : "" %> onMouseOver="window.status='Count dependencies to/from packages'" onMouseOut="window.status=''">&nbsp;package
	    <input type="checkbox" name="class-filter" <%= class_filter ? "checked" : "" %> onMouseOver="window.status='Count dependencies to/from classes'" onMouseOut="window.status=''">&nbsp;class
	    <input type="checkbox" name="feature-filter" <%= feature_filter ? "checked" : "" %> onMouseOver="window.status='Count dependencies to/from methods and fields'" onMouseOut="window.status=''">&nbsp;feature
	</td>
    </tr>
    <tr>
	<td>
	    including:
	</td>
	<td>
	    excluding:
	</td>
	<td>
	    including:
	</td>
	<td>
	    excluding:
	</td>
    </tr>
    <tr>
	<td>
	    <input type="text" name="scope-includes" value="<%= scope_includes %>" onMouseOver="window.status='Package, class, method, or field must match any these expressions. E.g., /^com.mycompany/, /\\.get\\w+\\(/'" onMouseOut="window.status=''">
	</td>
	<td>
	    <input type="text" name="scope-excludes" value="<%= scope_excludes %>" onMouseOver="window.status='Package, class, method, or field must NOT match any of these expressions. E.g., /Test/'" onMouseOut="window.status=''">
	</td>
	<td>
	    <input type="text" name="filter-includes" value="<%= filter_includes %>" onMouseOver="window.status='Package, class, method, or field at the other end of the dependency must match any these expressions. E.g., /^com.mycompany/, /\\.get\\w+\\(/'" onMouseOut="window.status=''">
	</td>
	<td>
	    <input type="text" name="filter-excludes" value="<%= filter_excludes %>" onMouseOver="window.status='Package, class, method, or field at the other end of the dependency must NOT match any of these expressions. E.g., /Test/'" onMouseOut="window.status=''">
	</td>
    </tr>
    </tbody>

    <tbody>
    <tr>
        <td colspan="4" align="center">

<input type="checkbox" name="list-elements" <%= list_elements ? "checked" : "" %> onMouseOver="window.status='List packages, classes, methods, and fields'" onMouseOut="window.status=''">&nbsp;List programming elements

        </td>
    </tr>
    </tbody>
</table>

</td></tr><tr>

<td align="left"><font size="-1">Use Perl regular expressions, <a target="_blank" href="http://depfind.sourceforge.net/Manual.html#Perl+Regular+Expressions">see the manual</a></font></td>
<td align="right"><a href="advancedmetrics.jsp">advanced &gt;&gt;&gt;</a></td>

</tr><tr><td align="center" colspan="2">

<input type="submit" name="submit" value="Run Query"/>

</td></tr></table>

</form>

<hr size="3" />

<pre class="result">

<%
    if (request.getParameter("submit") != null) {
	if (application.getAttribute("factory") != null) {
	    Date start = new Date();

	    SelectiveTraversalStrategy strategy = new SelectiveTraversalStrategy();
		
	    strategy.PackageScope(package_scope);
	    strategy.ClassScope(class_scope);
	    strategy.FeatureScope(feature_scope);
	    strategy.ScopeIncludes(scope_includes);
	    strategy.ScopeExcludes(scope_excludes);
	
	    strategy.PackageFilter(package_filter);
	    strategy.ClassFilter(class_filter);
	    strategy.FeatureFilter(feature_filter);
	    strategy.FilterIncludes(filter_includes);
	    strategy.FilterExcludes(filter_excludes);

	    MetricsGatherer metrics = new MetricsGatherer(strategy);
	    metrics.TraverseNodes(((NodeFactory) application.getAttribute("factory")).Packages().values());
	
	    MetricsReport reporter = new MetricsReport(new PrintWriter(out));
	    reporter.ListElements(list_elements);
	    reporter.Process(metrics);

	    Date stop = new Date();

	    out.println();
%>

</pre>

<p><%= (stop.getTime() - start.getTime()) / (double) 1000 %> secs.</p>

<%
	} else {
%>

<h3>No dependency graph available</h3>

<p>Please ask the webmaster to extract a dependency graph before you start placing queries.</p>

<%
	}
    }
%>

</body>

</html>
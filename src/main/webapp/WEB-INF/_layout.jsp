<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8"  %>
<%
    String pageBody = (String) request.getAttribute("page-body");
    String context = request.getContextPath();
%>
<html>
<head>
    <title>Java Web</title>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    <link type="text/css" rel="stylesheet" href="css/materialize.min.css"  media="screen,projection"/>
    <link rel="stylesheet" href="<%=context%>/css/site.css?time=<%= new Date().getTime() %>">
</head>
<body>
<nav>
    <div class="nav-wrapper pink lighten-2">
        <a class="right modal-trigger site-logo" href="#auth-modal"><i class="material-icons">exit_to_app</i></a>
        <a href="<%=context%>/" class="site-logo
             right">JavaWeb</a>
        <ul id="nav-mobile">
            <li <%=pageBody.equals("jsp.jsp") ? "class='active'" : ""%>><a href="<%= context %>/jsp">JSP</a></li>
            <li <%=pageBody.equals("filters.jsp") ? "class='active'" : ""%>><a href="<%= context %>/filters">Filters</a></li>
            <li <%=pageBody.equals("ioc.jsp") ? "class='active'" : ""%>><a href="<%= context %>/ioc">IoC</a></li>
            <li <%=pageBody.equals("db.jsp") ? "class='active'" : ""%>><a href="<%= context %>/db">DB</a></li>
        </ul>
    </div>
</nav>

<div class="container">        <!-- Page Content goes here -->
    <jsp:include page="<%=pageBody%>"/>
</div>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
<script src="<%=context%>/js/site.js?time=<%= new Date().getTime() %>"></script>
<div id="auth-modal" class="modal">
    <div class="modal-content">
        <h4>Modal Header</h4>
        <p>A bunch of text</p>
    </div>
    <div class="modal-footer">
        <a href="<%=context%>/signup" class="modal-close waves-effect waves-green btn-flat pink lighten-2">Enter</a>
        <a href="<%=context%>/signup" class="modal-close waves-effect waves-green btn-flat pink lighten-2">Registration</a>
    </div>
</div>
<footer class="page-footer pink lighten-2">
    <div class="container">
        <div class="row">
            <div class="col l6 s12">
                <h5 class="white-text">Footer Content</h5>
                <p class="grey-text text-lighten-4">You can use rows and columns here to organize your footer content.</p>
            </div>
        </div>
    </div>
    <div class="footer-copyright">
        <div class="container">
            © 2023 Copyright Text
            <a class="grey-text text-lighten-4 right" href="#!">More Links</a>
        </div>
    </div>
</footer>
</body>
</html>
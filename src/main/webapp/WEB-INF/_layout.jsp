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
    <link rel="stylesheet" href="<%=context%>/css/site.css">
</head>
<body>
<nav>
    <div class="nav-wrapper pink lighten-2">
        <a class="right modal-trigger site-logo" href="#auth-modal"><i class="material-icons">exit_to_app</i></a>
        <a href="<%=context%>/" class="site-logo
             right">JavaWeb</a>
        <ul id="nav-mobile">
            <li <%= "filters.jsp".equals(pageBody) ? "class='active'" : "" %>><a href="<%= context%>/jsp">JSP</a></li>
            <li <%= "filters.jsp".equals(pageBody) ? "class='active'" : "" %>><a href="<%= context%>/filters">Filters</a></li>
            <li <%= "filters.jsp".equals(pageBody) ? "class='active'" : "" %>><a href="<%= context%>/ioc">IOC</a></li>
        </ul>
    </div>
</nav>
<div class="container">
    <jsp:include page="<%=pageBody%>"/>
</div>
<footer class="page-footer pink lighten-2">
    <div class="container">
        <div class="row">
            <div class="col l6 s12">
                <h5 class="white-text">Footer Content</h5>
                <p class="grey-text text-lighten-4">You can use rows and columns here to organize your footer content.</p>
            </div>
            <div class="col l4 offset-l2 s12">
                <h5 class="white-text">Links</h5>
                <ul>
                    <li><a class="grey-text text-lighten-3" href="#!">Link 1</a></li>
                    <li><a class="grey-text text-lighten-3" href="#!">Link 2</a></li>
                    <li><a class="grey-text text-lighten-3" href="#!">Link 3</a></li>
                    <li><a class="grey-text text-lighten-3" href="#!">Link 4</a></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="footer-copyright">
        <div class="container">
            © 2014 Copyright Text
            <a class="grey-text text-lighten-4 right" href="#!">More Links</a>
        </div>
    </div>
</footer>
<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
<script src="<%=context%>/js/site.js"></script>
<div id="auth-modal" class="modal">
    <div class="modal-content">
        <h4>Modal Header</h4>
        <p>A bunch of text</p>
    </div>
    <div class="modal-footer">
        <a href="#<%=context%>/signup" class="modal-close waves-effect waves-green btn-flat pink lighten-2">Enter</a>
        <a href="#<%=context%>/signup" class="modal-close waves-effect waves-green btn-flat pink lighten-2">Registration</a>
    </div>
</div>
</body>
</html>

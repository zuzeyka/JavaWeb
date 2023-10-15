<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>JSP</title>
</head>
<body>
<h1>Java Web. Вступ</h1>
<p>Новий проєкт - архетип webapp.
    Для запуску проєкту потрібен веб-сервер. Варіанти:
    Tomcat (8), Glassfish (4-5), WildFly (22) та інші.
    Ключовий момент - обираємо версію з підтримкою javax.
    Будь-який з них завантажується архівом та просто розпаковується.</p>
<%
    String str = "Hello";
    str += ", world!";
    int x = 10;
%>
<p>str = <%= str %>, x + 5 = <%= x + 5 %></p>
<ul>
    <% for(int i = 0; i < 5; i++) {%>
    <li>Item # <%=i + 1%></li>
    <% } %>
</ul>
<jsp:include page="fragment.jsp"/>
<h2>Сервлети</h2>
<p>
    Сервлети - це класи Java, призначені для роботи з мережними задачами.
    Для роботи з ними треба встановити Servlet API (за допомогою Maven).
    Після створення класу сервлету його треба включити в маршрутизацію
</p>
<ul>
    <li>За допомогою web.xml</li>
    <li>За допомогою анотацій</li>
    <li>За допомогою IoC</li>
</ul>

</body>
</html>
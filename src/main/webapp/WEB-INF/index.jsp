<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <% for (int i = 0; i < 5; i++){ %>
        <li>
            Item No <%= i + 1 %>
        </li>
    <% } %>
</ul>
<jsp:include page="fragment.jsp"/>

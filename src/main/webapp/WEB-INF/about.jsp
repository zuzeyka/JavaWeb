<%@ page import="java.util.Random" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>About</title>
</head>

<body>
<h3>Змінні: </h3>
<p>Створимо змінную str, та виведемо її у &lt;i></p>
<p>&lt;%String str = "Hello, world";%></p>
<%String str = "Hello world";%>
<i>str = "<%=str%>"</i>
<p>Зробимо конкатенацію str та ":)"</p>
<p>&lt;%str += ":)";%></p>
<%str += ":)";%>
<i>str = "<%=str%>"</i>
<h3>Цикли: </h3>
<p>Створимо маркований список з 10 елементів:</p>
<ul class="collection with-header">
    <li class="collection-header"><h4>10 елементів циклічно</h4></li>
    <%for (int i = 0; i < 10; i++) {%>
    <li class="collection-item">Item#<%=i + 1%>
    </li>
    <%}%>
</ul>
<h3>Умовні конструкції: </h3>
<p>Створимо цілочислену зміну, у яку буде записуватись випадкове число</p>
<p>Якщо парне рендериться один фрагмент, інакше рендериться другий фрагмент</p>
<% int randValue = new Random().nextInt(50);%>
<h2>Число: <%=randValue%>
</h2>
<%if (randValue % 2 == 0) {%>
<jsp:include page="firstfragment.jsp"/>
<%} else {%>
<jsp:include page="secondfragment.jsp"/>
<%}%>
</body>
</html>

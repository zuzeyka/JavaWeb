<%@ page import="step.learning.dto.entitites.CallMe" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8"  %>
<%
    String connectionStatus = (String) request.getAttribute("connectionStatus");
    List<CallMe> calls = (List<CallMe>) request.getAttribute("calls");
%>
<h1>Работа с базами данных</h1>
<h2>JDBC</h2>
<p>
    <strong>JDBC</strong> - Java DataBase Connectivity - технология
    доступа к данным, аналогична подобным ADO, PDO и.т.д.
    Главная идея - создания подключения, формироване запроса и передача
    его в СУБД, получение результатов исполнения запроса и данных,
    которые их возвращаются
</p>
<p>
    Технолония предоставляет универсальный интерфейс доступа к данным
    (однинаковый для разных СУБД), конкретная реализация производится
    путём подключения драйвера соотвествия БД (которые так же называют конекторами)
    Настройка подключения осуществляет путём регистрации драйвера и отправки запроса
    к СУБД на счет подлючения (автентефикации).
    Напоминаем, что пароли к БД следует сохранять в отдельном файле (конфигурации)
</p>
<p>
    Поскольку данные про подключения могуд понадобиться в
    разных частях проэкта наиболее уместно
</p>
<p>
    Статус подключения: <strong><%= connectionStatus%></strong>
</p>
<p>
    При работе нескольких сервисов с одной БД используется подход
    разлечения таблиц с помощью смех или префиксов. Не все БД
    поддерживают схемы (MS SQL - да, MySQL - нет)
</p>
<h2>Управление данными</h2>
<p>
    <button id="db-create-button" class="waves-effect pink lighten-2 btn"><i class="material-icons right">cloud</i>create</button>
    <input name="user-name" placeholder="Name" type="text">
    <input name="user-phone" placeholder="Phone" type="tel">
    <span id="phone-error" style="color: red; display: none;">Invalid phone number</span>
    <button id="db-insert-button" class="waves-effect pink lighten-2 btn" onclick="validatePhone()"><i class="material-icons right">phone_iphone</i>Order call</button>
    <br>
    <u id="out"></u>
</p>
<div class="row">
    <button id="db-read-button" class="waves-effect pink lighten-2 btn"><i class="material-icons right">view_list</i>Check order</button>
</div>

<table>
    <thead>
    <tr>
        <th>Name</th>
        <th>Phone</th>
    </tr>
    </thead>
    <tbody>
    <% if (calls != null) {for (CallMe call : calls) { %>
    <tr>
        <td><%= call.getName() %></td>
        <td><%= call.getPhone() %></td>
    </tr>
    <% }} %>
    </tbody>
</table>

<script>
    function validatePhone() {
        var phoneInput = document.querySelector('[name="user-phone"]');
        var phoneError = document.getElementById('phone-error');
        var phonePattern = /^\+38\s?(\(\d{3}\)|\d{3})\s?\d{3}(-|\s)?\d{2}(-|\s)?\d{2}$/;
        var isValidPhone = phonePattern.test(phoneInput.value);

        if (!isValidPhone) {
            phoneError.style.display = 'block';
        } else {
            phoneError.style.display = 'none';
            // Proceed with order placement
        }
    }
</script>
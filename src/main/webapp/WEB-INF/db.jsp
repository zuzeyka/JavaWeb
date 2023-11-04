<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String connectionStatus = (String) request.getAttribute("connectionStatus");
%>
<h1>Робота з базами даних</h1>
<h2>JDBC</h2>
<p>
    <strong>JDBC</strong> - Java DataBase Connectivity - технологія
    доступу до даних, аналогічна подібним ADO, PDO тощо.
    Головна ідея - створення підключення, формування запиту та передача
    його до СУБД, одержання результатів виконання запиту та даних, що
    ним повертаються
</p>
<p>
    Технологія надає універсальний інтерфейс доступу до даних (однаковий
    для різних СУБД), конкретна реалізація здійснюється шляхом підключення
    драйверів відповідної БД (які також називають конекторами)
    Налаштування підключення здійснюється шляхом реєстрації драйвера
    та надсилання запиту до СУБД щодо підключення (автентифікації).
    Нагадуємо, що паролі до БД слід зберігати в окремому файлі (конфігурації)
    який вилучено з Git (.gitigonre)
</p>
<p>
    Оскільки дані про підключення можуть знадобитись у різних частинах проєкту найбільш доцільно створювати його у
    вигляді окремого сервісу
</p>

<p>
    Статус підключення: <strong><%=connectionStatus%>
</strong>
</p>
<p>
    При роботі кількох сервісів з однією БД вживається підхід з
    розрізнення таблиць за допомогою схем або префіксів. Не всі
    БД підтримують схеми (MS SQL - так, MySQL - ні)
</p>
<h2>Управління даними</h2>
<p>
    <button id="db-create-button"
            class="waves-effect waves-light btn pink lighten-2">
        Create Phone Table
    </button>
<div class="input-field col s6">
    <input value id="user-name" name="user-name" type="text" class="validate">
    <label for="user-name">Ім'я</label>
    <span id="nameError" class="helper-text" data-error=""></span>
</div>
<div class="row">
    <div class="input-field col s10">
        <input placeholder="Телефон" name="user-phone" id="user-phone" type="text" class="validate">
        <%--        <label class="active" for="user-phone">Телефон</label>--%>
        <span id="phoneError" class="helper-text" data-error=""></span>

    </div>
    <div class="input-field col s2">
        <button id="number-generate-button"
                class="waves-effect waves-light btn pink lighten-2">
            <i class="material-icons right">autorenew</i>
            Generate
        </button>
    </div>
</div>
<button id="db-insert-button"
        class="waves-effect waves-light btn pink lighten-2">
    <i class="material-icons right">phone_iphone</i>
    Замовити дзвінок
</button>
<p id="lastId"></p>
<br/>
<u id="out"></u>
</p>
<div class="row">
    <button id="db-read-button"
            class="waves-effect waves-light btn pink lighten-2">
        <i class="material-icons right">view_list</i>
        Переглянути замовлення
    </button>
    <button id="db-readall-button"
            class="waves-effect waves-light btn pink lighten-2">
        <i class="material-icons right">delete</i>
        Переглянути всі замовлення
    </button>
    <div class="col s12" id="cardTable">
        <div class="card">
            <div class="card-content">
                <span class="card-title"><h4>Call me</h4></span>
                <div id="orderTable" class="row">
                </div>
            </div>
        </div>
    </div>
</div>


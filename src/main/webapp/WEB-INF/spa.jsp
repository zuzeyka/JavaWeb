<%@ page contentType="text/html;charset=UTF-8"%>
<h1>SPA</h1>

<p>
  Автентифікація та авторизація за допомогою токенів здійснюється наступним чином:<br/>
- користувач вводить логін та пароль, формується асинхронний запит до АРІ авторизації, у відповідь отримується токен.<br/>
- токен перевіряється на цілісність та зберігається у локальному сховищі. Подальші запити включають одержаний токен до заголовків.
</p>
<p>
    Наявність токену на сторінці: <b id="spa-token-status"></b>
</p>
<auth-part></auth-part>
<button class="btn pink lighten-2" id="spa-get-data">Data</button>
<button class="btn pink lighten-2" id="spa-log-out">Exit</button>

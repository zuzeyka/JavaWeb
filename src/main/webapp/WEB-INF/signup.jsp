<%@ page contentType="text/html;charset=UTF-8" %>
<h2>Реєстрація користувача</h2>
<div class="row">
    <form class="col s12" method="post" action="">
        <div class="row">
            <div class="input-field col s6">
                <i class="material-icons prefix">badge</i>
                <input value="user" id="reg-login" name="reg-login" type="text" class="validate">
                <label for="reg-login">Логін на сайті</label>
            </div>
            <div class="input-field col s6">
                <i class="material-icons prefix">person</i>
                <input value="Experiensed user" id="reg-name" name="reg-name" type="text" class="validate">
                <label for="reg-name">Реальне ім'я</label>
            </div>
        </div>
        <div class="row">
            <div class="input-field col s6">
                <i class="material-icons prefix">lock</i>
                <input value="123" id="reg-password" name="reg-password" type="password" class="validate">
                <label for="reg-password">Пароль</label>
            </div>
            <div class="input-field col s6">
                <i class="material-icons prefix">lock_open</i>
                <input value="123" id="reg-repeat" name="reg-repeat" type="password" class="validate">
                <label for="reg-repeat">Повторіть пароль</label>
            </div>
        </div>
        <div class="row">
            <div class="input-field col s6">
                <i class="material-icons prefix">alternate_email</i>
                <input value="user@mail.net" id="reg-email" name="reg-email" type="email" class="validate">
                <label for="reg-email">E-mail</label>
            </div>
            <div class="input-field col s6">
                <i class="material-icons prefix">cake</i>
                <input value="2000-01-01" id="reg-birthdate" name="reg-birthdate" type="date" class="validate">
                <label for="reg-birthdate">Дата народження</label>
            </div>
        </div>
        <div class="row">
            <div class="input-field col s6">
                <i class="material-icons prefix">receipt_long</i>
                <label> &emsp;
                    <input id="reg-rules" name="reg-rules" type="checkbox" class="filled-in validate">
                    <span>Не буду нічого порушувати</span>
                </label>
            </div>

            <div class="input-field col s6 right-align">
                <button class="waves-effect waves-light btn pink lighten-2"><i class="material-icons right">how_to_reg</i>Реєстрація</button>
            </div>
        </div>
    </form>
</div>

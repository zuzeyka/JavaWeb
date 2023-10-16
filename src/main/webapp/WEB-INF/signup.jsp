<%@ page import="step.learning.dto.models.RegFormModel" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<h2>Реєстрація користувача</h2>
<%
    RegFormModel model = (RegFormModel) request.getAttribute("reg-model");
    String loginValue = model == null ? "" : model.getLogin();
    String nameValue = model == null ? "" : model.getName();
    String emailValue = model == null ? "" : model.getEmail();
    String birthdateValue = model == null ? "" : model.getBirthdateAsString();
    Map<String,String> errors = model == null ? new HashMap<String,String>() : model.getErrorMessages();
    String regMessage = (String) request.getAttribute("reg-message");
     if(regMessage == null)
    {
        regMessage = "";
    }
%>
<p><%= regMessage %></p>
<div class="row">
    <form class="col s12" method="post" action="" enctype="multipart/form-data">
        <div class="row">
            <div class="input-field col s6">
                <i class="material-icons prefix">badge</i>
                <input value="<%=loginValue%>" id="reg-login" name="reg-login" type="text" class="validate">
                <span id="loginError" class="helper-text red-text" data-error="wrong" data-success="right"></span>
                <label for="reg-login">Логін на сайті</label>
            </div>
            <div class="input-field col s6">
                <i class="material-icons prefix">person</i>
                <input value="<%=nameValue%>" id="reg-name" name="reg-name" type="text" class="validate">
                <label for="reg-name">Реальне ім'я</label>
                <span id="nameError" class="helper-text red-text" data-error="wrong" data-success="right"></span>
            </div>
        </div>
        <div class="row">
            <div class="input-field col s6">
                <i class="material-icons prefix">lock</i>
                <input  id="reg-password" name="reg-password" type="password" class="validate">
                <label for="reg-password">Пароль</label>
                <span id="passwordError" class="helper-text red-text" data-error="wrong" data-success="right"></span>
            </div>
            <div class="input-field col s6">
                <i class="material-icons prefix">lock_open</i>
                <input  id="reg-repeat" name="reg-repeat" type="password" class="validate">
                <label for="reg-repeat">Повторіть пароль</label>
                <span id="repeatError" class="helper-text red-text" data-error="wrong" data-success="right"></span>
            </div>
        </div>
        <div class="row">
            <div class="input-field col s6">
                <i class="material-icons prefix">alternate_email</i>
                <input value="<%=emailValue%>" id="reg-email" name="reg-email" type="email" class="validate">
                <label for="reg-email">E-mail</label>
                <span id="emailError" class="helper-text red-text" data-error="wrong" data-success="right"></span>
            </div>
            <div class="input-field col s6">
                <i class="material-icons prefix">cake</i>
                <input value="<%=birthdateValue%>>" id="reg-birthdate" name="reg-birthdate" type="date" class="validate">
                <label for="reg-birthdate">Дата народження</label>
                <span id="birthdateError" class="helper-text red-text" data-error="wrong" data-success="right"></span>
            </div>
        </div>
        <div class="row">
            <div class="input-field col s6">
                <i class="material-icons prefix">receipt_long</i>
                <label> &emsp;
                    <input id="reg-rules" name="reg-rules" type="checkbox" class="filled-in validate">
                    <span>Не буду нічого порушувати</span>
                    <span id="rulesError" class="helper-text red-text" data-error="wrong" data-success="right"></span>
                </label>
            </div>

            <div class="file-field input-field col s6">
                <div class="btn pink lighten-2">
                    <span>File</span>
                    <input  name="reg-avatar" type="file">
                </div>
                <div class="file-path-wrapper">
                    <input placeholder="Upload file" class="file-path validate" type="text">
                </div>
            </div>

            <div class="input-field col s6 right-align">
                <button name="submitButton" class="waves-effect waves-light btn pink lighten-2" onclick="return validateForm();"><i class="material-icons right">how_to_reg</i>Реєстрація</button>
            </div>
        </div>
    </form>
</div>
<script>
    function validateForm() {
        var loginValue = document.getElementById("reg-login").value;
        var nameValue = document.getElementById("reg-name").value;
        var passwordValue = document.getElementById("reg-password").value;
        var repeatValue = document.getElementById("reg-repeat").value;
        var emailValue = document.getElementById("reg-email").value;
        var birthdateValue = document.getElementById("reg-birthdate").value;
        var rulesCheckbox = document.getElementById("reg-rules");

        var errors = {};

        if (loginValue.trim() === "") {
            errors.login = "Логін обов'язковий для заповнення";
        }

        if (nameValue.trim() === "") {
            errors.name = "Реальне ім'я обов'язкове для заповнення";
        }

        if (passwordValue.trim() === "") {
            errors.password = "Пароль обов'язковий для заповнення";
        }

        if (repeatValue.trim() === "") {
            errors.repeat = "Повторіть пароль";
        } else if (passwordValue !== repeatValue) {
            errors.repeat = "Паролі не співпадають";
        }

        if (emailValue.trim() === "") {
            errors.email = "E-mail обов'язковий для заповнення";
        }

        if (birthdateValue.trim() === "") {
            errors.birthdate = "Дата народження обов'язкова для заповнення";
        }

        if (!rulesCheckbox.checked) {
            errors.rules = "Для реєстрації вам необхідно прийняти правила";
        }

        // Проверка на наличие ошибок
        if (Object.keys(errors).length > 0) {
            // Вывод ошибок
            for (var key in errors) {
                var errorSpan = document.getElementById(key + "Error");
                if (errorSpan) {
                    errorSpan.innerHTML = errors[key];
                }
            }
            return false; // Остановите отправку формы
        }
        return true; // Разрешите отправку формы, если все поля заполнены корректно
    }
</script>

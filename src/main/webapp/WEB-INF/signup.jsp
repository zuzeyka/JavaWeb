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
                <label for="reg-login">Логін на сайті</label>
            </div>
            <div class="input-field col s6">
                <i class="material-icons prefix">person</i>
                <input value="<%=nameValue%>" id="reg-name" name="reg-name" type="text" class="validate">
                <label for="reg-name">Реальне ім'я</label>
                <% if(errors.containsKey("name")){ %>
                    <span class="helper-text" data-error="wrong"<%=errors.get("name")%> data-success="right">Helper text</span>
                <% } %>
            </div>
        </div>
        <div class="row">
            <div class="input-field col s6">
                <i class="material-icons prefix">lock</i>
                <input  id="reg-password" name="reg-password" type="password" class="validate">
                <label for="reg-password">Пароль</label>
            </div>
            <div class="input-field col s6">
                <i class="material-icons prefix">lock_open</i>
                <input  id="reg-repeat" name="reg-repeat" type="password" class="validate">
                <label for="reg-repeat">Повторіть пароль</label>
            </div>
        </div>
        <div class="row">
            <div class="input-field col s6">
                <i class="material-icons prefix">alternate_email</i>
                <input value="<%=emailValue%>" id="reg-email" name="reg-email" type="email" class="validate">
                <label for="reg-email">E-mail</label>
            </div>
            <div class="input-field col s6">
                <i class="material-icons prefix">cake</i>
                <input value="<%=birthdateValue%>>" id="reg-birthdate" name="reg-birthdate" type="date" class="validate">
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
                <button class="waves-effect waves-light btn pink lighten-2"><i class="material-icons right">how_to_reg</i>Реєстрація</button>
            </div>
        </div>
    </form>
</div>
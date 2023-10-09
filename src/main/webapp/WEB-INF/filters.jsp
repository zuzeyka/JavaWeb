<%@ page contentType="text/html;charset=UTF-8"  %>
<h1>Сервлетные фильтры</h1>
<p>
    Фильтры (сервлетные фильтры) - классы для сетевых задач,
    которые создают фомализм "Middleware" - активности "промежуточного уровня".
    Эта активность операжает роботе сервлетив и могут выполнятся
    до маршутизации, то есть для всех запросовов (на все адреса, произвольным
    методом: GET, POST, ...). Более того, дополнительные фильтры могут
    "встраиаваться" в уже сужествующую цепь визовов (вставляется в середину, в
    "промежуточный уровень")
</p>
<p>
    На примере CharsetFilter реализуем задачу установки кодировки домена request и response.
    Эта процедура может быть осуществлена в модуле разбора пути, особенно если принимаем мультибайт кодирования.
</p>
<ul>
    <li>
        Создадим новый пакет filters, у него новый класс CharsetFilter
    </li>
    <li>
        Имплементируем в этом классе интерфейс javax.servlet.Filter (!
        обратить внимает, ибо типов Filter есть несколько в разных пакетах)
    </li>
    <li>
        При имплементации не забываем, что продолжение цепи фильтров
        должен быть реализован в нем, если не продолжить, дальше фильтра
        запрос обрабатываться не будет. Это тоже модет быть использовано, но
        осмыслено
    </li>
    <li>
        Регестрируем фильтр. Для этого есть те же самые возможности,
        что и для сервлетов, но в случае фильтров их порядок довольно часто
        играет ключевую роль. Поэтому регистрация с помощью
        анотацый - худший вариант. Дальше см. web.xml
    </li>
    <li>
        Для передачи данных по цепи используем атрибуты
        <code>req.setAtribute("charsetName", charsetName);</code>
        Получить эти данные можно где угодно (после фильтра), например
        в JSP: charsetName = '<%= request.getAttribute("charsetName")%>'
    </li>
</ul>
<%@ page contentType="text/html;charset=UTF-8"%>
<h1>Инверсия управление в веб-приложении</h1>
<ul>
    <li>
        Добавляем зависимости:
        Guice Core
        Guice servlet
    </li>
    <li class="collection-item">
        Создаем пакет "ioc", в котором объявляем класс – слушатель события
        образование контекста (IocContextListener), наследуем от
        GuiceServletContextListener, имплементируем метод getInjector()
    </li>
    <li class="collection-item">
        Регистрируем этот класс в качестве слушателя (обработчика) события
        создание контекста в web.xml, тут же регистрируем фильтр, но
        не наш, а Guice (com.google.inject.servlet.GuiceFilter)
    </li>
    <li class="collection-item">
        Создаем конфигурационные модули для инжектора (в пакете ioc):
        RouterModule (для настройки сервлетов и фильтров),
        ServicesModule (для настройки служб).
        В классе IocContextListener указываем объекты этих классов
    </li>
    <li class="collection-item">
        Переносим конфигурацию (роутинг) фильтров и сервлетов
        в RouterModule: удаляем из web.xml все записи (кроме новых),
        а также снимаем аннотации @WebFilter и @WebServlet
    </li>
    <li class="collection-item">
        !!! Добавляем аннотацию @Singleton ко всем классам фильтров и
        сервлетов
    </li>

    <li class="collection-item">
        Проверяем: hash(123) = <%= request.getAttribute("hash") %> rand(123) = <%= request.getAttribute("rand")%>
    </li>


</ul>
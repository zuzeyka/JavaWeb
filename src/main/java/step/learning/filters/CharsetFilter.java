package step.learning.filters;

import com.google.inject.Singleton;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
@Singleton
public class CharsetFilter implements Filter {
    private FilterConfig filterConfig ;
    public void init(FilterConfig filterConfig) throws ServletException {
        this.filterConfig = filterConfig ;
    }
    public void doFilter(                      // Основний метод, який викликається Servlet-API
            ServletRequest servletRequest,     // об'єкти запиту та відповіді, але !!!
            ServletResponse servletResponse,   // приходять як узагальнені (не НТТР)
            FilterChain filterChain            // Ланцюг фільтрів для продовження
    ) throws IOException, ServletException {
        // Прямий хід - етап надходження запиту
        // через то что входные параметры имеют обощенный тип
        // для определенных задач их нужно явно преобразовать
        HttpServletRequest req = (HttpServletRequest) servletRequest;
        HttpServletResponse resp = (HttpServletResponse) servletResponse;
        // с этого момента это те же объекты что и в сервлетах
        String charsetName = StandardCharsets.UTF_8.name();
        req.setCharacterEncoding(charsetName);
        resp.setCharacterEncoding(charsetName);
        // для передачи данных по цепи используем атрибуты
        req.setAttribute("charsetName", charsetName);
        // передача роботи по ланцюгу
        filterChain.doFilter( servletRequest, servletResponse ) ;

        // Зворотний хід - етап надсилання відповіді
    }
    public void destroy() {
        this.filterConfig = null;
    }
}

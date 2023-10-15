package step.learning.filters;

import com.google.inject.Singleton;

import javax.servlet.*;
import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.nio.charset.StandardCharsets;
import java.util.logging.LogRecord;

@Singleton
public class CharsetFilter implements Filter {
    private FilterConfig filterConfig ;
    private String avatar;
    public void init(FilterConfig filterConfig) throws ServletException {
        this.filterConfig = filterConfig ;
    }
    public void doFilter(                      // Основний метод, який викликається Servlet-API
                                               ServletRequest servletRequest,     // об'єкти запиту та відповіді, але !!!
                                               ServletResponse servletResponse,   // приходять як узагальнені (не НТТР)
                                               FilterChain filterChain            // Ланцюг фільтрів для продовження
    ) throws IOException, ServletException {
        // Прямий хід - етап надходження запиту

        HttpServletRequest req = (HttpServletRequest) servletRequest;
        HttpServletResponse resp = (HttpServletResponse) servletResponse;
        req.setCharacterEncoding(StandardCharsets.UTF_8.name());
        String charsetName = StandardCharsets.UTF_8.name();
        req.setCharacterEncoding(charsetName);
        resp.setCharacterEncoding(charsetName);
        req.setAttribute("charsetName", charsetName);
        // передача роботи по ланцюгу
        filterChain.doFilter( servletRequest, servletResponse ) ;

        // Зворотний хід - етап надсилання відповіді
    }
    public void destroy() {
        this.filterConfig = null;
    }

}

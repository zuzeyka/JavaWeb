package step.learning.ioc;

import com.google.inject.servlet.ServletModule;
import step.learning.filters.CharsetFilter;
import step.learning.servlets.*;

public class RouterModule extends ServletModule {
    @Override
    protected void configureServlets()
    {
        // Третій спосіб конфігурування фільтрів сервлетів - ІоС
        filter("/*").through(CharsetFilter.class);
        serve("/auth").with(AuthSevlet.class);
        serve("/").with(HomeServlet.class);
        serve("/db").with(DbServlet.class);
        serve("/filters").with(FiltersServlet.class);
        serve("/jsp").with(JspServlet.class);
        serve("/ioc").with(IocServlet.class);
        serve("/signup").with(SignupServlet.class);
        serve("/spa").with(SpaServlet.class);
        serve("/tpl/*").with(TemplatesServlet.class);
    }
}

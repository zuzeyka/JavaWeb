package step.learning.servlets;

import step.learning.dto.models.RegFormModel;

import javax.inject.Singleton;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;

@Singleton
public class SignupServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("page-body", "signup.jsp");
        req.getRequestDispatcher("WEB-INF/_layout.jsp")
                .forward(req, resp); // - return View()
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp){
        RegFormModel model;
        try {
            model = new RegFormModel(req);
        }
        catch (ParseException ex){
            throw new RuntimeException(ex);
        }
        req.getSession().setAttribute("req-model", model);
    }
}

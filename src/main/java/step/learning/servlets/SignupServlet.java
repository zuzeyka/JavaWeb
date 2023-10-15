package step.learning.servlets;

import com.google.inject.Inject;
import com.google.inject.Singleton;
import step.learning.dto.models.RegFormModel;
import step.learning.services.formparse.FormParseResult;
import step.learning.services.formparse.FormParseService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.ParseException;

@Singleton
public class SignupServlet extends HttpServlet {
    private final FormParseService formParseService ;

    @Inject
    public SignupServlet(FormParseService formParseService) {
        this.formParseService = formParseService;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // перевіряємо, чи повідомлення у сесії
        HttpSession session = req.getSession() ;
        Integer regStatus = (Integer) session.getAttribute( "reg-status" ) ;
        if( regStatus != null ) {  // є повідомлення (redirect)
            // видаляємо його з сесії
            session.removeAttribute( "reg-status" ) ;
            // та передаємо дані у атрибути запиту
            String message ;
            if( regStatus == 0 ) {
                message = "Помилка оброблення даних форми";
            }
            else if( regStatus == 1 ) {
                message = "Помилка валідації даних форми";
                req.setAttribute( "reg-model", session.getAttribute("reg-model") ) ;
                session.removeAttribute( "reg-model" ) ;
            }
            else {
                message = "Реєстрація успішна";
            }
            req.setAttribute( "reg-message", message ) ;
        }
        req.setAttribute( "page-body", "signup.jsp" ) ;
        req.getRequestDispatcher( "WEB-INF/_layout.jsp" ).forward( req, resp ) ;
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        FormParseResult formParseResult = formParseService.parse( req ) ;
        RegFormModel model ;
        try {
            model = new RegFormModel( formParseResult ) ;
        }
        catch( ParseException ex ) {
            // throw new RuntimeException(ex);
            model = null ;
        }
        // Перевірка наявності файлу (та його збереження)


        // Зберігаємо необхідні дані у сесії та повертаємо на ГЕТ
        // шляхом відповіді-редиректу
        HttpSession session = req.getSession() ;
        if( model == null ) {
            // стан помилки розбору форми
            session.setAttribute( "reg-status", 0 ) ;
        }
        else if( ! model.getErrorMessages().isEmpty() ) {
            // стан помилки валідації - зберігаємо саму модель
            //  для відновлення даних на формі введення
            session.setAttribute( "reg-model", model ) ;
            session.setAttribute( "reg-status", 1 ) ;
        }
        else {
            // стан успішної обробки моделі - передаємо лише повідомлення
            session.setAttribute( "reg-status", 2 ) ;
        }
        resp.sendRedirect( req.getRequestURI() ) ;
    }
}
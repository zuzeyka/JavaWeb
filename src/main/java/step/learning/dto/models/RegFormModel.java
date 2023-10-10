package step.learning.dto.models;

import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class RegFormModel {
    private String name;
    private String login;
    private String password;
    private String repeat;
    private String email;
    private Date birthdate;
    private boolean isAgree;

    public RegFormModel(HttpServletRequest request) {
        this.setName(request.getParameter("req-name"));
        this.setLogin(request.getParameter("req-login"));
        this.setPassword(request.getParameter("req-password"));
        this.setRepeat(request.getParameter("req-repeat"));
        this.setEmail(request.getParameter("req-email"));
        try {
            this.setBirthdate(request.getParameter("req-repeat"));
        } catch (ParseException e) {
            throw new RuntimeException(e);
        }
        this.setIsAgree("req-rules");
    }

    private static final SimpleDateFormat formDateFormat = new SimpleDateFormat("yyyy-MM-dd");

    public String getName() {
        return name;
    }

    public void setIsAgree( String isAgree ) {
        this.isAgree = "on".equalsIgnoreCase( isAgree ) ||
                "true".equalsIgnoreCase( isAgree ) ;
    }

    public void setBirthdate(String birthdate) throws ParseException {
        this.birthdate = formDateFormat.parse(birthdate);
    }

    public void setBirthdate(Date birthdate) throws ParseException {
        this.birthdate = birthdate;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setRepeat(String repeat) {
        this.repeat = repeat;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}

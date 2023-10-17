package step.learning.dto.entitites;

import java.util.Date;

public class CallMe {
    private long id;
    private String name;
    private  String phone;
    private Date moment;

    public long getId() {
        return id;
    }

    public CallMe(long id, String name, String phone, Date moment) {
        this.id = id;
        this.name = name;
        this.phone = phone;
        this.moment = moment;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public void setId(long id) {
        this.id = id;
    }
}

package step.learning.servlets;

import com.google.gson.*;
import step.learning.dao.CallMeDao;
import step.learning.dto.entities.CallMe;
import step.learning.services.db.DbProvider;

import javax.inject.Inject;
import javax.inject.Named;
import javax.inject.Singleton;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.regex.Pattern;

@Singleton
public class DbServlet extends HttpServlet {
    private final DbProvider dbProvider;

    private final String dbPrefix;

    private final CallMeDao callMeDao;
    @Inject
    public DbServlet(DbProvider dbProvider, @Named("db-prefix") String dbPrefix, CallMeDao callMeDao) {
        this.dbProvider = dbProvider;
        this.dbPrefix = dbPrefix;
        this.callMeDao = callMeDao;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String connectionStatus;
        try{
            dbProvider.getConnection();
            connectionStatus = "OK";
        }
        catch (RuntimeException ex)
        {
            connectionStatus = "Connection error: " + ex.getMessage();
        }
//        PlanetDbProvider dbProvider = new PlanetDbProvider();
//        dbProvider.getConnection();
        req.setAttribute("connectionStatus",connectionStatus);
        req.setAttribute("page-body", "db.jsp");
        req.getRequestDispatcher("WEB-INF/_layout.jsp")
                .forward(req,resp); // ~ return View()
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        String contentType = req.getContentType();
        if(contentType == null || !contentType.startsWith("application/json"))
        {
            resp.setStatus(415);
            resp.getWriter().print("\"Unsupported Media Type: 'application/json' only\"");
            return;
        }
        ByteArrayOutputStream bytes = new ByteArrayOutputStream();
        byte[] buffer = new byte[4096];
        int len;
        String json;
        JsonObject result = new JsonObject();
        try(InputStream body = req.getInputStream())
        {
            while((len = body.read(buffer)) > 0){
                bytes.write(buffer,0,len);
            }
            json = bytes.toString(StandardCharsets.UTF_8.name());
        }
        catch (IOException ex)
        {
            System.err.println(ex.getMessage());
            resp.setStatus(500);
            resp.getWriter().print("\"Server error. Details on server's logs \"");
            return;
        }
        JsonObject data;

        try {
            data = JsonParser.parseString(json).getAsJsonObject();
        }
        catch (JsonSyntaxException | IllegalStateException ex)
        {
            resp.setStatus(400);
            resp.getWriter().print("\"Invalid JSON. Object required \"");
            return;
        }
        String name,phone;


        try {
            name = data.get("name").getAsString();
            phone = data.get("phone").getAsString();
        }
        catch (Exception ignored){
            resp.setStatus(400);
            resp.getWriter().print("\"Invalid JSON data: required 'name' and 'phone' fields \"");
            return;
        }
        if(name.isEmpty() && phone.isEmpty())
        {
            resp.setStatus(400);
            resp.getWriter().print("\"Validation error: fields name and phone are empty\"");
            return;
        }
        if(name.isEmpty())
        {
            resp.setStatus(400);
            resp.getWriter().print("\"Validation error: field name is empty\"");
            return;
        }
        if(phone.isEmpty())
        {
            resp.setStatus(400);
            resp.getWriter().print("\"Validation error: field phone is empty\"");
            return;
        }

        if (!Pattern.matches("^\\+38\\s?(\\(\\d{3}\\)|\\d{3})\\s?\\d{3}(-|\\s)?\\d{2}(-|\\s)?\\d{2}$",phone))
        {
            resp.setStatus(400);
            resp.getWriter().print("\"Invalid 'phone' field: required '+\\d{12}' format\"");
            return;
        }
        phone = phone.replaceAll("[\\s()-]+","");

        String sql = "INSERT INTO " + dbPrefix + "call_me ( id, name, phone ) " +
                "VALUES ( UUID_SHORT(), ?, ? )" ;
        try (PreparedStatement prep = dbProvider.getConnection().prepareStatement(sql)){
            prep.setString(1,name); // ! у JDBC відлік від 1
            prep.setString(2,phone); // 2 - другий плейсхолдер "?"
            prep.execute();
        }
        catch (SQLException ex)
        {
            System.err.println(ex.getMessage() + " " + sql);
            resp.setStatus(500);
            resp.getWriter().print("\"Server error. Details on server's logs \"");
            return;
        }
        resp.setStatus(201);
        result.addProperty("name", name);
        result.addProperty("phone", phone);
        result.addProperty("status", "created");
        resp.getWriter().print(result);
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String status;
        String message;
        String sql = "CREATE TABLE " + dbPrefix + "call_me(" +
                "`id`             BIGINT      PRIMARY KEY," +
                "`name`           VARCHAR(64) NULL," +
                "`phone`          CHAR(13)    NOT NULL COMMENT '+38 098 765 43 21'," +
                "`moment`         DATETIME    DEFAULT CURRENT_TIMESTAMP" +
                "`call_moment`    DATETIME    NULL" +
                "`delete_moment`  DATETIME    NULL" +
                ") ENGINE = InnoDB DEFAULT CHARSET = UTF8";
        try (Statement statement = dbProvider.getConnection().createStatement()){
            statement.executeUpdate(sql);
            status = "OK";
            message = "Table created";
        } catch (SQLException e) {
            status = "error";
            message = e.getMessage();
        }
        JsonObject result = new JsonObject();
        result.addProperty("status",status);
        result.addProperty("message",message);
        resp.getWriter().print(result.toString());
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        String callId = req.getParameter("call-id");
        if( callId == null)
        {
            resp.setStatus(400);
            resp.getWriter().print("\"Missing required parameter 'call-id' \"");
            return;
        }
        CallMe item = callMeDao.getById(callId);
        if(item == null)
        {
            resp.setStatus(404);
            resp.getWriter().print("\"Item not found for given parameter 'call-id' \"");
            return;
        }
        if(item.getDeleteMoment() != null){
            resp.setStatus(422);
            resp.getWriter().print("\"Unprocessable Content: Item was processed early \"");
            return;
        }
        if(callMeDao.delete(item)){
            resp.setStatus(202);
            resp.getWriter().print("\"Operation completed\"");
        }
        else
        {
            resp.setStatus(500);
            resp.getWriter().print("\"Server error. Details on server's logs \"");
            return;
        }

    }

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // метод який запускається перед тим, як буде здійснено "розподіл" за HTTP методаними
        // тут можна додати реакцію на додаткові методи запиту
        switch (req.getMethod().toUpperCase())
        {
            case "PATCH": doPatch(req,resp); break;
            case "PURGE": doPurge(req,resp); break;
            case "LINK": doLink(req,resp); break;
            //case "UNLINK":break;
            case "MOVE": doMove(req,resp); break;
            case "COPY": doCopy(req,resp); break;
            default: super.service(req, resp);
        }
    }

    // зафіксувати callMoment
    protected void doPatch(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        String callId = req.getParameter("call-id");
        if( callId == null)
        {
            resp.setStatus(400);
            resp.getWriter().print("\"Missing required parameter 'call-id' \"");
            return;
        }
        CallMe item = callMeDao.getById(callId);
        if(item == null)
        {
            resp.setStatus(404);
            resp.getWriter().print("\"Item not found for given parameter 'call-id' \"");
            return;
        }
        if(item.getCallMoment() != null){
            resp.setStatus(422);
            resp.getWriter().print("\"Unprocessable Content: Item was processed early \"");
            return;
        }
        if(callMeDao.updateCallMoment(item)){
            resp.setStatus(202);
            resp.getWriter().print(new Gson().toJson(item));
        }
        else
        {
            resp.setStatus(500);
            resp.getWriter().print("\"Server error. Details on server's logs \"");
            return;
        }
        //resp.getWriter().print("Patch works");
    }

    protected void doCopy(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<CallMe> calls = callMeDao.getAll();
        //new ArrayList<>();
        //calls.add(new CallMe("100500","Петрович", "+380987654321", new Date()));
        //calls.add(new CallMe("100501","User", "+380987654321", new Date()));

        Gson gson = new GsonBuilder().create();
        resp.getWriter().print(gson.toJson(calls));


        //resp.getWriter().print("Copy works");
    }

    protected void doLink(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        resp.setContentType("application/json");
        String callId = req.getParameter("call-id");
        if( callId == null)
        {
            resp.setStatus(400);
            resp.getWriter().print("\"Missing required parameter 'call-id' \"");
            return;
        }
        CallMe item = callMeDao.getById(callId);
        if(item == null)
        {
            resp.setStatus(404);
            resp.getWriter().print("\"Item not found for given parameter 'call-id' \"");
            return;
        }
        if(item.getCallMoment() != null){
            resp.setStatus(422);
            resp.getWriter().print("\"Unprocessable Content: Item was processed early \"");
            return;
        }
        if(callMeDao.updateCallMoment(item)){
            resp.setStatus(202);
            resp.getWriter().print(new Gson().toJson(item));
        }
        else
        {
            resp.setStatus(500);
            resp.getWriter().print("\"Server error. Details on server's logs \"");
            return;
        }
    }

    protected void doPurge(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<CallMe> calls = callMeDao.getAll(true);
        Gson gson = new GsonBuilder().create();
        resp.getWriter().print(gson.toJson(calls));
    }
    protected void doMove(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        resp.setContentType("application/json");
        String callId = req.getParameter("call-id");
        if( callId == null)
        {
            resp.setStatus(400);
            resp.getWriter().print("\"Missing required parameter 'call-id' \"");
            return;
        }
        CallMe item = callMeDao.getById(callId,true);
        if(item == null)
        {
            resp.setStatus(404);
            resp.getWriter().print("\"Item not found for given parameter 'call-id' \"");
            return;
        }
        if(item.getDeleteMoment() == null){
            resp.setStatus(422);
            resp.getWriter().print("\"Unprocessable Content: Item was processed early \"");
            return;
        }
        if(callMeDao.restore(item)){
            resp.setStatus(202);
            resp.getWriter().print("\"Operation completed\"");
        }
        else
        {
            resp.setStatus(500);
            resp.getWriter().print("\"Server error. Details on server's logs \"");
            return;
        }
    }
}
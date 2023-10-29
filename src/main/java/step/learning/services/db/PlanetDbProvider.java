package step.learning.services.db;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import javax.inject.Singleton;
import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.Objects;
@Singleton
public class PlanetDbProvider implements DbProvider{

    private Connection connection;

    @Override
    public Connection getConnection() {
//        String server = "";
//        String login = "";
//        String password = "";
//
//        try {
//            Class.forName("com.mysql.cj.jdbc.Driver");
//        } catch (ClassNotFoundException e) {
//            throw new RuntimeException( e);
//        }
//
//        try (InputStream resourceStream = this.getClass().getClassLoader().getResourceAsStream("db_config.json")) {
//            JsonArray jsonArray = JsonParser.parseReader(new InputStreamReader(Objects.requireNonNull(resourceStream))).getAsJsonArray();
//            server = jsonArray.get(0).getAsString();
//            login = jsonArray.get(1).getAsString();
//            password = jsonArray.get(2).getAsString();
//        } catch (IOException ex) {
//            throw new RuntimeException(ex);
//        }
//
//        Connection conn = null;
//        try {
//            conn = DriverManager.getConnection(server, login, password);
//        } catch (SQLException e) {
//            throw new RuntimeException(e);
//        }
//        return conn;
        if (connection == null){
            // load configuration
            //locate file - get stream - parse JSON - get as object
            JsonObject config;
            try(Reader reader = new InputStreamReader(Objects.requireNonNull(this.getClass().getClassLoader().getResourceAsStream("db_config.json")));) {
                config = JsonParser.parseReader(reader).getAsJsonObject();
            }
            catch (IOException e) {
                throw new RuntimeException(e);
            }
            catch (NullPointerException e){
                throw new RuntimeException("Resource not found" + e);
            }
            JsonObject planetScale = config
                    .get("DataProviders").getAsJsonObject()
                    .get("PlanetScale").getAsJsonObject();
            try {
                //Class.forName("com.mysql.cj.jdbc.Driver");
                DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
                this.connection = DriverManager.getConnection(
                        planetScale.get("url").getAsString(),
                        planetScale.get("user").getAsString(),
                        planetScale.get("password").getAsString());
            }
            catch (SQLException e) {
                throw new RuntimeException( e);
            }
        }

        return this.connection;
    }
}
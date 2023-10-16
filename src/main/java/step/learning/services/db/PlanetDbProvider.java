package step.learning.services.db;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.inject.Singleton;

import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Objects;

@Singleton
public class PlanetDbProvider implements DbProvider {
    private Connection connection;

    @Override
    public Connection getConnection() {
        if (connection == null) {
            // load configuration
            // locate conection
            JsonObject config;
            try (Reader reader = new InputStreamReader(
                    Objects.requireNonNull(
                            this.getClass().getClassLoader()
                                    .getResourceAsStream("db_config.json")))
            ) {
                config = JsonParser.parseReader(reader).getAsJsonObject();
            } catch (IOException ex) {
                throw new RuntimeException(ex);
            } catch (NullPointerException ex) {
                throw new NullPointerException("Resourse not found");
            }

            JsonObject planetScale = config
                    .get("DataProviders")
                    .getAsJsonObject()
                    .get("PlanetScale")
                    .getAsJsonObject();
            try {
                // регистрация драйвера для протокола jdbc:mysql://
                //Class.forName("com.mysql.cj.jdbc.Driver");
                DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
                this.connection = DriverManager.getConnection(
                        planetScale.get("url").getAsString(),
                        planetScale.get("user").getAsString(),
                        planetScale.get("password").getAsString());
            }  catch (SQLException ex) {
                throw new RuntimeException(ex);
            }
        }
        return this.connection;
    }
}
/*
Д.З. Відновити паролі від БД (взяти зі старих проєктів)
Налаштувати файл конфігурації таким чином, щоб він не передавався до репозиторію
Додати залежність <!-- https://mvnrepository.com/artifact/com.mysql/mysql-connector-j -->
Завершити із завантаженням файлів-аватарок, додати скріншот папки з ними.
 */
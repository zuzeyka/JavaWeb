package step.learning.services.db;


public interface DbProvider {
    java.sql.Connection getConnection() ;
}

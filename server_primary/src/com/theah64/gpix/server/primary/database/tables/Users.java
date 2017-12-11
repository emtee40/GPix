package com.theah64.gpix.server.primary.database.tables;

import com.theah64.gpix.server.primary.database.Connection;
import com.theah64.gpix.server.primary.models.User;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by theapache64 on 15/10/16.
 */
public class Users extends BaseTable<User> {

    public static final String COLUMN_API_KEY = "api_key";
    public static final String COLUMN_EMAIL = "email";
    private static final Users instance = new Users();

    private Users() {
        super("users");
    }

    public static Users getInstance() {
        return instance;
    }

    public boolean add(User newUser) {

        boolean isUserAdded = false;
        final String query = "INSERT INTO users (email,api_key) VALUES (?,?);";
        final java.sql.Connection con = Connection.getConnection();
        try {

            final PreparedStatement ps = con.prepareStatement(query);

            ps.setString(1, newUser.getEmail());
            ps.setString(2, newUser.getApiKey());

            isUserAdded = ps.executeUpdate() == 1;

            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return isUserAdded;
    }

    @Override
    public User get(String column, String value) {

        User user = null;

        final String query = String.format("SELECT id, email,api_key,is_active FROM users WHERE %s = ? LIMIT 1 ", column);

        final java.sql.Connection con = Connection.getConnection();
        try {

            final PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, value);
            final ResultSet rs = ps.executeQuery();

            if (rs.first()) {
                final String id = rs.getString(COLUMN_ID);
                final String email = rs.getString(COLUMN_EMAIL);
                final String apiKey = rs.getString(COLUMN_API_KEY);
                final boolean isActive = rs.getBoolean(COLUMN_IS_ACTIVE);

                user = new User(id, email, apiKey, null, 0, isActive);
            }

            rs.close();
            ps.close();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return user;
    }
}

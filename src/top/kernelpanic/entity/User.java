package top.kernelpanic.entity;

import java.util.HashSet;

public class User {
    private String sessionID;
    private String ip;
    private String firstTime;
    private HashSet<Book>favorites;
    private String lastTime;
    private int id;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getLastTime() {
        return lastTime;
    }

    public void setLastTime(String lastTime) {
        this.lastTime = lastTime;
    }

    public HashSet<Book> getFavorites() {
        return favorites;
    }

    public void setFavorites(HashSet<Book> favorites) {
        this.favorites = favorites;
    }

    public String getSessionID() {
        return sessionID;
    }

    public void setSessionID(String sessionID) {
        this.sessionID = sessionID;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public String getFirstTime() {
        return firstTime;
    }

    public void setFirstTime(String firstTime) {
        this.firstTime = firstTime;
        this.lastTime=firstTime;
    }
}

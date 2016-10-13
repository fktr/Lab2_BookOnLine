package top.kernelpanic.util;

import top.kernelpanic.entity.User;

import java.util.ArrayList;

public class SessionUtil {

    public static User getUserBySessionID(ArrayList<User> userList, String sessionID){
        for(User user:userList)
            if(user.getSessionID().equals(sessionID))
                return user;
        return null;
    }
}

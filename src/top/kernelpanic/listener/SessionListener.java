package top.kernelpanic.listener;

import top.kernelpanic.entity.User;
import top.kernelpanic.util.SessionUtil;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import java.util.ArrayList;

@WebListener
public class SessionListener implements HttpSessionListener{
    private int userNumber=0;

    @Override
    public void sessionCreated(HttpSessionEvent httpSessionEvent) {
        userNumber++;
        httpSessionEvent.getSession().getServletContext().setAttribute("userNumber",userNumber);
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent httpSessionEvent) {
        userNumber--;
        httpSessionEvent.getSession().getServletContext().setAttribute("userNumber",userNumber);

        ArrayList<User>userList=(ArrayList<User>) httpSessionEvent.getSession().getServletContext().getAttribute("userList");
        User user;

        if((user= SessionUtil.getUserBySessionID(userList,httpSessionEvent.getSession().getId()))!=null)
            userList.remove(user);
    }
}

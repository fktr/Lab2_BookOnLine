package top.kernelpanic.listener;

import top.kernelpanic.entity.Book;
import top.kernelpanic.entity.User;
import top.kernelpanic.util.SessionUtil;

import javax.servlet.ServletRequestEvent;
import javax.servlet.ServletRequestListener;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;

@WebListener
public class RequestListener implements ServletRequestListener{
    ArrayList<User>userList;

    @Override
    public void requestDestroyed(ServletRequestEvent servletRequestEvent) {

    }

    @Override
    public void requestInitialized(ServletRequestEvent servletRequestEvent) {
        userList=(ArrayList<User>)servletRequestEvent.getServletContext().getAttribute("userList");
        if(userList==null)
            userList=new ArrayList<User>();
        HttpServletRequest request=(HttpServletRequest)servletRequestEvent.getServletRequest();
        String sessionID=request.getSession().getId();
        if(SessionUtil.getUserBySessionID(userList,sessionID)==null){
            User user=new User();
            user.setSessionID(sessionID);
            user.setIp(request.getRemoteAddr());
            user.setFirstTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
            user.setFavorites(new HashSet<Book>());
            user.setId(userList.size());
            userList.add(user);
        }
        servletRequestEvent.getServletContext().setAttribute("userList",userList);
    }
}

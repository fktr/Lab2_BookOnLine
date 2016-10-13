package top.kernelpanic.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBHelper {
    private static final String driver="com.mysql.jdbc.Driver";
    private static final String url="jdbc:mysql://w.rdc.sae.sina.com.cn:3307/app_fktr";
    private static final String username="onzkw5z4x0";
    private static final String password="wwmw2k52km3ijy0l33m3z4i5yh1i01y52zhji5m5";
    private static Connection conn=null;

    static {
        try{
            Class.forName(driver);
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    public static Connection getConnection()throws Exception{
        return DriverManager.getConnection(url,username,password);
    }

    public static void main(String[] args){
        try{
            Connection conn=getConnection();
            if(conn!=null)
                System.out.println("数据库连接正常！");
            else
                System.out.println("数据库连接异常！");
        }catch (Exception e){
            e.printStackTrace();
        }
    }

}


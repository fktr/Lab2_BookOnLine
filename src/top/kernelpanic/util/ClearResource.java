package top.kernelpanic.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ClearResource {

    public static void clean(ResultSet rs, PreparedStatement stmt, Connection conn){
        if (rs!=null){
            try{
                rs.close();
                rs=null;
            }catch (Exception e){
                e.printStackTrace();
            }
        }
        if(stmt!=null){
            try{
                stmt.close();
                stmt=null;
            }catch (Exception e){
                e.printStackTrace();
            }
        }
        if(conn!=null){
            try{
                conn.close();
                conn=null;
            }catch (Exception e){
                e.printStackTrace();
            }
        }
    }
}

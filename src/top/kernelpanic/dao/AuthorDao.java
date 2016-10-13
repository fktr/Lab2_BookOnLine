package top.kernelpanic.dao;

import top.kernelpanic.entity.Author;
import top.kernelpanic.util.ClearResource;
import top.kernelpanic.util.DBHelper;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class AuthorDao {
    
    public void deleteAuthorById(int id){
        Connection conn=null;
        PreparedStatement stmt=null;

        try{
            conn=DBHelper.getConnection();
            String sql="delete from author where id=?";
            stmt=conn.prepareStatement(sql);
            stmt.setInt(1,id);
            int rowCount=stmt.executeUpdate();
            System.out.println(rowCount+" row(s) affected!");
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            ClearResource.clean(null,stmt,conn);
        }
    }

    public void addAuthor(Author author){
        Connection conn=null;
        PreparedStatement stmt=null;

        try{
            conn=DBHelper.getConnection();
            String sql="insert into author (name,country_id,age,info)values(?,?,?,?)";
            stmt=conn.prepareStatement(sql);
            stmt.setString(1,author.getName());
            stmt.setInt(2,author.getCountry_id());
            stmt.setInt(3,author.getAge());
            stmt.setString(4,author.getInfo());
            int rowCount=stmt.executeUpdate();
            System.out.println(rowCount+" row(s) affected!");
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            ClearResource.clean(null,stmt,conn);
        }
    }

    public void updateAuthor(Author author){
        Connection conn=null;
        PreparedStatement stmt=null;

        try{
            conn=DBHelper.getConnection();
            String sql="update author set name=?,country_id=?,age=?,info=? where id=?";
            stmt=conn.prepareStatement(sql);
            stmt.setString(1,author.getName());
            stmt.setInt(2,author.getCountry_id());
            stmt.setInt(3,author.getAge());
            stmt.setString(4,author.getInfo());
            stmt.setInt(5,author.getId());
            int rowCount=stmt.executeUpdate();
            System.out.println(rowCount+" row(s) affected!");
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            ClearResource.clean(null,stmt,conn);
        }
    }

    public ArrayList<Author>getAllAuthors(){
        Connection conn=null;
        PreparedStatement stmt=null;
        ResultSet rs=null;
        ArrayList<Author>list=new ArrayList<Author>();

        try{
            conn= DBHelper.getConnection();
            String sql="select * from author";
            stmt=conn.prepareStatement(sql);
            rs=stmt.executeQuery();
            while(rs.next()){
                Author author=new Author();
                setAuthorFromResource(author,rs);
                list.add(author);
            }
            return list;
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }finally {
            ClearResource.clean(rs,stmt,conn);
        }
    }

    public Author getAuthorById(int id){
        Connection conn=null;
        PreparedStatement stmt=null;
        ResultSet rs=null;
        Author author=new Author();

        try{
            conn=DBHelper.getConnection();
            String sql="select * from author where id=?";
            stmt=conn.prepareStatement(sql);
            stmt.setInt(1,id);
            rs=stmt.executeQuery();
            if(rs.next()){
                setAuthorFromResource(author,rs);
                return author;
            }else
                return null;
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }finally {
            ClearResource.clean(rs,stmt,conn);
        }
    }

    private void setAuthorFromResource(Author author,ResultSet rs)throws Exception{
        author.setId(rs.getInt("id"));
        author.setName(rs.getString("name"));
        author.setCountry_id(rs.getInt("country_id"));
        author.setAge(rs.getInt("age"));
        author.setInfo(rs.getString("info"));
    }
}

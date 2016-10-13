package top.kernelpanic.dao;

import top.kernelpanic.entity.Book;
import top.kernelpanic.util.ClearResource;
import top.kernelpanic.util.DBHelper;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

public class BookDAO {
    private SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd");

    public ArrayList<Book>getHistoryView(String[] arr){
        if(arr!=null&&arr.length>0){
            ArrayList<Book>list=new ArrayList<Book>();
            for(int i=arr.length-1;i>=0;i--){
                Book book=getBookByIsbn(arr[i]);
                if(book!=null&&!list.contains(book))
                    list.add(book);
                if(list.size()>=6)
                    break;
            }
            return list;
        }else
            return null;
    }

    public ArrayList<Book>SearchBooks(String str){
        Connection conn=null;
        PreparedStatement stmt=null;
        ResultSet rs=null;
        ArrayList<Book>list=new ArrayList<Book>();

        try{
            conn=DBHelper.getConnection();
            String sql="select * from book where title like ? or isbn like ?";
            stmt=conn.prepareStatement(sql);
            stmt.setString(1,"%"+str+"%");
            stmt.setString(2,"%"+str+"%");
            rs=stmt.executeQuery();
            while(rs.next()){
                Book book=new Book();
                setBookFromResource(book,rs);
                list.add(book);
            }
            ClearResource.clean(rs,stmt,conn);
            conn=DBHelper.getConnection();
            sql="select a.* from book as a inner join author as b on a.author_id=b.id where b.name like ?";
            stmt=conn.prepareStatement(sql);
            stmt.setString(1,"%"+str+"%");
            rs=stmt.executeQuery();
            while(rs.next()){
                Book book=new Book();
                setBookFromResource(book,rs);
                list.add(book);
            }
            return list;
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }finally {
            ClearResource.clean(rs,stmt,conn);
        }
    }

    public ArrayList<Book>getBooksForPage(int startPage,int count){
        Connection conn=null;
        PreparedStatement stmt=null;
        ResultSet rs=null;
        ArrayList<Book>list=new ArrayList<Book>();

        try{
            conn=DBHelper.getConnection();
            String sql="select * from book limit ?,?";
            stmt=conn.prepareStatement(sql);
            stmt.setInt(1,(startPage-1)*count);
            stmt.setInt(2,count);
            rs=stmt.executeQuery();
            while(rs.next()){
                Book book=new Book();
                setBookFromResource(book,rs);
                list.add(book);
            }
            return list;
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }finally {
            ClearResource.clean(rs,stmt,conn);
        }
    }

    public void deletBookByIsbn(String isbn){
        Connection conn=null;
        PreparedStatement stmt=null;

        try{
            conn=DBHelper.getConnection();
            String sql="delete from book where isbn=?";
            stmt=conn.prepareStatement(sql);
            stmt.setString(1,isbn);
            int rowCount=stmt.executeUpdate();
            System.out.println(rowCount+" row(s) affected!");
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            ClearResource.clean(null,stmt,conn);
        }
    }

    public void addBook(Book book){
        Connection conn=null;
        PreparedStatement stmt=null;

        try{
            conn=DBHelper.getConnection();
            String sql="insert into book (isbn,title,author_id,price,page_num,score,reader_num,publisher,publish_date, image, info)values" +
                    "(?,?,?,?,?,?,?,?,?,?,?)";
            stmt=conn.prepareStatement(sql);
            stmt.setString(1,book.getIsbn());
            stmt.setString(2,book.getTitle());
            stmt.setInt(3,book.getAuthor_id());
            stmt.setFloat(4,book.getPrice());
            stmt.setInt(5,book.getPage_num());
            stmt.setFloat(6,book.getScore());
            stmt.setInt(7,book.getReader_num());
            stmt.setString(8,book.getPublisher());
            stmt.setString(9,book.getPublish_date());
            stmt.setString(10,book.getImage());
            stmt.setString(11,book.getInfo());
            int rowCount=stmt.executeUpdate();
            System.out.println(rowCount+" row(s) affected!");
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            ClearResource.clean(null,stmt,conn);
        }
    }

    public void updateBook(Book book){
        Connection conn=null;
        PreparedStatement stmt=null;

        try{
            conn=DBHelper.getConnection();
            String sql="update book set title=?,author_id=?,price=?,page_num=?,score=?,reader_num=?,publisher=?,publish_date=?,info=? where isbn=?";
            stmt=conn.prepareStatement(sql);
            stmt.setString(1,book.getTitle());
            stmt.setInt(2,book.getAuthor_id());
            stmt.setFloat(3,book.getPrice());
            stmt.setInt(4,book.getPage_num());
            stmt.setFloat(5,book.getScore());
            stmt.setInt(6,book.getReader_num());
            stmt.setString(7,book.getPublisher());
            stmt.setString(8,book.getPublish_date());
            stmt.setString(9,book.getInfo());
            stmt.setString(10,book.getIsbn());
            int rowCount=stmt.executeUpdate();
            System.out.println(rowCount+" row(s) affected!");
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            ClearResource.clean(null,stmt,conn);
        }
    }

    public Book getBookByIsbn(String isbn){
        Connection conn=null;
        PreparedStatement stmt=null;
        ResultSet rs=null;
        Book book=new Book();

        try{
            conn=DBHelper.getConnection();
            String sql="select * from book where isbn=?";
            stmt=conn.prepareStatement(sql);
            stmt.setString(1,isbn);
            rs=stmt.executeQuery();
            if(rs.next()){
                setBookFromResource(book,rs);
                return book;
            }else
                return null;
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }finally {
            ClearResource.clean(rs,stmt,conn);
        }
    }

    public ArrayList<Book> getAllBooks(){
        Connection conn=null;
        PreparedStatement stmt=null;
        ResultSet rs=null;
        ArrayList<Book>list=new ArrayList<Book>();

        try{
            conn=DBHelper.getConnection();
            String sql="select * from book";
            stmt=conn.prepareStatement(sql);
            rs=stmt.executeQuery();
            while(rs.next()){
                Book book=new Book();
                setBookFromResource(book,rs);
                list.add(book);
            }
            return list;
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }finally {
            ClearResource.clean(rs,stmt,conn);
        }
    }

    private void setBookFromResource(Book book,ResultSet rs)throws Exception{
        book.setIsbn(rs.getString("isbn"));
        book.setTitle(rs.getString("title"));
        book.setAuthor_id(rs.getInt("author_id"));
        book.setPrice(rs.getFloat("price"));
        book.setPage_num(rs.getInt("page_num"));
        book.setScore(rs.getFloat("score"));
        book.setReader_num(rs.getInt("reader_num"));
        book.setPublisher(rs.getString("publisher"));
        try {
            book.setPublish_date(dateFormat.format(rs.getDate("publish_date")));
        }catch (Exception e){
            book.setPublish_date("日期不详");
        }
        book.setImage(rs.getString("image"));
        book.setInfo(rs.getString("info"));
    }
}

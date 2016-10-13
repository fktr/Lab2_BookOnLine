package top.kernelpanic.servlet;

import top.kernelpanic.dao.AuthorDao;
import top.kernelpanic.dao.BookDAO;
import top.kernelpanic.dao.CountryDAO;
import top.kernelpanic.entity.Author;
import top.kernelpanic.entity.Book;
import top.kernelpanic.entity.Country;
import top.kernelpanic.entity.User;
import top.kernelpanic.util.SessionUtil;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

public class EventProcess extends HttpServlet {
    private BookDAO bookDAO=new BookDAO();
    private AuthorDao authorDao=new AuthorDao();
    private CountryDAO countryDAO=new CountryDAO();
    private HashMap<String,Book>bookMap=new HashMap<String,Book>();
    private HashMap<Integer,Author>authorMap=new HashMap<Integer,Author>();
    private HashMap<Integer,Country>countryMap=new HashMap<Integer,Country>();
    private ArrayList<Book>books;
    private ArrayList<Author>authors;
    private ArrayList<Country>countries;
    private String uri;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        uri=request.getRequestURI();

        if(uri.indexOf("index")!=-1){
            doContext();
            String page=request.getParameter("page");
            int startPage;
            if(page==null)
                startPage=1;
            else
                startPage=Integer.parseInt(page);
            int count=25;
            ArrayList<Book>booksPerPage=bookDAO.getBooksForPage(startPage,count);
            request.setAttribute("booksPerPage",booksPerPage);
            request.getRequestDispatcher("/index.jsp").forward(request,response);
        }else if(uri.indexOf("detail")!=-1){
            String object=request.getParameter("obj");
            String prmkey=request.getParameter("prm");
            if(object.equals("book")){
                String list="";
                Cookie[] cookies=request.getCookies();
                for(Cookie cookie:cookies)
                    if(cookie.getName().equals("HistoryView"))
                        list=cookie.getValue();
                list+=prmkey+"#";
                String[] arr=list.split("#");
                if(arr.length>1024)
                    list="";
                Cookie cookie=new Cookie("HistoryView",list);
                response.addCookie(cookie);
                ArrayList<Book>booksHistoryView=bookDAO.getHistoryView(arr);
                request.setAttribute("book",bookDAO.getBookByIsbn(prmkey));
                request.setAttribute("booksHistoryView",booksHistoryView);
                request.getRequestDispatcher("/book_detail.jsp").forward(request,response);
            }else if(object.equals("author")){
                request.setAttribute("author",authorDao.getAuthorById(Integer.parseInt(prmkey)));
                request.getRequestDispatcher("/author_detail.jsp").forward(request,response);
            }
        }else if(uri.indexOf("update")!=-1){
            String object=request.getParameter("obj");
            String prmkey=request.getParameter("prm");
            if(object.equals("book")){
                request.setAttribute("book",bookDAO.getBookByIsbn(prmkey));
                request.getRequestDispatcher("/book_update.jsp").forward(request,response);
            }else if(object.equals("author")){
                request.setAttribute("author",authorDao.getAuthorById(Integer.parseInt(prmkey)));
                request.getRequestDispatcher("/author_update.jsp").forward(request,response);
            }
        }else if(uri.indexOf("add")!=-1){
            String object=request.getParameter("obj");
            if(object.equals("book")){
                request.getRequestDispatcher("/book_add.jsp").forward(request,response);
            }else if(object.equals("author")){
                request.getRequestDispatcher("/author_add.jsp").forward(request,response);
            }
        }else if(uri.indexOf("delete")!=-1){
            String object=request.getParameter("obj");
            String prmkey=request.getParameter("prm");
            if(object.equals("book"))
                bookDAO.deletBookByIsbn(prmkey);
            else if(object.equals("author"))
                authorDao.deleteAuthorById(Integer.parseInt(prmkey));
            request.setAttribute("uri","index");
            request.getRequestDispatcher("/operate_ok.jsp").forward(request,response);
        }else if(uri.indexOf("search")!=-1){
            String searchCont=request.getParameter("search");
            ArrayList<Book>booksSearched=bookDAO.SearchBooks(searchCont);
            request.setAttribute("booksSearched",booksSearched);
            request.getRequestDispatcher("/book_searched.jsp").forward(request,response);
        }else if(uri.indexOf("login")!=-1){
            request.getRequestDispatcher("/login.jsp").forward(request,response);
        }else if(uri.indexOf("log")!=-1){
            request.getRequestDispatcher("/log.jsp").forward(request,response);
        }else if(uri.indexOf("collect")!=-1){
            HttpSession session=request.getSession();
            User user=SessionUtil.getUserBySessionID((ArrayList<User>) request.getServletContext().getAttribute("userList"),session.getId());
            user.getFavorites().add(bookDAO.getBookByIsbn(request.getParameter("prm")));
            request.getRequestDispatcher("/operate_ok.jsp").forward(request,response);
        }else if(uri.indexOf("mybook")!=-1){
            User user;
            String from=request.getParameter("from");
            if(from!=null && from.equals("admin")){
                user=((ArrayList<User>)request.getServletContext().getAttribute("userList")).get(Integer.parseInt(request.getParameter("id")));
            }else {
                HttpSession session = request.getSession();
                user = SessionUtil.getUserBySessionID((ArrayList<User>) request.getServletContext().getAttribute("userList"), session.getId());
            }
            request.setAttribute("user",user);
            request.getRequestDispatcher("/mybook.jsp").forward(request,response);
        }else if(uri.indexOf("remove")!=-1){
            HttpSession session=request.getSession();
            User user=SessionUtil.getUserBySessionID((ArrayList<User>) request.getServletContext().getAttribute("userList"),session.getId());
            user.getFavorites().remove(bookDAO.getBookByIsbn(request.getParameter("prm")));
            request.getRequestDispatcher("/operate_ok.jsp").forward(request,response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        uri=request.getRequestURI();
        if(uri.indexOf("update")!=-1){
            String object=request.getParameter("obj");
            String prmkey=request.getParameter("prm");
            if(object.equals("book")){
                Book book=bookDAO.getBookByIsbn(prmkey);
                setBookFromRequest(book,request);
                bookDAO.updateBook(book);
            }else if(object.equals("author")){
                Author author=authorDao.getAuthorById(Integer.parseInt(prmkey));
                setAuthorFromRequest(author,request);
                authorDao.updateAuthor(author);
            }
            request.setAttribute("uri","index");
            request.getRequestDispatcher("/operate_ok.jsp").forward(request,response);
        }else if(uri.indexOf("add")!=-1){
            String object=request.getParameter("obj");
            if(object.equals("book")){
                Book book=new Book();
                setBookFromRequest(book,request);
                bookDAO.addBook(book);
            }else if(object.equals("author")){
                Author author=new Author();
                setAuthorFromRequest(author,request);
                authorDao.addAuthor(author);
            }
            request.setAttribute("uri","index");
            request.getRequestDispatcher("/operate_ok.jsp").forward(request,response);
        }else if(uri.indexOf("login")!=-1){
            String username=request.getParameter("username");
            String password=request.getParameter("password");
            if(username.equals("admin")&&password.equals("admin")){
                HttpSession session=request.getSession();
                session.setAttribute("admin",username);
                request.getRequestDispatcher("/log.jsp").forward(request,response);
            }else{
                request.getRequestDispatcher("/login.jsp").forward(request,response);
            }
        }
    }

    private void setAuthorFromRequest(Author author,ServletRequest request){
        author.setName(request.getParameter("name"));
        author.setCountry_id(Integer.parseInt(request.getParameter("country_id")));
        author.setAge(Integer.parseInt(request.getParameter("age")));
        author.setInfo(request.getParameter("info"));
    }

    private void setBookFromRequest(Book book, ServletRequest request){
        book.setTitle(request.getParameter("title"));
        book.setAuthor_id(Integer.parseInt(request.getParameter("author_id")));
        book.setPrice(Float.parseFloat(request.getParameter("price")));
        book.setPage_num(Integer.parseInt(request.getParameter("page_num")));
        book.setScore(Float.parseFloat(request.getParameter("score")));
        book.setReader_num(Integer.parseInt(request.getParameter("reader_num")));
        book.setIsbn(request.getParameter("isbn"));
        book.setPublisher(request.getParameter("publisher"));
        book.setPublish_date(request.getParameter("publish_date"));
        book.setImage(request.getParameter("image"));
        book.setInfo(request.getParameter("info"));
    }

    private void doContext(){
        books=bookDAO.getAllBooks();
        authors=authorDao.getAllAuthors();
        countries=countryDAO.getAllCountries();
        ServletContext context=getServletContext();

        for(Book book:books)
            bookMap.put(book.getIsbn(),book);
        for(Author author:authors)
            authorMap.put(author.getId(),author);
        for(Country country:countries)
            countryMap.put(country.getId(),country);

        context.setAttribute("books",books);
        context.setAttribute("authors",authors);
        context.setAttribute("countries",countries);
        context.setAttribute("bookMap",bookMap);
        context.setAttribute("authorMap",authorMap);
        context.setAttribute("countryMap",countryMap);

    }
}

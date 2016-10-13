package top.kernelpanic.entity;

public class Book {
    private String isbn;
    private String title;
    private int author_id;
    private float price;
    private int page_num;
    private float score;
    private int reader_num;
    private String publisher;
    private String publish_date;
    private String image;
    private String info;

    @Override
    public int hashCode(){
        return isbn.hashCode()+title.hashCode();
    }

    @Override
    public boolean equals(Object obj) {
        if(this==obj)
            return true;
        else if(obj instanceof Book){
            if(isbn.equals(((Book) obj).getIsbn())&&title.equals(((Book) obj).getTitle()))
                return true;
            else
                return false;
        }else
            return false;
    }

    @Override
    public String toString() {
        return title;
    }

    public String getIsbn() {
        return isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getAuthor_id() {
        return author_id;
    }

    public void setAuthor_id(int author_id) {
        this.author_id = author_id;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public int getPage_num() {
        return page_num;
    }

    public void setPage_num(int page_num) {
        this.page_num = page_num;
    }

    public float getScore() {
        return score;
    }

    public void setScore(float score) {
        this.score = score;
    }

    public int getReader_num() {
        return reader_num;
    }

    public void setReader_num(int reader_num) {
        this.reader_num = reader_num;
    }

    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    public String getPublish_date() {
        return publish_date;
    }

    public void setPublish_date(String publish_date) {
        this.publish_date = publish_date;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info;
    }
}

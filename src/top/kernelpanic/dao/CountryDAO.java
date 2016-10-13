package top.kernelpanic.dao;

import top.kernelpanic.entity.Country;
import top.kernelpanic.util.ClearResource;
import top.kernelpanic.util.DBHelper;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class CountryDAO {

    public ArrayList<Country>getAllCountries(){
        Connection conn=null;
        PreparedStatement stmt=null;
        ResultSet rs=null;
        ArrayList<Country>list=new ArrayList<Country>();

        try{
            conn=DBHelper.getConnection();
            String sql="select * from country";
            stmt=conn.prepareStatement(sql);
            rs=stmt.executeQuery();
            while(rs.next()){
                Country country=new Country();
                setCountryFromResource(country,rs);
                list.add(country);
            }
            return list;
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }finally {
            ClearResource.clean(rs,stmt,conn);
        }
    }

    public Country getCountryById(int id){
        Connection conn=null;
        PreparedStatement stmt=null;
        ResultSet rs=null;
        Country country=new Country();

        try{
            conn=DBHelper.getConnection();
            String sql="select * from country where id=?";
            stmt=conn.prepareStatement(sql);
            stmt.setInt(1,id);
            rs=stmt.executeQuery();
            if(rs.next()){
                setCountryFromResource(country,rs);
                return country;
            }else
                return null;
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }finally {
            ClearResource.clean(rs,stmt,conn);
        }
    }

    private void setCountryFromResource(Country country,ResultSet rs)throws Exception{
        country.setId(rs.getInt("id"));
        country.setName(rs.getString("name"));
    }
}

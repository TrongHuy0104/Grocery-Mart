/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dataAccess;

import static com.sun.org.apache.xalan.internal.lib.ExsltDatetime.date;
import static context.DBContext.CreateConnection;
import entity.Order;
import entity.Product;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Trong Huy
 */
public class OrderDAO {

    public String getShippingDate(int num) {
        String timeStamp = "";
        try {
            timeStamp = new SimpleDateFormat("dd-MM-yyyy").format(Calendar.getInstance().getTime());
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(sdf.parse(timeStamp));
            calendar.add(Calendar.DAY_OF_MONTH, num);
            timeStamp = sdf.format(calendar.getTime());
        } catch (ParseException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return timeStamp;
    }

    public boolean insertOrder(Order o) {
        boolean result = false;
        Connection conn = CreateConnection();
        PreparedStatement ptmt = null;
        String sql = "insert into orders (o_id, u_id, o_date) values(?,?,?)";
        try {
            ptmt = conn.prepareStatement(sql);
            ptmt.setString(1, o.getOrderId());
            ptmt.setString(2, o.getUid());
            ptmt.setString(3, o.getDate());
            ptmt.executeUpdate();
            result = true;
            ptmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    public boolean insertOrderDetail(Order o) {
        boolean result = false;
        Connection conn = CreateConnection();
        PreparedStatement ptmt = null;
        String sql = "insert into `order-detail` (o_id,p_id, quantity) values(?,?,?)";
        try {
            ptmt = conn.prepareStatement(sql);
            ptmt.setString(1, o.getOrderId());
            ptmt.setLong(2, o.getpId());
            ptmt.setInt(3, o.getQunatity());
            ptmt.executeUpdate();
            result = true;
            ptmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    public List<Order> selectAllOrder() {
        List<Order> list = new ArrayList<>();
        Connection conn = CreateConnection();
        PreparedStatement ptmt = null;
        try {

            String sql = "select o.* from orders o order by o.o_id desc;";
            ptmt = conn.prepareStatement(sql);
            ResultSet rs = ptmt.executeQuery();;
            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getString("o_id"));
                order.setUid(rs.getString("u_id"));
                order.setDate(rs.getString("o_date"));
                order.setStatus(rs.getInt("status"));
                list.add(order);
            }
            
            ptmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Order> getAllOrder(String uid) {
        List<Order> list = new ArrayList<>();
        Connection conn = CreateConnection();
        PreparedStatement ptmt = null;
        try {

            String sql = "SELECT * from orders WHERE orders.u_id = ? order by o_id desc;";
            ptmt = conn.prepareStatement(sql);
            ptmt.setString(1, uid);
            ResultSet rs = ptmt.executeQuery();;
            while (rs.next()) {
                Order order = new Order();
                DAO dao = new DAO();
                order.setOrderId(rs.getString("o_id"));
                order.setUid(rs.getString("u_id"));
                order.setDate(rs.getString("o_date"));
                order.setStatus(rs.getInt("status"));
                list.add(order);
            }
            
            ptmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Order getOrderByOrderID(String oid) {
        Order order = new Order();
        Connection conn = CreateConnection();
        PreparedStatement ptmt = null;
        try {

            String sql = "SELECT * from orders WHERE orders.o_id = ? order by o_id desc;";
            ptmt = conn.prepareStatement(sql);
            ptmt.setString(1, oid);
            ResultSet rs = ptmt.executeQuery();;
            while (rs.next()) {
                order.setOrderId(rs.getString("o_id"));
                order.setUid(rs.getString("u_id"));
                order.setDate(rs.getString("o_date"));
                order.setStatus(rs.getInt("status"));
            }
            
            ptmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return order;
    }

    public List<Order> getAllOrderDetail(String oId, String uId) {
        List<Order> list = new ArrayList<>();
        Connection conn = CreateConnection();
        PreparedStatement ptmt = null;
        try {

            String sql = "SELECT * from orders, `order-detail` WHERE orders.o_id = `order-detail`.`o_id` AND orders.o_id = ? AND orders.u_id = ? order by orders.o_id desc;";
            ptmt = conn.prepareStatement(sql);
            ptmt.setString(1, oId);
            ptmt.setString(2, uId);
            ResultSet rs = ptmt.executeQuery();;
            while (rs.next()) {
                Order order = new Order();
                DAO dao = new DAO();
                int pId = rs.getInt("p_id");
                Product product = dao.getProductByID(pId);
                order.setOrderId(rs.getString("o_id"));
                order.setpId(pId);
                order.setpName(product.getpName());
                order.setpPrice(product.getpPrice() * rs.getInt("quantity"));
                order.setQunatity(rs.getInt("quantity"));
                order.setDate(rs.getString("o_date"));
                order.setpPrice(product.getpPrice());
                order.setpThumb(product.getpThumb());
                list.add(order);
            }
            
            ptmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public List<Order> getAllOrderDetail(String oId) {
        List<Order> list = new ArrayList<>();
        Connection conn = CreateConnection();
        PreparedStatement ptmt = null;
        try {

            String sql = "SELECT * from orders, `order-detail` WHERE orders.o_id = `order-detail`.`o_id` AND orders.o_id = ? order by orders.o_id desc;";
            ptmt = conn.prepareStatement(sql);
            ptmt.setString(1, oId);
            ResultSet rs = ptmt.executeQuery();;
            while (rs.next()) {
                Order order = new Order();
                DAO dao = new DAO();
                int pId = rs.getInt("p_id");
                Product product = dao.getProductByID(pId);
                order.setOrderId(rs.getString("o_id"));
                order.setpId(pId);
                order.setpName(product.getpName());
                order.setpPrice(product.getpPrice() * rs.getInt("quantity"));
                order.setQunatity(rs.getInt("quantity"));
                order.setDate(rs.getString("o_date"));
                order.setpPrice(product.getpPrice());
                order.setpThumb(product.getpThumb());
                list.add(order);
            }
            
            ptmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public void cancelOrder(String id) {
        Connection conn = CreateConnection();
        PreparedStatement ptmt = null;
        try {
            String sql = "UPDATE orders\n"
                    + "SET status = 0\n"
                    + "WHERE o_id=?";
            ptmt = conn.prepareStatement(sql);
            ptmt.setString(1, id);
            ptmt.execute();
            
            ptmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.print(e.getMessage());
        }
    }
    
    public void confirmOrder(String id) {
        Connection conn = CreateConnection();
        PreparedStatement ptmt = null;
        try {
            String sql = "UPDATE orders\n"
                    + "SET status = 2\n"
                    + "WHERE o_id=?";
            ptmt = conn.prepareStatement(sql);
            ptmt.setString(1, id);
            ptmt.execute();
            
            ptmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.print(e.getMessage());
        }
    }
    
    public void updateStatusOrder(String id, int status) {
        Connection conn = CreateConnection();
        PreparedStatement ptmt = null;
        try {
            String sql = "UPDATE orders\n"
                    + "SET status = ?\n"
                    + "WHERE o_id=?";
            ptmt = conn.prepareStatement(sql);
            ptmt.setInt(1, status);
            ptmt.setString(2, id);
            ptmt.execute();
            
            ptmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.print(e.getMessage());
        }
    }

    public static void main(String[] args) {
        OrderDAO o = new OrderDAO();
        Order order = new Order();
        Order order2 = new Order();
        order.setOrderId("1");
        order.setUid("1");
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date();
        order.setDate(formatter.format(date));
        order2.setOrderId("1");
        order2.setpId(3132311);
        order2.setQunatity(2);
        order.setUid("1700557164893");
//        o.insertOrderDetail(order2);
        System.out.println(o.getAllOrderDetail("1701801322766"));
//        o.cancelOrder("1701863894453");
    }
}

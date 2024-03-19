/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dataAccess;

import static context.DBContext.CreateConnection;
import entity.Cart;
import entity.Category;
import entity.Order;
import entity.Product;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Trong Huy
 */
public class DAO {

    //    count total products
    public int countTotal() {
        try {
            Connection conn = CreateConnection();
            PreparedStatement ptmt = null;
            String sql = "select count(*) from products";
            ptmt = conn.prepareStatement(sql);
            ResultSet rs = ptmt.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
            ptmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

//    Paging Products
    public List<Product> pagingProduct(int index) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT p.id, p.name, p.rating, p.thumb, \n"
                + "pd.product_id, pd.price, pd.description, pd.place_product,\n"
                + "pd.number_of_product, pd.number_left\n"
                + "FROM  products p, product_detail pd \n"
                + "WHERE p.id = pd.product_id\n"
                + "ORDER BY p.id\n"
                + "LIMIT 16\n"
                + "OFFSET ?;";
        Connection conn = CreateConnection();
        try {
            PreparedStatement ptmt = null;
            ptmt = conn.prepareStatement(sql);
            ptmt.setInt(1, (index - 1) * 16);
            ResultSet rs = ptmt.executeQuery();
            while (rs.next()) {
                long id = rs.getLong("id");
                String name = rs.getString("name");
                double rating = rs.getInt("rating");
                String thumb = rs.getString("thumb");
                double price = rs.getDouble("price");
                String desc = rs.getString("description");
                int numberLeft = rs.getInt("number_left");
                int totalNumber = rs.getInt("number_of_product");
                String origin = rs.getString("place_product");
                list.add(new Product(id, name, rating, thumb, price, desc, numberLeft, totalNumber, origin));
            }
            ptmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public ArrayList<Product> selectAll() {
        ArrayList<Product> result = new ArrayList<>();

        try {
            Connection conn = CreateConnection();
            PreparedStatement ptmt = null;

            String sql = "SELECT p.id, p.name, p.rating, p.thumb, c.name_category, \n"
                    + "pd.product_id, pd.price, pd.description, pd.place_product,\n"
                    + "pd.number_of_product, pd.number_left, pd.status\n"
                    + "FROM  products p, product_detail pd, product_category pc, categories c \n"
                    + "WHERE p.id = pd.product_id AND pc.product_id = p.id AND c.id = pc.category_id \n"
                    + "ORDER BY p.id\n";
            ptmt = conn.prepareStatement(sql);
            ResultSet rs = ptmt.executeQuery();
            while (rs.next()) {
                long id = rs.getLong("id");
                String name = rs.getString("name");
                double rating = rs.getInt("rating");
                String thumb = rs.getString("thumb");
                double price = rs.getDouble("price");
                String desc = rs.getString("description");
                int numberLeft = rs.getInt("number_left");
                int totalNumber = rs.getInt("number_of_product");
                String origin = rs.getString("place_product");
                String category = rs.getString("name_category");
                int status = rs.getInt("status");
                result.add(new Product(id, name, rating, thumb, price, desc, numberLeft, totalNumber, origin, category, status));
            }
            ptmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    //    count total products
    public int countCateProduct(int cateID) {
        Connection conn = CreateConnection();
        PreparedStatement ptmt = null;
        String sql;
        if (cateID == 1 || cateID == 2 || cateID == 3) {
            sql = "SELECT COUNT(*) FROM products\n"
                    + "JOIN categories\n"
                    + "ON products.code = categories.id\n"
                    + "WHERE products.code = ?\n";
        } else {
            sql = "SELECT COUNT(*) FROM products\n"
                    + "JOIN product_category\n"
                    + "ON products.id = product_category.product_id\n"
                    + "WHERE product_category.category_id = ?\n";
        }

        try {
            ptmt = conn.prepareStatement(sql);

            ptmt.setInt(1, cateID);
            ResultSet rs = ptmt.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
            ptmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

//    Get Product From Category
    public List<Product> getProductFromCate(int cateID, int index) {
        List<Product> list = new ArrayList<>();
        String sql;
        if (cateID == 1 || cateID == 2 || cateID == 3) {
            sql = "SELECT p.id, p.name, p.rating, p.thumb,\n"
                    + "pd.product_id, pd.price, pd.description, pd.place_product,\n"
                    + "pd.number_of_product, pd.number_left\n"
                    + "FROM  products p, product_detail pd,  categories c\n"
                    + "WHERE c.id = p.code AND p.id = pd.product_id AND  p.code = ?\n"
                    + "ORDER BY p.id\n"
                    + "LIMIT 16 \n"
                    + "OFFSET ?;";
        } else {
            sql = "SELECT p.id, p.name, p.rating, p.thumb,\n"
                    + "pd.product_id, pd.price, pd.description, pd.place_product,\n"
                    + "pd.number_of_product, pd.number_left\n"
                    + "FROM  products p, product_detail pd,  product_category pc\n"
                    + "WHERE pc.category_id = ? AND p.id = pd.product_id AND  p.id = pc.product_id\n"
                    + "ORDER BY p.id\n"
                    + "LIMIT 16 \n"
                    + "OFFSET ?;";
        }

        Connection conn = CreateConnection();
        PreparedStatement ptmt = null;
        try {
            ptmt = conn.prepareStatement(sql);
            ptmt.setInt(1, cateID);
            ptmt.setInt(2, (index - 1) * 16);
            ResultSet rs = ptmt.executeQuery();
            while (rs.next()) {
                long id = rs.getLong("id");
                String name = rs.getString("name");
                double rating = rs.getInt("rating");
                String thumb = rs.getString("thumb");
                double price = rs.getDouble("price");
                String desc = rs.getString("description");
                int numberLeft = rs.getInt("number_left");
                int totalNumber = rs.getInt("number_of_product");
                String origin = rs.getString("place_product");
                list.add(new Product(id, name, rating, thumb, price, desc, numberLeft, totalNumber, origin));
            }

            ptmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

//    Get All Categories
    public static List<Category> getAllCat() {
        Connection conn = CreateConnection();
        List<Category> listMenu = new ArrayList<Category>();
        PreparedStatement ptmt = null;
        String sql = "select * from categories;";
        try {
            ptmt = conn.prepareStatement(sql);
            ResultSet rs = ptmt.executeQuery();
            while (rs.next()) {
                Category item = new Category();
                item.setId(rs.getInt("id"));
                item.setName_category(rs.getString("name_category"));
                item.setParent_id(rs.getInt("parent_id"));
                listMenu.add(item);
            }
            ptmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listMenu;
    }

//    Get Info Of A Product
    public Product getProductByID(long id) {
        Product p = new Product();
        String sql = "SELECT p.id, p.name, p.rating, p.thumb,\n"
                + " pd.product_id, pd.price, pd.description, pd.status,\n"
                + " pd.number_of_product, pd.number_left\n"
                + "FROM  products p, product_detail pd \n"
                + "WHERE p.id = pd.product_id AND p.id = ?;";
        Connection conn = CreateConnection();
        PreparedStatement ptmt = null;
        try {
            ptmt = conn.prepareStatement(sql);
            ptmt.setLong(1, id);
            ResultSet rs = ptmt.executeQuery();
            while (rs.next()) {
                long pid = rs.getLong("id");
                String name = rs.getString("name");
                double rating = rs.getInt("rating");
                String thumb = rs.getString("thumb");
                double price = rs.getDouble("price");
                String desc = rs.getString("description");
                int numberLeft = rs.getInt("number_left");
                int totalNumber = rs.getInt("number_of_product");
                int status = rs.getInt("status");
                p = new Product(pid, name, rating, thumb, price, desc, numberLeft, totalNumber, status);
            }

            ptmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return p;
    }

//    Get Similar Products
    public List<Product> getSimilarProduct(long index) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT p.id, p.name, p.rating, p.thumb,\n"
                + " pd.product_id, pd.price, pd.description, pd.place_product,\n"
                + " pd.number_of_product, pd.number_left\n"
                + " FROM  products p, product_detail pd,  product_category pc\n"
                + " WHERE p.id = pd.product_id AND  p.id = pc.id AND p.id != ? AND pc.category_id = (SELECT  category_id \n"
                + "									FROM products p\n"
                + "									JOIN product_category pc ON p.id = pc.product_id\n"
                + "									WHERE ? = pc.product_id\n"
                + "									LIMIT 1);";
        Connection conn = CreateConnection();
        PreparedStatement ptmt = null;
        try {
            ptmt = conn.prepareStatement(sql);
            ptmt.setLong(1, index);
            ptmt.setLong(2, index);
            ResultSet rs = ptmt.executeQuery();
            while (rs.next()) {
                long id = rs.getLong("id");
                String name = rs.getString("name");
                double rating = rs.getInt("rating");
                String thumb = rs.getString("thumb");
                double price = rs.getDouble("price");
                String desc = rs.getString("description");
                int numberLeft = rs.getInt("number_left");
                int totalNumber = rs.getInt("number_of_product");
                String origin = rs.getString("place_product");
                list.add(new Product(id, name, rating, thumb, price, desc, numberLeft, totalNumber, origin));
            }

            ptmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

//    Get Search Product
    public List<Product> searchByName(String data, int index) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT p.id, p.name, p.rating, p.thumb,\n"
                + " pd.product_id, pd.price, pd.description, pd.place_product, \n"
                + " pd.number_of_product, pd.number_left, pd.status\n"
                + "FROM  products p, product_detail pd \n"
                + "WHERE p.id = pd.product_id AND p.name LIKE ? \n"
                + "ORDER BY p.id\n"
                + "LIMIT 16 \n"
                + "OFFSET ?;";
        Connection conn = CreateConnection();
        PreparedStatement ptmt = null;
        try {
            ptmt = conn.prepareStatement(sql);
            ptmt.setString(1, "%" + data + "%");
            ptmt.setInt(2, (index - 1) * 16);
            ResultSet rs = ptmt.executeQuery();
            while (rs.next()) {
                long id = rs.getLong("id");
                String name = rs.getString("name");
                double rating = rs.getInt("rating");
                String thumb = rs.getString("thumb");
                double price = rs.getDouble("price");
                String desc = rs.getString("description");
                int numberLeft = rs.getInt("number_left");
                int totalNumber = rs.getInt("number_of_product");
                String origin = rs.getString("place_product");
                int status = rs.getInt("status");
                list.add(new Product(id, name, rating, thumb, price, desc, numberLeft, totalNumber, origin, status));
            }

            ptmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

//    Get Search ALl Product 
    public List<Product> searchAllByName(String data) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT p.id, p.name, p.rating, p.thumb, c.name_category, \n"
                + "pd.product_id, pd.price, pd.description, pd.place_product,\n"
                + "pd.number_of_product, pd.number_left, pd.status\n"
                + "FROM  products p, product_detail pd, product_category pc, categories c \n"
                + "WHERE p.id = pd.product_id AND pc.product_id = p.id AND c.id = pc.category_id AND p.name LIKE ? \n"
                + "ORDER BY p.id\n";
        Connection conn = CreateConnection();
        PreparedStatement ptmt = null;
        try {
            ptmt = conn.prepareStatement(sql);
            ptmt.setString(1, "%" + data + "%");
            ResultSet rs = ptmt.executeQuery();
            while (rs.next()) {
                long id = rs.getLong("id");
                String name = rs.getString("name");
                double rating = rs.getInt("rating");
                String thumb = rs.getString("thumb");
                double price = rs.getDouble("price");
                String desc = rs.getString("description");
                int numberLeft = rs.getInt("number_left");
                int totalNumber = rs.getInt("number_of_product");
                String origin = rs.getString("place_product");
                String category = rs.getString("name_category");
                int status = rs.getInt("status");
                list.add(new Product(id, name, rating, thumb, price, desc, numberLeft, totalNumber, origin, category, status));
            }

            ptmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countTotalByName(String data) {
        try {
            Connection conn = CreateConnection();
            PreparedStatement ptmt = null;
            String sql = "select count(*) from products WHERE name LIKE ?";
            ptmt = conn.prepareStatement(sql);
            ptmt.setString(1, "%" + data + "%");
            ResultSet rs = ptmt.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
            ptmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Cart> getCartProducts(ArrayList<Cart> cartList) {
        List<Cart> list = new ArrayList<>();
        try {
            PreparedStatement ptmt = null;
            Connection conn = CreateConnection();
            if (cartList.size() > 0) {
                for (Cart item : cartList) {
                    String sql = "SELECT p.id, p.name, p.rating, p.thumb,\n"
                            + " pd.product_id, pd.price, pd.description, \n"
                            + " pd.number_of_product, pd.number_left\n"
                            + "FROM  products p, product_detail pd \n"
                            + "WHERE p.id = pd.product_id AND p.id = ? \n";
                    ptmt = conn.prepareStatement(sql);
                    ptmt.setLong(1, item.getpId());
                    ResultSet rs = ptmt.executeQuery();
                    while (rs.next()) {
                        Cart row = new Cart();
                        row.setpId(rs.getLong("id"));
                        row.setpName(rs.getString("name"));
                        row.setpThumb(rs.getString("thumb"));
                        row.setpPrice(rs.getDouble("price") * item.getQuantity());
                        row.setpNumberLeft(rs.getInt("number_left"));
                        row.setQuantity(item.getQuantity());
                        list.add(row);
                    }

                }
                ptmt.close();
                conn.close();

            }

        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return list;
    }

    public double getTotalCartPrice(ArrayList<Cart> cartList) {
        double sum = 0;
        try {
            PreparedStatement ptmt = null;
            Connection conn = CreateConnection();
            if (cartList.size() > 0) {
                for (Cart cart : cartList) {
                    String sql = "SELECT pd.price \n"
                            + "FROM  products p, product_detail pd \n"
                            + "WHERE p.id = pd.product_id AND p.id = ? \n";
                    ptmt = conn.prepareStatement(sql);
                    ptmt.setLong(1, cart.getpId());
                    ResultSet rs = ptmt.executeQuery();
                    while (rs.next()) {
                        sum += rs.getDouble("price") * cart.getQuantity();
                    }
                }
                ptmt.close();
                conn.close();

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return sum;
    }

    public double getTotalOrderPrice(List<Order> orderList) {
        double sum = 0;
        try {
            Connection conn = CreateConnection();
            PreparedStatement ptmt = null;
            if (orderList.size() > 0) {
                for (Order order : orderList) {
                    String sql = "SELECT pd.price \n"
                            + "FROM  products p, product_detail pd \n"
                            + "WHERE p.id = pd.product_id AND p.id = ? \n";
                    ptmt = conn.prepareStatement(sql);
                    ptmt.setLong(1, order.getpId());
                    ResultSet rs = ptmt.executeQuery();
                    while (rs.next()) {
                        sum += rs.getDouble("price") * order.getQunatity();
                    }

                }
                ptmt.close();
                conn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return sum;
    }

    public void deleteProduct(Product t) {
        try {
            Connection conn = CreateConnection();
            PreparedStatement ptmt;
            String sql = "DELETE from products WHERE id=?";
            ptmt = conn.prepareStatement(sql);
            ptmt.setLong(1, t.getpId());
            ptmt.executeUpdate();
            ptmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteProductDetail(Product t
    ) {
        try {

            String sql = "DELETE from product_detail WHERE product_id=?";
            Connection conn = CreateConnection();
            PreparedStatement ptmt;
            ptmt = conn.prepareStatement(sql);
            ptmt.setLong(1, t.getpId());
            ptmt.executeUpdate();
            ptmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteProductCategory(Product t
    ) {
        try {

            String sql = "DELETE from product_category WHERE product_id=?";
            Connection conn = CreateConnection();
            PreparedStatement ptmt;
            ptmt = conn.prepareStatement(sql);
            ptmt.setLong(1, t.getpId());
            ptmt.executeUpdate();
            ptmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean checkProductIsDuplicated(String name) {
        boolean result = false;
        try {
            Connection conn = CreateConnection();

            String sql = "SELECT * FROM products WHERE name = ?";
            PreparedStatement ptmt = null;
            ptmt = conn.prepareStatement(sql);
            ptmt.setString(1, name);
            ResultSet rs = ptmt.executeQuery();

            while (rs.next()) {
                result = true;
            }
            ptmt.close();
            conn.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    public boolean checkProductIsDuplicated2(String name, long id) {
        boolean result = false;
        try {
            Connection conn = CreateConnection();

            String sql = "SELECT * FROM products WHERE name = ? AND id != ?";
            PreparedStatement ptmt = null;
            ptmt = conn.prepareStatement(sql);
            ptmt.setString(1, name);
            ptmt.setLong(1, id);
            ResultSet rs = ptmt.executeQuery();

            while (rs.next()) {
                result = true;
            }
            ptmt.close();
            conn.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    public void insertProduct(Product t) {

        try {
            String sql = "INSERT INTO products (id, name, code) "
                    + " VALUES (?,?,?)";
            Connection conn = CreateConnection();
            PreparedStatement ptmt = null;
            ptmt = conn.prepareStatement(sql);

            ptmt.setLong(1, t.getpId());
            ptmt.setString(2, t.getpName());
            ptmt.setString(3, t.getpCode());

            ptmt.executeUpdate();
            ptmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void insertProductDetail(Product t) {

        try {
            String sql = "INSERT INTO product_detail (product_id, description, number_left, place_product, price, status) "
                    + " VALUES (?,?,?,?,?,?)";
            Connection conn = CreateConnection();
            PreparedStatement ptmt = null;
            ptmt = conn.prepareStatement(sql);

            ptmt.setLong(1, t.getpId());
            ptmt.setString(2, t.getpDescription());
            ptmt.setInt(3, t.getpNumberLeft());
            ptmt.setString(4, t.getpOrigin());
            ptmt.setDouble(5, t.getpPrice());
            ptmt.setInt(6, t.getpStatus());

            ptmt.executeUpdate();
            ptmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void insertProductCate(Product t) {

        try {
            String sql = "INSERT INTO product_category (product_id, category_id) "
                    + " VALUES (?,?)";
            Connection conn = CreateConnection();
            PreparedStatement ptmt = null;
            ptmt = conn.prepareStatement(sql);

            ptmt.setLong(1, t.getpId());
            ptmt.setInt(2, t.getpCateId());;

            ptmt.executeUpdate();
            ptmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateProduct(Product t) {

        try {
            String sql = "UPDATE products SET name = ?, code = ? "
                    + "WHERE id = ?;";
            Connection conn = CreateConnection();
            PreparedStatement ptmt = null;
            ptmt = conn.prepareStatement(sql);

            ptmt.setLong(3, t.getpId());
            ptmt.setString(1, t.getpName());
            ptmt.setString(2, t.getpCode());

            ptmt.executeUpdate();
            ptmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateProductDetail(Product t) {

        try {
            String sql = "UPDATE product_detail SET description = ?, number_left = ?, place_product = ?, price = ?, status = ? "
                    + "WHERE product_id = ?;";
            Connection conn = CreateConnection();
            PreparedStatement ptmt = null;
            ptmt = conn.prepareStatement(sql);

            ptmt.setLong(6, t.getpId());
            ptmt.setString(1, t.getpDescription());
            ptmt.setInt(2, t.getpNumberLeft());
            ptmt.setString(3, t.getpOrigin());
            ptmt.setDouble(4, t.getpPrice());
            ptmt.setInt(5, t.getpStatus());

            ptmt.executeUpdate();
            ptmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateProductCate(Product t) {

        try {
            String sql = "UPDATE product_category SET  category_id = ? "
                    + "WHERE product_id = ?;";
            Connection conn = CreateConnection();
            PreparedStatement ptmt = null;
            ptmt = conn.prepareStatement(sql);

            ptmt.setLong(2, t.getpId());
            ptmt.setInt(1, t.getpCateId());

            ptmt.executeUpdate();
            ptmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Product selectById(Product t) {
        Product p = null;

        String sql
                = "SELECT p.id, p.name, p.rating, p.thumb, c.name_category, \n"
                + "pd.product_id, pd.price, pd.description, pd.place_product,\n"
                + "pd.number_of_product, pd.number_left, pd.status\n"
                + "FROM  products p, product_detail pd, product_category pc, categories c \n"
                + "WHERE p.id = pd.product_id AND pc.product_id = p.id AND c.id = pc.category_id AND p.id = ?";
        Connection conn = CreateConnection();
        PreparedStatement ptmt = null;
        try {
            ptmt = conn.prepareStatement(sql);
            ptmt.setLong(1, t.getpId());
            ResultSet rs = ptmt.executeQuery();
            while (rs.next()) {
                long id = rs.getLong("id");
                String name = rs.getString("name");
                double rating = rs.getInt("rating");
                String thumb = rs.getString("thumb");
                double price = rs.getDouble("price");
                String desc = rs.getString("description");
                int numberLeft = rs.getInt("number_left");
                int totalNumber = rs.getInt("number_of_product");
                String origin = rs.getString("place_product");
                String category = rs.getString("name_category");
                int status = rs.getInt("status");
                p = new Product(id, name, rating, thumb, price, desc, numberLeft, totalNumber, origin, category, status);
            }

            ptmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return p;
    }

    public void updateThumb(Product t
    ) {
        try {

            String sql = "UPDATE products SET thumb = ?" + " WHERE id = ?";
            Connection conn = CreateConnection();
            PreparedStatement ptmt = conn.prepareStatement(sql);

            ptmt = conn.prepareStatement(sql);
            ptmt.setLong(2, t.getpId());
            ptmt.setString(1, t.getpThumb());

            ptmt.executeUpdate();
            ptmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public void updateNumberLeft(Product t
    ) {
        try {

            String sql = "UPDATE product_detail SET number_left = ?" + " WHERE product_id = ?";
            Connection conn = CreateConnection();
            PreparedStatement ptmt = conn.prepareStatement(sql);

            ptmt = conn.prepareStatement(sql);
            ptmt.setInt(1, t.getpNumberLeft());
            ptmt.setLong(2, t.getpId());

            ptmt.executeUpdate();
            ptmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        Product p = new Product();
        p.setpId(1701759805);
        p.setpName("SAMSUNG ####");
        p.setpCategory("Mobile");
        p.setpOrigin("JP");
        p.setpPrice(20.5);
        p.setpNumberLeft(20);
        p.setpDescription("12345678");
        p.setpCode("1");
        p.setpCateId(5);
        p.setpStatus(2);
        new DAO().updateProduct(p);
        new DAO().updateProductDetail(p);
        new DAO().updateProductCate(p);
    }
}

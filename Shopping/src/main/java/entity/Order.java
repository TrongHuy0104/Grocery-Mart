/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

/**
 *
 * @author Trong Huy
 */
public class Order extends Product {

    private String orderId;
    private String uid;
    private int qunatity;
    private String date;
    private int status;

    public Order() {
    }

    public Order(String orderId, String uid, int qunatity, String date) {
        super();
        this.orderId = orderId;
        this.uid = uid;
        this.qunatity = qunatity;
        this.date = date;
    }

    public Order(String uid, int qunatity, String date) {
        super();
        this.uid = uid;
        this.qunatity = qunatity;
        this.date = date;
    }
    
    

    public String getOrderId() {
        return orderId;
    }

    public int getStatus() {
        return status;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    public int getQunatity() {
        return qunatity;
    }

    public void setQunatity(int qunatity) {
        this.qunatity = qunatity;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    @Override
    public String toString() {
        return "Order{" + "orderId=" + orderId + ", uid=" + uid + ", qunatity=" + qunatity + ", date=" + date + '}';
    }
    
    
}

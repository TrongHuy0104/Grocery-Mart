/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

import java.util.List;

/**
 *
 * @author Trong Huy
 */
public class MenuItems {
    private int id;
    private String name;
    private int parentId;
    private List<MenuItems> child;

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public int getParentId() {
        return parentId;
    }

    public List<MenuItems> getChild() {
        return child;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setParentId(int parentId) {
        this.parentId = parentId;
    }

    public void setChild(List<MenuItems> child) {
        this.child = (List<MenuItems>) child;
    }
}

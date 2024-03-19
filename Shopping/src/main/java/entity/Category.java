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
public class Category {
    private int id;
    private String name_category;
    private String text;
    private int status;
    private String slug;
    private int parent_id;
    
    public int getId(){
        return id;
    }

    public String getName_category() {
        return name_category;
    }

    public int getParent_id() {
        return parent_id;
    }

    public String getText() {
        return text;
    }

    public String getSlug() {
        return slug;
    }

    public int getStatus() {
        return status;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setName_category(String name_category) {
        this.name_category = name_category;
    }

    public void setSlug(String slug) {
        this.slug = slug;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public void setText(String text) {
        this.text = text;
    }

    public void setParent_id(int parent_id) {
        this.parent_id = parent_id;
    }

    @Override
    public String toString() {
        return "Category{" + "id=" + id + ", name_category=" + name_category + ", text=" + text + ", status=" + status + ", slug=" + slug + ", parent_id=" + parent_id + '}';
    }
    
    
}

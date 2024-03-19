<%-- 
    Document   : checkout
    Created on : Nov 22, 2023, 9:06:21 AM
    Author     : Trong Huy
--%>
<%@page import="java.util.*"%>
<%@page import="entity.*" %>
<%@page import="dataAccess.*" %>
<%
ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
List<Cart> cartProduct = null;
if (cart_list != null) {
        DAO dao = new DAO();
        cartProduct = dao.getCartProducts(cart_list);
        double total = dao.getTotalCartPrice(cart_list);
        request.setAttribute("total", total);
        request.setAttribute("cart_list", cart_list);
}

int number_of_cart;
if (cart_list == null) {
number_of_cart = 0;
} else {
number_of_cart = cart_list.size();
}

Object obj = session.getAttribute("user");
User user = null;
if (obj!=null){
user = (User)obj;			
}

OrderDAO orderDao = new OrderDAO();
String date_1 = orderDao.getShippingDate(3);
String date_2 = orderDao.getShippingDate(6);
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class="">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Checkout | Grocery Mart</title>
        <!-- Favicon -->
        <link rel="apple-touch-icon" sizes="76x76" href="./assets/favicon/apple-touch-icon.png" />
        <link rel="icon" type="image/png" sizes="32x32" href="./assets/favicon/favicon-32x32.png" />
        <link rel="icon" type="image/png" sizes="16x16" href="./assets/favicon/favicon-16x16.png" />
        <link rel="manifest" href="./assets/favicon/site.webmanifest" />
        <link rel="mask-icon" href="./assets/favicon/safari-pinned-tab.svg" color="#5bbad5" />
        <meta name="msapplication-TileColor" content="#da532c" />
        <meta name="theme-color" content="#ffffff" />
        <!-- Fonts -->
        <link rel="stylesheet" href="./assets/fonts/stylesheet.css" />
        <!-- Stylesheets -->
        <link rel="stylesheet" href="./assets/css/main.css" />
        <!-- Scripts -->
        <script src="./assets/js/scripts.js"></script>
    </head>
    <body>

        <!-- Header -->
        <jsp:include page="/templates/header.jsp" /> 
        <!-- Main -->
        <main class="checkout-page">
            <%
            if (cart_list == null || cart_list.isEmpty()) {
            %>
            <p style="display: flex;
               font-size: 3rem;
               font-weight: 500;
               justify-content: center;
               align-items: center;">Empty cart <a href="Home" style="color: #0000EE; margin-left: 10px"> Back to home page</a></p>
            <%
            } else { 
            %>
            <div class="container">
                <!-- Search bar -->
                <div class="checkout-container">
                    <div class="search-bar d-none d-md-flex">
                        <input type="text" name="" id="" placeholder="Search for item" class="search-bar__input">
                        <button class="search-bar__submit">
                            <img src="./assets/icons/search.svg" alt="" class="search-bar__icon icon">
                        </button>
                    </div>
                </div>

                <!-- Breadcrumbs -->
                <div class="checkout-container">
                    <ul class="breadcrumbs checkout-page__breadcrumbs">
                        <li>
                            <a href="Home" class="breadcrumbs__link" previewlistener="true">
                                Home
                                <img src="./assets/icons/arrow-right.svg" alt="">
                            </a>
                        </li>
                        <li>
                            <a href="#!" class="breadcrumbs__link breadcrumbs__link--current">Checkout</a>
                        </li>
                    </ul>
                </div>

                <!-- Checkout content -->
                <div class="checkout-container">
                    <div class="row gy-xl-3">
                        <div class="col-8 col-xl-12">
                            <div class="cart-info">
                                <h1 class="cart-info__heading">1. Shipping, arrives between <%=date_1%> and <%=date_2%></h1>
                                <div class="cart-info__separate"></div>
                                <div class="user-address">
                                    <div class="user-address__top">
                                        <div>
                                            <h2 class="user-address__title">Shipping address</h2>
                                            <p class="user-address__desc">Where should we deliver your order?</p>
                                        </div>
                                        <button class="user-address__btn btn btn--primary btn--rounded btn--small js-toggle" toggle-target="#add-new-address">
                                            <img src="./assets/icons/plus.svg" alt="">
                                            Update address
                                        </button>
                                    </div>
                                    <div class="user-address__list">
                                        <!-- Address card 1 -->
                                        <article class="address-card">
                                            <div class="address-card__left">
                                                <div class="address-card__choose">
                                                    <label class="cart-info__checkbox">
                                                        <input type="radio" name="shipping-adress" checked="" class="cart-info__checkbox-input">
                                                    </label>
                                                </div>
                                                <div class="address-card__info">
                                                    <h3 class="address-card__title"><%=user.getFullName()%></h3>
                                                    <p class="address-card__desc">
                                                        <%=user.getDeliveryAddress()%>
                                                    </p>
                                                    <ul class="address-card__list">
                                                        <li class="address-card__list-item">Shipping</li>
                                                        <li class="address-card__list-item">Delivery from store</li>
                                                    </ul>
                                                </div>
                                            </div>
                                            <div class="address-card__right">
                                                <div class="address-card__ctrl">
                                                    <button class="cart-info__edit-btn js-toggle" toggle-target="#add-new-address">
                                                        <img class="icon" src="./assets/icons/edit.svg" alt="">
                                                        Edit
                                                    </button>
                                                </div>
                                            </div>
                                        </article>
                                    </div>
                                </div>
                                <div class="cart-info__separate"></div>
                                <h2 class="cart-info__sub-heading">Items details</h2>
                                <div class="cart-info__list">
                                    <%
                                    for(Cart c : cartProduct) {
                                        String url;
                                        String root = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
                                        + request.getContextPath();
                                        String avatarURL= c.getpThumb();
                                        if (avatarURL != null) {
                    //                                        D:\Workspace\Java\Shopping\src\main\webapp\assets\img\avatar
                                        url = root + "/assets/img/product/" + avatarURL;
                                        
                                        } else url = "";
                                    %>
                                    <!-- Cart item 1 -->
                                    <article class="cart-item">
                                        <a href="./product-detail.html" previewlistener="true">
                                            <img src="<%=url%>" alt="" class="cart-item__thumb">
                                        </a>
                                        <div class="cart-item__content">
                                            <div class="cart-item__content-left">
                                                <h3 class="cart-item__title">
                                                    <a href="./product-detail.html" previewlistener="true">
                                                        <%=c.getpName()%>
                                                    </a>
                                                </h3>
                                                <p class="cart-item__price-wrap">
                                                    $<%=c.getpPrice() / c.getQuantity()%> | <span class="cart-item__status">In Stock</span>
                                                </p>
                                                <div class="cart-item__ctrl cart-item__ctrl--md-block">
                                                    <div class="cart-item__input">
                                                        <a href="quantity-inc-dec?action=dec&id=<%=c.getpId()%>" class="cart-item__input-btn">
                                                            <img class="icon" src="./assets/icons/minus.svg" alt="">
                                                        </a>
                                                        <span><%=c.getQuantity()%></span>
                                                        <a href="quantity-inc-dec?action=inc&id=<%=c.getpId()%>" class="cart-item__input-btn">
                                                            <img class="icon" src="./assets/icons/plus.svg" alt="">
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="cart-item__content-right">
                                                <p class="cart-item__total-price">$<%=c.getpPrice()%></p>
                                                <div class="cart-item__ctrl">
                                                    <a href="remove-from-cart?id=<%=c.getpId()%>" class="cart-item__ctrl-btn">
                                                        <img src="./assets/icons/trash.svg" alt="">
                                                        Delete
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </article>
                                    <%}%>
                                </div>
                                <div class="cart-info__bottom d-md-none">
                                    <div class="row">
                                        <div class="col-8 col-xxl-7">
                                            <div class="cart-info__continue">
                                                <a href="Home" class="cart-info__continue-link" previewlistener="true">
                                                    <img class="cart-info__continue-icon icon" src="./assets/icons/arrow-down-2.svg" alt="">
                                                    Continue Shopping
                                                </a>
                                            </div>
                                        </div>
                                        <div class="col-4 col-xxl-5">
                                            <div class="cart-info__row">
                                                <span>Subtotal:</span>
                                                <span>$${total > 0 ? total : 0}</span>
                                            </div>
                                            <div class="cart-info__row">
                                                <span>Shipping:</span>
                                                <span>$10.00</span>
                                            </div>
                                            <div class="cart-info__separate"></div>
                                            <div class="cart-info__row cart-info__row--bold">
                                                <span>Total:</span>
                                                <span>$${(total > 0) ? (total + 10.00) : 0}</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-4 col-xl-12">
                            <div class="cart-info">
                                <div class="cart-info__row">
                                    <span>Subtotal <span class="cart-info__sub-label">(items)</span></span>
                                    <span><%=number_of_cart%></span>
                                </div>
                                <div class="cart-info__row">
                                    <span>Price <span class="cart-info__sub-label">(Total)</span></span>
                                    <span>$${total > 0 ? total : 0}</span>
                                </div>
                                <div class="cart-info__row">
                                    <span>Shipping</span>
                                    <span>$10.00</span>
                                </div>
                                <div class="cart-info__separate"></div>
                                <div class="cart-info__row">
                                    <span>Estimated Total</span>
                                    <span>$${(total > 0) ? (total + 10.00) : 0}</span>
                                </div>
                                <a href="payment.jsp" class="cart-info__next-btn btn btn--primary btn--rounded" previewlistener="true">
                                    Continue to checkout
                                </a>
                            </div>
                            <div class="cart-info">
                                <a href="#!">
                                    <article class="gift-item">
                                        <div class="gift-item__icon-wrap">
                                            <img src="./assets/icons/gift.svg" alt="" class="gift-item__icon">
                                        </div>
                                        <div class="gift-item__content">
                                            <h3 class="gift-item__title">Send this order as a gift.</h3>
                                            <p class="gift-item__desc">
                                                Available items will be shipped to your gift recipient.
                                            </p>
                                        </div>
                                    </article>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%}%>
        </main>
        <!-- Footer -->
        <%@include file="/templates/footer.jsp"%>
        <div id="add-new-address" class="modal hide" style="--content-width: 650px">
            <div class="modal__content">
                <form action="update-address" class="form" method="POST" id="address-form">
                    <h2 class="modal__heading">Update shipping address</h2>
                    <div class="modal__body">
                        <div class="form__row">
                            <div class="form__group">
                                <label for="phone" class="form__label form__label--small">Phone</label>
                                <div class="form__text-input form__text-input--small">
                                    <input type="tel" name="phone" id="phone" placeholder="Phone" class="form__input" value="<%=user.getPhone()%>" rules="required|phone">
                                </div>
                                <p class="form__message"></p>
                            </div>
                        </div>
                        <div class="form__group">
                            <label for="address" class="form__label form__label--small">Address</label>
                            <div class="form__text-input">
                                <input type="text" name="address" id="address" placeholder="Address (Area and street)" class="form__input" value="<%=user.getDeliveryAddress()%>" rules="required"></textarea>
                            </div>
                            <p class="form__message"></p>
                        </div>
                    </div>
                    <div class="modal__bottom">
                        <button class="btn btn--small btn--text modal__btn js-toggle" toggle-target="#add-new-address">
                            Cancel
                        </button>
                        <button type="submit" class="btn btn--small btn--primary modal__btn btn--no-margin">
                            Update
                        </button>
                    </div>
                </form>
            </div>
            <div class="modal__overlay"></div>
        </div>
        <script>window.dispatchEvent(new Event("template-loaded"));</script>
        <script src="./assets/js/validator.js"></script>
        <script>
            new Validator("#address-form");
        </script>
        <script src="assets/js/theme.js" type="text/javascript"></script>
    </body>
</html>


    
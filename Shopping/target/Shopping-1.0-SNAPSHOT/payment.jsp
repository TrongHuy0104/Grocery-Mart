<%-- 
    Document   : payment
    Created on : Nov 23, 2023, 7:11:46 PM
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
<html>
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Payment | Grocery Mart</title>
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
        <main class="checkout-page">
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
                            <a href="checkout.jsp" class="breadcrumbs__link" previewlistener="true">
                                Checkout
                                <img src="./assets/icons/arrow-right.svg" alt="">
                            </a>
                        </li>
                        <li>
                            <a href="#!" class="breadcrumbs__link breadcrumbs__link--current">Payment method</a>
                        </li>
                    </ul>
                </div>

                <!-- Checkout content -->
                <div class="checkout-container">
                    <div class="row gy-xl-3">
                        <div class="col-8 col-xl-8 col-lg-12">
                            <div class="cart-info">
                                <div class="cart-info__top">
                                    <h2 class="cart-info__heading cart-info__heading--lv2">
                                        1. Shipping, arrives between <%=date_1%> and <%=date_2%>
                                    </h2>
                                    <a class="cart-info__edit-btn" href="checkout.jsp" previewlistener="true">
                                        <img class="icon" src="./assets/icons/edit.svg" alt="">
                                        Edit
                                    </a>
                                </div>

                                <!-- Payment item 1 -->
                                <article class="payment-item">
                                    <div class="payment-item__info">
                                        <h3 class="payment-item__title"><%=user.getFullName()%></h3>
                                        <p class="payment-item__desc"><%=user.getDeliveryAddress()%></p>
                                    </div>
                                </article>

                                <!-- Payment item 2 -->
                                <article class="payment-item">
                                    <div class="payment-item__info">
                                        <h3 class="payment-item__title">Items details</h3>
                                        <p class="payment-item__desc"><%=number_of_cart%> item(s)</p>
                                    </div>
                                    <a href="checkout.jsp" class="payment-item__detail" previewlistener="true">View details</a>
                                </article>
                            </div>

                            <div class="cart-info">
                                <h2 class="cart-info__heading cart-info__heading--lv2">2. Shipping method</h2>
                                <div class="cart-info__separate"></div>
                                <h3 class="cart-info__sub-heading">Availeble Shipping method</h3>

                                <!-- Payment item 3 -->
                                <label>
                                    <article class="payment-item payment-item--pointer">
                                        <img src="./assets/img/payment/delivery-1.png" alt="" class="payment-item__thumb">
                                        <div class="payment-item__content">
                                            <div class="payment-item__info">
                                                <h3 class="payment-item__title">Fedex Delivery</h3>
                                                <p class="payment-item__desc payment-item__desc--low">
                                                    Delivery: 2-3 days work
                                                </p>
                                            </div>

                                            <span class="cart-info__checkbox payment-item__checkbox">
                                                <input type="radio" name="delivery-method" checked="" class="cart-info__checkbox-input payment-item__checkbox-input">
                                                <span class="payment-item__cost">$10.00</span>
                                            </span>
                                        </div>
                                    </article>
                                </label>

                                <!-- Payment item 4 -->
                                <label>
                                    <article class="payment-item payment-item--pointer">
                                        <img src="./assets/img/payment/delivery-2.png" alt="" class="payment-item__thumb">
                                        <div class="payment-item__content">
                                            <div class="payment-item__info">
                                                <h3 class="payment-item__title">DHL Delivery</h3>
                                                <p class="payment-item__desc payment-item__desc--low">
                                                    Delivery: 2-3 days work
                                                </p>
                                            </div>

                                            <span class="cart-info__checkbox payment-item__checkbox">
                                                <input type="radio" name="delivery-method" class="cart-info__checkbox-input payment-item__checkbox-input">
                                                <span class="payment-item__cost">$10.00</span>
                                            </span>
                                        </div>
                                    </article>
                                </label>
                            </div>
                        </div>
                        <div class="col-4 col-xl-4 col-lg-12">
                            <div class="cart-info">
                                <h2 class="cart-info__heading cart-info__heading--lv2">Payment Details</h2>
                                <p class="cart-info__desc">
                                    Complete your purchase item by providing your payment details order.
                                </p>

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
                                <a href="order-now" class="cart-info__next-btn btn btn--primary btn--rounded">Pay $${(total > 0) ? (total + 10.00) : 0}</a>
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
        </main>
        <!-- Footer -->
        <%@include file="/templates/footer.jsp"%>
        <script src="assets/js/theme.js" type="text/javascript"></script>
    </body>
</html>

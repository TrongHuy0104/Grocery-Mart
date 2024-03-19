<%-- 
    Document   : sign-up
    Created on : Nov 18, 2023, 9:25:57 PM
    Author     : Trong Huy
--%>
<%@page import="entity.User"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Sign Up | Grocery Mart</title>
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
        <!-- Styles -->
        <link rel="stylesheet" href="./assets/css/main.css" />
        <!-- Scripts -->
        <script src="./assets/js/scripts.js"></script>
        <style>
            .auth__form {
                margin-top: 0;
            }

            .sign-up-content-inner {
                margin: 0;
                width: auto;
            }

            .form__group {
                text-align: left;
            }

            .form__group--inline {
                flex-direction: column;
                align-items: unset;
            }

            .form__title {
                font-size: 2.2rem;
                font-weight: 500;
                margin: 40px 0 20px;
                text-align: left;
            }

            .gender-container {
                display: flex;
                align-items: center;
                justify-content: space-around;
                margin: 20px 0;
            }

            .gender-group {
                display: flex;
                align-items: center;
                gap: 10px;
                font-size: 1.8rem;
                font-weight: 500;
            }

            .form__error {
                font-size: 1.6rem;
                color: red;
                margin-top: 20px;
                font-weight: 500;
                align-self: flex-start;
                margin-left: 15px;
            }

        </style>
    </head>
    <body>
        <!-- Main -->
        <main class="auth container">
            <%
                Object obj = session.getAttribute("user");
                User user = null;
                if (obj!=null)
                        user = (User)obj;		
                        if(user==null){		
            %>
            <div style="display: flex; align-items: center; justify-content: center; flex-direction: column; gap: 30px; width: 100%;">

                <h1 style="font-size: 3.6rem; font-weight: 600;">Bạn chưa đăng nhập vào hệ thống. Vui lòng quay lại trang chủ!</h1>
                <p class="auth__text">
                    <a href="Home" class="auth__link auth__text-link">Back to home page</a>
                </p>
            </div>
            <%
                            }else {
				
            %>
            <%
                String name= user.getFullName();
		
                String gender = user.getGender();
		
                String address= user.getAddress();
		
                String email= user.getEmail();
		
                String phone= user.getPhone();
		
                String deliveryAddress= user.getDeliveryAddress();
		
            %>
            <!-- Auth Content -->
            <div id="auth-content" class="auth__content hide">
                <div class="auth__content-inner sign-up-content-inner">
                    <!-- Logo -->
                    <a href="Home" class="logo">
                        <img src="./assets/icons/logo.svg" alt="grocerymart" class="logo__img top-bar__logo-img" />
                        <h2 class="logo__title top-bar__logo-title">grocerymart</h2>
                    </a>
                    <h1 class="auth__heading">Update Information</h1>
                    <p class="auth__desc">Let’s change your information.</p>
                    <p class="form__error">${note == "" ? "" : note}</p>
                    <form
                        action="user"
                        method="POST"
                        class="form auth__form row row-cols-2 row-cols-md-1 gx-5 gx-sm-0"
                        id="sign-up-form"
                        >
                        <input type="hidden" name="action" value="update-information"/>
                        <div class="col">
                            <p class="form__title">User Information</p>
                            <div class="form__group">
                                <label for="fullname" class="form__label">Full name</label>
                                <div class="form__text-input">
                                    <input
                                        id="fullname"
                                        type="text"
                                        placeholder="Name"
                                        class="form__input"
                                        name="name"
                                        value="<%=name%>"
                                        rules="required"
                                        />
                                    <img src="./assets/icons/letter.svg" alt="" class="form__input-icon" />
                                </div>
                                <span class="form__message"></span>
                            </div>
                            <div class="form__group">
                                <label for="gender" class="form__label">Gender</label>
                                <div class="gender-container">
                                    <div class="gender-group">
                                        <label for="male" class="radio">
                                            <input
                                                name="gender"
                                                type="radio"
                                                rules="required"
                                                value="male"
                                                <%=(gender.equals("male"))?"checked":"" %>
                                                class="form__input"
                                                id="male"
                                                />
                                            Male
                                        </label>
                                    </div>
                                    <div class="gender-group">
                                        <label class="female" class="radio">
                                            <input
                                                name="gender"
                                                type="radio"
                                                rules="required"
                                                value="female"
                                                <%=(gender.equals("female"))?"checked":"" %>
                                                class="form__input"
                                                id="female"
                                                />Female
                                        </label>
                                    </div>
                                    <div class="gender-group">
                                        <label for="other" class="radio">
                                            <input
                                                name="gender"
                                                type="radio"
                                                rules="required"
                                                value="other"
                                                <%=(gender.equals("other"))?"checked":"" %>
                                                class="form__input"
                                                id="other"
                                                />Other
                                        </label>
                                    </div>
                                </div>
                                <span class="form__message"></span>
                            </div>
                        </div>
                        <div class="col">
                            <p class="form__title">Address</p>
                            <div class="form__group">
                                <label for="address" class="form__label">Address</label>
                                <div class="form__text-input">
                                    <input
                                        id="address"
                                        type="text"
                                        placeholder="Address"
                                        class="form__input"
                                        name="address"
                                        value="<%=address%>"
                                        rules="required"
                                        />
                                    <img src="./assets/icons/letter.svg" alt="" class="form__input-icon" />
                                </div>
                                <span class="form__message"></span>
                            </div>
                            <div class="form__group">
                                <label for="delivery-address" class="form__label">Delivery address</label>
                                <div class="form__text-input">
                                    <input
                                        id="delivery-address"
                                        type="text"
                                        placeholder="Delivery Address"
                                        class="form__input"
                                        name="delivery-address"
                                        value="<%=deliveryAddress%>"
                                        rules="required"
                                        />
                                    <img src="./assets/icons/letter.svg" alt="" class="form__input-icon" />
                                </div>
                                <span class="form__message"></span>
                            </div>
                            <div class="form__group">
                                <label for="phone" class="form__label">Phone</label>
                                <div class="form__text-input">
                                    <input
                                        id="phone"
                                        type="text"
                                        placeholder="Phone number"
                                        class="form__input"
                                        name="phone"
                                        value="<%=phone%>"
                                        rules="required|phone"
                                        />
                                    <img src="./assets/icons/letter.svg" alt="" class="form__input-icon" />
                                </div>
                                <span class="form__message"></span>
                            </div>

                            <div class="form__group">
                                <label for="email" class="form__label">Email</label>
                                <div class="form__text-input">
                                    <input
                                        id="email"
                                        type="email"
                                        placeholder="Email"
                                        class="form__input"
                                        name="email"
                                        value="<%=email%>"
                                        rules="required|email"
                                        />
                                    <img src="./assets/icons/letter.svg" alt="" class="form__input-icon" />
                                </div>
                                <span class="form__message"></span>
                            </div>
                            <div class="form__group auth__btn-group">
                                <button class="btn btn--primary auth__btn form__submit-btn">Update</button>
                            </div>
                        </div>
                    </form>
                    <p class="auth__text">
                        <a href="Home" class="auth__link auth__text-link">Back to home page</a>
                    </p>
                </div>
            </div>
            <%} %>                                
        </main>
        <script>
            window.dispatchEvent(new Event("template-loaded"));
        </script>
        <script src="./assets/js/validator.js"></script>
        <script>
            new Validator("#sign-up-form");
        </script>
        <script src="assets/js/theme.js" type="text/javascript"></script>
    </body>
</html>


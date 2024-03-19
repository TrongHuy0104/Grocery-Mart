<%-- 
    Document   : 404
    Created on : Nov 17, 2023, 11:48:20 PM
    Author     : Trong Huy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Error Server</title>
        <!-- Favicon -->
        <link rel="apple-touch-icon" sizes="76x76" href="./assets/favicon/apple-touch-icon.png">
        <link rel="icon" type="image/png" sizes="32x32" href="./assets/favicon/favicon-32x32.png">
        <link rel="icon" type="image/png" sizes="16x16" href="./assets/favicon/favicon-16x16.png">
        <link rel="manifest" href="./assets/favicon/site.webmanifest">
        <link rel="mask-icon" href="./assets/favicon/safari-pinned-tab.svg" color="#5bbad5">
        <meta name="msapplication-TileColor" content="#da532c">
        <meta name="theme-color" content="#ffffff">
        <!-- Fonts -->
        <link rel="stylesheet" href="./assets/fonts/stylesheet.css">
        <!-- Stylesheets -->
        <link href="./assets/css/main.css" rel="stylesheet" type="text/css"/>
        <link href="./assets/css/error.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <main class="error">
            <img src="./assets/img/error/500.png" alt="" class="error__img"/>
            <p class="error__message">We have an internal server error</p>
            <a href="./Home" class="btn btn--primary btn--rounded error__cta">Go To Home</a>
        </main>
    </body>
</html>

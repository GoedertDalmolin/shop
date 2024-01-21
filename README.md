---

## Shop App (In progress)

---

<div align="center">

**Language:**

[![English](https://img.shields.io/badge/Language-English-blue?style=for-the-badge)](README.md)
[![Portuguese](https://img.shields.io/badge/Language-Português-blueviolet?style=for-the-badge)](README.pt-br.md)

</div>

---
## ℹ️ About this repository
Mobile application for managing an online store.

This repository's main objective is to demonstrate the application developed to train my knowledge during the Flutter course from the company [COD3R](https://www.udemy.com/course/curso-flutter/).

---
## ⚙️ Features
This app has the following features for managing a store:

- Integration with Firebase.
- User authentication.
- Product Management.
- Product cart management per user.
- Order Management per user.

---
## 👁️ Preview
<h1 align="center">
    <img src=".github/images/1-login-page.png" width="32%">
    <img src=".github/images/2-register-page.png" width="32%">
    <img src=".github/images/3-home-shop-page.png" width="32%">
</h1>

<h1 align="center">
    <img src=".github/images/4-product-detail-page.png" width="32%">
    <img src=".github/images/5-cart-page.png" width="32%">
    <img src=".github/images/6-drawer-menu-page.png" width="32%">
</h1>

<h1 align="center">
    <img src=".github/images/7-orders-page.png" width="32%">
    <img src=".github/images/8-product-list-page.png" width="32%">
    <img src=".github/images/9-product-form-page.png" width="32%">
</h1>

<h1 align="center">
<img src='.github/auth_page_gif.gif' width="35%">
<img src='.github/product_detail_animation.gif' width="35%">
</h1>

---
 ## 🧪 Technologies
This project was developed using the following technologies:

- [Flutter 3.16.7](https://docs.flutter.dev/)
- [Dart 3.2.4](https://dart.dev/)
- [Intl](https://pub.dev/packages/intl)
- [Google_Fonts](https://pub.dev/packages/google_fonts)
- [Http](https://pub.dev/packages/http)
- [Provider](https://pub.dev/packages/provider)
- [Shared Preferences](https://pub.dev/packages/shared_preferences)

---
## ⚡ Installing

Clone this project using

```bash
  git clone https://github.com/GoedertDalmolin/shop.git
  cd shop
```

Access the firebase_config.dart file using:

```bash
  cd shop/lib/utils/firebase_config.dart
```

Take your credentials listed in the project configuration within the Firebase console and replace them in their respective String variables (urlDatabase and apiKey).

```dart
class FirebaseConfig {
  // Put your DataBase URL here
  static String urlDatabase = 'YOUR-FIREBASE-DATABASE-URL';
  static String apiKey = 'YOUR-FIREBASE-API-KEY';
}
```

Finally compile and run the project.

---
</> Developed by [GoedertDalmolin](https://github.com/GoedertDalmolin) 👋
---

---

## Shop App

---

<div align="center">

**Language:**

[![English](https://img.shields.io/badge/Language-English-blueviolet?style=for-the-badge)](README.md)
[![Portuguese](https://img.shields.io/badge/Language-Português-blue?style=for-the-badge)](README.pt-br.md)

</div>

---
## ℹ️ Sobre este repositório
Aplicativo mobile para gerenciamento de uma loja virtual.

O objetivo principal deste repositório é demonstrar o aplicativo desenvolvido para treinar meus conhecimentos durante o curso de Flutter da empresa [COD3R](https://www.udemy.com/course/curso-flutter/).

---
## ⚙️ Funcionalidades
Este app tem as seguintes funcionalidades dentro do gerenciamento de uma loja:

- Integração com Firebase.
- Autenticação de usuário.
- Gerenciamento de Produtos.
- Gerenciamento de Carrinho de produtos por usuário.
- Gerenciamento de Pedidos por usuário.

---
## 👁️ Pré-visualização
<h1 align="center">
<img src='.github/auth_page.gif' width="35%">
<img src='.github/product_detail_animation.gif' width="35%">
</h1>

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

---
## 🧪 Tecnologias
Este projeto foi desenvolvido usando as seguintes tecnologias:

- [Flutter 3.16.7](https://docs.flutter.dev/)
- [Dart 3.2.4](https://dart.dev/)
- [Intl](https://pub.dev/packages/intl)
- [Google_Fonts](https://pub.dev/packages/google_fonts)
- [Http](https://pub.dev/packages/http)
- [Provider](https://pub.dev/packages/provider)
- [Shared Preferences](https://pub.dev/packages/shared_preferences)

---
## ⚡ Instalação

Primeiramente clone este projeto usando:

```bash
  git clone https://github.com/GoedertDalmolin/shop.git
  cd shop
```

Acesse o arquivo firebase_config.dart usando:

```bash
  cd shop/lib/utils/firebase_config.dart
```

Pegue suas credenciais listadas na configuração do projeto dentro do console do Firebase e substitua nas suas respectivas variáveis String (urlDatabase e apiKey).

```dart
class FirebaseConfig {
  // Put your DataBase URL here
  static String urlDatabase = 'YOUR-FIREBASE-DATABASE-URL';
  static String apiKey = 'YOUR-FIREBASE-API-KEY';
}
```

Por fim compile e execute o projeto.

---
</> Desenvolvido por [GoedertDalmolin](https://github.com/GoedertDalmolin) 👋
---

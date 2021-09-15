from django.urls import path
from .views import *
from rest_framework.authtoken.views import obtain_auth_token

urlpatterns = [

    path('register/', AuthUserRegistrationView.as_view()),
    path('login/', AuthUserLoginView.as_view()),

    path('users/', UserListView.as_view()),
    path('users/<int:id>/', UserDetailView.as_view()),

    path('products/', ProductView.as_view()),
    path('products/<int:id>/', Productdetails.as_view()),

    path('order/<int:id>',Orderdetails.as_view()),
    path('order/', OrderView.as_view()),
    path('ordernow/', OrderCreate.as_view()),

    path('addtocart/', AddToCart.as_view()),
    path('cart/', CartView.as_view()),
    path('delatecartprod/', DelateCarProduct.as_view()),
    path('deletecart/', DelateCart.as_view()),

    path('table/', Tablelist.as_view()),
    path('table/<int:num>/', Tabledetails.as_view()),

    path('category/', Categorylist.as_view()),
    path('category/<int:id>/', Categorydetails.as_view()),

    path('supplier/', Supplierlist.as_view()),
    path('supplier/<int:id>/', Supplierdetails.as_view()),

    path('stock/', Stocklist.as_view()),
    path('stock/<int:id>/', Stockdetails.as_view()),
]

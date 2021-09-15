from django.contrib import admin
from .models import Cart, Product, CartProduct, Category, Order,Table ,User ,Stock,Supplier


admin.site.register([User ,Cart, Product, CartProduct, Category, Order,Table,Stock,Supplier ])

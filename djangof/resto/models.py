from django.db import models
from django.contrib.auth.models import User

import uuid

from django.db import models
from django.contrib.auth.models import PermissionsMixin
from django.contrib.auth.base_user import AbstractBaseUser
from django.utils import timezone

from .manager import CustomUserManager

# Create your models here.
class User(AbstractBaseUser, PermissionsMixin):

    # These fields tie to the roles!
    ADMIN = 1
    MANAGER = 2
    SERVEUR = 3
    CUISINER= 4


    ROLE_CHOICES = (
        (ADMIN, 'Admin'),
        (MANAGER, 'Manager'),
        (SERVEUR, 'Serveur'),
        (CUISINER, 'Cuisiner'),
    )

    class Meta:
        verbose_name = 'user'
        verbose_name_plural = 'users'

    uid = models.UUIDField(unique=True, editable=False, default=uuid.uuid4, verbose_name='Public identifier')
    email = models.EmailField(unique=True)
    username = models.CharField(max_length=30, blank=True)
    first_name = models.CharField(max_length=30, blank=True)
    last_name = models.CharField(max_length=50, blank=True)
    role = models.PositiveSmallIntegerField(choices=ROLE_CHOICES, blank=True, null=True, default=3)
    date_joined = models.DateTimeField(auto_now_add=True)
    is_active = models.BooleanField(default=True)
    is_deleted = models.BooleanField(default=False)
    is_staff = models.BooleanField(default=False)
    created_date = models.DateTimeField(default=timezone.now)
    modified_date = models.DateTimeField(default=timezone.now)
    created_by = models.EmailField()
    modified_by = models.EmailField()
    is_admin = models.BooleanField(default=False)


    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = []

    objects = CustomUserManager()

    def __str__(self):
        return self.email



class Category(models.Model):
    title = models.CharField(max_length=100)

    def __str__(self):
        return self.title


class Product(models.Model):
    title = models.CharField(max_length=100)
    data = models.DateField(auto_now_add=True)
    category = models.ForeignKey(Category, on_delete=models.CASCADE)
    image = models.ImageField(upload_to="products/")
    price = models.PositiveIntegerField()
    description = models.TextField()

    def __str__(self):
        return self.title


class Cart(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    total = models.PositiveIntegerField()
    isComplit = models.BooleanField(default=False)
    date = models.DateField(auto_now_add=True)

    def __str__(self):
        return f"User={self.user.username}|ISComplit={self.isComplit}"


class CartProduct(models.Model):
    cart = models.ForeignKey(Cart, on_delete=models.CASCADE)
    product = models.ManyToManyField(Product)
    price = models.PositiveIntegerField()
    quantity = models.PositiveIntegerField()
    subtotal = models.PositiveIntegerField()

    def __str__(self):
        return f"Cart=={self.cart.id}<==>CartProduct:{self.id}==Qualtity=={self.quantity}"

class Table(models.Model):
    num = models.IntegerField(primary_key=True)
    capacite = models.IntegerField()

    def __str__(self):
        return str(self.num)




class Order(models.Model):
    to_do = 1
    In_progress = 2
    deliver = 3
    end = 4

    CHOICES = (
    (to_do, 'to_do'),
    (In_progress, 'In_progress'),
    (deliver, 'deliver'),
    (end, 'end'),
    )   

    cart = models.OneToOneField(Cart, on_delete=models.CASCADE)
    table = models.ForeignKey(Table, on_delete=models.CASCADE)
    etat= models.PositiveSmallIntegerField(choices=CHOICES ,blank=True, null=True, default=1)




class Supplier(models.Model):
    name_s= models.CharField(max_length=100)
    phone = models.IntegerField()
    services = models.CharField(max_length=100)

    def __str__(self):
        return str(self.name_s)

class Stock(models.Model):
    Article= models.CharField(max_length=100)
    quantite =models.IntegerField()
    categories = models.CharField(max_length=100)


    def __str__(self):
        return str(self.name_art)






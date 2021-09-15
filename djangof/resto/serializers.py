from rest_framework import serializers
from .models import *
from django.contrib.auth import get_user_model
from rest_framework.authtoken.models import Token
from rest_framework.authtoken.views import ObtainAuthToken
from django.contrib.auth.models import User
from django.contrib.auth import authenticate

User = get_user_model()




class UserRegistrationSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = (
            'id',
            'username',
            'email',
            'password',
            'role',
        )

    def create(self, validated_data):
        user = User.objects.create_user(**validated_data)
        Token.objects.create(user=user)
        return user


class UserListSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = (
            'id',
            'username',
            'email',
            'role'
        )


class UserLoginSerializer(serializers.Serializer):
    email = serializers.EmailField()
    password = serializers.CharField(max_length=128, write_only=True)
    role = serializers.CharField(read_only=True)
    token= serializers.CharField(read_only=True)

    def create(self, validated_date):
        pass
    def update(self, instance, validated_data):
        pass

    def validate(self, data):
        email = data['email']
        password = data['password']
        user = authenticate(email=email, password=password)

        if user is None:
            raise serializers.ValidationError("Invalid login credentials")

        try:

            token, created = Token.objects.get_or_create(user=user)

            validation = {

                'token': token.key,
                'email': user.email,
                'role': user.role,
            }

            return validation

        except User.DoesNotExist:
            raise serializers.ValidationError("Invalid login credentials")





class ProductSerializer(serializers.ModelSerializer):
    class Meta:
        model = Product
        fields = "__all__"
        depth = 1



class CartSerializers(serializers.ModelSerializer):
    class Meta:
        model = Cart
        fields = "__all__"


class CartProductSerializers(serializers.ModelSerializer):
    class Meta:
        model = CartProduct
        fields = "__all__"
        depth = 1


class OrdersSerializers(serializers.ModelSerializer):
    class Meta:
        model = Order
        fields = "__all__"
        depth = 1

class TableSerializers(serializers.ModelSerializer):
    class Meta:
        model = Table
        fields = "__all__"
        depth = 1

class CategorySerializers(serializers.ModelSerializer):
    class Meta:
        model = Category
        fields = "__all__"
        depth = 1


class SupplierSerializers(serializers.ModelSerializer):
    class Meta:
        model = Supplier
        fields = "__all__"
        depth = 1

class StockSerializers(serializers.ModelSerializer):
    class Meta:
        model = Stock
        fields = "__all__"
        depth = 1

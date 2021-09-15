from .serializers import *
from .models import *
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from rest_framework.authentication import TokenAuthentication
from rest_framework import generics,mixins
from rest_framework import filters
from rest_framework.authtoken.views import ObtainAuthToken
from django.contrib.auth.models import User
from rest_framework.authtoken.models import Token


from .models import User


class AuthUserRegistrationView(APIView):
    serializer_class = UserRegistrationSerializer

    def post(self, request):
        serializer = self.serializer_class(data=request.data)
        valid = serializer.is_valid(raise_exception=True)

        if valid:
            serializer.save()

            response = {
                'success': True,

                'message': 'User successfully registered!',
                'user': serializer.data,
            }

            return Response(response)





class UserListView(generics.GenericAPIView, mixins.ListModelMixin):

    queryset = User.objects.all()
    serializer_class = UserListSerializer

    def get(self,request):
        return self.list(request)



class UserDetailView(generics.GenericAPIView ,mixins.RetrieveModelMixin,mixins.UpdateModelMixin ,mixins.DestroyModelMixin):
    queryset = User.objects.all()
    serializer_class = UserListSerializer

    lookup_field = 'id'

    def get(self, request, id):
        return self.retrieve(request, id=id)

    def put(self,request, id):
        return self.update(request, id=id)

    def delete(self,request, id):
        return self.destroy(request,id=id)



class AuthUserLoginView(ObtainAuthToken):
     serializer_class = UserLoginSerializer

     def post(self, request):
         serializer = self.serializer_class(data=request.data)
         valid = serializer.is_valid(raise_exception=True)

         if valid:
             response = {
                'token': serializer.data['token'],
                'email': serializer.data['email'],
                'role': serializer.data['role']

             }

             return Response(response)




class ProductView(generics.GenericAPIView, mixins.ListModelMixin,mixins.CreateModelMixin):
    search_fields = ['title','price']
    filter_backends = (filters.SearchFilter,)

    authentication_classes = [TokenAuthentication, ]

    queryset = Product.objects.all()
    serializer_class = ProductSerializer

    def get(self, request):
        return self.list(request)

    def post(self, request):
        return self.create(request)


class Productdetails(generics.GenericAPIView ,mixins.RetrieveModelMixin,mixins.UpdateModelMixin ,mixins.DestroyModelMixin):

    authentication_classes = [TokenAuthentication, ]
    queryset = Product.objects.all()
    serializer_class = ProductSerializer

    lookup_field = 'id'

    def get(self, request, id):
        return self.retrieve(request, id=id)

    def put(self,request, id):
        return self.update(request, id=id)

    def delete(self,request, id):
        return self.destroy(request,id=id)




class Orderdetails(generics.GenericAPIView ,mixins.RetrieveModelMixin,mixins.UpdateModelMixin ,mixins.DestroyModelMixin):

    authentication_classes = [TokenAuthentication, ]
    queryset = Order.objects.all()
    serializer_class = OrdersSerializers

    lookup_field = 'id'

    def get(self, request, id):
        return self.retrieve(request, id=id)

    def put(self,request, id):
        return self.update(request, id=id)

    def delete(self,request, id):
        return self.destroy(request,id=id)


class OrderCreate(APIView):

    authentication_classes = [TokenAuthentication, ]

    def post(self, request):
        try:
            data = request.data
            cart_id = data['cartid']
            table_num = data['table_num']
            etat = data['etat']

            cart_obj = Cart.objects.get(id=cart_id)
            cart_obj.isComplit = True
            print("iscomplit =",cart_obj.isComplit)
            table_obj = Table.objects.get(num=table_num)


            cart_obj.save()
            table_obj.save()

            Order.objects.create(
                cart=cart_obj,

                table=table_obj,
            )
        
            response_msg = {"error": False, "message": "Your Order is Complit"}
        except:
            response_msg = {"error": True, "message": "Somthing is Wrong !"}
        return Response(response_msg)



class OrderView(APIView):

    authentication_classes = [TokenAuthentication, ]

    def get(self, request):
        try:
            query = Order.objects.filter(cart__user=request.user)
            serializers = OrdersSerializers(query, many=True)

            response_msg = {"error": False, "data": serializers.data}
        except:
            response_msg = {"error": True, "data": "no data"}
        return Response(response_msg)



class CartView(APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]

    def get(self, request):
        user = request.user
        try:
            cart_obj = Cart.objects.filter(user=user).filter(isComplit=False)
            data = []
            cart_serializer = CartSerializers(cart_obj, many=True)
            for cart in cart_serializer.data:
                cart_product_obj = CartProduct.objects.filter(cart=cart["id"])
                cart_product_obj_serializer = CartProductSerializers(
                    cart_product_obj, many=True)
                cart['cartproducts'] = cart_product_obj_serializer.data
                data.append(cart)
            response_msg = {"error": False, "data": data}
        except:
            response_msg = {"error": True, "data": "No Data"}
        return Response(response_msg)



class AddToCart(APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]

    def post(sefl, request):
        product_id = request.data['id']
        product_obj = Product.objects.get(id=product_id)
        print(product_obj, "product_obj")
        cart_cart = Cart.objects.filter(
            user=request.user).filter(isComplit=False).first()
        cart_product_obj = CartProduct.objects.filter(
            product__id=product_id).first()

        try:
            if cart_cart:
                print(cart_cart)
                print("OLD CART")
                this_product_in_cart = cart_cart.cartproduct_set.filter(
                    product=product_obj)
                if this_product_in_cart.exists():
                    cartprod_uct = CartProduct.objects.filter(
                        product=product_obj).filter(cart__isComplit=False).first()
                    cartprod_uct.quantity += 1
                    cartprod_uct.subtotal += product_obj.price
                    cartprod_uct.save()
                    cart_cart.total += product_obj.price
                    cart_cart.save()
                else:
                    print("NEW CART PRODUCT CREATED--OLD CART")
                    cart_product_new = CartProduct.objects.create(
                        cart=cart_cart,
                        price=product_obj.price,
                        quantity=1,
                        subtotal=product_obj.price
                    )
                    cart_product_new.product.add(product_obj)
                    cart_cart.total += product_obj.price
                    cart_cart.save()
            else:
                Cart.objects.create(user=request.user,
                                    total=0, isComplit=False)
                new_cart = Cart.objects.filter(
                    user=request.user).filter(isComplit=False).first()
                cart_product_new = CartProduct.objects.create(
                    cart=new_cart,
                    price=product_obj.price,
                    quantity=1,
                    subtotal=product_obj.price
                )
                cart_product_new.product.add(product_obj)
                new_cart.total += product_obj.price
                new_cart.save()
            response_mesage = {
                'error': False, 'message': "Product add to card successfully", "productid": product_id}
        except:
            response_mesage = {'error': True,
                               'message': "Product Not add!Somthing is Wromg"}
        return Response(response_mesage)


class DelateCarProduct(APIView):
    authentication_classes = [TokenAuthentication, ]
    permission_classes = [IsAuthenticated, ]

    def post(self, request):
        cart_product_id = request.data['id']
        try:
            cart_product_obj = CartProduct.objects.get(id=cart_product_id)
            cart_cart = Cart.objects.filter(
                user=request.user).filter(isComplit=False).first()
            cart_cart.total -= cart_product_obj.subtotal
            cart_product_obj.delete()
            cart_cart.save()
            response_msg = {'error': False}
        except:
            response_msg = {'error': True}
        return Response(response_msg)


class DelateCart(APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]

    def post(self, request):
        cart_id = request.data['id']
        try:
            cart_obj = Cart.objects.get(id=cart_id)
            cart_obj.delete()
            response_msg = {'error': False}
        except:
            response_msg = {'error': True}
        return Response(response_msg)




class Tablelist(generics.GenericAPIView, mixins.ListModelMixin,mixins.CreateModelMixin):

    authentication_classes = [TokenAuthentication, ]
    queryset = Table.objects.all()
    serializer_class = TableSerializers


    def get(self,request):
        return self.list(request)

    def post(self,request):
        return self.create(request)


class Tabledetails(generics.GenericAPIView ,mixins.RetrieveModelMixin,mixins.UpdateModelMixin ,mixins.DestroyModelMixin):

    authentication_classes = [TokenAuthentication, ]
    queryset = Table.objects.all()
    serializer_class = TableSerializers

    lookup_field = 'num'

    def get(self, request, num):
        return self.retrieve(request, num=num)

    def put(self,request, num):
        return self.update(request, num=num)

    def delete(self,request,num):
        return self.destroy(request,num=num)



class Categorylist(generics.GenericAPIView, mixins.ListModelMixin,mixins.CreateModelMixin):

    authentication_classes = [TokenAuthentication, ]
    queryset = Category.objects.all()
    serializer_class = CategorySerializers


    def get(self,request):
        return self.list(request)

    def post(self,request):
        return self.create(request)


class Categorydetails(generics.GenericAPIView ,mixins.RetrieveModelMixin,mixins.UpdateModelMixin ,mixins.DestroyModelMixin):
    authentication_classes = [TokenAuthentication, ]
    queryset = Category.objects.all()
    serializer_class = CategorySerializers

    lookup_field = 'id'

    def get(self, request, id):
        return self.retrieve(request, id=id)

    def put(self,request, id):
        return self.update(request, id=id)

    def delete(self,request, id):
        return self.destroy(request,id=id)



class Supplierlist(generics.GenericAPIView, mixins.ListModelMixin,mixins.CreateModelMixin):

    authentication_classes = [TokenAuthentication, ]
    queryset = Supplier.objects.all()
    serializer_class = SupplierSerializers


    def get(self,request):
        return self.list(request)

    def post(self,request):
        return self.create(request)


class Supplierdetails(generics.GenericAPIView ,mixins.RetrieveModelMixin,mixins.UpdateModelMixin ,mixins.DestroyModelMixin):

    authentication_classes = [TokenAuthentication, ]
    queryset = Supplier.objects.all()
    serializer_class = SupplierSerializers

    lookup_field = 'id'

    def get(self, request, id):
        return self.retrieve(request, id=id)

    def put(self,request, id):
        return self.update(request, id=id)

    def delete(self,request, id):
        return self.destroy(request,id=id)



class Stocklist(generics.GenericAPIView, mixins.ListModelMixin, mixins.CreateModelMixin):
    authentication_classes = [TokenAuthentication, ]
    queryset = Stock.objects.all()
    serializer_class = StockSerializers

    def get(self, request):
        return self.list(request)

    def post(self, request):
        return self.create(request)


class Stockdetails(generics.GenericAPIView, mixins.RetrieveModelMixin, mixins.UpdateModelMixin,mixins.DestroyModelMixin):
    authentication_classes = [TokenAuthentication, ]
    queryset = Stock.objects.all()
    serializer_class = StockSerializers

    lookup_field = 'id'

    def get(self, request, id):
        return self.retrieve(request, id=id)

    def put(self, request, id):
        return self.update(request, id=id)

    def delete(self, request, id):
        return self.destroy(request, id=id)

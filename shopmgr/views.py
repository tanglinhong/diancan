from django.shortcuts import render, get_object_or_404
from django.template import loader
from django.http import HttpResponseRedirect, HttpResponse, JsonResponse
from django.urls import reverse
from login.models import User
import json
from django.views.decorators.csrf import csrf_protect, csrf_exempt
from django.contrib.auth import authenticate, login, logout
from mainpage.models import Orders, OrderDetail, Address, Shop, Merchandise, SalesNum

# Create your views here.

def index(request):
	return render(request, 'shopmgr/index.html', {'user': request.user})

def show_today_orders_shop(request):
	# shop_id = 
	order_table = Orders.objects.filter()
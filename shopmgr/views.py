from django.shortcuts import render, get_object_or_404
from django.template import loader
from django.http import HttpResponseRedirect, HttpResponse
from django.urls import reverse
from login.models import User
import json
from mainpage.models import Orders, OrderDetail, Address, Shop, Merchandise, SalesNum
from datetime import datetime

# Create your views here.

def json_serialize(obj):
	if isinstance(obj, datetime):
		serial = obj.isoformat()
		return serial
	raise TypeError('Type not serializable')

def index(request):
	return render(request, 'shopmgr/index.html', {'user': request.user})

def show_today_orders_shop(request):
	print("show today orders")
	# shop_id = 
	shop = Shop.objects.get(user_id_id=request.user.id)
	print(shop)
	shop_id = shop.id
	order_table = Orders.objects.filter(shop_id_id=shop_id).values()
	order_list = list(order_table)
	print(order_list)
	response_data = {}
	response_data['orders'] = order_list
	return HttpResponse(json.dumps(response_data, default=json_serialize))

def complete_shopinfo(request):
	return render(request, 'shopmgr/complete_shopinfo.html', {'user': request.user})
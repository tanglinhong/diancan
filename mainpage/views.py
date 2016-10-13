from django.shortcuts import render, get_object_or_404
from django.template import loader
from django.http import HttpResponseRedirect, HttpResponse, JsonResponse
from django.urls import reverse
from login.models import User
from .models import Address, Orders, Shop, Merchandise
import json
from django.contrib.auth import authenticate, login, logout
from os import sys
from django.db.models import Count, Sum
import decimal
from django.contrib.sessions.backends.db import SessionStore

def index(request):
	return render(request, 'mainpage/index.html', {'user': request.user})


def complete_info(request):
	# print(request.user.username + str(request.user.id))
	curr_user = User.objects.get(pk=request.user.id)
	try:
		province = request.POST['province']
		city = request.POST['city']
		county = request.POST['county']
		street = request.POST['street']
		consignee = request.POST['consignee']
		consignee_tel = request.POST['consignphone']
		moren = request.POST['moren']
		email = request.POST['email']
		postcode = request.POST['postcode']
		if moren == 'true':
			is_default = True
		else:
			is_default = False
		cellphone = request.POST['phone']
		curr_user.cellphone = cellphone
		curr_user.email = email
		curr_user.save()
		if province!='':
			# print(is_default)
			addr = Address(province=province, city=city, county=county, street=street,
				consignee=consignee, consignee_tel=consignee_tel, user_id=curr_user,
				is_default=is_default, postcode=postcode)
			addr.save()
		return HttpResponse(1)
	except:
		import traceback
		# print(traceback.format_exc())
		return HttpResponse(0)

def add_address(request):
	province = request.POST['province']
	city = request.POST['city']
	county = request.POST['county']
	street = request.POST['street']
	consignee = request.POST['consignee']
	consignee_tel = request.POST['consignphone']
	is_default = request.POST['moren']
	postcode = request.POST['postcode']
	if is_default == '1':
		print("is default!")
		try:

			Address.objects.filter(user_id__id=request.user.id).filter(
				is_default=True).update(
				is_default=False)
		except:
			return HttpResponse(0)

	try:
		addr = Address(province=province, city=city, county=county, street=street,
						consignee=consignee, consignee_tel=consignee_tel, user_id=request.user,
						is_default=is_default, postcode=postcode)
		addr.save()
		return HttpResponse(1)
	except:
		return HttpResponse(0)


def location(request):
	return render(request, 'mainpage/location.html', {'user': request.user})

def jmp_to_personal(request):
	return render(request, 'mainpage/personal_center_page.html', {'user':request.user})

def jmp_to_complete_info(request):
	return render(request, 'mainpage/complete_info.html', {'user': request.user})

def query_user_info(request):
	response_data = {}
	curr_user = User.objects.get(pk=request.user.id)
	cellphone = curr_user.cellphone
	email = curr_user.email
	response_data['phone'] = cellphone
	response_data['email'] = email
	return HttpResponse(json.dumps(response_data))

def check_origin_pwd(request):
	password = request.POST['originPass']
	# print(password)
	user = authenticate(username=request.user.username, password=password)
	if user is not None:
		return HttpResponse(1)
	else:
		return HttpResponse(0)

def change_password(request):
	try:
		password = request.POST['newPass']
		user = User.objects.get(pk=request.user.id)
		user.set_password(password)
		user.save()
		# print(password)
		return HttpResponse(1)
	except:
		return HttpResponse(0)

def get_address_count(request):
	try:
		addrs = Address.objects.filter(user_id=request.user)
		addr_count = addrs.count()
		# print(addr_count)
		return HttpResponse(addr_count)
	except Address.DoesNotExist:
		return HttpResponse(0)


def show_first_page(request):
	pagenum_temp = request.POST['pagenum']
	limits_temp = request.POST['limits']
	pagenum = int(pagenum_temp)
	limits = int(limits_temp)
	start = (pagenum-1)*limits
	addr_table = Address.objects.filter(
				user_id=request.user).order_by('-id')[start:start+limits].values()
	addr_list = list(addr_table)
	response_data = {}
	response_data['address_array'] = addr_list
	return HttpResponse(json.dumps(response_data))


def del_addr(request):
	addr_id = int(request.POST['address_id'])
	addr = Address.objects.get(pk=addr_id)
	addr.delete()
	# addr.save()
	return HttpResponse(1)


def conf_default_addr(request):
	try:
		addr_id = int(request.POST['default_addr_id'])
		# print(addr_id)
		Address.objects.filter(user_id=request.user, is_default=True).update(is_default=False)
		default_user = Address.objects.get(pk=addr_id)
		default_user.is_default = True
		default_user.save()
		return HttpResponse(1)
	except:
		return HttpResponse(0)

def jmp_to_shop_detail(request, shop_id):
	return HttpResponseRedirect(reverse('mainpage:shop_detail', args=(shop_id,)))

def shop_detail(request, shop_id):
	return render(request,'mainpage/shoper_detail.html', {'shop_id':shop_id})

def jmp_to_shoppingcar(request):
	return render(request, 'mainpage/shopping_car.html', {'user': request.user})

def decimal_default(obj):
	if isinstance(obj, decimal.Decimal):
		return float(obj)
	raise TypeError('Type not serializable')

def show_shops_orderby_sales(request):
	all_orders = Orders.objects.values('shop_id_id').annotate(Count('shop_id_id'))
	all_shop_set = Shop.objects.order_by('id').values()
	all_shop = list(all_shop_set)
	for shop in all_orders:
		shop_id = shop['shop_id_id']
		all_shop[shop_id-1]['sales_num'] = shop['shop_id_id__count']
	# print(all_shop)
	response_data = {}
	response_data['shopArray'] = all_shop
	return HttpResponse(json.dumps(response_data, default=decimal_default))

def get_merchandises(request):
	shop_id = request.POST['shop_id']
	all_merchandises = Merchandise.objects.filter(shop_id_id=shop_id).values()
	merchandise_table = list(all_merchandises)
	response_data = {}
	response_data['foodsArray'] = merchandise_table
	return HttpResponse(json.dumps(response_data))

def get_spec_shopinfo(request):
	shop_id = request.POST['shop_id']
	shop = Shop.objects.get(pk=shop_id)
	user_id = shop.user_id_id
	user = User.objects.get(pk=user_id)
	addr = Address.objects.get(user_id_id=user_id)
	response_data = {}
	response_data['shopname'] = shop.shopname
	response_data['least_price']=shop.least_price;
	response_data['deliver_fee']=shop.deliver_fee;
	response_data['review_score']=float(shop.review_score);
	response_data['shop_img']=str(shop.shop_img);
	response_data['cellphone']=user.cellphone;
	response_data['address']= addr.city+ '市'+addr.street;
	print(response_data)
	return HttpResponse(json.dumps(response_data))

def add_to_shopcar(request):
	good_id = request.POST['food_id']
	shop_id = request.POST['shop_id']
	cart = request.session.get("cart", None)
	if not cart:
		print("Init cart")
		cart = {}
		cart[shop_id] = [good_id]
		request.session['cart'] = cart
		request.session.save()
	else:
		print("add to cart")
		if shop_id in list(cart.keys()):
			cart[shop_id].append(good_id)
		else:
			cart[shop_id] = [good_id]
		request.session.save()
	print(request.session['cart'])
	return HttpResponse(1)

def get_cart(request):
	user_id = request.user.id
	cart = request.session.get("cart", None)
	if not cart:
		return HttpResponse(0)
	print(cart)
	cart_dic = []
	for key in cart.keys():
		cart_dic.append({ key: { x: cart[key].count(x) for x in cart[key] } })
	response_data = {}
	response_data['shoppingcar_array'] = cart_dic
	return HttpResponse(json.dumps(response_data))

def flush_cart(request):
	print("clear cart")
	request.session['cart'] = {}
	return HttpResponse(1)

def get_shop_by_keywords(request):
	print("get by keywords")
	keywords = request.POST['keyword']
	shop_set = Shop.objects.filter(shopname__contains=keywords).values()
	shop_list = list(shop_set)
	print(shop_list)
	response_data = {}
	response_data['shopArray'] = shop_list
	return HttpResponse(json.dumps(response_data, default=decimal_default))

def get_my_threemonth_order(request):
	order_set = Orders.objects.filter(user_id_id=request.user.id).values()
	order_list = list(order_set)
	print(order_list)
from django.shortcuts import render, get_object_or_404
from django.template import loader
from django.http import HttpResponseRedirect, HttpResponse, JsonResponse
from django.urls import reverse
from login.models import User
from .models import Address
import json
from django.views.decorators.csrf import csrf_protect, csrf_exempt
from django.contrib.auth import authenticate, login, logout
from os import sys

def index(request):
		return render(request, 'mainpage/index.html', {'user': request.user})


def complete_info(request):
	print(request.user.username + str(request.user.id))
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
			print(is_default)
			addr = Address(province=province, city=city, county=county, street=street,
				consignee=consignee, consignee_tel=consignee_tel, user_id=curr_user,
				is_default=is_default, postcode=postcode)
			addr.save()
		return HttpResponse(1)
	except:
		import traceback
		print(traceback.format_exc())
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
	print(password)
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
		print(password)
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
		print(addr_id)
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
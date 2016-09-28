from django.shortcuts import render, render_to_response
from django.template import loader
from django.http import HttpResponseRedirect, HttpResponse
from django.urls import reverse
from .models import MyUser
import http.client, urllib.parse


# Create your views here.
def index(request):
	return render(request, 'login/index.html')

def authorize(request):
	user_name = request.POST['user_name']
	password = request.POST['user_pwd']
	try:
		user = MyUser.objects.get(username=user_name)
		if not user.check_password(password):
			raise MyUser.DoesNotExist
		else:
			return HttpResponseRedirect(reverse('login:jmp_to_mainpage'))
			#return render(request, "mainpage/index.html", {'user':user})
	except MyUser.DoesNotExist:
		return render(request, 'login/index.html',{
				'error_message': '用户名或密码错误',
			})

def jmp_to_mainpage(request):
	return render(request, 'mainpage/index.html')

def jmp_to_register(request):
	return HttpResponseRedirect(reverse('login:register_page'))

def register_page(request):
	return render(request, 'login/register.html')

def register(request):
	name = request.POST['user_name']
	password = request.POST['user_pwd']
	print(password)
	email = request.POST['user_email']
	cellphone = request.POST['user_phone']
	user = MyUser(username=name, email=email, cellphone=cellphone)
	user.set_password(password)
	user.save()
	return HttpResponseRedirect(reverse('login:index'))
from django.shortcuts import render, render_to_response
from django.template import loader
from django.http import HttpResponseRedirect, HttpResponse
from django.urls import reverse
from .models import User
from django.contrib.auth import authenticate, login

# Create your views here.
def index(request):
	return render(request, 'login/index.html')

def authorize(request):
	user_name = request.POST['user_name']
	password = request.POST['user_pwd']
	try:
		user = User.objects.get(username=user_name)
		if not user.check_password(password):
			raise User.DoesNotExist
		else:
			user = authenticate(username=user_name, password=password)
			login(request, user)
			return HttpResponseRedirect(reverse('mainpage:index'))
	except User.DoesNotExist:
		return render(request, 'login/index.html',{
				'error_message': '用户名或密码错误',
			})

def jmp_to_register(request):
	return HttpResponseRedirect(reverse('login:register_page'))

def register_page(request):
	return render(request, 'login/register_page.html')

def register(request):
	name = request.POST['user_name']
	password = request.POST['user_pwd']
	email = request.POST['user_email']
	cellphone = request.POST['user_phone']
	#user = User(username=name, email=email, cellphone=cellphone)
	#user.set_password(password)
	#user.save()
	user = User.objects.create_user(name, email, cellphone, password)
	user.save()
	return HttpResponseRedirect(reverse('login:index'))

def handle_duplicate(request):
	user_name = request.POST['name']
	user = User.objects.get(username=user_name)
	if user:
		HttpResponse(0)
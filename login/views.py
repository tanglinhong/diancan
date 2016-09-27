from django.shortcuts import render
from django.template import loader
from django.http import HttpResponseRedirect, HttpResponse
from django.urls import reverse
from .models import User

# Create your views here.
def index(request):
	return render(request, 'login/index.html')

def authorize(request):
	user_name = request.POST['user_name']
	password = request.POST['user_pwd']
	try:
		user = User.objects.get(name=user_name)
		if user.password != password:
			raise User.DoesNotExist
	except User.DoesNotExist:
		return render(request, 'login/index.html',{
				'error_message': '用户名或密码错误',
			})
	else:
		return HttpResponseRedirect(reverse('login:authorized'))

def login_success(request):
	return render(request, 'login/success.html')

def jmp_to_register(request):
	return HttpResponseRedirect(reverse('login:register_page'))

def register_page(request):
	return render(request, 'login/register.html')

def register(request):
	name = request.POST['user_name']
	password = request.POST['user_pwd']
	email = request.POST['user_email']
	cellphone = request.POST['user_phone']
	user = User(name=name, password=password,email=email,cellphone=cellphone)
	user.save()
	return HttpResponseRedirect(reverse('login:index'))
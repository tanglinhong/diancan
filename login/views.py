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
    user = authenticate(username=user_name, password=password)
    if user is not None:
        login(request, user)
        return HttpResponseRedirect(reverse('mainpage:index'))
    else:
        return render(request, 'login/index.html', {
            'error_message': '用户名或密码错误',
        })


def jmp_to_register(request):
    return HttpResponseRedirect(reverse('login:register_page'))


def register_page(request):
    return render(request, 'login/register_page.html')


def register(request):
    name = request.POST['user_name']
    password = request.POST['user_pwd']
    user = User.objects.create_user(name, password)
    user.save()
    user = authenticate(username=name, password=password)
    login(request, user)
    return HttpResponse(1)


def handle_duplicate(request):
    user_name = request.POST['name']
    try:
        user = User.objects.get(username=user_name)
        return HttpResponse(0)
    except User.DoesNotExist:
        return HttpResponse(1)

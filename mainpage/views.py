from django.shortcuts import render, get_object_or_404
from django.template import loader
from django.http import HttpResponseRedirect, HttpResponse
from django.urls import reverse
from login.models import User


def index(request):
	print(request.user.username=='')
	print(request.user)
	return render(request, 'mainpage/index.html', {'user': request.user})

def my_account(request):
	return render(request, 'mainpage/account.html', {'user': request.user})

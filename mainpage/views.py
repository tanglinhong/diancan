from django.shortcuts import render
from django.template import loader
from django.http import HttpResponseRedirect, HttpResponse
from django.urls import reverse
from login.models import User

def index(request, user_name):
	return render(request, 'mainpage/index.html', {'user_name': user_name})
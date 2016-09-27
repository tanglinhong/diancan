from django.shortcuts import render, get_object_or_404
from django.template import loader
from django.http import HttpResponseRedirect, HttpResponse
from django.urls import reverse
from login.models import User

def index(request, user_id):
	user = get_object_or_404(User, pk=user_id)
	return render(request, 'mainpage/index.html', {'user': user})
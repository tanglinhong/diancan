from django.shortcuts import render
from django.template import loader
from .models import User

# Create your views here.
def index(request):
	return render(request, 'login/index.html')

def authorize(request):
	user_name = request.POST['user_name']
	password = request.POST['user_pwd']
	user = User.objects.filter(name=user_name)
	if user.password == password:
		return render(request, 'login/success.html')
	else:
		return render(request, 'login/failed.html')
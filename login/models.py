from django.db import models
from django.contrib.auth.models import AbstractBaseUser
# Create your models here.
class MyUser(AbstractBaseUser):
	username = models.CharField(max_length=20, unique=True)
	email = models.CharField(max_length=40)
	cellphone = models.CharField(max_length=11)
	USERNAME_FIELD = 'username'
	class Meta:
		db_table = 'MyUser'
from django.db import models
from django.contrib.auth.models import AbstractBaseUser
# Create your models here.
class MyUser(AbstractBaseUser):
	username = models.CharField(max_length=20, unique=True)
	email = models.CharField(max_length=40)
	cellphone = models.CharField(max_length=11)
	USERNAME_FIELD = 'username'
	REQUIRED_FIELDS = ['email',]
	is_active = models.BooleanField(default=True)

	def get_full_name():
		return username

	def get_short_name():
		return username

	class Meta:
		db_table = 'MyUser'
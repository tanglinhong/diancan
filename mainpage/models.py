from django.db import models
from login.models import User

# Create your models here.
class Address(models.Model):
	province = models.CharField(max_length=30)
	city = models.CharField(max_length=30)
	county = models.CharField(max_length=30)
	street = models.CharField(max_length=400)
	consignee = models.CharField(max_length=30)
	consignee_tel = models.CharField(max_length=30)
	is_default = models.BooleanField(default=False)
	postcode = models.CharField(max_length=6)
	user_id = models.ForeignKey(User, on_delete=models.CASCADE)

	class Meta:
		db_table = 'Address'

	def __str__(self):
		return self.street
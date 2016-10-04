from django.conf.urls import url

from . import views

app_name = 'mainpage'

urlpatterns = [
    url(r'^$', views.index, name='index'),
    url(r'^account$', views.my_account, name='my_account'),
    url(r'^complete_info$', views.complete_info, name='complete'),
]
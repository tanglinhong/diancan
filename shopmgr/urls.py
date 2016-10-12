from django.conf.urls import url

from . import views

app_name = 'shopmgr'

urlpatterns = [
    url(r'^$', views.index, name='index'),
    url(r'^show_today_orders_shop$', views.show_today_orders_shop, name='show_today_orders_shop'),
]
from django.conf.urls import url

from . import views

app_name = 'login'
#login/
urlpatterns = [
    url(r'^$', views.index, name='index'),
    url(r'^authorize/$', views.authorize, name='authorize'),
]
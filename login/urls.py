from django.conf.urls import url

from . import views

app_name = 'login'
#login/
urlpatterns = [
    url(r'^$', views.index, name='index'),
    url(r'^authorize$', views.authorize, name='authorize'),
    url(r'^jmp_register$', views.jmp_to_register, name='jmp_to_register'),
    url(r'^register_page$', views.register_page, name='register_page'),
    url(r'^registered$', views.register, name='register'),
    url(r'^jmp_to_mainpage$', views.jmp_to_mainpage, name='jmp_to_mainpage'),
]
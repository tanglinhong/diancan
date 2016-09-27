from django.conf.urls import url

from . import views

app_name = 'login'
#login/
urlpatterns = [
    url(r'^$', views.index, name='index'),
    url(r'^authorize$', views.authorize, name='authorize'),
    url(r'^successfully$', views.login_success, name='authorized'),
    url(r'^jmp_register$', views.jmp_to_register, name='jmp_to_register'),
    url(r'^register_page$', views.register_page, name='register_page'),
    url(r'^registered$', views.register, name='register')
]
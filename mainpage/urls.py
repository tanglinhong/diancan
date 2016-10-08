from django.conf.urls import url

from . import views

app_name = 'mainpage'

urlpatterns = [
    url(r'^$', views.index, name='index'),
    url(r'^complete_info$', views.complete_info, name='complete'),
    url(r'^location$', views.location, name='location'),
    url(r'^personal_center$', views.jmp_to_personal, name='personal_center'),
    url(r'^jmp_to_complete_info$', views.jmp_to_complete_info, name="jmp_to_complete_info"),
    url(r'^query_user_info$', views.query_user_info, name="query_user_info"),
    url(r'^check_origin_pwd$', views.check_origin_pwd, name="check_origin_pwd"),
    url(r'^change_password$', views.change_password, name="change_password"),
    url(r'^add_addr$', views.add_address, name="add_addr"),
    url(r'^get_address_count$', views.get_address_count, name="get_address_count"),
    url(r'^show_first_page$', views.show_first_page, name="show_first_page"),
    url(r'^del_addr$', views.del_addr, name="del_addr"),
    url(r'^conf_default_addr$', views.conf_default_addr, name="conf_default_addr"),
]
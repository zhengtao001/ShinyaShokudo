from django.conf.urls import patterns, url

from EatsIndex import views

urlpatterns = patterns('',
  # ex: /index/
  url(r'^$', views.index, name='index'),
  url(r'^RegistePage$', views.registe, name='registe'),
  url(r'^LoginPage/(?P<fromurl>\w+)$', views.userlogin, name='userlogin'),
  url(r'^LogoutPage$', views.userlogout, name='userlogout'),
  url(r'^Lookfor$', views.lookfor, name='lookfor'),
  url(r'^Friend$', views.friends, name='friends'),
  url(r'^LikeIt/(?P<comment_id>\d+)$', views.LikeIt, name='LikeIt'),
  url(r'^Search$', views.searchTitle, name='searchTitle'),
  url(r'^Friend/(?P<user_id>\d+)$', views.follow, name='follow'),
  url(r'^Details/(?P<user_id>\d+)$', views.details, name='details'),
  url(r'^Chat$', views.chatPage, name='chatPage'),
  url(r'^api/sendmsg', views.sendmsg, name='sendmsg'),
  url(r'^api/recvmsg$', views.recvmsg, name='recvmsg'),
  url(r'^api/qfriends$', views.queryFriends, name='queryFriends'),
  url(r'^api/group/create$', views.createGroup, name='createGroup'),
  url(r'^api/group/join$', views.joinGroup, name='joinGroup'),
  url(r'^test', views.test, name='test'),
)
from django.conf.urls import patterns, include, url
from django.views import static
from django.contrib import admin
import os

ImageDir = os.path.join(os.getcwd(), 'files', 'pic_folder')

admin.autodiscover()

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'mysite.views.home', name='home'),
    # url(r'^blog/', include('blog.urls')),
    url(r'^', include('EatsIndex.urls', namespace='EatsIndex')),
    # url(r'^polls/', include('polls.urls', namespace='polls')),
    url(r'^admin/', include(admin.site.urls)),
    url(r'^site_media/pic_folder/(?P<path>.*)', static.serve, {'document_root': ImageDir}),
)

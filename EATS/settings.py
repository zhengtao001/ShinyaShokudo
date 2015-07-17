"""
Django settings for EATS project.

For more information on this file, see
https://docs.djangoproject.com/en/1.6/topics/settings/

For the full list of settings and their values, see
https://docs.djangoproject.com/en/1.6/ref/settings/
"""

# Build paths inside the project like this: os.path.join(BASE_DIR, ...)
import os
BASE_DIR = os.path.dirname(os.path.dirname(__file__))

# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/1.6/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = '*rx1^dz$dw&j#q3_0qlk*x+o3r55*p4qwt2cq7wak+m6@#cmf-'

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

TEMPLATE_DEBUG = True

ALLOWED_HOSTS = []


# Application definition

INSTALLED_APPS = (
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'EatsIndex',
    'comment',
    'Message',
)

MIDDLEWARE_CLASSES = (
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
)

ROOT_URLCONF = 'EATS.urls'

WSGI_APPLICATION = 'EATS.wsgi.application'

SESSION_EXPIRE_AT_BROWSER_CLOSE = True

# Database
# https://docs.djangoproject.com/en/1.6/ref/settings/#databases

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'EATS',
        'USER': 'root',
        'PASSWORD': '123',
        'HOST': 'localhost',
        'PORT': '3306',
        'OPTIONS': {
           'init_command': 'SET storage_engine=INNODB',
        }
    }
}

# Internationalization
# https://docs.djangoproject.com/en/1.6/topics/i18n/

LANGUAGE_CODE = 'en-us'

TIME_ZONE = 'Asia/Shanghai'

USE_I18N = True

USE_L10N = True

USE_TZ = True

TEMPLATE_DIRS = [os.path.join(BASE_DIR, "templates"),]

# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/1.6/howto/static-files/

STATIC_ROOT = os.path.join(os.path.dirname(os.path.dirname(__file__)),'static')

STATIC_URL = '/static/'

STATICFILES_DIRS = (
    ('css',os.path.join(STATIC_ROOT,'css').replace('\\', '/') ),  
    ('js',os.path.join(STATIC_ROOT,'js').replace('\\', '/') ),
    ('images',os.path.join(STATIC_ROOT,'images').replace('\\', '/') ),
    ('upload',os.path.join(STATIC_ROOT,'upload').replace('\\', '/') ),
)

MEDIA_ROOT = os.path.join(os.path.dirname(os.path.dirname(__file__)),'files')

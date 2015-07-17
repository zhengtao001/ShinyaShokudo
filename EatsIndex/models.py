from django.db import models
from django.contrib.auth.models import User
from django import forms
# Create your models here.

class RegisterForm(forms.Form):
  username    = forms.CharField(max_length = 16, min_length = 3)
  password    = forms.CharField(max_length = 18, min_length = 3)
  psw_confirm = forms.CharField(max_length = 18, min_length = 3)
  emial_add   = forms.EmailField(max_length = 30, min_length = 3)



class LoginForm(forms.Form):
  username = forms.CharField(max_length = 16, min_length = 3)
  password = forms.CharField(max_length = 18, min_length = 3)


class CommentForm(forms.Form):
  address  = forms.CharField(max_length = 30)
  foodname = forms.CharField(max_length = 80)
  price    = forms.CharField(max_length = 4)
  text     = forms.CharField(max_length = 300)
  image    = forms.ImageField()

class ImageUploadForm(forms.Form):
  image = forms.ImageField()

class RelationShip(models.Model):
    itself   = models.OneToOneField(User)
    relation = models.ManyToManyField(User, related_name="follower")

    # On Python 3: def __str__(self):
    def __unicode__(self):
        return self.itself.username

    class Meta:
        ordering = ('itself',)

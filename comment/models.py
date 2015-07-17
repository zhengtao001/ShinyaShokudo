from django.db import models
from django.contrib.auth.models import User

import datetime
import time
from django.utils import timezone
# Create your models here.
class UserComment(models.Model):
  """Users' comments"""
  author = models.ForeignKey(User)
  pub_date = models.DateTimeField('date published')
  text = models.TextField(max_length = 140)
  plus_one = models.IntegerField(default = 0)
  image = models.CharField(max_length = 40, null = True)

  def __unicode__(self):
    if not self.text is None:
      if len(self.text) < 20:
        return self.text
      else:
        return self.text[:20]
    else:
      return ''

class UserCommentV2(models.Model):
  """Users' comments"""
  author    = models.ForeignKey(User)
  pub_date  = models.DateTimeField('date published')
  text      = models.TextField(max_length = 300)
  plus_one  = models.IntegerField(default = 0)
  foodname  = models.CharField(max_length = 80)
  price     = models.IntegerField(default =  0)
  address   = models.CharField(max_length = 30)
  model_pic = models.ImageField(upload_to = 'pic_folder/', default = 'pic_folder/None/no-img.jpg')

class UserCommentV3(models.Model):
  model_pic = models.ImageField(upload_to = 'pic_folder/', default = 'pic_folder/None/no-img.jpg')
from django.db import models
from django.contrib.auth.models import User
from django import forms
import datetime
import time
from django.utils import timezone


# Create your models here.
class UserMessage(models.Model):
    sender = models.ForeignKey(User, related_name="sender")
    recver = models.ForeignKey(User, related_name="recver")
    pub_date = models.DateTimeField('date published')
    text = models.TextField()

    def __unicode__(self):
        return ("<From:"  + self.sender.username + 
                " To: "   + self.recver.username + 
                " Word: " + self.text + ">")

class ReceiveStatus(models.Model):
    user = models.ForeignKey(User)
    last_recv = models.DateTimeField()

class Group(models.Model):
    groupname = models.CharField(max_length=30)
    user = models.ManyToManyField(User)

class GroupMessage(models.Model):
    group = models.ForeignKey(Group)
    sender = models.ForeignKey(User)
    pub_date = models.DateTimeField('date published')
    text = models.TextField()
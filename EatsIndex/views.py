 # -*- coding: UTF-8 -*-
from django.shortcuts import (
  render_to_response,
  render,
  get_object_or_404,
  redirect
  )
from EatsIndex.models import (
  RegisterForm,
  LoginForm,
  CommentForm,
  ImageUploadForm,
  RelationShip,
)
from Message.models import (
  UserMessage,
  ReceiveStatus,
  Group,
  GroupMessage,
)
from comment.models import UserCommentV2
from django.db.models import Q
from django.http import HttpResponse
from django.template import RequestContext, loader
from django.http import HttpResponse, HttpResponseRedirect, HttpResponseForbidden
from django.contrib.auth.models import User, UserManager
from django.contrib.auth import authenticate, login, logout
from django.shortcuts import render
from django.utils import timezone
import random

import datetime
import time
import json

from django.views.decorators.csrf import csrf_exempt  

# Create your views here.
def index(request):
  if request.method == 'POST':
    if not request.user.is_authenticated():
      return redirect("/")
    else:
      comment = request.POST['comment']
      newComment = UserComment(author = request.user,
        pub_date = timezone.now(),
        text = comment
        )
      newComment.save()
      return redirect("/")
  else:
    commentsByPub_date = UserCommentV2.objects.order_by('-pub_date')[:12]
    commentsByPlus_one = UserCommentV2.objects.order_by('-plus_one')[:12]
    tmplist = []
    for i in UserCommentV2.objects.all():
      tmplist.append(i.id)
    count = UserCommentV2.objects.count()
    idlist = random.sample(tmplist, count)
    commentsByRandom = []
    loopCounter = 0
    for i in idlist:
      try:
        aComment = UserCommentV2.objects.get(pk = i)
      except UserCommentV2.DoesNotExist, e:
        pass
      else:
        commentsByRandom.append(aComment)
        loopCounter += 1
        if loopCounter == 12:
          break
    if request.user.is_authenticated():
      try:
        r = RelationShip.objects.get(itself = request.user)
      except RelationShip.DoesNotExist, e:
        r = RelationShip(itself = request.user)
        r.save()
      FollowList = r.relation.all()
    else:
      FollowList = []
    context = {'OrderByPubDate' : commentsByPub_date,
               'OrderByPlusOne' : commentsByPlus_one,
               'OrderByRandom'  : commentsByRandom,
               'follow_list'    : FollowList,
              }
    return render(request, 'EatsIndex/index.html', context)

def LikeIt(request, comment_id):
  if not request.user.is_authenticated():
    context = {
      'msg' : "Please login first!",
    }
    return render(request, "EatsIndex/Error.html", context)
  else:
    comment = UserCommentV2.objects.get(pk = comment_id)
    if comment is None:
      context = {
        'msg' : "You could not like something that is not exist!",
      }
      return render(request, "EatsIndex/Error.html", context)
    else:
      comment.plus_one += 1
      comment.save()
      return redirect("/")

def friends(request):
  if request.user.is_authenticated():
    try:
      r = RelationShip.objects.get(itself = request.user)
    except RelationShip.DoesNotExist, e:
      r = RelationShip(itself = request.user)
      r.save()
    FollowList = r.relation.all()
    context = {
      'follow_list' : FollowList,
    }
    return render(request, "EatsIndex/Friends.html", context)
  else:
    context = {
      'msg' : 'Please login first!',
    }
    return render(request, "EatsIndex/Friends.html", context)

def follow(request, user_id):
  if not request.user.is_authenticated():
    context = {
      'msg' : "Please login first!",
    }
    return render(request, "EatsIndex/Error.html", context)
  else:
    followed_user = User.objects.get(pk = user_id)
    if followed_user is None:
      context = {
        'msg' : "You could not follow someone that is not exist!",
      }
      return render(request, "EatsIndex/Error.html", context)
    else:
      if followed_user != request.user:
        try:
          r = RelationShip.objects.get(itself = request.user)
          r2 = RelationShip.objects.get(itself = followed_user)
        except RelationShip.DoesNotExist, e:
          r = RelationShip(itself = request.user)
          r.save()
        flist = r.relation.all()
        flist2 = r2.relation.all()
        if followed_user in flist:
          r.relation.remove(followed_user)
          r2.relation.remove(request.user)
          r.save()
          r2.save()
        else:
          r.relation.add(followed_user)
          r2.relation.add(followed_user)
          r.save()
          r2.save()
        return redirect('/')
      else:
        context = {
          'msg' : "You could not follow yourself!",
        }
        return render(request, "EatsIndex/Error.html", context)

def registe(request):
  if request.method == 'POST':
    form = RegisterForm(data = request.POST)
    if form.is_valid():
      username = form.cleaned_data['username']
      password = form.cleaned_data['password']
      # psw_confirm = form.cleaned_data['psw_confirm']
      mail = form.cleaned_data['emial_add']
      try:
        user = User.objects.get(username = username)
      except User.DoesNotExist, e:
        user = User.objects.create_user(username = username,
          email = mail,
          password = password)
        user.save()
        userlogin = authenticate(username=username, password=password)
        login(request, userlogin)
        return redirect('/')
      else:
        context = {
          'msg' : "The name has been registed! Please try another name",
        }
        return render(request, "EatsIndex/Error.html", context)
    else:
      context = {
        'msg' : "Check your input",
      }
      return render(request, "EatsIndex/Error.html", context)
  else:
    context = {
      'msg' : "Page not found!",
    }
    return render(request, "EatsIndex/Error.html", context)

def searchTitle(request):
  if request.method == 'GET':
    searchText = request.GET['ThingToSreach']
    commentsBySearch = UserCommentV2.objects.filter(foodname__contains = searchText)
    context = {
      'commentlist' : commentsBySearch,
      'keyword'     : searchText,
    }
    return render(request, 'EatsIndex/result.html', context)
  else:
    context = {
      'msg' : "Allow Get Method Only",
    }
    return render(request, "EatsIndex/Error.html", context)

def userlogin(request, fromurl):
  if request.method == 'POST':
    form = LoginForm(data = request.POST)
    if form.is_valid():
      username = form.cleaned_data['username']
      password = form.cleaned_data['password']
      user = authenticate(username=username, password=password)
      if user is not None:
        if user.is_active:
          login(request, user)
          if fromurl == 'index':  
            return redirect("/")
          elif fromurl == 'lookfor':
            return redirect("/Lookfor")
          elif fromurl == 'friend':
            return redirect("/Friend")
          else:
            context = {
              'msg' : "User not found!",
            }
            return render(request, "EatsIndex/Error.html", context)
        else:
          context = {
            'msg' : "User is not active!",
          }
          return render(request, "EatsIndex/Error.html", context)
      else:
        context = {
          'msg' : "User not found!",
        }
        return render(request, "EatsIndex/Error.html", context)
    else:
      context = {
        'msg' : "Please check up your name and password, and try it later",
      }
      return render(request, "EatsIndex/Error.html", context)
  else:
    context = {
      'msg' : "Page not found",
    }
    return render(request, "EatsIndex/Error.html", context)

def userlogout(request):
  logout(request)
  return redirect('/')

def lookfor(request):
  if request.method == 'POST':
    form = CommentForm(request.POST, request.FILES)
    if form.is_valid():
      newComment = UserCommentV2(author = request.user,
        pub_date = timezone.now(),
        text = form.cleaned_data['text'],
        foodname = form.cleaned_data['foodname'],
        price = form.cleaned_data['price'],
        address = form.cleaned_data['address']
        )
      newComment.save()
      rec = form.cleaned_data['image']
      filetype = '.' + rec.name.split('.')[-1]
      rec.name = request.user.username + filetype
      newComment.model_pic = rec
      newComment.save()
      return redirect('/Lookfor')
    else:
      context = {
        'msg' : "Check your input",
      }
      return render(request, "EatsIndex/Error.html", context)
  else:
    commentlist_v2 = UserCommentV2.objects.order_by('-plus_one')[:12]
    context = {
      'commentlist' : commentlist_v2,
    }
    return render(request, 'EatsIndex/lookFor.html', context)

def details(request, user_id):
  if request.method == 'GET':
    try:
      user = User.objects.get(pk = user_id)
    except User.DoesNotExist, e:
      context = {
        'msg' : 'This user does not exist'
      }
      return render(request, "EatsIndex/Error.html", context)
    commentByUserlist = UserCommentV2.objects.filter(author = user)
    context = {
      'keyword'     : user.username,
      'commentlist' : commentByUserlist,
    }
    return render(request, 'EatsIndex/result.html', context)

def chatPage(request):
  if not request.user.is_authenticated():
    context = {
      'msg' : 'pls login first!'
    }
    return render(request, 'EatsIndex/Error.html', context)
  else:
    friends = [u for u in getAllFriends(request.user)]
    groups  = [u for u in getAllGroups(request.user)]
    print groups
    context = {
      "friends" : friends,
      "friedns_count" : len(friends),
      "groups"  : groups,
    }

    return render(request, "EatsIndex/chat.html", context)

@csrf_exempt
def sendmsg(request):
  # print request.COOKIES["user"]
  if request.method == 'GET':
    context = {
      'msg' : "You got a wrong page!",
    }
    return render(request, "EatsIndex/Error.html", context)
  who = request.POST.get("who", None)
  when = request.POST.get("when", None)
  what = request.POST.get("what", None)
  if not who or not when or not what:
    return HttpResponse(json.dumps({
        'code' : 'error',
      }))
  print when, type(when)
  who = who.strip()
  # when = datetime.datetime.fromtimestamp(float(when)/1000.0)
  when = datetime.datetime.now().replace(tzinfo=timezone.utc)
  # when = when.replace(tzinfo=timezone.utc)
  print who
  print when
  print what
  sender = request.user
  recverType, recverId = who.split('-')
  if recverType == 'user':
    recver = User.objects.get(id=int(recverId))
    um = UserMessage(sender=sender, recver=recver, pub_date=when, text=what)
    print um
    um.save()
  elif recverType == 'group':
    recver = Group.objects.get(id=int(recverId))
    gm = GroupMessage(group=recver, sender=sender, pub_date=when, text=what)
    print gm
    gm.save()
  # time.sleep(1)
  return HttpResponse(json.dumps({
        'code' : 'success',
      }))

def recvmsg(request):
  # if request.method == 'GET':
  #   context = {
  #     'msg' : "You got a wrong page!",
  #   }
  #   return render(request, "EatsIndex/Error.html", context)
  timenow = datetime.datetime.now().replace(tzinfo=timezone.utc)
  timenow_s  = time.mktime(timenow.timetuple())
  try:
    recvT = ReceiveStatus.objects.get(user=request.user)
  except ReceiveStatus.DoesNotExist, e:
    recvT = ReceiveStatus.objects.create(
          user=request.user,
          last_recv=datetime.datetime(2000,1,1).replace(tzinfo=timezone.utc)
        )
  lastTime = request.COOKIES.get("lastTime")
  response = HttpResponse()
  if not lastTime:
    
    timeForTheFirst = time.mktime(recvT.last_recv.timetuple())
    response.content = json.dumps({
        'code' : 'the first time'
      })
    response.set_cookie("lastTime", timeForTheFirst*1000)
    
  else:
    # MsgCount: return the count of new message according to the time.
    # Messages: the list of message
    # response.content = json.dumps({
    #   "MsgCount" : 2,
    #   "Messages" : [
    #     {
    #       "who"  : "Ycc",
    #       "uid"  : "user-2",
    #       "what" : "I'm coding!",
    #       "when" : lastTime,
    #     },
    #     {
    #       "who"  : "Yccc",
    #       "uid"  : "user-"+str(3),
    #       "what" : "I'm coding!",
    #       "when" : lastTime,
    #     },
    #     {
    #       "who"  : "Yccc",
    #       "uid"  : "group-1",
    #       "what" : "I'm coding!",
    #       "when" : lastTime,
    #     }
    #   ],
    # })
    lastTime = datetime.datetime.fromtimestamp(float(lastTime)/1000).replace(tzinfo=timezone.utc)
    # utcTime = utcTime.replace(tzinfo=timezone.utc)
    print lastTime
    MsgFromFriends = UserMessage.objects.filter(pub_date__gt=lastTime, recver=request.user)
    MsgFromGroups = GroupMessage.objects.filter(Q(pub_date__gt=lastTime, group__in=request.user.group_set.all()),~Q(sender=request.user))
    retJSON = {"Messages":[]}
    for msg in MsgFromFriends:
      retJSON["Messages"].append({
        "who"  : msg.sender.username,
        "uid"  : "user-" + str(msg.sender.id),
        "what" : msg.text,
        "when" : time.mktime(msg.pub_date.timetuple())*1000
      })
    for msg in MsgFromGroups:
      retJSON["Messages"].append({
        "who"  : msg.sender.username,
        "uid"  : "group-" + str(msg.group.id),
        "what" : msg.text,
        "when" : time.mktime(msg.pub_date.timetuple())*1000
      })
    retJSON["MsgCount"] = len(retJSON["Messages"])
    print request.user.username, json.dumps(retJSON)
    response.content = json.dumps(retJSON, encoding='UTF-8', ensure_ascii=False)
    if retJSON["MsgCount"] != 0 and timenow > recvT.last_recv:
      response.set_cookie("lastTime", timenow_s*1000)
      recvT.last_recv = timenow
      recvT.save()
  return response

def queryFriends(request):
  if not request.user.is_authenticated():
    return HttpResponse(json.dumps({
      "error" : "please login in first"
      }))
  friends = getAllFriends(request.user)
  retJSON = { "FriendsCount" : friends.count(), "friends":[] }
  for friend in friends:
    retJSON["friends"].append({
        "name" : friend.username,
        "uid"  : friend.id,
      })
  return HttpResponse(json.dumps(retJSON))

def getAllFriends(user):
  try:
    r = RelationShip.objects.get(itself = user)
  except RelationShip.DoesNotExist, e:
    r = RelationShip(itself=user)
    r.save()
  return r.relation.all()

def getAllGroups(user):
  return user.group_set.all()

# @csrf_exempt
def createGroup(request):
  if request.method != "POST":
    return JsonResponse({'success':False, 'reason':'Only post method allowed.'})
  groupName = request.POST.get('name')
  if not groupName:
    return JsonResponse({'success':False, 'reason':'Please give me your group name.'})
  try:
    group = Group.objects.get(groupname=groupName)
    return JsonResponse({'success':False, 'reason':'The group name is already used.'}) 
  except Group.DoesNotExist, e:
    group = Group(groupname=groupName)
    group.save()
    print request.POST
    groupmemberId = request.POST.getlist('choices')
    print groupmemberId
    gm = User.objects.filter(id__in=groupmemberId)
    group.user.add(request.user)
    for u in gm:
      group.user.add(u)
    print group.user.all()
    # group.save()
  return JsonResponse({
    'success'   : True,
    'GroupName' : group.groupname,
    'GroupId'   : "group-" + str(group.id)
    })

def joinGroup(request):
  if request.method != "POST":
    return JsonResponse({'success':False, 'reason':'Only post method allowed.'})
  groupName = request.POST.get('name')
  if not groupName:
    return JsonResponse({'success':False, 'reason':'Please give me your group name.'})
  try:
    group = Group.objects.get(groupname=groupName)
    isExist = group.user.filter(username=request.user)
    if isExist:
      return JsonResponse({'success':False, 'reason':'You have already join the group!'})
    group.user.add(request.user)
    group.save()
    return JsonResponse({
      'success'   : True,
      'GroupName' : group.groupname,
      'GroupId'   : "group-" + str(group.id)
      })
  except Group.DoesNotExist, e:
    return JsonResponse({'success':False, 'reason':'The group does not exist!'})
  

def test(request):
  return render(request, "EatsIndex/ajaxLab.html")

def JsonResponse(dictionary):
  return HttpResponse(json.dumps(dictionary))
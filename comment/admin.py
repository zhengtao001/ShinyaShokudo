from django.contrib import admin

# Register your models here.
from comment.models import UserCommentV2

class CommentsIndex(admin.ModelAdmin):
  fieldsets = [
    ('Author', {'fields' : ['author']}),
    ('LikeIt', {'fields' : ['plus_one']}),
    ('Published Date', {'fields' : ['pub_date']}),
    ('Text', {'fields' : ['text']}),
    ('Address', {'fields' : ['address']}),
    ('FoodName', {'fields' : ['foodname']}),
    ('Price', {'fields' : ['price']}),
    ('Image', {'fields' : ['model_pic']})
  ]
  list_display = ['text', 'author', 'pub_date', 'plus_one']

admin.site.register(UserCommentV2, CommentsIndex)

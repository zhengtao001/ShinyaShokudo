1. 编程环境：
    ubuntu 14.04.1

2. 依赖：
    以下环境是本项目所必须的，请事先配置好
    a) python v2.7.6
    b) mysql  v5.5.4
    c) django v1.6.5

3. 配置：
    a) 首先修改项目文件夹下的Eats文件夹下的settings.py文件的第65~66行的数据库用户名与密码，使与本机一致
    b) 使用以下命令导入数据库文件。请将{{ username }} 改为数据库根用户名
       $ mysql -u {{ username }} -p EATS < eats.sql
    c) 如果(b)方法不成功，请尝试使用 databaseBackUp文件夹下的build.sh将数据库导入

4. 运行：
    在manage.py的同级目录下使用以下命令运行程序
    $ python manage.py runserver 8888 #仅限本机访问
    或者
    $ python manage.py runserver 0.0.0.0:8888 #同一局域网下可通过本机"ip:8888"访问

5. 使用：
    a) 浏览器（请使用chrome以保证访问效果）地址栏输入
       localhost:8888
    b) 以下账号作为测试账号可以使用（密码都是123）
       ycc xiaoming cyc
       也可以自己注册账号测试，注意账号密码长度至少为3位
    c) 登录以后在导航栏选择 chat 一栏，开始聊天

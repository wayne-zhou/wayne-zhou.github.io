---
title: mongoDB语法笔记
copyright: true
date: 2017-12-08 13:56:51
categories: notes
tags: mongo
top: 4
---

## 启动
```Bash
#进入mongoDB下的bin文件, 可加参数 --port 20000 --auth      auth表示开始鉴权
mongod.exe --dbpath "F:\ProgramFiles2\mongoDB\db"

执行mongo.exe
```

## 创建db
```Bash
#创建名为mydb的数据库，如果该数据库存在，则切换到这个数据库
use mydb
#检查当前选定的数据库
db
#检查数据库列表，空的数据库不显示
show dbs
删除当前所在的数据库
db.dropDatabase()
```

## 创建用户
```Bash
#查看用户,在admin库
db.system.users.find()
#创建用户,admin库创建root用户
db.createUser({user:"root",pwd:"123456",roles:["userAdminAnyDatabase"]})
#登录root用户
db.auth("root","123456")  
#创建可执行js的角色：
db.createRole({role:'sysadmin',roles:[],privileges:[{resource:{anyResource:true},actions:['anyAction']}]})  
#其它库创建用户，首先以用户管理员的身份登录 admin 数据库。然后用 use 命令切换到目标数据库，同样用 db.createUser() 命令来创建用户，其中角色名为 read 和 readWrite
#testy用户追加权限执行js权限
db.grantRolesToUser("test", [{role:"sysadmin", db:"admin"}] )
#更新权限
db.updateUser()
#删除权限
db.revokeRolesFromUser()
```

## 创建集合
```Bash
#创建一个movie的集合
db.createCollection('movie')
#查看当前库的集合
db.getCollectionNames()
#删除movie的集合
db.movie.drop()
```

## 新增
```Bash
#movie的集合中插入一条数据
db.movie.insert({})
#movie的集合中插入多条数据
db.movie.insert([{},{}])
```

## 查询
```Bash
#查询movie的集合，pretty()输出的是格式化后的
db.movie.find().pretty()
##根据key1和key2的条件过滤, &&关系
db.movie.find({key1:'value1', key2:'value2'}).pretty()
#根据key1或key2的条件过滤,||的关系过滤
db.movie.find({$or:[{key1:'value1'},{key1:'value2'}]}).pretty()
#条件key1大于num
db.movie.find({key1:{$gt:num}}).pretty()   #$lt小于,$get大于等于,$let小于等于
#按磁盘存储顺序返回第一个
db.movie.findOne({key1:'value1'})
#skip表示从第几(0)个开始,limit输出几个   
db.movie.find().skip(1).limit(2).pretty()
#第一个是过滤参数，第二个表示返回字段，1表示要返回，而0则表示不返回，默认0
db.movie.find({key1:'value'},{'key1':1,'key2':1}).pretty()
```

## 更新
```Bash
#key1条件，key2更新字段,默认更新第一个。key2不存在时新增key2字段
db.movie.update({key1:'value1'}, {$set:{key2:value2}})
#key2自增加num,多记录默认更新第一个
db.movie.update({key1:'value1'}, {$inc:{key2:num}})
#符合条件的都更新
db.movie.update({}, {$inc:{key2:num}},{multi:true})
#符合key1条件的记录中key2的值追加value2
db.movie.update({key1:'value1'}, {$push:{key2:'value2'}})
```

## 删除
```Bash
#删除movie集合
db.movie.remove()
#删除符合key1条件的所有记录
db.movie.remove({key1:'value1'})
#删除符合key1条件的第一条记录
db.movie.remove({key1:'value1'},1)
```

## 索引和排序
```Bash
#key1加上升序索引,-1为降序
db.movie.ensureIndex({key1:1},{"background":true})
#key1加上text索引，用于文本搜索
db.movie.ensureIndex({key1:'text'},{"background":true})
#过滤文本中含有aaa的
db.movie.find({$text:{$search:"aaa"}}).pretty()
#返回movie的所有索引
db.movie.getIndexes()
#删除key1的索引
db.movie.dropIndex('indexName')
#按照key1升序，-1为降序
db.movie.find().sort({'key1':1}).pretty()
```

## 聚合
```Bash
#按照key1分组后求和key2。$avg、$first、$last、$max、$min
db.movie.aggregate([{$group:{_id:'$key1',num2:{$sum:'$key2'}}}])
db.movie.group
#多项分组
db.movie.aggregate([{$group:{_id:{key1:'$key1',key2:'$key2'},num2:{$sum:'$key2'}}}])
#分组并加查询条件
db.movie.group({
    key:{key1:'$key1',key2:'$key2'},
    initial:{count:0},
    $reduce:function(doc,prev)
    {
        prev.count++
    },
    condition:{key1:{$gte:3}}
});
```

## 正则表达式
```Bash
#过滤key1中含有b的，区分大小写
db.movie.find({key1:{$regex:'.*b'}}).pretty()
#不区分大小写
db.movie.find({key1:{$regex:'.*b$',$options:'$i'}}).pretty()
```
---
title: GitHub+Hexo+Next搭建个人博客笔记
date: 2017-09-23 23:09:28
categories: notes
tags: Git
copyright: true
top: 1
---

## Git步骤
* 通过Git bash进入要建仓库的文件夹
* 把当前的目录变成可以管理的git仓库，生成隐藏.git文件
```Bash
git init
```

* 指定用户名和邮箱
```Bash
git config  --global user.name "gitName"
git config  --global user.email "gitEmail"
```

* 生成SHK
```Bash
#先查看有没有生成过
cd ~/.ssh
ls
#有就直接用
#没有命令生成
ssh-keygen  -t rsa –C  "gitEmail"
#复制id_rsa.pub到Settings→SSH and GPG keys →New SSH key

#测试命令
ssh -T git@github.com
```

* Git常用命令
```Bash
#把XX文件添加到暂存区去，XX写成 . ,表示提交当前目录下所有文件
git add XX

#提交XX文件
git commit –m "注释" XX

#查看仓库状态
git status

#查看XX文件修改了那些内容     
git diff  XX

#查看历史记录     
git log

#查看历史记录的版本号id         
git reflog

#回退到上一个版本     
git reset  --hard HEAD^ 或者 git reset  --hard HEAD~

#把XX文件在工作区的修改全部撤销
git checkout -- XX

#删除XX文件   
git rm XX

#创建+切换分支
git checkout –b name

#查看分支
git branch

#切换分支
git checkout name
　　
#合并某分支到当前分支
git merge name

#删除分支
git branch –d name

#删除分支后保留分支信息
git merge –no-ff  -m "注释" name
　　
#删除远程分支
git push origin :name

#隐藏当前工作现场
git stash

#回复工作现场,恢复后，stash内容并不删除，需要使用命令 git stash drop 来删除
git stash apply
#另一种方式,恢复的同时把stash内容也删除了
git stash pop

#关联一个远程库gitUrl, origin是给远程仓库起的别名       
git remote add origin gitUrl

#把当前master分支推送到远程库
git push –u(第一次要用-u 以后不需要) origin master

#获取仓库最新代码
git pull

#查看远程仓库信息
git remote –v

#取消与远程仓库origin的关联
git remote remove origin

#推送到远程仓库， master可换位分支名，即推送分支
git push origin master
#强行覆盖远程仓库  
git push -f origin master
将本地分支name推送到远程，并在远程创建name分支      
git push origin name:name

#从远程库中克隆
git clone gitUrl

#把本地的分支推送到仓库，并在仓库创建对应的分支,name为分支名
git branch --set-upstream name origin/name

#在远程库中克隆分支到本地，并在本地创建对应分支，name为分支名
git checkout  –b name origin/name
```

## Hexo步骤
* 安装Hexo
```Bash
npm install -g hexo-cli
```

* 初始化Hexo
```Bash
hexo init
```

* 生成Hexo文件结构
```Bash
npm install
```

* 配置deploy（修改站点_config.yml中的deploy，修改完后执行）
```Bash
npm install hexo-deployer-git --save
```

* 插件安装
```Bash
#rss插件： 
npm install --save hexo-generator-feed

#统计插件：
npm install hexo-wordcount --save

#本地搜索插件：
npm install hexo-generator-searchdb --save
```

## Next主题扩展
* 站点统计：LeanCloud
* 第三方评论：来必力
* 图床：七牛云


## 软件下载
* [git下载地址：](https://git-scm.com/download) 
<https://git-scm.com/download>
* [tortoiseGit下载地址：](https://tortoisegit.org/download/) 
<https://tortoisegit.org/download/>
* [nodejs下载地址：](https://nodejs.org/en/download/) 
<https://nodejs.org/en/download/>

## 文档参考
* [HEXO：](https://hexo.io/zh-cn/docs/) 
<https://hexo.io/zh-cn/docs/>
* [Next主题：](http://theme-next.iissnan.com/getting-started.html) 
<http://theme-next.iissnan.com/getting-started.html>
* [Next个性化配置传送门](http://shenzekun.cn/hexo%E7%9A%84next%E4%B8%BB%E9%A2%98%E4%B8%AA%E6%80%A7%E5%8C%96%E9%85%8D%E7%BD%AE%E6%95%99%E7%A8%8B.html) 
* [Sublime Text编辑MarkDowm参考传送门](http://blog.csdn.net/github_32886825/article/details/52930195) 
Sublime Text配置常用插件(Package Control 、OmniMarkupPreviewer、IMESupport、spacegray),配置snippet
#hexo 生成静态文件
hexo generate
#复制public文件夹下文件到关联库的本地地址
cp -R public/* .deploy_git/
cd .deploy_git/
git add .
git commit -m “update”
git push origin master
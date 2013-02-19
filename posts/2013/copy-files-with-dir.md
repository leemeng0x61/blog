---
title: 如何带路径复制文件
date: '2013-02-19'
description: Linux下带路径复制文件
categories: [technology]
tags: [command]
---

###背景
前段时间在做代码合并的时候，不得不采取手工merge，由于涉及的文件很多，单个`beyondcmp`着实抗不住，就想着用命令一次性搞定。

###分析
`beyondcmp`多文件比较需要路径一致，因此如果要做这样的修改，就需要将目前修改的文件放到对应的目录下。

###思路
起初的想法是先截取每个文件所在的目录全路径，然后通过`cp`的方式复制过去，但这样感觉太过复杂，可能还需要写一个小脚本，有点过了。最后就想到之前用`tar`的带路径压缩解压，至于参数列表可以通过`xargs`的`-I`参数来解决，这样就可以解决文件路径创建的问题。

###做法
使用`git diff --name-only`可以将当前仓库做的修改文件列出来   
使用`tar cvf`将文件带路径压缩   
最终的命令就是
   
    git diff --name-only | xargs -I @ tar cvf 11.tar  @

或者

    git status --short | awk '{print $2}' | xargs -I @ tar cvf 11.tar  @ 

前者只列出修改的文件，后者包含了新加的文件--未添加到仓库中   
使用`tar xvf`将`11.tar`文件带路径解压 仓库外的新目录，然后与另一个仓库进行目录比较，最后在`beyondcmp`中做手工merge

###后记
其实这种操作本来可以避免，但是目前由于android的版本太多，多文件比对操作无法避免，上面的做法，简单明了，能很快的将修改文件列出比较，相对与文件逐一寻找比对要方便，时间上也节省不少。
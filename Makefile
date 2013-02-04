#=============================================================================
#     FileName: Makefile
#         Desc: Auto Blog Makefile
#       Author: Lee Meng
#        Email: leaveboy@gmail.com
#     HomePage: http://leaveboy.is-programmer.com/
#      Version: 0.0.1
#   LastChange: 2013-01-26 23:32:52
#      History:
#=============================================================================
src = /tmp/compiled/
target = ../leaveboy.github.com

all:
	@bundle exec ruhoh compile '${src}'
	#@bundle exec ruhoh compile

.PHONE:install
install:
	rm ${target}/* -fr
	cp ${src}/* ${target} -fr

.PHONE:clean
clean:
	@rm ${src} -fr

.PHONE:push
push:
	cd ${target} && git add . && git commit -a -m "update" && git push
#module 模块
=begin
模块时只有程序部分的集合体 
类与模块最大的不同在于 
module 不能建立实例
module 不能继承


 
=end
# 用途 1提供命名空间  modulename.functionname
p FileTest.exist?("ruby.rb")

include Math

puts PI
#用途 2 Mix-in  将模块混进类里 称为Mix-in
module MyModule
	#想要共同提供的方法等
	def all_have_t_method
		puts "all_have_t_method"
	end
end

class MyClass1
	include MyModule
	#MyClass1所特有的方法
end

class MyClass2
	include MyModule
	#MyClass2所有的方法
end

puts MyClass1.new.all_have_t_method
puts MyClass2.new.all_have_t_method

#define module
module HelloModule
	Version="1.0"
	def hello(name)#默认只能module内部使用 不能使用modulename.functionname
		print "Hello ,",name,"\n"
	end
	
	module_function :hello #将Hello以模块函数的形式公开
end

puts HelloModule::Version
puts HelloModule::hello("Adele")

include HelloModule #读入
p Version
hello("Alien")

#！！专门为Mix-in 而设计的模块不应该提供模块函数


#异常处理

def copy(from,to)
	begin
		#有可能发生异常的操作
		#i=1/0
		src=open(from)
		dst=open(to,w) 
		data=src.read
		dst.write
		dst.close
	rescue => ex
		#异常发生时的处理
		print ex.message,"\n"
		print ex.backtrace,"\n"
		print ex.class,"\n"
		
		#	print $@,"\n" #	print ex.backtrace,"\n"
		#	print $!,"\n" #	print ex.message,"\n"
		#重新执行 
		sleep 10
		retry #+、重新执行 有可能无线循环*
	ensure #相当于finally
		src.close
	end
end



#rescue 
val="abc"  # n=0
n=Integer(val) rescue 0
puts n

val="123"	#123
n=Integer(val) rescue 0
puts n


class Foo
	begin
		#类定义内容
	rescue  Exception1,Exception2=>ex
		#例外处理
	ensure
		#后置处理
	end
end

class MyError <StandardError;end
#触发Exception
#catch throw

def test_throw
	throw :MyError
end

puts "test start"

catch(:MyError){
	puts "before test_throw"
	test_throw()#异常发生 下面语句不执行
	puts "after test_throw"
}

puts "test end"
#test start
#before test_throw
#test end

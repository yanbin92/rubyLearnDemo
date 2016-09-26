#循环
from=0
to=10
sum=0
for i in from..to  #.. 包含to  ...不包含to
	sum=sum+i #sum+=i
	#puts sum
end
p sum

#

names=["alex","ailen","adele"]
for name in names 
	print name,"\n"
end
names.each{|name|
	print name,"\n"

}
(1..5).each{|name|
	print name,"\n"
}
(1...5).each{|name|
	print name,"\n"
}

i=0
while i<3
	print i,"\n"
	i+=1
end

sum=0
until sum>=50
	sum+=i
	i+=1
end
print sum

#loop 没有结束条件 只是不断进行循环
#需要和break配合 
#next 类似java continue
#redo 以相同条件重新进行这一次循环

loop{	
	if(i==40)
		break;
	elsif i==20
		i+=1;
		redo;
		print "redo i=20"

	end


	i+=1
	print "ruby",i,"\t"
}

#redo 详解  redo 必须在redo 之前做循环增加 类似next 
#但是redo之后的语句也会执行
i=0
["adele","alex","alen","demon"].each{|name|
	i+=1
	if(i===3)
		redo;
	end
	print [i,name],"\n"
}



=begin
def quickSort(arr,left,right)
	key=arr[left]
	i=left
	j=right
	while(i<j)
		while arr[j]>key 
			j-=1
		end
		if(arr[j]<key)
			arr[i]=arr[j]
			i+=1
		end
		while(arr[i]<key)
			i+=1
		end
		if(arr[i]>key)
			arr[j]=arr[i]
			j-=1
		end
	
	end
	if(i===j)
		arr[i]=key
	end
	
	quickSort(arr,left,i-1)
	quickSort(arr,i+1,right)
end


arr=[20,76,10,25,15,78]
quickSort(arr,0,arr.length)

#定义方法

 def functionname(args,...) 
	dosomething
 end
=end
def hello(name="Ruby")#设默认值
	name
	#return 可以省略 这样methond中最后一行是返回值
	#return name #带返回值
end
puts hello();
puts hello("myRuby")



=begin

def quick_sort(a)  
  (x=a.pop) ? quick_sort(a.select{|i| i <= x}) + [x] + quick_sort(a.select{|i| i > x}) : []  
end 


def quickSort(arr,left,right)
	key=arr[left]
	i=left
	j=right
	while(i<j)
		while(arr[j]>key)   #TODO 这边报错为啥 
			j-=1
		end
		if(arr[j]<key)
			arr[i]=arr[j]
			i+=1
		end
		while(arr[i]<key)
			i+=1
		end
		if(arr[i]>key)
			arr[j]=arr[i]
			j-=1
		end
	
	end
	if(i===j)
		arr[i]=key
	end
	
	quickSort(arr,left,i-1)
	quickSort(arr,i+1,right)
end

arr=[20,76,10,25,15,78]
print arr,"\n"

quickSort(arr,0,arr.length-1)
print arr

=end

def quickSort(arr,left,right)
	key=arr[left]
	i=left
	j=right
	while(i<j)
		while(arr[j]>key)   #TODO 这边报错为啥 
			j-=1
		end
		if(arr[j]<key)
			arr[i]=arr[j]
			i+=1
		end
		while(arr[i]<key)
			i+=1
		end
		if(arr[i]>key)
			arr[j]=arr[i]
			j-=1
		end
	
	end
	if(i===j)
		arr[i]=key
	end
	
	if(left<i)
		quickSort(arr,left,i-1)
		quickSort(arr,i+1,right)
	end
end

arr=[20,76,10,25,15,78]
print arr,"\n"

quickSort(arr,0,arr.length-1)
print arr,"\n"


ary=Array.new
puts ary
p ary.class#==Array #对象属于哪个类
p ary.instance_of?(Array) #java中也有
#继承 
str="geek"
p str.is_a?(String) # true
p str.is_a?(Object) # true

class HelloRubyClass#
	attr_accessor:name #快速设置读写方法
=begin
	attr_readere:name #只读
	attr_writer:name	#只写
	def name 
		return @name
	end
	
	def name=(value)
		@name=value
	end
=end
	
	def initialize(myname="Ruby")#类似java构造器
		@name=myname  #初始化属性
	end
	
	def hello
		print "hello world , i am ",@name,".\n"
	end
	
	def HelloRubyClass.hello(name)
		print "static method" #静态写法一
	end
	
	#静态function 写法3
	def self.hello3()   
		print "static hello3 method","\n"
	end
	
	def self.count
		@@count #不写return 默认最后一行返回值
	end
	
	Version="1.0" #常数 类似java static final
	@@count=0 #静态变量 类似java 
end
	#静态写法2
class << HelloRubyClass
	def hello(name)
		print name,"static method 2" 
	end
end
HelloRubyClass.hello("static ");
HelloRubyClass.hello3();

bob=HelloRubyClass.new("Yin")
bob.hello()
p bob.name
p bob.name="xiugai name"

puts HelloRubyClass::Version
puts HelloRubyClass.count


#扩充类
class String#
	def count_word
		ary=self.split(/\s+/)
		return ary.size
	end
end

str="hello exClass "
puts str.count_word
#继承
class #childclass
< #parentclass


end















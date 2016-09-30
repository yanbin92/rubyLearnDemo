#ruby 其他补充知识
#Ruby解释器  
#命令行选项
#ruby -ks sample.rb
#-c 语法检查 
#-d设定调试模式
some_var="i am in debug"
print　some_var if $DEBUG

#自定义运算符
class Vector
	attr_reader :x, :y
	def initialize(x=0,y=0)
		@x,@y=x,y
	end
	def inspect #显示用
		"(#{@x},#{@y})"
	end
	def +(other)
		Vector.new(@x+other.x,@y+other.y)
	end
	def -(other)
		Vector.new(@x-other.x,@y-other.y)
	end
	def +@  #vec=Vector.new  +vec
		self.dup
	end
	def -@  #vec=Vector.new  +vec
		Vector.new(-@x,-@y)
	end	
	def ~@  #vec=Vector.new  +vec
		Vector.new(-@y,-@x)
	end	
	
	def [](idx)
		case idx
		when 0
			@x
		when 1
			@y
		else
			raise ArgumentError,"out of range #{idx}"
		end
	end
	def []=(idx,val)#[]= 方法名？
		case idx
		when 0
			@x=val
		when 1
			@y=val
		else
			raise ArgumentError,"out of range #{idx}"
		end
	end
end

vec0=Vector.new(3,6)
vec1=Vector.new(1,8)

p vec0
p vec1
p vec0+vec1
p vec0-vec1
vec=Vector.new(3,6)
p +vec
p -vec
p ~vec
p vec[0]
p vec[1]=2
p vec[1]
#p vec[2]

#迭代器
#区块调用 
#obj.method(arg1,arg2,...){|变量行|
	#想要反复处理的部分
#}

#f=File.open("sample.txt")
#f.each{|line|
#	print line
#}
#f.close

#Enumerable 模块 each  collect sort sort_by



ary=%w(1 2 3 4 5 6 7 8 9 10 11 12 13 14 12 1 121 21 12)
num=0
ary.sort{|a,b|
 num+=2
 a.length<=>b.length
}#19 个元素
p num  #76

num=0
sorted=ary.sort{|a,b|
	num+=1
	a <=> b
}
p num  #64 性能点 
#p ary
sorted=ary.sort{|a,b|  #自定义排序逻辑 
	a.length <=> b.length
}

###sort_by会对每个元素先执行一次区块指定的动作 再以这个结果进行排序
num=0
ary.sort_by!{|item|
	num+=1
	item.length
}

p num  #19
p ary


####自定义迭代器
class Book
	attr_accessor :title, :author, :genre
	def initialize(title,author,genre=nil)
		@title=title
		@author=author
		@genre=genre
	end
end



class BookList
	def initialize
		@booklist=Array.new
	end
	
	def add(book)
		@booklist.push(book)
	end
	
	def[]=(b,book)
		@booklist[n]=book
	end
	
	def [](n)
		@booklist[n]
	end
	
	def delete(book)
		@booklist.delete(book)
	end
	#####！！！yield 是定义迭代器最重要的关键所在
	#yield 在方法中 表示调用传递给这个方法的区块
	def each
		@booklist.each{|book|
			yield(book)
		}
	end
	
	def each_title
		@booklist.each{|book|
			yield(book.title)
		}
	end
	
	##add a method  find_by_author
	def find_by_author (author)
		if block_given?  ###!!!区块不存在时 
			@booklist.each{|book|
			if(author =~ book.author)
				yield(book)
			end
			}
		else ##区块不存在 
			res=[]
			@booklist.each{|book|
			if(author =~ book.author)
				res << book
			end
			}
			return res
		end
	end
end


#require "booklist" require "book"

booklist=BookList.new
b1=Book.new("Ipad讲解","adele")
b2=Book.new("Ipad讲解2","adele2")
booklist.add(b1)
booklist.add(b2)

print booklist[0].title,"\n"
print booklist[1].title,"\n"

booklist.each{|book|
	print book
}

booklist.each_title{|title|
	print title
}


##扩展  下面方法转换 下一个method
author_regexp=/^adele$/
booklist.each{|book|
	if book.author=~author_regexp
		print "\n",book.title
	end
}

#find_by_author
booklist.find_by_author(/adele/){|book|
	puts book
}


#in `block in find_by_author': no block given (yield) (LocalJumpError
#解决方案  修改##!!! find_by_author
books=booklist.find_by_author(/adele/)
books.each{|book|
	puts "find "+book.title
}

#!!!区块的传递方法  &
def each_some(a,b,&block)
	#前面的处理
	each_some2(&block)
	#后面的处理
	end
	
def call(a,b)
	print a,b
end

def fooo(a,b,&block)
	#Invokes the block, setting the block's parameters
#	to the values in paramsusing something close to 
#method calling semantics.
# Generates a warning if multiple values are 
#passed to a proc that expects just one
# (previously this silently converted the 
#parameters to an array). 
#Note that prc.() invokes prc.call() with the parameters given. It's a syntax sugar to hide “call”.

	block.call(a,b) 

end
	
fooo(3,5){|a,b|
	#def call
		print "\n call ",a,b,"\n"
	#end
}


#------别人讲解的block  yield------------
def cal(num)
	yield(num)
end

def cal_many(*num_arr,&block)
	num_arr.map do |num|
		cal(num,&block)
	end
end

p cal_many(1,2,3){|num|  num**2}


#与下面相同 TODO　没明白
def foo(a,b)
	yield(a,b) #传递给调用这个方法的block
end
foo(3,5){|a,b|   #{block}
	print a,b
}

def ruby_china(&block)
   puts block
end
ruby_china{
}

#block 是Proc的实例 
a_proc = Proc.new {|a, *b| b.collect {|i| i*a }}
p a_proc.call(9, 1, 2, 3)   #=>  调用block [9, 18, 27]
p a_proc[9, 1, 2, 3]        #=> [9, 18, 27]


#Mix-in 与继承很像  用于扩充类 模块的机制
# Mix-in 是将想要新增的部分定义成模块 再将模块嵌入到类里去
#include 方法

module Mix
	def meth
		puts "method"
	end
end

class C
	include Mix
end

c=C.new
c.meth


#Comparable 是Ruby所内建的Mix-in  模块和java中类似

class Book #
	include Comparable
	
	def <=>(other)
		#比较领域
		t=@genre.to_s <=> other.genre.to_s
		return t if t!=0
		return @title <=> other.title
	end

	attr_accessor :title,:author,:genre
	
	def initialize(title,author,genre="DATA")
		@title=title
		@author=author
		@genre=genre
	end
end


ary=[]
ary << Book.new("Music","Adele","SF")
ary << Book.new("Music_Japan","yadang","TUFU ")
ary << Book.new("Music_safe","Alien","C")
ary << Book.new("Music_stage","Wendi")

ary.sort.each{|book|
	printf "%-10s %-20s %s\n",book.genre,book.title,book.author
}

#Enumerable 模块

#在BookList 类里加入Enmuerable
#The Enumerablemixin provides collection classes 
#with several traversal and searching methods, 
#and with the ability to sort. 
#The class must provide a method each, 
#which yields successive members of the collection. 
#If Enumerable#max, #min, or #sortis used, the objects in the collection
# must also implement a meaningful <=>operator, as these methods rely on an ordering between members of the collection.
# Enumerable 必须实现each
class BookList 
include Enumerable

	def each
		@booklist.each{|book|
			yield(book)
		}
	end

end


booklist=BookList.new
booklist.add(Book.new("AR","Adele"))
booklist.add(Book.new("VR","Adele"))
booklist.add(Book.new("CR","Adele"))

titles=booklist.collect{|book|
	book.title
}
p titles

#各个方法用法 http://doc.rubyfans.com/ruby/v2.1/
#all?{|item| ..} 对每个元素调用区块的内容 若所有结果都为真则返回true
#any?{|item| ..} 对每个元素调用区块的内容 若有结果为真则返回true
#map{|item| ..} 以数组返回区块运算的结果
#find{|item|} 返回区块的返回值为真的第一个item
#find_all{|item|} 返回区块的返回值为真的所有item
#grep(pattern){|item|} 返回===与pattern匹配的的所有item
#include?(obj)
#inject(initial=nil){|memo,item|} initial=nil 初始值传给memo 每次调用区块后将放回值给memo 返回最后一次的区块返回值
#max min{|a,b|} 以sort 方法相同的方式进行比较 
#partition{|item|}  
#reject 与findall 相反
p (1..10).reject { |i|  i % 3 == 0 }   #=> [1, 2, 4, 5, 7, 8, 10]

#sort
(1..10).sort { |a, b| b <=> a }  #=> [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
#sort_by
#to_a  
#zip
a = [ 4, 5, 6 ]
b = [ 7, 8, 9 ]

[1, 2, 3].zip(a, b)      #=> [[1, 4, 7], [2, 5, 8], [3, 6, 9]]



##21.4与继承的关系
# 读入顺序 Book Comparable Object
p Book.ancestors() #[Book, Comparable, Object, Kernel, BasicObject]

#Array String Hash IO 都读入了Enumerable
#单继承 与Mix-in 组合 可以说是类设计上达到好懂又满足好用的两全解答
#使用Mix-in方法是查找顺序


def print2
 yield(1,2)
end

print2{|a,b|
	print a,b

}

#使用Mix-in时方法查找规则  ancestors

#1类本身有就类本身的类似继承
#2 在类中读入不止一个模块时 以最后读入的优先
#3 当读入多层现象时以最后读入的优先
#4重复读入同一个module是第二次读入无效
#5当读入有多层现象时 查找顺序仍呈线狀



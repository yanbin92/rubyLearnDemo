#使用类
#数值 Numeric 
#Numeric ->Integer 
#				->Bignum
#				->Fixnum   普通整数
#		 ->Float
#puts 2**1000  #**乘 2^1000
p 10.divmod(3)  #[3,1] 商3余1
p Math.sqrt(2)

include Math
p sqrt(4)
#sin(x)... exp(x)  指数函数 log(x)  log10(x)
#Math提供的常数 PI E

#数值类型转换

p 10.to_f 	#10.0
p 10.8.to_i	#10
p -10.8.to_i #-10
p "10.8".to_f #10.8
#round 四舍五入
p 1.5.ceil  #2 返回比接收者大的最小整数
p -1.5.ceil #-1
p 1.5.floor # 1 返回比接收者小的最大整
p -1.5.floor
=begin
~ 逻辑非
& 逻辑与
| 逻辑或
^ 互斥逻辑和
>>  右移
<< 左移
=end
def pb(i)
	printf "%08b\n",i&0b11111111
end

b=0b11110000
pb(b)
pb(~b)
pb(b&0b00010001)
pb(b|0b00010001)
#    0b11110000
pb(b^0b00010001) #异或  01 为1  11100001

a=0.1+0.2 
p a # 0.3
b=(a==0.3)
p b #false 
=begin
解释为啥出现这中情况呢
因为浮点数的小数部分在计算机的内部实现时
是按1/2,1/4,1/8等与2的幂相乘的形式存在的
1/5 1/3不等数在二进制中不能被正确的表示出来
为了将上述数字通过二进制数表示出来 就不得不适当的截取部分值来表示
这就出现了所谓的舍入误差
=end

ary=[]
10.times{|i|
	ary << i #递增赋值
}
p ary

2.upto(10){|i|
	ary << i
}
p ary
#from.step(to,step)

ary=[]
2.step(10,2){|i|
	ary << i
}
p ary

#练习1 
def cels2fahr(cels)#摄氏温度转华式温度
	fahr=cels*9/5.0+32
end
#练习2
def fahr2cels(fahr)
	cels=(fahr-32)*5/9.0
end
1.step(100,1){|i|
	print i,"\t",cels2fahr(i),"\n"
}
#练习3
def dice()
	rand(6)+1
end
#6.times{|i|
	p dice()
#}

#练习4
def prime?(num)
	#p Math.sqrt(num)
	2.step(Math.sqrt(num),1){|i|
		if(num%i==0)
			return false
		end
	}
	return true
end
p prime?(17)


########数组
list=[]
list=Array.new(5)
p list[5] #nil
list.each{|item|
	print item
}
#元素式字符串且不含空白时 可以使用%w建立数组
lang=%w(Ruby Perl Python)
p lang  #["Ruby", "Perl", "Python"]

#to_a 其他对象转成数组的方法
hash={"black"=>"#000000","white"=>"ffffff"}
p hash.to_a #[["black", "#000000"], ["white", "ffffff"]]

#split 
#索引
#a[n..m] 包含m 或a[n...m]  不包含m
#a[n,len] 从a[n]处 取len个元素
#改写多个元素
ary[2,3]=["C","D","E"]  
p ary
#!!插入元素  这又意思
alpha=["a","b","c","d"]
alpha[2,0]=["X","Y","Z"]
p alpha

#以多个索引建立新数组
new_ary=alpha.values_at(1,3,4)
p new_ary

#数组当集合  交集 并集
array=ary&alpha
print "ary",ary,"\nalpha",alpha,"\n",array,"\n"

array=ary|alpha #并集
p array
#差集
array=ary-alpha
#| 与+的差异
num=[1,2,3]
even=[2,4,6]
p num+even
p num|even

#数组实现队列和栈
#  		 对前段的操作  对末端的操作
#加入    unshift		push
#取出	 shift			pop
#读取    first			last
#堆栈可以使用 push和pop方法实现
#队列         push  shift
alpha=alpha-["X","Y","Z"]
#队列 first in first out
p alpha
alpha.push("e")  #队尾加入
p alpha.shift() #对头出去

#
a=[1,2,3,4,5]
a.unshift(0)
a.push(6)
p a

#a.concat(b)  concat 破坏性方法 ？  +则会返回新数组
a.concat([8,9])
p a
#pop和shift function，由于对方法的接收者对象的值进行这样或那样的变更 故而称之为破换性方法
#在使用破坏性方法时 存在下面的问题
name=["小林","林","彬","琳"]
a=[1,2,3,4]
b=a #b,a 都指向了同一个对象
p b.pop
p b.pop
p b.pop
p b
p a
a[1,5]=[2,3,4,5,6]
#a[1,5]=0
p a

#删除 a.compact  会建立新的数组 删除nil a.compact!会直接改写原来的数组
a[5,6]=nil
p a
p a.compact
a.compact! #删除nil
p a

#a.delete(x)  从数组a中删除元素x
a=[1,2,2,2,3]
#a.delete(2)
p a
#!!!a.delete_at(n)  从数组删除索引n  处的元素
a.delete_at(1)
p a
#a.delete_if{|item|....}
#a.reject{|item|....}
#a.reject!{|item|....}
#对数组a的每个元素item进行测试  则从中删除item  delete reject!是破坏性function
a.delete_if{|item|
	item>2
}
p a
a.reject{|item|
	item>1
	p item>1
}
p a

#a.slice!(n)  除去数组a指定的部分的内容 并换成指定的值
#a.slice!(n..m)
#a.slice!(n,len)
a=[1,2,3,4,5]
a.slice!(1,2)
p a

#a.uniq 删除数组a重复的元素
#a.uniq!  破坏性方法 
a=[1,2,3,2,3,4,5]
a.uniq!
p a

#a.shift 删除首位
#a.pop
a=[1,2,3,4,5]
a.shift  
p a #[2, 3, 4, 5]

a.pop
p a #[2, 3, 4]

#换掉数组的元素  !加上 破坏性方法 直接改写对象
=begin 
a.collect{|item|...}
a.collect!{|item|...}
a.map{|item|...}
a.map!{|item|...}
=end
a=[1,2,3,4]
b=a.collect{|item| item*2}
a.collect!{|item| item*2}
p a
p b

b=a.map{|item| item*2}
p b

#a.fill(value) 将元素改写为value
#a.fill(value,begin)
#a.fill(value,begin,len)
#a.fill(value,n..m)

#a.flatten 将嵌套数组展开
#a.flatten!
a=[1,[2,[3]],[4],5]
a.flatten!
p a

#a.reverse a.reverse!
#a.sort a.sort!  
# a.sort{|i,j|...} 区块指定排序
# a.sort!{|i,j|...}
#a.sort_by{|i|...} 以数组中的元素通过区块指定的方式进行排序  区块指定20.4.4 详细介绍
a=[2,4,3,5,1]
p a.sort_by{|i| -i}

#数组和迭代器  each{|item|  collect{|item|
list=["a","b","C","d"]
for i in 0...list.length#注意... 不包含后
   print "第",i+1,"个元素是",list[i],"\n"
end
list.each{|item|
	   print item,"\n"
}

list.each_with_index{|item,i|
  print "第",(i+1),"个元素是",item,"\n"
}
#使用破坏性方法反复操作
while item=a.pop
	#对item的处理
	#逐项取出元素 直到空为止
end
#需要使用迭代器时查下参考手册 看看Ruby是否已经提供了 避免自己努力实现的功能 Ruby已经实现了
#
a=[[1,2,3],[4,5,6],[7,8,9]]
#
a=Array.new(3){
	[0,0,0]
}
a[0][1]=2
p a
a=Array.new(5){|i|i+1}
p a


#并行处理多个ary  a.zip(a2,a3){|a,b,c|...}
ary1=[1,2,3,4,5]
ary2=[10,20,30,40,50]
ary3=[100,200,300,400,500]

i=0
res=[]
ary1.zip(ary2,ary3){|a,b,c|
	res << a+b+c
}
p res


#练习1
array=Array.new(100){|index|
	index+1
}
p array
#练习2
new_ary=array.collect{|item|
	item*100
}
p new_ary

#练习3
array.delete_if{|item|
	item%3!=0
}
p array

#练习4
p array.reverse
p array.sort
p array.sort_by{|i|
	-i
}
#练习5
sum=0
array.each{|item|
	sum+=item
}
p sum
p array.inject{|sum,n| sum+n}

#练习6
array.map!{|item|
	item+rand(100)
}
p array

#练习7
array=Array.new(100){|index| index+1}
p array
result=Array.new
j=0
while j<10
	10.times{|i|
		# i 0-9  [10-19] [20-29]
		result << array[i+10*j]
	}
	j+=1
end

p result


#练习8

def sum_array(nums1,nums2)
	c = []
	nums1.zip(nums2){|x,y|	
		c << x+y
	}
	return c
end
p sum_array([1,2,3],[4,6,8])


#练习9  检查数组中括号是否对称
def balanced?(arr)
	new_ary=[]	#栈
	while(arr.length>0)
		item_first=arr.shift
		#p item_first
		if((item_first == "(") |
		(item_first == "{")
		)
			new_ary.push(item_first)
		elsif(item_first==")" &&
		(new_ary.last=="("))#匹配
			new_ary.pop
		elsif(item_first=="}"&&
		(new_ary.last=="{"))
			new_ary.pop
		else
			#p new_ary
			return false
		end
	end
	if(new_ary.length==0)
		return true
	end
end
p balanced?(["(","{","{","}","}",")","(",")"])
p balanced?(["(","{","(","(","}",")","(",")"])

#删除不需自己前移了



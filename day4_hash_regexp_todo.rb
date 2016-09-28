#Hash
persons=Hash.new
persons["adele"]="阿黛雷"
print persons["adele"]

#创建Hash对象 {}  Hash.new
h1=Hash.new("") #默认值
h2=Hash.new #
p h1["not_key"] #""  默认初始值
p h2["not_key"] #nil

#You could write it as:
options = { font_size: 10, font_family: "Arial" }
#you can access in hash:
p options[:font_size]

options.store("R","Ruby")
p options.fetch("R")
p options.fetch("N","undef")  #如果键不存在 第二个参数作为默认返回值

#fetch 的实参也可以十区块 
p options.fetch("N") {
str=String.new
str="hello block"
} #""

#取出所有键和值
#                以数组的方式     迭代的方式
#  取出键       keys             each_key{|key|}
#  取出值		values           each_value{|value|}
#取出键值对      to_a             each{|key，val|}  each_key{|pair|}
h={"a"=>"A","b"=>"B"}
p h.keys
p h.values
p h.to_a

#指定用来产生默认值得区号
h=Hash.new{|hash,key|
	hash[key]=key.upcase
}

h["a"]="Abc"
p h["a"]
p h["x"]
p h["u"]

#查找hash中是否存在某个键值
#h.key?(key)
#h.has_key?(key)
#h.include?(key)
#h.member?(key)
p h.key?("a")

#删除键值
h={"R"=>"Ruby"}
h.delete("R")
p h["R"]  #nil

h={"R"=>"Ruby","P"=>"Perl"}
p h.delete_if{|key,val|
	key=="P"
}

#清空 clear
#初始化
h={"k1"=>"v1"}
g=h
h=Hash.new
p g  #g h 分别指向不同的对象


#Hash  嵌套
table={"A"=>{"a"=>"c","b"=>"d"}}
p table["A"]["a"]

#计算单字数量
=begin
count=Hash.new(0)

while line=gets
	words=line.force_encoding("utf-8").split
	words.each{|key,val|
		count[key]+=1
	}
end

#输出结果
count.sort{|a,b|  #使用了数组第一个元素
	a[1] <=> b[1] #按出现次数排序   <=> -1 0 1 三个返回值得一个
}.each{|key,val|
	print "#{key}:#{val}"
}
=end

# 正常 以String NUmeric Symbol Date 作为键
#自定义hash 键的对象  hash 和eql?方法需要重新定义
class Book
  attr_reader :author, :title

  def initialize(author, title)
    @author = author
    @title = title
  end

  def ==(other)
    self.class === other and
      other.author == @author and
      other.title == @title
  end

  alias eql? ==

  def hash
    @author.hash ^ @title.hash # XOR
  end
end

book1 = Book.new 'matz', 'Ruby in a Nutshell'
book2 = Book.new 'matz', 'Ruby in a Nutshell'

reviews = {}

reviews[book1] = 'Great reference!'
reviews[book2] = 'Nice and compact!'

reviews.length #=> 1




#练习1
wday={"monday"=>"星期一","Therday"=>"星期二"}
p wday["sunday"]
p wday["monday"]
p wday["saturday"]

#2
p wday.length

#3
wday.each{|key,val|
	
	print "#{key} is #{val}\n"
}

#4
def  str2hash(str)
	ary=str.split(/\s+/)
	hash={}
	0.step(ary.length-1,2){|i|
		hash.store(ary[i],ary[i+1])
		
	}
	return hash
end

print str2hash("blue 蓝 white 白\nred 红")


#实现类似java中的linkedhashmap的功能
#使存储有顺序性 TODO   能实现下面的功能
#oh=LinkedHashMap.new
oh={}
oh["one"]=1
oh["two"]=2
oh["three"]=3
oh["two"]=4
p oh.keys # ["one","two","three"]
p oh.values # [1,4,3]

##正则表达式
re=Regexp.new("ruby")
re=/"ruby"/
#正则表达式中用到'/'时使用 %r更好
#re=%r(样式)

#匹配 正则表达式=~字符串
if 1#正则表达式=~字符串
	#匹配成功的动作
else
	#匹配失败的动作
end

#文字匹配 正则表达式的英文字母与数字只会单纯匹配是否包含相同的文字
#						匹配成功的部分
#/ABC/ 		"ABCDEF"    "ABCDEF"
p /ABC/=~"ABCDEF"

#匹配行首与行尾   
#/^ABC$/     只匹配ABC这个字符串
#/^ABC/      以ABC开头
p /^ABC$/=~"ABCSFSFSFFABC"  #nil 匹配不成功  ？？


p /^ABC/=~ "012\nABC"  

#匹配想要匹配成功的文字范围
#/[A-Z_]/...所有英文文字大写和_
#/[^A-Z]/... [^xxx]除xxx之外的匹配


#.  匹配任意字符
/a.c/=~"acc"
#* 0个或多个
#使用反斜杠的样式
#\s 空白 定位 换行 换页 \d 0-9  
#\w 英文数字 
#字符串开头匹配字符 \A  \Z 
#\AABC  "ABC"
#\[ \^  特殊字符匹配


#*0-n次 		+ 1-n次 		?0-1次
#最短匹配 *?0-n   +?

#(xxx)* + ? 多字反复
#a|b   	多选
/^(ABC|DEF)&/=~"ABC"

#使用quote方法的正则表达式  忽略所有转义字符
re1=Regexp.new("abc*def")
re2=Regexp.new(Regexp.quote("abc*def"))

p (re1=~"abc*def")
p (re2=~"abc*def")

/needle/.match('haystack') #=> nil

#options 
Regexp.new("abc", Regexp::IGNORECASE | Regexp::MULTILINE) #=> /abc/mi


#!!最重要的作用回溯参照  知道哪个部分匹配到了
#匹配最重要的是获取信息 比如我之前做的匹配短信验证码功能
p /(.)(.)(.)/	=~ "abc"
first=$1
second=$2
three=$3
p first
p second
p three


/(.)(\d\d)+(.)/=~ "123456"

p $1  #1
p $2  #45
p $3  #6

#某段不需要回溯 可以加?:
/(.)(?:\d\d)+(.)/=~ "123456"
p $1  #1
p $2  #6

#使用正则表达式的方法
#sub 只取代第一个匹配成功处的正则表达式样式 gsub
str="abc  def  g  hi"#多个个空白

p str.sub(/\s+/,' ')
p str.gsub(/\s+/,' ')

str="abracatabra"
#
nstr=str.sub(/.a/){|matched|
	'<'+matched.upcase+'>'  #替换匹配的字符
}

p nstr

nstr=str.gsub(/.a/){|matched|
	'<'+matched.upcase+'>'  #替换匹配的字符
}

p nstr

#scan  和gsub类似  只获取
str.scan(/.a/){|matched|
p '<'+matched.upcase+'>'
}

str.scan(/(.)(a)/){|matched|
	p matched
}

#在区块里指定与()一样多时 则直接串每个变量

str.scan(/(.)(a)/){|a,b|
	p a+"-"+"b"
}

#案例 URL匹配
#/http:\/\//

#/http:\/\/([^/]*)\//

#%r|http://([^]*)/|

str="http://www.ruby-lang.org/ja/"
%r|http://([^/]*)/|=~ str
print "server address: ",$1,"\n" #server address: www.ruby-lang.org

#URI 的正则表达式样式  
#！！！正则表达式圣书 Master Regular Expressions
# %r|^(([^:/?#]:)?(//([^/?#]*))?([^?#]*)(\?([^#]*))?(#(.*))?|

#1 电子邮件地址的格式式  区域账号@域名 请建立一个正则 从中分离除账号和域名
str="ybinbin@outlook.com"
/(.+)@(.+)/=~str
p $1
p $2

#2  
str="面向对象很好玩!反正就是好玩,比数据与行为分离更加拥抱变化"  
str.gsub!(/好玩/,"非常好玩")
print str,"\n"
#3
def word_capitalize(str)
	res=""
	str.split(/-/).map{|item|
		res.concat(item.capitalize).concat("-")
	}
	res.slice!(res.length-1)
	return res
	
end
p word_capitalize("in-reply-to")
p word_capitalize("X-MAILER")
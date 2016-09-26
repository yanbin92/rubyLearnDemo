#字符串
#含有特殊字符时 用%q %Q 更方便
str1=%q{这也是字符串'' \ ""}
print str1

#here document  << 建立中间有换行的多行字符串时 这方法最简单
=begin
message <<-"结束标记" #EOB EOF 结束标记
	可内嵌的字符串
结束记号
=end
#   #{ruby表达式}当成语言执行

10.times{|i|
	10.times{|j|
		print <<-"EOB"
	i: #{i}
	j: #{j}
	i*j= #{i*j}      
		EOB
	}
}

#printf springf
n=123
printf "%d\n",n   #123
printf "%4d\n",n  # 123
printf "%04d\n",n #0123
printf "%+4d",n  #+123

n="abc"
#sprintf("%d", 123)  #=> "123" #输出字符串

p "just".size 
p "just".length 

p "".empty?
p "foo".empty?

p "mellow yellow".split("ello")   #=> ["m", "w y", "w"]
p "1,2,,3,4,,".split(/,/)         #=> ["1", "2", "", "3", "4"]


#字符串以特定字数分割
str="ruby bury ryby bbuuu 1234 3214"
column=str.unpack("a4a10a15a*")
p column

hello="hello,"
ruby=" ruby"
hello<<ruby  #concat << 比+ 效率高
p hello


str="abcde"
p str[0]
p str[0].chr

#删除换行字符 chop   (  chomp! 删除一个字符)
=begin
while line=gets
 line.chomp!
 #处理line
 end
=end

#查找字符串 str.index(x)  str.rindex()
p str.index("c")
p str.rindex("d")
p str.include?("d")
 
#取代  sub 取代最先找到的  gsub所有找到的
#sub(pattern,replacement)

#索引操作相关 
#s[n]=str
#s[n..m]=str
#s[n,len]=str

#删除的部分
p str.slice!(0)  #删除指定索引的
p str
#s.slice!(n,m)
#s.slice!(n,len)

#s.concat(s2)  s.delete(str)
s="abcabc"
p s.delete("b")

#s.strip  upcase downcase  capitalize
#swapcase 大小写互换
#capitalize 第一个字母大写 其余全小写
p s.swapcase()

p "abcabcde".tr("a-ce","A-D") #一一对应 可以用来加密

#转换繁体中文字码
=begin
require "iconv"
big5_str="中文Big5字符串"
utf_str=Iconv.conv("utf-8","big5",big5_str)
p utf_str
=end

#nkf 不依赖操作系统
require "nkf"
big5_str="中文Big5字符串"
utf_str=NKF.nkf("-E -w -x,0",big5_str)
print utf_str,"\n"

#iconv 库文件  没看懂


#练习 1
#a
str="Ruby is an object oriented programming langauge"
ary=str.split(/ /)
#0.step(str.length-1,1){|i|
#		ary << str[i]
#}
p ary
#b
ary.sort!
p ary
#c
ary.sort!{|x,y|
	x.downcase <=> y.downcase
}
p ary
#d 将每个单字开头都转换为大写
str="Ruby is an object oriented programming langauge"
ary=str.split(/ /)
ary.map!{|item|
	item.capitalize
} 
p  ary

#e 
hash={}
str.each_char{|item|
	if hash.include?(item)
		hash[item]+=1
	else
		hash[item]=1
	end
	#p item
}
p hash
hash.each{|k,v|
	print <<-"EOB"
	#{k}: #{'*'*v}
EOB
}
#练习2  zuo

def kan2num(str)#7bai7shi  77
	str.tr("零一二三四五六七八九十 十百千万亿","0123456789 ").delete!(" ")

end

p kan2num("七万三千一百二十三")

#练习3  
def num2astrisk(str_num)
	'*'*str_num.to_i(10)

end

p num2astrisk("12")

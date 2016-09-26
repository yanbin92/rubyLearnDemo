

print("hello ruby \n")

puts("100")

puts("hello","puts")

#字符串 * 重複字串
str="你好\t"
print str*2

=begin
	注释多行注释
=end

#单行注释
print("ni","hao","wa","单行注释")

if(false) then
	p "\ntrue"
else 
	puts("\n  判断false")
end

i=1
while i<50
	print(i,"\n")
	i=i*10
end

10.times{
 printf("i love ruby")
}

#定义function
def qucikSort(arr,left,right)
	print("\nhello ruby function")
	
end

qucikSort(1,2,3)

#引入标准库
require "date"

#容器  hash、数组、对象
name=["adele","alex"]

print "\n name1:",name[0]
p name

#foreach {|变量| }
name.each{|item|
	print item,"\n"
}

hash={"normal"=>"0","small"=>"-1"}

p hash["normal"]

hash.each{|key,value|
	print '<font size="',value,'">',key,'</font><br>',"\n"
}

=begin
words = ['foobar', 'baz', 'quux']
secret = words[rand(3)]


print "guess?"
while guess = STDIN.gets
  guess.chop!
  if guess == secret
    puts "You win!"
    break
  else
    puts "Sorry, you lose."
  end
  print "guess?"
end
puts "The word was " + secret + "."

=end

require "pp"
#arr +hash  
v=[{
"key_00"=>"value_0",
"key_01"=>"value_1"
},
{"key_1"=>"value"}
]

p v
pp v[1]

#就正規表示式而言，"=~" 是匹配的運算子 (operator)，
#如果發現符合的話，就會在字串中傳回位置，沒有符合就會傳回 nil
p /ruby/=~"ruby"

#控制台input
=begin
name=ARGV[0]
print "my name is:",name,"\n"

num0=ARGV[0].to_i
print "string to int :",ARGV[0]



=end
#file input
filename=ARGV[0]
file=open(filename)
#while text=file.gets do  #read 全部读入内存  gets 读入一行
		#print text
#	end
file.close


filename=ARGV[0]
pattern=Regexp.new(ARGV[1])
file=open(filename)
while text=file.gets do  #read 全部读入内存  gets 读入一行
	if pattern=~text
		print text,"\n"
	end
end
file.close










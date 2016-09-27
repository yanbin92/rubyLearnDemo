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
p options.fetch("N") {str=String.new
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
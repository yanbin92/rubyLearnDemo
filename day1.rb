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
	print [i,name]
}





























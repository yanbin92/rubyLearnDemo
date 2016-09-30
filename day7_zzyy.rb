#22日志文件解析
#23 查找邮政编码
t0=Time.now
#open("youbianwendang.htm").each{|line|
	#line.chomp!
	#line.split(",")
#}
p Time.now-t0
#gdbm建立数据库
require "gdbm"
mode=0644
flag=GDBM::NEWDB
#GDBM::NOLOCK||GDBM::READER 读锁
#GDBM.open("mydb.db",mode,flag){|db|
	#db[key]=data
#}
#将数据录入到数据库

require "csv"
module JZipCode
	COLUMN_ZIP=2 
	ZIP_FILE="ken_all.csv"
	DB_FILE="mydb.db"
	
	module_function
	
	def make_database(zipfile,dbfile)
		return if File.exist?(dbfile)
		open(zipfile){|io|
			GDBM.open(dbfile,0644,GDBM::NEWDB){|db|
				io.each{|line|#TODO 
					columns=line.split(",")
					#第二列式邮政编码
					zipcode=colums[COLUMN_ZIP].delete('"')
					if tmp=db[zipcode] #若已经有该记录时则用追加
						line=tmp+line
					end
					db[zipcode]=line
				}
			}
		}
	end
	
	#查找数据
	def find(code)
		make_database(ZIP_FILE,DB_FILE)
		GDBM.open(DB_FILE,nil,GDBM::READER|GDBM::NOLOCK){|db|
			if line=db[code]
				#解析csv文件
				return CSV.parse(line)
			end
		}
		return nil
	end
end

#test

t0=Time.now
code=ARGV[0]||"100000"
if rows=JZipCode.find(code)
	rows.each{|row|
		address=rows[6]+rows[7]
		#unless /^\210\310\211\272\202\311/=~rows[8]
		#	address <<rows[8]
		#end
	puts NKF.nkf("-u",address)
	#UNIX 下使用-u  utf-8
	#-e 
	#wins 下使用-s  shift_jis
	}
	
end
p 	Time.now-t0
#总结 主要介绍了GDBM的用法  GDBM功能有限  还是使用专业的数据库MySql等 模糊匹配就不支持

# 文档	Examples

#Opening/creating a database, and filling it with some entries:

require 'gdbm'

gdbm = GDBM.new("mydb.db")
gdbm["ananas"]    = "3"
gdbm["banana"]    = "8"
gdbm["cranberry"] = "4909"
gdbm.close

#Reading out a database:

gdbm = GDBM.new("mydb.db")
gdbm.each_pair do |key, value|
  print "#{key}: #{value}\n"
end
gdbm.close

#produces

#banana: 8
#ananas: 3
#cranberry: 4909


#24章解析Html

#字符引用转换
def unescape(str)
	return nil unless str
	ret=str.dup 
	#在Ruby中有两个方法来实现浅拷贝clone, dup，他们都是Object mix in Kernel得到的方法。
	#他们之间有个微小的差别，dup将不会对extended的modules进行拷贝。
	#"   &quot;   &#34;
	ret.gsub!(/&#(\d+);|&(\w+);/){|m|
		num,name=$1,$2
		if num then num.to_i.chr
		elsif name == "quot" then '"'
		elsif name == "amp" then '&'
		elsif name == "lt" then '<'
		elsif name == "gt" then '>'
		else m
		end
	}
	ret
end
io=open("index.html")
io.each{|line|
	p unescape(line.chomp)
}
io.close


#建立程序
#目标 读入Html 数据 提取所有标签和文字数据
#取出标签的元素名称和属性 
#不要取出注释中的标签
 #分离HTML 单独处理 比如针对标签 取出
 #！！！！*? 最短匹配  +?也是最短匹配
 #eg *?说明最短匹配
 "<!-- commment1 --> data<!-- commment1 --> "
# 使用 /<!--(.*)--\s*>/ 最大匹配 (.*)匹配到数据为commment1 --> data<!-- commment1 
# 使用 /<!--(.*?)--\s*>/ 最短匹配 (.*?)匹配到数据为commment1
#注释的解析  标签的解析

#24.2.2  标签的解析 
#标签<name ...>
tagRegexp=/<.*?>/
#问题在属性值得引号里也有可能出现>
/"[^"]*"/  #不包含双引号的字符串
/"[^']*"/	#不包含单引号的字符串
tagRegexp=/<(?:.*?|"[^"]*"|'[^']*')+>/
#这样写 虽然后面有匹配引号的部分  但是.*? 部分还是匹配到" 与' 这些引号 
 # 属性值里有> 的问题还是存在  所以要把这个部分该车功能不去匹配引号和>才对
 tarRegexp=/<(?:[^"'>]*"|"[^"]*"|'[^']*')+>/
 #这个正则表达式能够匹配到起始标签 结束标签与 <!DOCTYPE ..>这类标记申明
#

module HTML
	commentRegexp=/<!--.*?--\s*>/
	#[^...]	匹配不在方括号中的任意单字符。
	tagRegexp=/<(?:[^"'>]*"|"[^"]*"|'[^']*')+>/
	textDataRegexp=/[^<]*/
	MarkUpDeclRegexp=/^<!/
	HTMLRegexp=/(<!--.*?--\s*>)|
				(<(?:[^"'>]*"|"[^"]*"|'[^']*')+>)|
				([^<]*)/xm
				
	AttrRegexp=/(\w+)(?:=           #$1
				(?:"([^"]*)"|		#$2
				'([^']*)'|			#$3
				([^'"\s]*)))?/ 		#$4
				
	Starttagregexp=/^<(\w+)(.*)>/m
	
	Endtagregexp=/^<\/(\w+)>/		
	#x	忽略空格，允许在整个表达式中放入空白符和注释。
	#m	匹配多行，把换行字符识别为正常字符。
	#class Item :用来存放解析结果的类
	
	Item=Struct.new(:name,:attribute,:value,:source)
	class Comment < Item; end
	class MarkUpDecl < Item; end
	class StartTag < Item; end
	class EndTag < Item; end
	class TextData < Item; end
	
	
	def scan(data)
		data.scan(HTMLRegexp){|match|
			comment,tag,tdata=match[0..2]
			if comment
				#p ["Comment",comment]
				/^<!--(.*)--\s*>/om=~comment
				item=Comment.new(nil,nil,$1,comment)
			elsif tag
				#p ["Tag",tagregexp]
				case tag
				when MarkUpDeclRegexp
					item=MarkUpDecl.new(nil,nil,tag,tag)
					
				when Endtagregexp
					item=EndTag.new($1.upcase,nil,nil,tag)
					
				when Starttagregexp
					#从标签中取出元素名与属性
					#将元素名称转换为大写
					element_name,attrs=$1.upcase,$2
					#将属性名逐个存到hash中
					#将属性名称转换成小写 unescape
					attr=Hash.new
					attrs.scan(AttrRegexp){
						attr_name=$1
						value=$2||$3||$4  #URL-decode a string with encoding(optional).
						attr[attr_name.downcase]=unescape(value)
					}
					item=StartTag.new(element_name,attr,nil,tag)
				end
			elsif tdata
				tdata.gsub!(/\s+/," ")
				tdata.sub!(/ $/,"")
				item=TextData.new(nil,nil,unescape(tdata),tdata)
				#p ["textData",tdata] unless tdata.empty?
			end
			yield(item)
		}
	end
	module_function :scan, :unescape
	
	#字符引用转换
	def unescape(str)
		return nil unless str
		ret=str.dup 
		#在Ruby中有两个方法来实现浅拷贝clone, dup，他们都是Object mix in Kernel得到的方法。
		#他们之间有个微小的差别，dup将不会对extended的modules进行拷贝。
		#"   &quot;   &#34;
		ret.gsub!(/&#(\d+);|&(\w+);/){|m|
			num,name=$1,$2
			if num then num.to_i.chr
			elsif name == "quot" then '"'
			elsif name == "amp" then '&'
			elsif name == "lt" then '<'
			elsif name == "gt" then '>'
			else m
			end
		}
		ret
	end
		
end

io=open("index.html")
data=io.read
HTML.scan(data){|item|
#	case item
	#when HTML::Comment
	p item.name,item.attribute,item.value,item.source,"\n"
}

#标签的解析2  解析属性名称与属性值
#标签的种类 起始标签 结束标签 标记声明<!DOCTYPE html>
markUpDeclRegexp=/^<!/
#取出结束元素名
endtagregexp=/^<\/(\w+)>/
#起始标签 较复杂 分离两步 
#1从标签取得元素名与属性
#2从属性取得属性名和属性值
starttagregexp=/^<(\w+)(.*)>/
#2-1属性可能没有值 
	/(\w+)/ 	#没有值
	/(\w+)="([^"]*)"/ #双引号
	/(\w+)='([^']*)'/ #
	/(\w+)=([^'"\s])*/ #没有引号 名称=值
attrRegexp=/(\w+)(?:=           #$1
			(?:"([^"]*)"|		#$2
			'([^']*)'|			#$3
			([^'"\s]*)))?/xm		#$4
		
			
#加入之前的module中
#TODO 测试 加 解析超链接 
#总结 当你有啊 有这种功能就好了  或发现 这功能我好想会做的时候
#请务必挑战一下做做看看



#附录
#常见错误 和学习资料指南


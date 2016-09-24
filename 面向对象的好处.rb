#!!面向对象的好处
#！！！！面向对象之前的数据处理方式
#大赞 数据与处理程序的问题 
#!!!把数据与处理程序分开看待  pg 96页
#eg 检索程序
def search_info(book,name)
	for i in book.data	
		if i.name==name
			return i
		end
	end
end
#search_info(addr_book,"adele")
#存在问题 当数据结构改变时 无法进行简单调整
#book 的姓和名分开  此时需要修改 同理如果有新增与删除等操作也要进行修改
def search_info2(book,name)
	for i in book.data	
		if (i.firstname+i.secondname)
	end
end

class AddressBook
	attr_accessor :name
	attr_accessor :data
	...
end
class PersonalInfo
	attr_accessor :firstname
	attr_accessor :secondname
	....
end

#这样当数据结构改变需要加上新的处理程序
#这样很多相似的数据不断追加新的处理程序 #这会让程序变得很复杂
#实际开发中数据结构修改与追加是家常便饭 
#很多人思考如何更容易应对数据的变更 最后找到一个解决方法 就是面向对象

#面向对象 对象除了拥有数据以外还拥有行为
#！！！谁拥有数据谁就拥有操作数据的方法
class PersonalInfo2
	attr_accessor :firstname
	attr_accessor :secondname
	........
	#行为
	def name
		return @firstname+@secondname
	end
end
#通讯录
class AddressBook
	attr_accessor :name
	attr_accessor :data #PersonalInfo
	
	def search_info(name)
		for i in data	
			if i.name==name
				return i
			end
		end
	end
end
=begin 这样的好处 只有PersonalInfo能够回答name是什么
因此当通讯录(AddressBook)中无论存放那种个人信息(PersonalInfo)
相关处理部分(AddressBook.search_info)都不需要修改
#如果需要修改数据结构或行为时 修改起来很容易
#这very amazy
=end
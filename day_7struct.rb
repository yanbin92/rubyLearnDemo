#Struct 类
Customer = Struct.new(:name, :address) do
  def greeting
    "Hello #{name}!"
  end
end

dave = Customer.new("Dave", "123 Main")
dave.name     #=> "Dave"
dave.greeting #=> "Hello Dave!"
#在那些自身只有数据的类的生成场合中 使用Struct类非常方便
#Struct 类不会反悔实例

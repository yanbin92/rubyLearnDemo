#https://ruby-china.org/topics/22164
class Obj
  attr_accessor :first, :second
  def initialize
    @first = {:one => 'x',:two => 'y',:three => 'z'}
    @second = {[1,2]=>'x',[3,2]=>'o'}
  end
end

# 浅拷贝
obj1 = Obj.new
obj2 = obj1.clone

obj1.object_id != obj2.object_id 
# 拷贝对象和源对象都指向同样的依赖
obj1.first.object_id == obj2.first.object_id

# 深拷贝
obj3 = Marshal.load( Marshal.dump(obj1) )
# 依赖也被拷贝了
obj3.first.object_id != obj1.first.object_id
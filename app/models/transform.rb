class Transform 

def initialize
 @d = {}
end

def getd
 @d 
end

def method_missing(method_name,*args,&block)
 if method_name[-3..-1] == '_is'
    nd = {}
    nd[:name] = args[0]
    nd[:operands] = args[1]
    nd[:params] = args[2]
    @d[method_name[0..-4].to_sym] = nd
 else 
    raise NoMethodError    
 end
end

def spos
 rec @d[:main]
end

def rec(arg)
 flag = false
 result = "#{arg[:name]}("
 arg[:operands].each do |elem|
  result += "," if flag
  if elem.is_a?(Symbol)
     unless @d[elem].nil?
       result += rec(@d[elem])
     else
       result += elem.to_s
     end
  else
   result += elem.to_s
  end
  flag = true
 end
 result += ")"
end


end

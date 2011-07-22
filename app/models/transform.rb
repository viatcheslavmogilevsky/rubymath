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




end

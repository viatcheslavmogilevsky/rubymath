class Transform 

def initialize
 @d = {}
end
 
def td(*args)
  result = ['<apply>','<times />']
  args.each do |arg|
   if arg.is_a?(Symbol)
      result << arg
   else
      result << input_token(arg)
   end
  end
  result << '</apply>'

end

def plus(*args)
 result = ['<apply>','<plus />']
  args.each do |arg|
   if arg.is_a?(Symbol)
      result << arg
   else
      result << input_token(arg) 
   end
  end
  result << '</apply>'

end


def begin(arg)
  @root = arg 
end


def minus(*args)
 result = ['<apply>','<minus />']
  args.each do |arg|
   if arg.is_a?(Symbol)
      result << arg
   else
      result << input_token(arg)
   end
  end
  result << '</apply>'


end

def getd
 @d 
end

def input_token(arg)
 if arg.is_a?(String) 
  "<ci>"+arg+"</ci>"
 else 
  "<cn>#{arg.to_s}</cn>"
 end
end

def method_missing(method_name,*args,&block)
	if method_name[-3..-1] == '_is'
	 @d[method_name[0..-4].to_sym] = args[0]
        else raise NoMethodError
 end
end

def rec(args)
 args.each do |arg|
  if arg.is_a?(String)
     puts arg
  else
    if @d[arg].nil? 
       puts "<cs>#{arg.to_s}</cs>"
    else
       rec @d[arg]
    end
  end
 end
end

def complete
 rec @root 
end



end

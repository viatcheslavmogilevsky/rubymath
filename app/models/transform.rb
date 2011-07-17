class Transform 

def initialize
 @d = {}
end

=begin
def input(result,*args)
 args.each do |arg|
   if arg.is_a?(Symbol)
      result << arg
   else
      result << ' '+input_token(arg)
   end
 end
end
=end

def apply(operator, *args)
 result = ['<apply>']#, " <#{operator.to_s} />"]

 if operator.is_a?(String)
    result << " <#{operator} />"
 else
    result << operator
 end

 args.each do |arg|
   if arg.is_a?(Symbol)
      result << arg
   else
      result << ' '+input_token(arg)
   end
 end

  #input(result,args) 
  result << '</apply>'
end


def interval(str,*args)
 cl = []

 if str[0] == '('
    cl[0] = 'open'
 else 
    cl[0] = 'closed'
 end

 if str[1] == ')'
    cl[1] = 'open'
 else
    cl[1] = 'closed'
 end

 if cl[0] == cl[1] 
    cl[1] = ''
 else 
    cl[1] = '-'+cl[1]
 end

 result = ['<interval closure="'+cl[0]+cl[1]+'">']
 #input(result,args)
 args.each do |arg|
   if arg.is_a?(Symbol)
      result << arg
   else
      result << ' '+input_token(arg)
   end
 end
 
 result << '</interval>'
end


=begin
 
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
=end

def check_op(arg)
 if arg  
 end
end

def begin(arg)
  @root = arg 
end

=begin
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
=end

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

def rec(space_count,args)
 args.each do |arg|
  if arg.is_a?(String)
     puts " "*space_count+arg
  else
    if @d[arg].nil? 
      puts " "*space_count+" <cs>#{arg.to_s}</cs>"
    else
       rec space_count+2, @d[arg]
    end
  end
 end
end

def complete
 rec 1,@root 
end



end

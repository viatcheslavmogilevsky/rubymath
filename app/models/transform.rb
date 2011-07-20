class Transform 

def initialize
 @d = {}
 #@aliases = {:+ => :plus,
  #     :* => :times,
   #    :/ => :divide,
  #     :- => :minus,
  #     :"=" => :eq,
#       :<= => :leq,
 #      :>= => :geq,
  #     :"<>" => :neq,
   #    :"=!" => :neq,
#	:< => :lt,
#	:> => :gt,}
end



def input(arg)
 if arg.is_a?(Symbol)
    arg
 else 
    input_token(arg)
 end
end

=begin
def getoper(arg)
if @aliases[arg.to_sym].nil?
   " <#{arg}/>"
else
   " <#{@aliases[arg.to_sym]}/>"
end
  
end
=end

def apply(operator, *args)
 result = ['<apply>']
 result << operator
 args.each do |arg|
   result << input(arg)
 end

  result << '</apply>'
end

def plus(*args)
 apply('<plus/>',args) 
end

def factorial(arg)
 apply('<factorial/>',arg) 
end

def divide(arg1,arg2)
 apply('<divide/>',arg1,arg2)
end

def minus(arg1,arg2 = nil)
 arr = [arg1,arg2].compact
 apply('<minus/>',*arr)
end

def power(arg1,arg2) 
 apply('<power/>',arg1,arg2) 
end

def sqr(arg)
 apply('<power/>',arg,2)
end

def rem(arg1,arg2)
 apply('<rem/>',arg1,arg2)
end

def not(arg)
 apply('<not/>',arg)
end

def implies(arg1,arg2)
 apply('<implies/>',arg1,arg2)
end

def abs(arg)
 apply('<abs/>',arg)
end

def floor(arg)
 apply('<floor/>',arg)
end

def ceiling(arg)
 apply('<ceiling/>',arg)
end

def neq(arg1,arg2)
 apply('<neq/>',arg1,arg2)
end

def equivalent(arg1,arg2)
 apply('<equivalent/>',arg1,arg2)
end






def interval(arg1,arg2,closure={:lb => :closed, :ub => :closed})

# cl = []

# if str[0] == '('
#    cl[0] = 'open'
# else 
#    cl[0] = 'closed'
# end

# if str[1] == ')'
#    cl[1] = 'open'
# else
#    cl[1] = 'closed'
# end

# if cl[0] == cl[1] 
#    cl[1] = ''
# else 
#    cl[1] = '-'+cl[1]
# end


if closure[:lb] == closure[:ub]
   str = closure[:lb]
else
   str = closure.values.join('-') 
end

 result = ['<interval closure="'+str+'">']
 result << input(arg1)
 result << input(arg2) 
 result << '</interval>'
end







def begin(arg)
  @root = arg 
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

def generate(tag,args)
 h = args[0]
 unless h.empty? 
  h = ' '+h
 end
 result = ["<#{tag}#{h}>"]
 args[1..-1].each do |arg|
   result << input(arg)
 end

 result << "</#{tag}>"

end

def method_missing(method_name,*args,&block)
	if method_name[-3..-1] == '_is'
	 @d[method_name[0..-4].to_sym] = args[0]
        else 
         if method_name[-1] == '!'
          generate(method_name[0..-2],args)
         else
          raise NoMethodError 
         end       
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

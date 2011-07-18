class Transform 

def initialize
 @d = {}
 @w = {:+ => :plus,
       :plus => :plus,
       :* => :times,
       :times => :times,
       :/ => :divide,
       :divide => :divide,
       :- => :minus,
       :minus => :minus,
       :"=" => :eq
       :<= => :}
end



def input(arg)

 if arg.is_a?(Symbol)
    arg
 else 
    input_token(arg)
 end

# args.each do |arg|
 #  if arg.is_a?(Symbol)
  #    result << arg
   #else
      #result << ' '+input_token(arg)
  # end
 #end
end


def apply(operator, *args)
 result = ['<apply>']#, " <#{operator.to_s} />"]

 if operator.is_a?(String)
    result << " <#{@w[operator.to_sym]} />"
 else
    result << operator
 end

 args.each do |arg|
   result << input(arg)
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
   result << input(arg)
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

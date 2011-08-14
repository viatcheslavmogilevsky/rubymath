class Transform 

def initialize
 @d = {}

end

def getd
 @d 
end

def puzzle()
 
end

# relations:
#	:applex  < > = <= >= << >> =~  == != (7)
# simple operators: + -(6) % * /(5) ^(4) _(3) !(2)
# boolean operators: & | -> &! |! =! = ~
# all: ( ) (1)
# elem func: 
	#sin		cos	tan	sec	csc	cot
	#sinh		cosh	tanh	sech	csch	coth
	#arcsin		arccos	arctan	arcsec	arccsc  arccot  
	#arcsinh 	arccosh	arctanh	arcsech	arccsch	arccoth
	# exp
        # ln lg

        
# const PI EXP 


=begin
etape 1: + -(2)  * /  %(1) ^ (0)  @@@@@@@@@  _ ! @@@@@@@@@@@@  and 1234 
        
# ####       /\w+(\.\d+)?|[\/%*_!\^\(\)]|\+\-?|\-\+?|:\w+:/



	/\d+(?:\.\d+)?|[\/%*!\^\(\)=]|\+\-?|\-\+?|:\w+:|\w+/        



 
       5+4-56^2%5
	5 + 4 - 56^2 % 5
	is
 		<apply>
		<plus>
        	 <cn>5</cn>
		 <apply>
		  <minus>
     		  <cn>4</cn>
		  <apply>
		   <quotient>
		   <apply>
		    <power>
		    <cn>56</cn>
		    <cn>2</cn>
		   </apply>
		   <cn>5</cn>
		  </apply>
		 </apply>
		</apply>
 	 
=end



def getContentML

end



def parsing(arg)
 stack = []
 pr = [44,43]
 op = []
 nh = {}
 res = []
 arr = arg.scan(/\d+(?:\.\d+)?|[\/%*!\^\(\)=]|\+\-?|\-\+?|:\w+:|\w+/)
 arr << 42 # :-)
 arr.each do |elem|
	case elem
	  when /\d+/
	   stack << elem
	  when /\^/
	    op << elem
	    pr << 0
          when /[\/%*]/
	    op << elem
	    pr << 1
	  when /\+\-?|\-\+?/
 	    op << elem
	    pr <<  2
	  when 42
            op << elem
	    pr << 42 # xD
	end 
		
		while pr[-1] >= pr[-2]
		   nh[:name] = op[-2]
 		   nh[:operands] = stack[-2..-1]
		   res <<  nh
		   stack.pop
		   stack[-1] = res.size - 1
 	           nh = {}
		   pr.delete_at(-2)
		   op.delete_at(-2)
		end	  
	
        #puts "ARR #{arr.inspect}"
       # puts "STACK#{stack.inspect}"
       # puts "PR #{pr.inspect}"
#	 puts "OP #{op.inspect}"
 #       puts "E #{@e}"
  #      puts "---------------------"


 end
#  p res.inspect
  pr.clear
  stack.clear
  stack << res.last
  pr << res.size - 1
  until stack.empty?
    el = stack.shift
    eli = pr.shift
    if el[:name] =~ /\+|\*/
     el[:operands].each do |i|
      if i.is_a?(Fixnum)
      	if res[i][:name] == el[:name]
 		res[eli][:operands].concat(res[i][:operands])
		res.delete_at i
        end
      end
     end
    end
    el[:operands].each do |i|
     if i.is_a?(Fixnum)
        stack << res[i]
        pr << i
     end
    end 
	puts "STACK #{stack.inspect}"
	puts "PR #{pr.inspect}"
  end
  
  res

end

#private :parsing, :synonim



def method_missing(method_name,*args,&block)
 if method_name[-3..-1] == '_is'
    nd = {}
    nd[:name] = args[0] if args[0].nil?
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
 flag = ""
 result = "#{arg[:name]}("
 arg[:operands].each do |elem|
  result += flag
  if elem.is_a?(Symbol)
     unless @d[elem].nil?
       result += rec(@d[elem])
     else
       result += elem.to_s
     end
  else
   result += elem.to_s
  end
  flag = ", "
 end
 result += ")"
end


end

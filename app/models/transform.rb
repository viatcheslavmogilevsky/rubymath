class Transform 

def initialize
 @d = {}
 @e = []
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
 pr = [43]
 op = []
 nh = {}
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
	if pr.size > 1		
		while pr[-1] >= pr[-2]
		   nh[:name] = op[-2]
 		   nh[:operands] = stack[-2..-1]
		   @e <<  nh
		   stack.pop
		   stack[-1] = @e.size - 1
 	           nh = {}
		   #pr[-2] = pr[-1]
		   #pr.pop
	           #op[-2] = op[-1]
		   #op.pop
		   pr.delete_at(-2)
		   op.delete_at(-2)
		end	  
	end
        #puts "ARR #{arr.inspect}"
        puts "STACK#{stack.inspect}"
        puts "PR #{pr.inspect}"
	puts "OP #{op.inspect}"
        puts "E #{@e}"
        puts "---------------------"


 end





end

#private :parsing, :synonim



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

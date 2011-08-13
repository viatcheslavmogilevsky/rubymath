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
 pr = []
 arr = arg.scan(/\d+(?:\.\d+)?|[\/%*!\^\(\)=]|\+\-?|\-\+?|:\w+:|\w+/)
 arr.each do |elem|
	case elem
	  when /\d+/
	   stack << elem
	  when /\^/
	    pr << [elem,0]
          when /[\/%*]/
	    pr << [elem,1]
	  when /\+\-?|\-\+?/
 	    pr << [elem,3]
	end
	if pr.size > 1
		
		if pr[-1][1] 

		end	  

        end

 end
end

private :parsing



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

class Transform 

def initialize
 @d = {}
end

def getd
 @d 
end

=begin
def puzzle()
 
end

# relations:
#	:applex  < > = <= >= =~  != (7)
# simple operators: + -(6) div mod * /(5) ^(4)  !(2)
		#	div- *- /- ^-
# boolean operators: and or xor ->  = ~ not 
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

 	 
=end



#def argscan(arg)
# arg.scan(/\d+(?:\.\d+)?|[\/%*!\^\(\)=\+\-]|:\w+:|\w+/)
#end

=begin
def getContentML

end

=begin
def open_closed(i,arr)
 balance = 1
 i+=1
 while i < arr.size 
	if arr[i] == "("
		balance += 1
        else
		if arr[i] == ")"
 		 balance -= 1
		end
	end
	break if balance == 0
	i+=1
 end
 i 
end


def parsing(arg)
 arr = arg.scan(/\d+(?:\.\d+)?|[\/%*!\^\(\)=\+\-]|:\w+:|\w+/)
 parsing1 arr
end
=end

def fatd

 
end

def parsing(arg)

 stack = []
 pr = [44,43]
 op = []
 nh = {}
 res = []
 b = 0
 f = true
 arr = arg.scan(/\d+(?:\.\d+)?|[<>]=|[\/*!\^\+\-<>\(\)]|=[!~]?|:\w+:|\[\w+\]|div|mod/)
 arr << 42 # :-)

 arr.each do |elem|

 	case elem

		when /\d+(?:\.\d+)?|:\w+:|\[\w+\]/
	   		stack << elem
	   		f = false
		when /\^/
	    		op << elem
	    		pr << 1+b
   	    		f = false	
        	when /[\/*]|div|mod/
	    		op << elem
	    		pr << 2+b
	    		f = false
		when /\+/
 	    		op << elem
	    		pr <<  3+b
	    		f = false
		when /\-/
	    		if f
	    		op << elem + "-"
	    		pr << 2+b
            		else
   	    		op << elem
	    		pr << 3+b
	    		end
	    		f = false
        	when /[<>]=|=~?|[<>]/
	    		op << elem
	    		pr << 4+b	 
	    		f = true   
		when 42
            		op << elem
	    		pr << 42 # xD
		when /!/
	    		op << elem
	    		pr << 0+b
	    		f = false
		when /\(/
	    		b -= 10
	    		f = true
		when /\)/
	    		b += 10
	    		f = false

 	end 	
	
 	while pr[-1] >= pr[-2]

		nh[:name] = op[-2]	
   		unless op[-2] == '--' or op[-2] == '!'
		nh[:operands] = stack[-2..-1]
		stack.pop
		else
		nh[:operands] = [stack[-1]]
		end
		res <<  nh
		nh = {}
        	stack[-1] =  res.size - 1
		pr.delete_at(-2)
		op.delete_at(-2)

 	end	  
	        
 end

  pr.clear
  pr << res.size - 1

  until pr.empty?

    eli = pr.shift

    if res[eli][:name] =~ /(\+|\*|=|[<>]=?)$/

     		res[eli][:operands].each_with_index do |i,index|

      		  if i.is_a?(Fixnum)
      	          if res[i][:name] == res[eli][:name]
		      res[eli][:operands].insert index+1,res[i][:operands]
		      res[eli][:operands].flatten!
		      res[i][:name] = nil
  	    	      res[i][:operands] = []
                  end
                  end

                end

    end

    res[eli][:operands].each do |i|
     if i.is_a?(Fixnum)
        pr << i
     end
    end 
	
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

 else raise NoMethodError    
 end
end

=begin
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
=end

end

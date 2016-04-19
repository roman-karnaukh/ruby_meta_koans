   def attribute(atr, &block)
     atr, value = atr.first if atr.is_a? Hash

     define_method "#{atr}" do
       unless instance_variable_defined? :"@#{atr}"
        send "#{atr}=", block_given? ? instance_eval(&block) : value
       end
       instance_variable_get(:"@#{atr}")
     end

     define_method("#{atr}=") {|v| instance_variable_set("@#{atr}", v)}
     define_method("#{atr}?") { !send(atr).nil? }
   end

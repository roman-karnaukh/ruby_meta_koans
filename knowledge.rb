
   def attribute(name, &block)

     name, value = name.first if name.is_a? Hash

     define_method "#{name}" do
       unless instance_variable_defined?(:"@#{name}")
         if value
           instance_variable_set(:"@#{name}", value)
         elsif block
           instance_variable_set(:"@#{name}", instance_eval(&block))
         end
       end

       instance_variable_get(:"@#{name}")
     end

     define_method "#{name}=" do
       instance_variable_set("@#{name}".to_sym, value)
     end

     define_method "#{name}?" do
       return false if instance_variable_get(:"@#{name}").nil?
       instance_variable_defined?(:"@#{name}")
     end
   end


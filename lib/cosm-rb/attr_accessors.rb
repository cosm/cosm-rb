module Cosm
  module AttrAccessors
    def stripped_attr_accessor(*args)
      args.each do |arg|
        # getter
        self.class_eval("def #{arg}; return @#{arg}; end")

        # setter
        self.class_eval("def #{arg}=(value); @#{arg} = case value; when NilClass: nil; when String: value.strip; else; @#{arg} = value; end; end")
      end
    end
  end
end

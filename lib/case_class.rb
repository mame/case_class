require "delegate"

module CaseClass
  class PlaceHolder < SimpleDelegator
    def initialize
      class << self
        def ==(obj)
          obj = obj.__getobj__ while PlaceHolder === obj
          class << self
            remove_method(:==)
            remove_method(:===)
            remove_method(:inspect)
          end
          __setobj__(obj)
          true
        end

        alias === ==

        def inspect
          "_promise_"
        end
      end

      super(nil)
    end
  end

  class Case < Struct
    def ===(obj)
      obj = obj.__getobj__ while PlaceHolder === obj
      super
    end

    def self.[](*ary)
      if ary.size >= 1
        new(*ary)
      else
        new(:dummy)[nil]
      end
    end
  end

  def _
    PlaceHolder.new
  end
end

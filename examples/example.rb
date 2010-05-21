require "case_class"
include CaseClass

# create placeholder (a.k.a. promise or future)
x = _
a = [1, x, 2, x, 3, x]

p a  #=> [1, _promise_, 2, _promise_, 3, _promise_]

# fulfill promise by 42 (not assign)
x === 42

p a  #=> [1, 42, 2, 42, 3, 42]

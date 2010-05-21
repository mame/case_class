require "case_class"
include CaseClass

# data Expr = Number Int | Sum Expr Expr

Number = Case[:n]
Sum    = Case[:e1, :e2]

# evaluation with pattern matching
def eval(n)
  case n
  when Sum[e1 = _, e2 = _] then eval(e1) + eval(e2)
  when Number[n = _] then n
  end
end

# (1 + 2) + (3 + 4)
expr = Sum[Sum[Number[1], Number[2]], Sum[Number[3], Number[4]]]
p eval(expr)  #=> 10

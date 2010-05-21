require "case_class"
include CaseClass

# translated from http://www.cs.kent.ac.uk/people/staff/smk/redblack/
module RedBlackTree
  # data RB a = E | T Color (RB a) a (RB a)
  E = Case[]
  T = Case[:c, :l, :v, :r]

  def insert(x, t)
    T[_,a=_,z=_,b=_] === insert0(x, t)
    T[:B,a,z,b]
  end

  def insert0(x, t)
    case t
    when E; T[:R,E,x,E]
    when T[:B,a=_,y=_,b=_]
      case
      when x<y; balance(insert0(x, a), y, b)
      when x>y; balance(a, y, insert0(x, b))
      else t
      end
    when T[:R,a=_,y=_,b=_]
      case
      when x<y; T[:R, insert0(x, a), y, b]
      when x>y; T[:R, a, y, insert0(x, b)]
      else t
      end
    end
  end

  def member(x, t)
    case t
    when T[_, a=_, y=_, b=_]
      case
      when x<y; member(x, a)
      when x>y; member(x, b)
      else true
      end
    else
      false
    end
  end

  def balance(l, v, r)
    case [l, v, r]
    when [T[:R,T[:R,a=_,x=_,b=_],y=_,c=_],z=_,d=_]; T[:R,T[:B,a,x,b],y,T[:B,c,z,d]]
    when [T[:R,a=_,x=_,T[:R,b=_,y=_,c=_]],z=_,d=_]; T[:R,T[:B,a,x,b],y,T[:B,c,z,d]]
    when [T[:R,a=_,x=_,b=_],y=_,T[:R,c=_,z=_,d=_]]; T[:R,T[:B,a,x,b],y,T[:B,c,z,d]]
    when [a=_,x=_,T[:R,T[:R,b=_,y=_,c=_],z=_,d=_]]; T[:R,T[:B,a,x,b],y,T[:B,c,z,d]]
    when [a=_,x=_,T[:R,b=_,y=_,T[:R,c=_,z=_,d=_]]]; T[:R,T[:B,a,x,b],y,T[:B,c,z,d]]
    when [a=_,x=_,b=_]; T[:B,a,x,b]
    end
  end

#  # balance with no pattern matching
#  def balance(l, v, r)
#    case
#    when T===l && l.c===:R && T===l.l && l.l.c===:R
#      T[:R,T[:B,l.l.l,l.l.v,l.l.r],l.v,T[:B,l.r,v,r]]
#    when T===l && l.c===:R && T===l.r && l.r.c===:R
#      T[:R,T[:B,l.l,l.v,l.r.l],l.r.v,T[:B,l.r.r,v,r]]
#    when T===l && l.c===:R && T===r   && r  .c===:R
#      T[:R,T[:B,l.l,l.v,l.r],v,T[:B,r.l,r.v,r.r]]
#    when T===r && r.c===:R && T===r.l && r.l.c===:R
#      T[:R,T[:B,l,v,r.l.l],r.l.v,T[:B,r.l.r,r.v,r.r]]
#    when T===r && r.c===:R && T===r.r && r.r.c===:R
#      T[:R,T[:B,l,v,r.l],r.v,T[:B,r.r.l,r.r.v,r.r.r]]
#    else T[:B,l,v,r]
#    end
#  end
end

include RedBlackTree

tree = E
(1..10).to_a.shuffle.each do |x|
  tree = insert(x, tree)
end

p member( 5, tree) #=> true
p member(11, tree) #=> false
p member( 0, tree) #=> false
p tree

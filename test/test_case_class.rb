require "helper"

class TestCaseClass < Test::Unit::TestCase
  def test_placeholder
    x = CaseClass::PlaceHolder.new
    assert_equal("_promise_", x.inspect)
    assert_equal(true, x === 42)
    assert_equal("42", x.inspect)
  end

  Foo = CaseClass::Case[:x, :y, :z]
  def test_case
    foo = Foo[1, 2, 3]
    x = CaseClass::PlaceHolder.new
    y = CaseClass::PlaceHolder.new
    z = CaseClass::PlaceHolder.new
    Foo[x, y, z] === Foo[1, 2, 3]
    assert_equal(1, x)
    assert_equal(2, y)
    assert_equal(3, z)
  end
end

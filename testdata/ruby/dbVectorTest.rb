
$:.push(File::dirname($0))

load("test_prologue.rb")

class DBVector_TestClass < TestBase

  # DVector basics
  def test_1_DVector

    a = RBA::DVector::new( 1, -17 )
    b = RBA::DVector::new
    c = RBA::DVector::new( RBA::Vector::new( 5, 11 ) )

    assert_equal( a.to_s, "1,-17" )
    assert_equal( RBA::DVector::from_s(a.to_s).to_s, a.to_s )
    assert_equal( (-a).to_s, "-1,17" )
    assert_equal( b.to_s, "0,0" )
    assert_equal( c.to_s, "5,11" )

    assert_equal( (a + c).to_s, "6,-6" )
    assert_equal( (a * 0.5).to_s, "0.5,-8.5" )
    assert_equal( (a - c).to_s, "-4,-28" )
    assert_equal( a == c, false )
    assert_equal( a == a, true )
    assert_equal( a != c, true )
    assert_equal( a != a, false )

    assert_equal( a.x.to_s, "1.0" )
    assert_equal( a.y.to_s, "-17.0" )

    assert_equal( (a.length - Math::sqrt(17 * 17 + 1 * 1)).abs < 1e-12, true )

    b.x = a.x
    b.y = a.y
    assert_equal( a, b )

  end

  # Transforming DVector
  def test_2_DVector

    a = RBA::DVector::new( 1, -17 )
    b = RBA::DVector::new

    t = RBA::DTrans::new( RBA::DTrans::R90, RBA::DVector::new( 5, -2 )) 
    assert_equal( t.trans(a).to_s, "17,1" )

    m = RBA::DCplxTrans::new( RBA::DTrans::new( RBA::DTrans::R90, RBA::DVector::new( 5, -2 )), 0.5 ) 
    assert_equal( m.trans(a).to_s, "8.5,0.5" )

  end

  # Vector basics
  def test_1_Vector

    a = RBA::Vector::new( 1, -17 )
    b = RBA::Vector::new
    c = RBA::Vector::new( RBA::DVector::new( 5, 11 ) )

    assert_equal( a.to_s, "1,-17" )
    assert_equal( RBA::Vector::from_s(a.to_s).to_s, a.to_s )
    assert_equal( (-a).to_s, "-1,17" )
    assert_equal( b.to_s, "0,0" )
    assert_equal( c.to_s, "5,11" )

    assert_equal( (a + c).to_s, "6,-6" )
    assert_equal( (a * 0.5).to_s, "1,-9" )
    assert_equal( (a - c).to_s, "-4,-28" )
    assert_equal( a == c, false )
    assert_equal( a == a, true )
    assert_equal( a != c, true )
    assert_equal( a != a, false )

    assert_equal( a.x.to_s, "1" )
    assert_equal( a.y.to_s, "-17" )

    assert_equal( (a.length - Math::sqrt(17 * 17 + 1 * 1)).abs < 1e-12, true )

    b.x = a.x
    b.y = a.y
    assert_equal( a, b )

  end

  # Transforming Vector
  def test_2_Vector

    a = RBA::Vector::new( 1, -17 )
    b = RBA::Vector::new

    t = RBA::Trans::new( RBA::Trans::R90, RBA::Vector::new( 5, -2 )) 
    assert_equal( t.trans(a).to_s, "17,1" )

    m = RBA::CplxTrans::new( RBA::Trans::new( RBA::Trans::R90, RBA::Vector::new( 5, -2 )), 0.5 ) 
    assert_equal( m.trans(a).to_s, "8.5,0.5" )

  end

  # Fuzzy compare
  def test_3_Vector

    p1 = RBA::DVector::new(1, 2)
    p2 = RBA::DVector::new(1 + 1e-7, 2)
    p3 = RBA::DVector::new(1 + 1e-4, 2)
    assert_equal(p1.to_s, "1,2")
    assert_equal(p2.to_s, "1.0000001,2")
    assert_equal(p3.to_s, "1.0001,2")

    assert_equal(p1 == p2, true)
    assert_equal(p1.eql?(p2), true)
    assert_equal(p1 != p2, false)
    assert_equal(p1 < p2, false)
    assert_equal(p2 < p1, false)
    assert_equal(p1 == p3, false)
    assert_equal(p1.eql?(p3), false)
    assert_equal(p1 != p3, true)
    assert_equal(p1 < p3, true)
    assert_equal(p3 < p1, false)

  end

  # Hash values 
  def test_4_Vector

    p1 = RBA::DVector::new(1, 2)
    p2 = RBA::DVector::new(1 + 1e-7, 2)
    p3 = RBA::DVector::new(1 + 1e-4, 2)

    assert_equal(p1.hash == p2.hash, true)
    assert_equal(p1.hash == p3.hash, false)

    h = { p1 => "a", p3 => "b" }
    assert_equal(h[p1], "a")
    assert_equal(h[p2], "a")
    assert_equal(h[p3], "b")

  end

end

load("test_epilogue.rb")


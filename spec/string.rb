require_relative 'preparation'

describe 'A String' do
  it 'can be interpreted as and converted to a boolean' do
    "true".to_b.should.be.true
    "True".to_b.should.be.true
    "TRUE".to_b.should.be.true
    "tRue".to_b.should.be.true
    "t".to_b.should.be.true
    "T".to_b.should.be.true
    "1".to_b.should.be.true
    "yes".to_b.should.be.true
    "Yes".to_b.should.be.true
    "YES".to_b.should.be.true
    "yEs".to_b.should.be.true
    "y".to_b.should.be.true
    "Y".to_b.should.be.true
    "on".to_b.should.be.true
    "On".to_b.should.be.true
    "ON".to_b.should.be.true
    "oN".to_b.should.be.true
    "+".to_b.should.be.true

    "false".to_b.should.be.false
    "False".to_b.should.be.false
    "FALSE".to_b.should.be.false
    "fALse".to_b.should.be.false
    "f".to_b.should.be.false
    "F".to_b.should.be.false
    "n".to_b.should.be.false
    "N".to_b.should.be.false
    "x".to_b.should.be.false
    "X".to_b.should.be.false
    "0".to_b.should.be.false
    "2".to_b.should.be.false
    "no".to_b.should.be.false
    "No".to_b.should.be.false
    "NO".to_b.should.be.false
    "nO".to_b.should.be.false
    "off".to_b.should.be.false
    "Off".to_b.should.be.false
    "OFF".to_b.should.be.false
    "oFf".to_b.should.be.false
    "-".to_b.should.be.false
    "*".to_b.should.be.false
    "foobar".to_b.should.be.false
  end

  it 'can expand its tabs' do
    s = "              "
    s.expand_tabs( 8 ).should.equal s
    s = "\t"
    s.expand_tabs( 8 ).should.equal " " * 8
    s = "\t\t"
    s.expand_tabs( 8 ).should.equal " " * 8*2
    s = "\t  \t"
    s.expand_tabs( 8 ).should.equal " " * 8*2
    s = "\t  \t  "
    s.expand_tabs( 8 ).should.equal " " * (8*2 + 2)
    s = "\t        \t"
    s.expand_tabs( 8 ).should.equal " " * 8*3
    s = "\t         \t"
    s.expand_tabs( 8 ).should.equal " " * 8*3
  end

  it 'knows the index of a first matching regexp group' do
    s = "abc def ghi"
    s.group_index( /abc/ ).should.equal [ 0, "abc" ]
    s.group_index( /def/ ).should.equal [ 4, "def" ]
    s.group_index( /a(b)c/ ).should.equal [ 1, "b" ]
    s.group_index( /a(b)c d(e)f/ ).should.equal [ 1, "b" ]
    s.group_index( /q/ ).should.equal [ nil, nil ]
    s.group_index( /abc(q?)/ ).should.equal [ 3, '' ]
  end
end
def parseAttendant(line)
  name, expects = line.split(':', 2)
  [name, expects.split(',')]
end

def simple_match(mens, ladies)
  free = mens.keys + ladies.keys
  weight(mens, ladies).sort_by { |couple, priority| priority }.select do |(m, l), _|
    if free.include?(m) && free.include?(l)
      free = free - [m, l]
      true
    end
  end
end

def weight(mens, ladies)
  mens.each_with_object({}) do |(m, exp), matrix|
    exp.each_with_index do |l, i|
      expected = ladies.fetch(l,[]).index(m)
      matrix[[m, l]] = [i, expected].max unless expected.nil?
    end
  end
end

ATTENDANTS = <<__ATT__
A:c,a,b
B:c,f,a
C:f,c,b
D:d,d,d
E:
F:e,c,a
a:A,D,F
b:C,B,A
c:D,A,C
d:A,A,B
e:C,A,E
f:D,B,A
__ATT__

mens, ladies = ATTENDANTS.each_line.map { |line| parseAttendant(line.chop) }.partition { |n, _| ('A'..'Z') === n[0] }.map { |attendants| Hash[attendants] }
p simple_match(mens, ladies)


def parseAttendant(line)
  name, expects = line.split(':', 2)
  [name, expects.split(',')]
end

def match(mens, ladies)
  matched = []
  mens.
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
p mens, ladies

def parse_attendant(line)
  name, expects = line.split(':', 2)
  [name, expects.split(',')]
end

def simple_match(weighted)
  free = weighted.keys.flatten.uniq
  weighted.sort_by(&:last).map(&:first).select do |m, l|
    free = free - [m, l] if free.include?(m) && free.include?(l)
  end
end

def weight(men, ladies)
  men.each_with_object({}) do |(m, exp), matrix|
    exp.each_with_index do |l, i|
      expected = ladies.fetch(l,[]).index(m)
      matrix[[m, l]] = [i, expected].max unless expected.nil?
    end
  end
end

def show_couples(couples)
  puts couples.map { |couple| couple.join('-') }.join("\n")
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

men, ladies = ATTENDANTS.each_line.map { |line| parse_attendant(line.chop) }.partition { |n, _| ('A'..'Z') === n[0] }.map { |attendants| Hash[attendants] }
puts simple_match(weight(men, ladies)).map { |couple| couple.join('-') }.join("\n")

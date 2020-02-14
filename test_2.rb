require 'oekaki'

Width, Height = 400, 300
CircumcircleR = 0.8

def incircle(a, b, c)
  l, m, n = (b - a).norm, (c - b).norm, (a - c).norm
  q = l + m + n

  po = a * (m / q) + b * (n / q) + c * (l / q)
  r  = sqrt((q / 2 - l) * (q / 2 - m) * (q / 2 - n) * 2 / q)
  [po, r]
end

class Vector
  def to_w
    l = Height / 2
    Vector[Width / 2 + self[0] * l, l - self[1] * l]
  end
end

get_po = proc {|θ| Vector[cos(θ), sin(θ)] * CircumcircleR}
rv  = proc {PI * (rand + 1) * 0.005}

angle = [0.5 * 2 * PI, 1.17 * 2 * PI, 1.83 * 2 * PI]
step  = [rv.call, rv.call, -rv.call]


Oekaki.app width: Width, height: Height do
  draw {clear}

  timer(30) do
    clear

    a, b, c = get_po[angle[0]], get_po[angle[1]], get_po[angle[2]]

    color(0, 65535, 0)
    line(a.to_w[0], a.to_w[1], b.to_w[0], b.to_w[1])
    line(b.to_w[0], b.to_w[1], c.to_w[0], c.to_w[1])
    line(c.to_w[0], c.to_w[1], a.to_w[0], a.to_w[1])

    color(65535, 0, 65535)
    circle(false, Width / 2, Height / 2, CircumcircleR * Height / 2)

    color(65535, 65535, 0)
    po, r = incircle(a, b, c)
    circle(true, po.to_w[0], po.to_w[1], r * Height / 2)

    angle = angle.map.with_index {|θ, i| θ + step[i]}
  end
end

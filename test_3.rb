require 'oekaki'

Oekaki.app title: :clock do
  Oekaki::W.move(100, 100)
  palegreen = color(0x98 * 256, 0xfb * 256, 0x98 * 256)
  draw {clear(palegreen)}

  hand = proc do |r, θ, f = true|
    θ1 = PI * θ / 180
    a = Vector[sin(θ1), cos(θ1)]
    if f
      a1 = Vector[cos(θ1), -sin(θ1)]
      v1 = -a * 6 + a1 * 3
      v2 = -a * 6 - a1 * 3
      ar = []
      ar << [150 + r * a[0], 150 - r * a[1]]
      ar << [150 + v1[0], 150 - v1[1]]
      ar << [150 + v2[0], 150 - v2[1]]
      polygon(true, ar)
    else
      line(150, 150, 150 + r * a[0], 150 - r * a[1])
    end
  end

  timer(1000) do
    clear(palegreen)

    l, r = 120, 0.8
    color(0x98ff * r, 0xfbff * r, 0x98ff * r)
    rectangle(true, 150 - l / 2, 190, l, 20)

    d = Date.today
    color(0xffff, 0xffff, 0xffff)
    week = %w(日 月 火 水 木 金 土)
    text("%02d %02d %s" % [d.month, d.day, week[d.wday]], 150 - 46, 188, 13 * 1000)

    12.times do |i|
      color(0xcd * 256, 0x85 * 256, 0x3f * 256)   #peru
      θ = PI * i * 30 / 180
      circle(true, 150 + 130 * cos(θ), 150 - 130 * sin(θ), 4)
    end

    t = Time.now
    color(65535, 0, 0)
    hand.call(100, t.sec * 6, false)

    color(0, 0, 0)
    hand.call(110, t.min * 6)
    hand.call(90, (t.hour % 12 * 60 + t.min) * 0.5)
  end
end

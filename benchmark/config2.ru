require 'rubygems'
require 'rack'

def fibonacci(n)
  a,b = 0,1
  n.times do
    a,b = b,a+b
  end
end

run Proc.new { |env|
  [200, {'Content-Type' => "text/plain"}, [fibonacci(10000).to_s]]
}

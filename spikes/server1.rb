require 'socket'
require 'rubygems'
require 'http/parser'
require 'date'

server = TCPServer.new('0.0.0.0', 3000)

while (session = server.accept)
  file = nil
  parser = Http::Parser.new
  parser << session.gets
  puts "log: #{parser.http_method} #{parser.request_url}"

  is_image = parser.request_url =~ /jpg$|png$|jpeg$|gif$/
  read_method = is_image ? "rb" : "r"

  if parser.request_url == "/"
    file = File.new("index.html", "r")
  else
    begin
      file = File.new(parser.request_url.gsub(/\//, ''), read_method)
    rescue Exception => e
      file = nil
      puts e.message
    end
  end

  response = []
  if file
    response << 'HTTP/1.1 200 OK'
    response << "\n"
    response << DateTime.now
    response << "\n"
    if is_image
      response << "Content-Type: image/#{parser.request_url.split('.').last.gsub(/jpg/, "jpeg")}"
    elsif parser.request_url =~ /.css$/
      response << 'Content-Type: text/css'
    else
      response << 'Content-Type: text/html'
    end
    response << "\n"
    response << "Content-Length: #{file.size}" 
    response << "\n"
    response << "\n"

    response << file.readlines

    file.close
  else
    response << 'http/1.1 300 ERROR'
  end

  session.puts response.join
  session.close
end

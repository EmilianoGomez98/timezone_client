require 'angus-remote'

def make_request(remote_service, location)
  case location.length
  when 2
    res = remote_service.show([location[0], location[1]])
    p res.status == 'success' ? res.elements['time'] : res.messages.first.description
  else
    p 'Error, wrong number of parameters'
  end
end

remote_service = Angus::Remote::ServiceDirectory.lookup('timezone', '0.1')
loop do
  puts 'Enter the timezone or exit:'
  input = gets.chomp
  break if input == 'exit'
  location = input.split('/').map{ |x| x.gsub(/\s+/, "") }
  location.delete_if { |a| a == '' }
  make_request(remote_service, location)
end
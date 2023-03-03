if ARGV.length < 2
  puts "Insufficient parameters\n First paramet: Size\n Second paramet: Name of the file\n"
  return
end
size = ARGV.first.to_i
file = File.new("spec/fixture/csv/building/#{ARGV[1]}.csv", 'w')
file.puts 'reference,address,zip_code,city,country,manager_name'
(1..size).each do |i|
  file.puts "#{i},adresse#{i},zip#{i},city#{i},country#{i},manager#{i}"
end
file.close
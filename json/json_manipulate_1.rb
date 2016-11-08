require 'json'

options = JSON.parse(IO.read('data/demo.json'))
options['demo']['kailash'] = { "Name" => "new" }

File.open("demo_out.json","w") do |f|

    f.write(JSON.pretty_generate(options))

end
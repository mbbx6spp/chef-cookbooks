define :couch_data, 
  :action => :import, :name => nil, :url => nil, :dir => nil do

  require 'net/http'

  raise ArgumentError,
    "Missing required argument: name" unless params[:name]
  raise ArgumentError,
    "Missing required argument: url" unless params[:url]
  raise ArgumentError,
    "Missing required argument: dir" unless params[:dir]

  action = params[:action]
  url = URI.parse(params[:url])
  name = params[:name]
  dir = params[:dir]
  
  exec "couch:data:#{action}:#{url}/#{name}" do
    Net::HTTP.start(url.host, url.port) do |http|
      http.post("/#{name}")
    end
  end
end

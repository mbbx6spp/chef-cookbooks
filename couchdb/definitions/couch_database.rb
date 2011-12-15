define :couch_database,
  :action => :create, :name => nil, :url => nil do

  require 'net/http'

  raise ArgumentError,
    "Missing required argument: name" unless params[:name]
  raise ArgumentError,
    "Missing required argument: url" unless params[:url]

  action = params[:action]
  url = URI.parse(params[:url])
  name = params[:name]

  exec "couch:db:#{action}:#{url}/#{name}" do
    Net::HTTP.start(url.host, url.port) do |http|
      http.put("/#{name}")
    end
  end
end

require_relative 'time_format_handler'

class App
  def call(env)
    @request = Rack::Request.new(env)
    @response = Rack::Response.new

    if @request.path_info == "/time"
      time_response(TimeFormatHandler.new(@request.params["format"]))
    else
      compose_response(404, "Unknown resource '#{@request.path_info}'\n")
    end
  end

  private

  def compose_response(status, text)
    @response.status = status
    @response.write "#{text}"
    @response.headers['Content-Type'] = 'text/plain'
    @response.finish
  end

  def time_response(handler)
    if handler.unknown_formats.empty?
      compose_response(200, "#{handler.result}\n")
    else
      compose_response(400, "Unknown time format #{handler.unknown_formats}\n")
    end
  end
end


require_relative 'time_format_handler'

class App
  def call(env)
    @request = Rack::Request.new(env)
    @response = Rack::Response.new

    if @request.path_info == "/time"
      @handler = TimeFormatHandler.new(@request.params["format"])
      status = @handler.success? ? 200 : 400
      compose_response(status, "#{@handler.result}\n")
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
end


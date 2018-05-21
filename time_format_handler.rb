class TimeFormatHandler
  FORMATS = {year: "%Y", month: "%m", day: "%d", hour: "%H", minute: "%M", second: "%S"}.freeze

  attr_reader :formats, :unknown_formats

  def initialize(input_string)
    @input_string = input_string

    check_formats
  end

  def result
    Time.now.strftime(@formats.join('-'))
  end

  private

  def check_formats
    @formats = []
    @unknown_formats = []

    @input_string.split(',').each do |format|
      if FORMATS[format.to_sym]
        @formats << FORMATS[format.to_sym]
      else
        @unknown_formats << format
      end
    end
  end
end


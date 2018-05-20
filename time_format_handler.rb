class TimeFormatHandler
  FORMATS = {year: "%Y", month: "%m", day: "%d", hour: "%H", minute: "%M", second: "%S"}.freeze

  def initialize(input_string)
    @input_string = input_string

    check_formats
  end

  def success?
    @unknown_formats.empty?
  end

  def result
    if success?
      Time.now.strftime(@formats.join('-'))
    else
      "Unknown time format #{@unknown_formats}"
    end
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


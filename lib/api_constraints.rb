class ApiConstraints
  def initialize(options)
    @version = options[:value]
    @default = options[:default]
  end

  def matches?(req)
    @default || req.headers['Accept'].include?("application/my_notes.v#{@version}")
  end
end
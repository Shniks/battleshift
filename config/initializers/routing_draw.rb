class ActionDispatch::Routing::Mapper
  def draw(route)
    instance_eval(File.read(Rails.root.join("config/routes/#{route}.rb")))
  end
end

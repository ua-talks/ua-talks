class Builders::Helpers < SiteBuilder
  def build
    # see plugins/helpers
    ::Helpers.constants.each do |mod_name|
      mod = ::Helpers.const_get(mod_name)
      self.class.include(mod)
      mod.instance_methods.each do |method|
        helper method
      end
    end
  end
end

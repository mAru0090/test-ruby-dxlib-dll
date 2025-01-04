require "fiddle/import"
require "fiddle"



# ライブラリのロード
RubyInstaller::Runtime.add_dll_directory("./")
module Box2DFFI
  extend Fiddle::Importer
  # Box2DのDLLをロード(Debug)
  #dlload "./box2dd.dll"

end

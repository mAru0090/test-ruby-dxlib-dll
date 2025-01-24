$LOAD_PATH.unshift(File.expand_path('./'))
require 'listen'

listener = Listen.to('./') do |modified, _added, _removed|
  modified.each do |file|
    load file if File.extname(file) == '.rb' # Rubyファイルだけをロード
  end
end

listener.start
sleep

$LOAD_PATH.unshift(File.expand_path('./'))
require 'listen'

listener = Listen.to('./') do |modified, added, removed|
  modified.each do |file|
    if File.extname(file) == '.rb' # Rubyファイルだけをロード
      load file
    end
  end
end

listener.start
sleep

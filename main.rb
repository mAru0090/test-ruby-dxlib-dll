$LOAD_PATH.unshift(File.expand_path('./'))

require 'dxlib_const_variables'
require "dxlib"
require 'objspace'
require 'fps'

include DxLib
class Game

  def initialize(title)
    @title =  title
    @is_running = true
    set_use_char_code_format(DX_CHARCODEFORMAT_UTF8)
    set_main_window_text(@title)
    change_window_mode(TRUE)
    set_wait_vsync_flag(FALSE)

    ObjectSpace.define_finalizer(self, self.class.finalize)
    dxlib_init
  end
  def self.finalize
        Proc.new{
            dxlib_end
        }
  end
  def loop(&main_block)
      @main_block = main_block
     
      while @is_running
          if process_message() == -1 then
             @is_running = false
             break
          end
          @main_block&.call if @main_block  
      end

  end
end
 
fps = FPS.new(60)
game = Game.new("DxLib").loop do       
      # 現在のFPSを表示
      cls_draw_screen()
      current_fps = fps.current_fps
      draw_string(0, 0, "@FPS[#{current_fps}]", get_color(255, 255, 255))
      draw_string(0, 10, "あいうえお", get_color(255, 255, 255))
      screen_flip()      
      fps.wait
end








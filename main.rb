$LOAD_PATH.unshift(File.expand_path('..', __FILE__))
require './dxlib-ruby/dxlib_const_variables'
require './dxlib-ruby/dxlib'
require 'objspace'
require 'fps'
require 'fiddle'

class Game
  include DxLib

  def initialize(title)
    @title = title
    @is_running = true
    set_use_char_code_format(DX_CHARCODEFORMAT_UTF8)
    set_main_window_text(@title)
    change_window_mode(TRUE)
    set_wait_vsync_flag(FALSE)
    # DxLibの初期化
    dxlib_init
    set_draw_screen(DX_SCREEN_BACK) 
    @fps = FPS.new(30)  # FPSを60に設定
  end 

  # ゲームループ
  def loop(&main_block)
    @main_block = main_block

    while @is_running
      if process_message() == -1
        @is_running = false
        break
      end
      @main_block&.call if @main_block
      @fps.wait
    end
  end

  def is_running
    @is_running
  end

  def is_running=(flag)
    @is_running = flag
  end

  # メイン処理
  def main
    
    sound = load_sound_mem("./ryokugan.wav")  # サウンドの読み込み
    play_sound_mem(sound, DX_PLAYTYPE_BACK)  # 音の再生

    input_handle = make_key_input(50, FALSE, FALSE, FALSE)  # キー入力ハンドル作成
    input_flag = false

    # バッファの準備 (変更可能なメモリ領域を確保)
    buffer_size = 1000  # バッファサイズ
    buffer = Fiddle::Pointer.malloc(buffer_size)
    set_active_key_input(input_handle)

    self.loop do
      # 入力が終了している場合は終了
      @is_running = false if check_key_input(input_handle) != 0
      @is_running = false if check_hit_key(KEY_INPUT_ESCAPE) == TRUE

      cls_draw_screen()  # 画面クリア
      draw_box(0,0,640,480,get_color(100,100,100),TRUE)
      draw_string(0, 0, "@FPS[#{@fps.current_fps}]", get_color(255, 255, 255))
      draw_string(0, 50, "buffer: #{buffer.to_s(buffer_size)}", get_color(255, 255, 255))
      
      if check_hit_key(KEY_INPUT_1) == TRUE then
        input_flag = !input_flag
      end
     

        # 入力モードを描画
        #draw_key_input_mode_string(640,480) 
        # 入力途中の文字列を描画
        draw_key_input_string(0,20,input_handle)

      if check_hit_key(KEY_INPUT_2) == TRUE then
        if check_key_input(input_handle) == TRUE then
          get_key_input_string(buffer,input_handle)
        end
      end

      # 画面の反転
      screen_flip()   
    end    
    dxlib_end
  end
end
game = Game.new("").main
























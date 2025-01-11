$LOAD_PATH.unshift(File.expand_path('./'))

require 'dxlib_const_variables'
require 'dxlib'
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
  
    @fps = FPS.new(60)  # FPSを60に設定
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
    buffer_size = 256  # バッファサイズ
    buffer = Fiddle::Pointer.malloc(buffer_size)
    set_active_key_input(input_handle)

    self.loop do
      # 入力が終了している場合は終了
      @is_running = false if check_key_input(input_handle) != 0
      @is_running = false if check_hit_key(KEY_INPUT_ESCAPE) == TRUE

      cls_draw_screen()  # 画面クリア
      draw_box(0,0,640,480,get_color(100,100,100),TRUE)
      draw_string(0, 0, "@FPS[#{@fps.current_fps}]", get_color(255, 255, 255))

      # キー入力モードの表示
      draw_key_input_mode_string(0, 100)
      draw_key_input_string(0, 100, input_handle)

      # 画面の反転
      screen_flip()   
    end    
    dxlib_end
  end
end
game = Game.new("").main

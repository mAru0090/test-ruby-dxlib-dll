$LOAD_PATH.unshift(File.expand_path(__dir__))
require './dxlib-ruby/dxlib_const_variables'
require './dxlib-ruby/dxlib'
require 'objspace'
require 'fps'
require 'novel_engine'




class Game
  include DxLib

  def initialize(title, width, height)
    @title = title
    @is_running = true
    @width = width
    @height = height
    set_graph_mode(width, height, 32, 120)
    set_use_char_code_format(DX_CHARCODEFORMAT_UTF8)
    set_main_window_text(title)
    change_window_mode(TRUE)
    set_wait_vsync_flag(FALSE)
    dxlib_init
    set_draw_screen(DX_SCREEN_BACK)
    @fps = FPS.new(60)
    set_font_size(30)
    change_font('メイリオ')
    # text = "あい@WAITｄｋをえｖｆｋｊｖげｋぽｖげｒｄｓ"
    text = File.read('novel.txt')
    @n_engine = NovelEngine.new(width, height, text)

    # @NEWLINEコマンドに処理を追加
    # @n_engine.add_command("@WAIT") do |char|
    # wait_timer(1000) # 1秒待機
    # end
  end

  def loop(&main_block)
    @main_block = main_block


    while @is_running
      if process_message == -1
        @is_running = false
        break
      end

      # メインブロックの処理を呼び出し
      @main_block&.call if @main_block

      @fps.wait
    end
  end

  attr_accessor :is_running


  # メイン処理
  def main
    self.loop do
      # エスケープキーで終了
      @is_running = false if check_hit_key(KEY_INPUT_ESCAPE) == TRUE

      # 画面のクリア
      # cls_draw_screen()

      clear_draw_screen
      # NovelEngineのupdateとdrawを呼び出し
      @n_engine.update
      @n_engine.draw

      # 画面の反転
      screen_flip
    end
    dxlib_end
  end
end








# ゲームの実行
Game.new('Title', 640, 480).main

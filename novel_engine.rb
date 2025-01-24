$LOAD_PATH.unshift(File.expand_path(__dir__))
require './dxlib-ruby/dxlib_const_variables'
require './dxlib-ruby/dxlib'
require 'base_game_loop'
require 'objspace'
require 'fps'
require 'fiddle'









class NovelEngine < BaseGameLoop
  include DxLib

  def initialize(width, height, text)
    @width = width
    @height = height
    @original_text = text
    @wait_positions = [] # ここで初期化
    @text = process_text(text) # テキストからカスタム構文を処理して削除
    @index = 0
    @interval = 8
    @counter = 0
    @initialize_x = 0
    @initialize_y = 0
    @x = @initialize_x
    @y = @initialize_y

    @commands = {} # コマンド名とその処理を管理するハッシュ
    @waiting = false # 待機中かどうかを判定するフラグ
  end

  # テキストからカスタム構文（@WAITなど）を処理し、除去するメソッド
  def process_text(text)
    clean_text = ''
    buffer = ''
    text.each_char.with_index do |char, _index|
      if char == '@' # コマンドの開始
        buffer = '@'
      elsif buffer.start_with?('@') # コマンドの途中であればバッファに追加
        buffer += char
        if buffer == '@WAIT' # @WAITを見つけた場合
          @wait_positions.push(clean_text.length) # ここで@WAITの位置を記録
          buffer = '' # バッファをリセット
        end
      else
        clean_text += char
      end
    end
    clean_text # カスタム構文を削除したテキストを返す
  end

  def update
    # if @waiting
    # @waitingがtrueのときのみ、キー入力待機を行う
    # wait_for_input
    # else
    @counter += 1
    return unless @counter >= @interval && @index < @text.size # 待機中でない場合のみ文字を進める

    @counter = 0
    @index += 1

    # end
  end

  def draw
    @x = @initialize_x
    @y = @initialize_y
    current_text = @text[0..@index] # 現在表示すべき部分を取得
    if @waiting
      # @waitingがtrueのときのみ、キー入力待機を行う
      wait_for_input
    else
      current_text.each_char.with_index do |char, index|
        # @WAITの位置に到達したら、待機状態にする
        if @wait_positions.include?(index) && !@waiting
          @waiting = true # 待機状態にする
        end

        # ここから通常の文字描画処理
        # 改行文字の場合、x, yの位置をリセット
        if char == "\n"
          @x = @initialize_x
          @y += get_font_size
          next # 改行文字そのものは描画しない
        end

        # 1文字の幅を取得
        char_width = get_draw_string_width(char, char.bytesize)

        # 横幅を超えた場合
        if @x + char_width > @width
          @x = @initialize_x
          @y += get_font_size
        end

        # 文字を描画
        draw_string(@x, @y, char, get_color(255, 255, 255))

        # 次の文字の描画位置を計算
        @x += char_width
      end
    end
  end

  # キーが押されるのを待つメソッド
  def wait_for_input
    wait_key
    @waiting = false # 入力を受け取ったら待機状態を解除
  end
end

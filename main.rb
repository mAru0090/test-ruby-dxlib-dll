$LOAD_PATH.unshift(File.expand_path('./'))
require "dxlib"
require "fps"
require "yaml"

class Main
  def initialize(title)
    @title = title
    @x = 150
    @y = 100
    @text = "おはよう!!"
    @window_width = 640
    @window_height = 480
    @cnt = 0
    @direction = 1
    # メモリを確保して値を格納
    @p_mouse_x = Fiddle::Pointer.malloc(Fiddle::SIZEOF_INT) # int型のサイズ分のメモリを確保
    @p_mouse_y = Fiddle::Pointer.malloc(Fiddle::SIZEOF_INT)

    data = {
      title: @title,
      window_width: @window_width,
      window_height: @window_height
    }

    # ハッシュをYAML形式に変換して出力
    yaml_data = data.to_yaml
    # ファイルに書き込む
    File.write('./ini.yml', yaml_data)










    initialize1()
    initialize2()
  end

  def initialize1()
    DxLibFFI::dx_SetUseCharCodeFormat(DX_CHARCODEFORMAT_UTF8)
    DxLibFFI::dx_SetMainWindowText(@title)
    DxLibFFI::dx_ChangeWindowMode(TRUE)
    DxLibFFI::dx_SetWaitVSyncFlag(FALSE)
  end

  def initialize2()
    @dxlib = DxLib.new()
    DxLibFFI::dx_SetAlwaysRunFlag(TRUE)
    DxLibFFI::dx_SetDrawScreen(DX_SCREEN_BACK)

    DxLibFFI::dx_SetDragFileValidFlag(TRUE)
    @snd = DxLibFFI::dx_LoadSoundMem("./ryokugan.wav")
    @img = DxLibFFI::dx_LoadGraph("よくわかなすし.png")
    DxLibFFI::dx_PlaySoundMem(@snd, 1)

  end

  def main()
    # バッファを作成
    path_buffer_size = 256*2
    path_buffer = Fiddle::Pointer.malloc(path_buffer_size)  # メモリ確保
    path_buffer[0, path_buffer_size] = "\0" * path_buffer_size  # 初期化（ヌル文字で埋める）
    
    @dxlib.main_loop {
      # ESC
      if DxLibFFI::dx_CheckHitKey(1) == TRUE then
        @dxlib.is_running = false
      end
      # Space
      if DxLibFFI::dx_CheckHitKey(57) == TRUE then
        #DxLibFFI::dx_DeleteGraph(@img)
        path = path_buffer.to_s.split("\0").first
        path = path.to_s if path == nil
        text = File.read(path) if !path.empty?
        DxLibFFI::dx_WaitTimer(1500)       
      end

      DxLibFFI::dx_DrawExtendGraph(@x, @y, @x + 300, @y + 300, @img, TRUE)
      DxLibFFI::dx_DrawString(0, 0, "x: #{@x} y: #{@y}", DxLibFFI::dx_GetColor(255, 255, 255))
      DxLibFFI::dx_DrawString(0, 20, "mouseX: #{@p_mouse_x[0,Fiddle::SIZEOF_INT].unpack1("i")} mouseY: #{@p_mouse_y[0,Fiddle::SIZEOF_INT].unpack1("i")}", DxLibFFI::dx_GetColor(255, 255, 255))
      DxLibFFI::dx_DrawString(0, 40, "cnt: #{@cnt}", DxLibFFI::dx_GetColor(255, 255, 255))
      DxLibFFI::dx_DrawString(0, 80, "path: #{path_buffer.to_s}", DxLibFFI::dx_GetColor(255, 255, 255))
      DxLibFFI::dx_DrawString(0, 100, "text: #{text.to_s}", DxLibFFI::dx_GetColor(255, 255, 255))
      angle = (Math::PI / (180/4))
      @x += Math::sin(@cnt*angle)
      @y += @direction*Math::cos(@cnt*angle)
      @cnt+=1

      @direction = ~@direction if @cnt == 300
      DxLibFFI::dx_GetMousePoint(@p_mouse_x,@p_mouse_y)
      DxLibFFI::dx_GetDragFilePath(path_buffer) 
    }
    @dxlib.run
  end
end

m = Main.new("DxLibテストタイトルーーーー").main









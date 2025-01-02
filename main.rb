$LOAD_PATH.unshift(File.expand_path('./'))
require "dxlib"
require "yaml"


class Main
  def initialize(title)
    @title = title
    @x = 20
    @y = 20
    @text = "おはよう!!"
    @window_width = 640
    @window_height = 480

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
    DxLibFFI::dx_SetUseCharCodeFormat(65001)
    DxLibFFI::dx_SetMainWindowText(@title)
    DxLibFFI::dx_ChangeWindowMode(TRUE)
  end

  def initialize2()
    @dxlib = DxLib.new()
    DxLibFFI::dx_SetAlwaysRunFlag(TRUE)
    DxLibFFI::dx_SetDrawScreen(-2)
    @snd = DxLibFFI::dx_LoadSoundMem("./ryokugan.wav")
    @img = DxLibFFI::dx_LoadGraph("よくわかなすし.png")
    DxLibFFI::dx_PlaySoundMem(@snd, 1)
  end

  def main()
    @dxlib.main_loop {
      if DxLibFFI::dx_CheckHitKey(1) == TRUE then
        @dxlib.is_running = false
      end

      if DxLibFFI::dx_CheckHitKey(57) == TRUE then
        DxLibFFI::dx_DeleteGraph(@img)
      end

      DxLibFFI::dx_DrawExtendGraph(50 + @x, 50 + @y, 50 + @x + 300, 50 + @y + 300, @img, TRUE)

      @text.each_char.with_index do |t, index|
          DxLibFFI::dx_DrawString(@x, @y * 1.5 * index, t, DxLibFFI::dx_GetColor((@x) % 255, (@y) % 255, 255))
      end

      DxLibFFI::dx_DrawString(0, 0, "x: #{@x} y: #{@y}", DxLibFFI::dx_GetColor(255, 255, 255))

      @x = @x + 1
 
    }
    @dxlib.run
  end
end

m = Main.new("タイトル")
m.main()









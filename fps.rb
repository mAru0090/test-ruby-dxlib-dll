require 'dxlib-ruby/dxlib'


class FPS
  include DxLib
  def initialize(fps)
    @fps = fps
    @interval = 1000 / fps # FPSから1フレームあたりの待機時間（ミリ秒）
    @last_time = Time.now # 最初のタイムスタンプを設定
    @frame_count = 0 # フレームカウント
    @last_fps_time = Time.now # FPS計算のための時間
    @current_fps = 0 # 現在のFPS
  end

  # 現在のFPSを取得する
  def current_fps
    # 一定時間（1秒）ごとにFPSを計算
    if (Time.now - @last_fps_time) >= 1
      @current_fps = @frame_count
      @frame_count = 0 # フレームカウントをリセット
      @last_fps_time = Time.now # 最後のFPS計算時間を更新
    end
    @current_fps
  end

  # 待機する（FPS制御）
  def wait
    elapsed_time = (Time.now - @last_time) * 1000 # 経過時間（ミリ秒）
    remaining_time = @interval - elapsed_time

    wait_timer(remaining_time.to_i) if remaining_time > 0

    @last_time = Time.now # 時間をリセット
    @frame_count += 1 # フレームカウントをインクリメント
  end
end

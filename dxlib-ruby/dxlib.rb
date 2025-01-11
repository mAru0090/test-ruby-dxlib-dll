$LOAD_PATH.unshift(File.expand_path('..', __FILE__))
require "dxlib_ffi"
module DxLib
  def self.create_method(original_name)
    # dx_DxLib_Init と dx_DxLib_End をスキップ
    return if ["dx_DxLib_Init", "dx_DxLib_End","dx_SetWaitVsyncFlag"].include?(original_name.to_s)
    # メソッド名を変換し、先頭の不要な'_'を削除
    new_name = original_name.to_s.sub(/^dx_/, '').gsub(/([A-Z])/, '_\1').downcase.sub(/^_/, '')
    
    # インスタンスメソッドとして定義
    define_method(new_name) do |*args|
      DxLibFFI.send(original_name, *args)
    end
  end

  # DxLibFFIの全メソッドを取得してラップ
  DxLibFFI.methods(false).grep(/^dx_/).each do |method_name|
    create_method(method_name)
  end
  def dxlib_init
    DxLibFFI::dx_DxLib_Init
  end
  def dxlib_end
    DxLibFFI::dx_DxLib_End
  end
  def set_wait_vsync_flag(flag)
    DxLibFFI::dx_SetWaitVSyncFlag(flag)
  end
end

# DxLibFFIの関数を列挙して表示
#puts "Available methods in DxLibFFI:"
DxLibFFI.methods(false).grep(/^dx_/).each do |method|
  #puts method.to_s
end

# DxLibの生成済みインスタンスメソッドを確認
#puts "\nAvailable wrapped methods in DxLib:"
DxLib.instance_methods(false).each do |method|
  #puts method.to_s
end

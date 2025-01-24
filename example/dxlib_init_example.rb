$LOAD_PATH.unshift(File.expand_path('..', __dir__))
require 'dxlib-ruby/dxlib_const_variables'
require 'dxlib-ruby/dxlib'
require 'fiddle'

include DxLib
change_window_mode(TRUE)
dxlib_init
wait_key
# ＤＸライブラリの使用終了
dxlib_end

$LOAD_PATH.unshift(File.expand_path('..', __dir__))
require 'dxlib-ruby/dxlib_const_variables'
require 'dxlib-ruby/dxlib'
require 'fiddle'

include DxLib
set_use_char_code_format(DX_CHARCODEFORMAT_UTF8)
set_main_window_text('DxLib DrawInfo Example')
change_window_mode(TRUE)
set_wait_vsync_flag(FALSE)
# DxLibの初期化
return if dxlib_init == -1

# 描画先を裏にする
# set_draw_screen(DX_SCREEN_BACK)


int_size = Fiddle::SIZEOF_INT
# int _GetSystemInfo( int *DxLibVer , int *DirectXVer , int *WindowsVer )
dxlib_ver_p = Fiddle::Pointer.malloc(int_size)
directx_ver_p = Fiddle::Pointer.malloc(int_size)
windows_ver_p = Fiddle::Pointer.malloc(int_size)

_get_system_info(dxlib_ver_p, directx_ver_p, windows_ver_p)

dxlib_ver = dxlib_ver_p[0, int_size].unpack1('i!')
directx_ver = directx_ver_p[0, int_size].unpack1('i!')
windows_ver = windows_ver_p[0, int_size].unpack1('i!')

draw_string(0, 0, "DxLib Version[#{dxlib_ver}] DirectX Version[#{directx_ver}] Windows Version[#{windows_ver}]",
            get_color(255, 255, 255))


# キー入力待ち
wait_key
# ＤＸライブラリの使用終了
dxlib_end

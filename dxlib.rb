require 'dxlib_ffi'



module DxLib
  def dxlib_init
    DxLibFFI::dx_DxLib_Init()
  end

  def dxlib_end
    DxLibFFI::dx_DxLib_End()
  end

  def change_window_mode(mode)
    DxLibFFI::dx_ChangeWindowMode(mode)
  end

  def process_message
    DxLibFFI::dx_ProcessMessage()
  end

  def get_color(r, g, b)
    DxLibFFI::dx_GetColor(r, g, b)
  end

  def draw_string(x, y, string, color)
    DxLibFFI::dx_DrawString(x, y, string, color)
  end

  def set_use_char_code_format(format)
    DxLibFFI::dx_SetUseCharCodeFormat(format)
  end

  def screen_flip
    DxLibFFI::dx_ScreenFlip()
  end

  def set_draw_screen(screen)
    DxLibFFI::dx_SetDrawScreen(screen)
  end

  def cls_draw_screen
    DxLibFFI::dx_ClsDrawScreen()
  end

  def load_sound_mem(file_path)
    DxLibFFI::dx_LoadSoundMem(file_path)
  end

  def play_sound_mem(handle, play_type)
    DxLibFFI::dx_PlaySoundMem(handle, play_type)
  end

  def load_graph(file_path)
    DxLibFFI::dx_LoadGraph(file_path)
  end

  def delete_graph(handle)
    DxLibFFI::dx_DeleteGraph(handle)
  end

  def draw_graph(x, y, handle, trans_flag)
    DxLibFFI::dx_DrawGraph(x, y, handle, trans_flag)
  end

  def check_hit_key(key_code)
    DxLibFFI::dx_CheckHitKey(key_code)
  end

  def draw_extend_graph(x1, y1, x2, y2, handle, trans_flag)
    DxLibFFI::dx_DrawExtendGraph(x1, y1, x2, y2, handle, trans_flag)
  end

  def set_always_run_flag(flag)
    DxLibFFI::dx_SetAlwaysRunFlag(flag)
  end

  def set_main_window_text(title)
    DxLibFFI::dx_SetMainWindowText(title)
  end

  def get_mouse_point(x, y)
    DxLibFFI::dx_GetMousePoint(x, y)
  end

  def set_drag_file_valid_flag(flag)
    DxLibFFI::dx_SetDragFileValidFlag(flag)
  end

  def drag_file_info_clear
     DxLibFFI::dx_DragFileInfoClear()
  end

  def get_drag_file_num
     DxLibFFI::dx_GetDragFileNum()
  end

  def get_drag_file_path(buffer)
     DxLibFFI::dx_GetDragFilePath(buffer)
  end

  def wait_timer(wait_time)
     DxLibFFI::dx_WaitTimer(wait_time)
  end

  def set_wait_vsync_flag(flag)
     DxLibFFI::dx_SetWaitVSyncFlag(flag)
  end

  def set_draw_blend_mode(blend_mode, param)
     DxLibFFI::dx_SetDrawBlendMode(blend_mode, param)
  end
end

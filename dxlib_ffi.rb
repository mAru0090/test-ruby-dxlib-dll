require "fiddle/import"
require "fiddle"

# ライブラリのロード
RubyInstaller::Runtime.add_dll_directory("./")
module DxLibFFI
  extend Fiddle::Importer
  dlload "./DxLib_x64.dll"
  
  # 外部関数の定義
  extern "int dx_DxLib_Init(void)"
  extern "int dx_DxLib_End(void)"
  extern "int dx_ChangeWindowMode(int)"
  extern "int dx_ProcessMessage(void)"
  extern "int dx_GetColor(int, int, int)"
  extern "int dx_DrawString(int, int, char*, int)"
  extern "int dx_SetUseCharCodeFormat(int)"
  extern "int dx_ScreenFlip(void)"
  extern "int dx_SetDrawScreen(int)"
  # なぜかClearDrawScreen使おうとするとセグメンテーション違反になるため古い名前のClearDrawScreen相当を使う
  extern "int dx_ClsDrawScreen(void)"
  extern "int dx_LoadSoundMem(char*)"
  extern "int dx_PlaySoundMem(int,int)"
  extern "int dx_LoadGraph(char*)"
  extern "int dx_DeleteGraph(int)"
  extern "int dx_DrawGraph(int,int,int,int)"
  extern "int dx_CheckHitKey(int)"
  extern "int dx_DrawExtendGraph(int,int,int,int,int,int)"
  extern "int dx_SetAlwaysRunFlag(int)"
  extern "int dx_SetMainWindowText(char*)"
end


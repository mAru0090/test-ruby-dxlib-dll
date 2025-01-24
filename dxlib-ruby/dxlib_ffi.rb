require 'ffi'
DXLIB_DLL_NAME = 'DxLib_x64.dll'

# ライブラリのロード
RubyInstaller::Runtime.add_dll_directory('./')
RubyInstaller::Runtime.add_dll_directory('./dll/')

module DxLibFFI
  extend FFI::Library

  # DxLib_x64.dllのロード
  ffi_lib DXLIB_DLL_NAME

  # 関数宣言
  attach_function :dx_DxLib_Init, [], :int
  attach_function :dx_DxLib_End, [], :int
  attach_function :dx_ChangeWindowMode, [:int], :int
  attach_function :dx_ProcessMessage, [], :int
  attach_function :dx_GetColor, %i[int int int], :int
  attach_function :dx_DrawString, %i[int int pointer int], :int
  attach_function :dx_SetUseCharCodeFormat, [:int], :int
  attach_function :dx_ScreenFlip, [], :int
  attach_function :dx_SetDrawScreen, [:int], :int
  attach_function :dx_ClsDrawScreen, [], :int
  attach_function :dx_ClearDrawScreen, [:pointer], :int

  attach_function :dx_LoadSoundMem, [:string], :int
  attach_function :dx_PlaySoundMem, %i[int int], :int
  attach_function :dx_LoadGraph, [:string], :int
  attach_function :dx_DeleteGraph, [:int], :int
  attach_function :dx_DrawGraph, %i[int int int int], :int
  attach_function :dx_CheckHitKey, [:int], :int
  attach_function :dx_DrawExtendGraph, %i[int int int int int int], :int
  attach_function :dx_SetAlwaysRunFlag, [:int], :int
  attach_function :dx_SetMainWindowText, [:string], :int
  attach_function :dx_GetMousePoint, %i[pointer pointer], :int
  attach_function :dx_SetDragFileValidFlag, [:int], :int
  attach_function :dx_DragFileInfoClear, [], :int
  attach_function :dx_GetDragFileNum, [], :int
  attach_function :dx_GetDragFilePath, [:string], :int
  attach_function :dx_WaitTimer, [:int], :int
  attach_function :dx_WaitKey, [], :int
  attach_function :dx_SetWaitVSyncFlag, [:int], :int
  attach_function :dx_SetDrawBlendMode, %i[int int], :int
  attach_function :dx_MakeKeyInput, %i[int int int int], :int
  attach_function :dx_DrawKeyInputString, %i[int int int], :int
  attach_function :dx_SetActiveKeyInput, [:int], :int
  attach_function :dx_CheckKeyInput, [:int], :int
  attach_function :dx_DrawKeyInputModeString, %i[int int], :int
  attach_function :dx_DrawKeyInputString, %i[int int int], :int
  attach_function :dx_InitKeyInput, [], :int
  attach_function :dx_DeleteKeyInput, [:int], :int
  attach_function :dx_GetKeyInputString, %i[pointer int], :int
  attach_function :dx_DrawBox, %i[int int int int int int], :int
  attach_function :dx_KeyInputString, %i[int int int pointer int], :int
  attach_function :dx_KeyInputSingleCharString, %i[int int int pointer int], :int
  attach_function :dx_KeyInputNumber, %i[int int int int int], :int
  attach_function :dx_SetKeyInputStringColor, %i[
    int int int int int int int int int int int int int int int int int
  ], :int
  attach_function :dx__GetSystemInfo, %i[pointer pointer pointer], :int
  attach_function :dx_DxAlloc, %i[size_t string int], :pointer
  attach_function :dx_DxCalloc, %i[size_t string int], :pointer
  attach_function :dx_DxRealloc, %i[pointer size_t string int], :pointer
  attach_function :dx_DxFree, [:pointer], :void
  attach_function :dx_DxSetAllocSizeTrap, [:size_t], :size_t
  attach_function :dx_DxSetAllocPrintFlag, [:int], :int
  attach_function :dx_DxGetAllocSize, [], :size_t
  attach_function :dx_DxGetAllocNum, [], :int
  attach_function :dx_DxDumpAlloc, [], :void
  attach_function :dx_DxErrorCheckAlloc, [], :int
  attach_function :dx_DxSetAllocSizeOutFlag, [:int], :int
  attach_function :dx_DxSetAllocMemoryErrorCheckFlag, [:int], :int
  attach_function :dx_GetDrawStringWidth, %i[pointer int], :int
  attach_function :dx_SetFontSize, [:int], :int
  attach_function :dx_GetFontSize, [], :int
  attach_function :dx_ChangeFont, [:string], :int
  attach_function :dx_GetFontSizeToHandle, [:int], :int
  attach_function :dx_SetGraphMode, %i[int int int int], :int
end

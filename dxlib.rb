require './dxlib_ffi'
require './dxlib_const_variables'

require 'objspace'

class DxLib
   def initialize()
        DxLibFFI::dx_DxLib_Init()
        ObjectSpace.define_finalizer(self, self.class.finalize)
        @is_running = true
   end
   def self.finalize
        Proc.new{
            DxLibFFI::dx_DxLib_End()
        }
   end
   def main_loop(&main_block)
       @main_block = main_block
   end
   
   def is_running
      @is_running
   end

   def is_running=(value)
      @is_running = value
   end
   def run()
      while @is_running
          if DxLibFFI::dx_ProcessMessage() == -1 then
             @is_running = false
             break
          end
          DxLibFFI::dx_ClsDrawScreen()
          @main_block.call if @main_block
          DxLibFFI::dx_ScreenFlip()
          # 60fpsのためにフレームを待機
          sleep(1.0 / 60.0)
      end
    end
end

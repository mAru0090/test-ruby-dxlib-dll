require 'fiddle'
require 'fiddle/import'
require 'fiddle/types'

module DxLibStructs
  extend Fiddle::Importer
  include Fiddle::Types
  INT = Fiddle::SIZEOF_INT

  # RECT構造体
  class RECT < Fiddle::CStruct
    layout(
      :left, INT,
      :top, INT,
      :right, INT,
      :bottom, INT
    )
  end

  # VECTOR構造体
  class VECTOR < Fiddle::CStruct
    layout(
      :x, FLOAT,
      :y, FLOAT,
      :z, FLOAT
    )

    # 演算子オーバーロード (加算)
    def +(other)
      VECTOR.malloc.tap do |result|
        result.x = self.x + other.x
        result.y = self.y + other.y
        result.z = self.z + other.z
      end
    end

    # 演算子オーバーロード (減算)
    def -(other)
      VECTOR.malloc.tap do |result|
        result.x = self.x - other.x
        result.y = self.y - other.y
        result.z = self.z - other.z
      end
    end

    # Clone メソッド
    def clone
      VECTOR.malloc.tap do |result|
        result.x = self.x
        result.y = self.y
        result.z = self.z
      end
    end
  end

  # COLOR_U8構造体
  class COLOR_U8 < Fiddle::CStruct
    layout(
      :a, UINT8,
      :r, UINT8,
      :g, UINT8,
      :b, UINT8
    )
  end

  # COLOR_F構造体
  class COLOR_F < Fiddle::CStruct
    layout(
      :a, FLOAT,
      :r, FLOAT,
      :g, FLOAT,
      :b, FLOAT
    )
  end

  # MATERIALPARAM構造体
  class MATERIALPARAM < Fiddle::CStruct
    layout(
      :Diffuse, COLOR_F,
      :Ambient, COLOR_F,
      :Specular, COLOR_F,
      :Emissive, COLOR_F,
      :Power, FLOAT
    )
  end

  # VERTEX3D構造体
  class VERTEX3D < Fiddle::CStruct
    layout(
      :pos, VECTOR,
      :norm, VECTOR,
      :dif, COLOR_U8,
      :spc, COLOR_U8,
      :u, FLOAT,
      :v, FLOAT,
      :su, FLOAT,
      :sv, FLOAT
    )
  end

  # HITRESULT_LINE構造体
  class HITRESULT_LINE < Fiddle::CStruct
    layout(
      :HitFlag, INT,
      :Position, VECTOR
    )
  end

  # DATEDATA構造体
  class DATEDATA < Fiddle::CStruct
    layout(
      :Year, INT,
      :Mon, INT,
      :Day, INT,
      :Hour, INT,
      :Min, INT,
      :Sec, INT
    )
  end

  # XAUDIO2FX_REVERB_PARAMETERS構造体
  class XAUDIO2FX_REVERB_PARAMETERS < Fiddle::CStruct
    layout(
      :WetDryMix, FLOAT,
      :ReflectionsDelay, UINT32,
      :ReverbDelay, UINT8,
      :RearDelay, UINT8,
      :PositionLeft, UINT8,
      :PositionRight, UINT8,
      :PositionMatrixLeft, UINT8,
      :PositionMatrixRight, UINT8,
      :EarlyDiffusion, UINT8,
      :LateDiffusion, UINT8,
      :LowEQGain, UINT8,
      :LowEQCutoff, UINT8,
      :HighEQGain, UINT8,
      :HighEQCutoff, UINT8,
      :RoomFilterFreq, FLOAT,
      :RoomFilterMain, FLOAT,
      :RoomFilterHF, FLOAT,
      :ReflectionsGain, FLOAT,
      :ReverbGain, FLOAT,
      :DecayTime, FLOAT,
      :Density, FLOAT,
      :RoomSize, FLOAT
    )
  end

  # IPDATA構造体
  class IPDATA < Fiddle::CStruct
    layout(
      :d1, UINT8,
      :d2, UINT8,
      :d3, UINT8,
      :d4, UINT8
    )
  end

  # MATRIX構造体
  class MATRIX < Fiddle::CStruct
    layout(
      :m, [FLOAT, 4 * 4] # 4x4行列
    )

    # Clone メソッド
    def clone
      MATRIX.malloc.tap do |result|
        result.m = self.m
      end
    end
  end
end

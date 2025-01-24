class RECT < FFI::Struct
  layout :left, :long,
         :top, :long,
         :right, :long,
         :bottom, :long
end

class VECTOR < FFI::Struct
  layout(
    :x, :float,
    :y, :float,
    :z, :float
  )

  # 演算子オーバーロード (加算)
  def +(other)
    VECTOR.malloc.tap do |result|
      result.x = x + other.x
      result.y = y + other.y
      result.z = z + other.z
    end
  end

  # 演算子オーバーロード (減算)
  def -(other)
    VECTOR.malloc.tap do |result|
      result.x = x - other.x
      result.y = y - other.y
      result.z = z - other.z
    end
  end

  # Clone メソッド
  def clone
    VECTOR.malloc.tap do |result|
      result.x = x
      result.y = y
      result.z = z
    end
  end
end

class COLOR_U8 < FFI::Struct
  layout(
    :a, :uint8,
    :r, :uint8,
    :g, :uint8,
    :b, :uint8
  )
end

class COLOR_F < FFI::Struct
  layout(
    :a, :float,
    :r, :float,
    :g, :float,
    :b, :float
  )
end

class MATERIALPARAM < FFI::Struct
  layout(
    :Diffuse, COLOR_F,
    :Ambient, COLOR_F,
    :Specular, COLOR_F,
    :Emissive, COLOR_F,
    :Power, :float
  )
end

class VERTEX3D < FFI::Struct
  layout(
    :pos, VECTOR,
    :norm, VECTOR,
    :dif, COLOR_U8,
    :spc, COLOR_U8,
    :u, :float,
    :v, :float,
    :su, :float,
    :sv, :float
  )
end

class HITRESULT_LINE < FFI::Struct
  layout(
    :HitFlag, :int,
    :Position, VECTOR
  )
end

# DATEDATA構造体
class DATEDATA < FFI::Struct
  layout(
    :Year, :int,
    :Mon, :int,
    :Day, :int,
    :Hour, :int,
    :Min, :int,
    :Sec, :int
  )
end

# XAUDIO2FX_REVERB_PARAMETERS構造体
class XAUDIO2FX_REVERB_PARAMETERS < FFI::Struct
  layout(
    :WetDryMix, :float,
    :ReflectionsDelay, :uint32,
    :ReverbDelay, :uint8,
    :RearDelay, :uint8,
    :PositionLeft, :uint8,
    :PositionRight, :uint8,
    :PositionMatrixLeft, :uint8,
    :PositionMatrixRight, :uint8,
    :EarlyDiffusion, :uint8,
    :LateDiffusion, :uint8,
    :LowEQGain, :uint8,
    :LowEQCutoff, :uint8,
    :HighEQGain, :uint8,
    :HighEQCutoff, :uint8,
    :RoomFilterFreq, :float,
    :RoomFilterMain, :float,
    :RoomFilterHF, :float,
    :ReflectionsGain, :float,
    :ReverbGain, :float,
    :DecayTime, :float,
    :Density, :float,
    :RoomSize, :float
  )
end

# IPDATA構造体
class IPDATA < FFI::Struct
  layout(
    :d1, :uint8,
    :d2, :uint8,
    :d3, :uint8,
    :d4, :uint8
  )
end

# MATRIX構造体
class MATRIX < FFI::Struct
  layout(
    :m, [:float, 4 * 4] # 4x4行列
  )

  # Clone メソッド
  def clone
    MATRIX.malloc.tap do |result|
      result.m = m
    end
  end
end

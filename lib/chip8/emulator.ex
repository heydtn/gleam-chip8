defmodule Chip8.Emulator do
  use Chip8.Strucord,
    name: :emulator,
    from: "gen/src/chip8@emulator_Emulator.hrl"

  alias __MODULE__

  alias Chip8.{
    RegisterFile,
    Stack
  }

  def init() do
    :chip8@emulator.init()
    |> from_record()
  end

  def registers(%Emulator{} = emulator) do
    RegisterFile.from_record(emulator.registers)
  end

  def stack(%Emulator{} = emulator) do
    Stack.from_record(emulator.stack)
  end

  def reset(%Emulator{} = emulator) do
    with_record(emulator, fn record ->
      :chip8@emulator.reset(record)
    end)
  end

  def load_rom(%Emulator{} = emulator, rom) when is_binary(rom) do
    with_record(emulator, fn record ->
      :chip8@emulator.load_rom(record, rom)
    end)
  end

  def step(%Emulator{} = emulator) do
    with_record(emulator, fn record ->
      :chip8@emulator.step(record)
    end)
  end

  def handle_key_down(%Emulator{} = emulator, key) when is_atom(key) do
    with_record(emulator, fn record ->
      :chip8@emulator.handle_key_down(record, key)
    end)
  end

  def handle_key_up(%Emulator{} = emulator, key) when is_atom(key) do
    with_record(emulator, fn record ->
      :chip8@emulator.handle_key_up(record, key)
    end)
  end

  def handle_timers(%Emulator{} = emulator) do
    with_record(emulator, fn record ->
      :chip8@emulator.handle_timers(record)
    end)
  end

  def disassemble_instructions(%Emulator{} = emulator, length) when is_integer(length) do
    record = to_record(emulator)

    :chip8@emulator.disassemble_instructions(record, length)
  end

  def emitting_sound?(%Emulator{} = emulator) do
    sound_timer =
      emulator
      |> registers()
      |> Map.fetch!(:sound_timer)

    sound_timer > 0
  end
end

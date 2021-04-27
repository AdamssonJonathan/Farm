defmodule FarmbotCore.Firmware.Flash do
  alias FarmbotCore.Firmware.UARTCoreSupport

  alias FarmbotCore.Firmware.{
    Resetter,
    Avrdude
  }

  require FarmbotCore.Logger
  @reason "Starting firmware flash."
  @flash_ok "Success: Firmware flashed. Unlock FarmBot to continue."

  def run(state0, package) do
    FarmbotCore.Logger.info(3, @reason)
    state1 = UARTCoreSupport.disconnect(state0, @reason)

    try do
      {:ok, hex_file} = FarmbotFirmware.FlashUtils.find_hex_file(package)
      tty = state1.uart_path
      {:ok, fun} = Resetter.find_reset_fun(package)
      result = Avrdude.flash(hex_file, tty, fun)
      finish_flashing(result, tty)
      state1
    rescue
      err ->
        FarmbotCore.Logger.error(3, "Firmware flash error: #{inspect(err)}")
        state1
    end
  end

  def finish_flashing({_, 0}, _), do: FarmbotCore.Logger.success(1, @flash_ok)

  def finish_flashing(result, _) do
    FarmbotCore.Logger.debug(2, "AVR flash returned #{inspect(result)}")
  end
end

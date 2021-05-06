defmodule FarmbotCore.Firmware.UARTObserverTest do
  use ExUnit.Case
  use Mimic
  import ExUnit.CaptureLog
  alias FarmbotCore.Firmware.UARTObserver
  alias FarmbotCore.Firmware.UARTCoreSupport, as: Support
  alias FarmbotCore.AssetWorker.FarmbotCore.Asset.FirmwareConfig

  test "data_available/2" do
    parent_pid = self()

    caller = fn ->
      UARTObserver.data_available(parent_pid, FirmwareConfig)
    end

    spawn_link(caller)
    assert_receive {:data_available, FirmwareConfig}, 888
  end

  test "unknown messages" do
    {:ok, pid} = UARTObserver.start_link([], [])
    error = fn -> send(pid, :unknown_message) end
    assert capture_log(error) =~ "##### UNKNOWN ##### :unknown_message"
  end
end

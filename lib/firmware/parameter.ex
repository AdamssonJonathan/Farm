defmodule FarmbotOS.Firmware.Parameter do
  @all [
    {000, :param_version},
    {001, :param_test},
    {002, :param_config_ok},
    {003, :param_use_eeprom},
    {004, :param_e_stop_on_mov_err},
    {005, :param_mov_nr_retry},
    {011, :movement_timeout_x},
    {012, :movement_timeout_y},
    {013, :movement_timeout_z},
    {015, :movement_keep_active_x},
    {016, :movement_keep_active_y},
    {017, :movement_keep_active_z},
    {018, :movement_home_at_boot_x},
    {019, :movement_home_at_boot_y},
    {020, :movement_home_at_boot_z},
    {021, :movement_invert_endpoints_x},
    {022, :movement_invert_endpoints_y},
    {023, :movement_invert_endpoints_z},
    {025, :movement_enable_endpoints_x},
    {026, :movement_enable_endpoints_y},
    {027, :movement_enable_endpoints_z},
    {031, :movement_invert_motor_x},
    {032, :movement_invert_motor_y},
    {033, :movement_invert_motor_z},
    {036, :movement_secondary_motor_x},
    {037, :movement_secondary_motor_invert_x},
    {041, :movement_steps_acc_dec_x},
    {042, :movement_steps_acc_dec_y},
    {043, :movement_steps_acc_dec_z},
    {044, :movement_steps_acc_dec_z2},
    {045, :movement_stop_at_home_x},
    {046, :movement_stop_at_home_y},
    {047, :movement_stop_at_home_z},
    {051, :movement_home_up_x},
    {052, :movement_home_up_y},
    {053, :movement_home_up_z},
    {055, :movement_step_per_mm_x},
    {056, :movement_step_per_mm_y},
    {057, :movement_step_per_mm_z},
    {061, :movement_min_spd_x},
    {062, :movement_min_spd_y},
    {063, :movement_min_spd_z},
    {064, :movement_min_spd_z2},
    {065, :movement_home_spd_x},
    {066, :movement_home_spd_y},
    {067, :movement_home_spd_z},
    {071, :movement_max_spd_x},
    {072, :movement_max_spd_y},
    {073, :movement_max_spd_z},
    {074, :movement_max_spd_z2},
    {075, :movement_invert_2_endpoints_x},
    {076, :movement_invert_2_endpoints_y},
    {077, :movement_invert_2_endpoints_z},
    {081, :movement_motor_current_x},
    {082, :movement_motor_current_y},
    {083, :movement_motor_current_z},
    {085, :movement_stall_sensitivity_x},
    {086, :movement_stall_sensitivity_y},
    {087, :movement_stall_sensitivity_z},
    {091, :movement_microsteps_x},
    {092, :movement_microsteps_y},
    {093, :movement_microsteps_z},
    {101, :encoder_enabled_x},
    {102, :encoder_enabled_y},
    {103, :encoder_enabled_z},
    {105, :encoder_type_x},
    {106, :encoder_type_y},
    {107, :encoder_type_z},
    {111, :encoder_missed_steps_max_x},
    {112, :encoder_missed_steps_max_y},
    {113, :encoder_missed_steps_max_z},
    {115, :encoder_scaling_x},
    {116, :encoder_scaling_y},
    {117, :encoder_scaling_z},
    {121, :encoder_missed_steps_decay_x},
    {122, :encoder_missed_steps_decay_y},
    {123, :encoder_missed_steps_decay_z},
    {125, :encoder_use_for_pos_x},
    {126, :encoder_use_for_pos_y},
    {127, :encoder_use_for_pos_z},
    {131, :encoder_invert_x},
    {132, :encoder_invert_y},
    {133, :encoder_invert_z},
    {141, :movement_axis_nr_steps_x},
    {142, :movement_axis_nr_steps_y},
    {143, :movement_axis_nr_steps_z},
    {145, :movement_stop_at_max_x},
    {146, :movement_stop_at_max_y},
    {147, :movement_stop_at_max_z},
    {161, :movement_calibration_retry_x},
    {162, :movement_calibration_retry_y},
    {163, :movement_calibration_retry_z},
    {165, :movement_axis_stealth_x},
    {166, :movement_axis_stealth_y},
    {167, :movement_axis_stealth_z},
    {171, :movement_calibration_deadzone_x},
    {172, :movement_calibration_deadzone_y},
    {173, :movement_calibration_deadzone_z},
    {175, :movement_calibration_retry_total_x},
    {176, :movement_calibration_retry_total_y},
    {177, :movement_calibration_retry_total_z},
    {198, :pin_report_1_pin_nr},
    {199, :pin_report_2_pin_nr},
    {201, :pin_guard_1_pin_nr},
    {202, :pin_guard_1_time_out},
    {203, :pin_guard_1_active_state},
    {205, :pin_guard_2_pin_nr},
    {206, :pin_guard_2_time_out},
    {207, :pin_guard_2_active_state},
    {211, :pin_guard_3_pin_nr},
    {212, :pin_guard_3_time_out},
    {213, :pin_guard_3_active_state},
    {215, :pin_guard_4_pin_nr},
    {216, :pin_guard_4_time_out},
    {217, :pin_guard_4_active_state},
    {221, :pin_guard_5_pin_nr},
    {222, :pin_guard_5_time_out},
    {223, :pin_guard_5_active_state}
  ]

  @decoder Enum.reduce(@all, %{}, fn {number, name}, all ->
             Map.merge(all, %{number => name, name => number})
           end)

  def translate(key), do: Map.fetch!(@decoder, key)
  def names(), do: Enum.map(@all, fn {_code, name} -> name end)
  def is_param?(key), do: Map.has_key?(@decoder, key)
end

# encoding: utf-8

Rango.logger.info("Loaded TEST Environment...")
Rango::Config.use { |c|
  c[:exception_details] = true
  c[:reload_classes] = true
  c[:reload_time] = 0.5
}

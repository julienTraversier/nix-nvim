local status_ok, bbq = pcall(require, "barbecue.ui")
if not status_ok then
  return
end

bbq.toggle(true)



-- v0.1.13
-- Load required files
os.loadAPI("monitor")
os.loadAPI("logo")

-- Monitor settings
local mon = peripheral.wrap("top")
monitor.setup(mon)
local monWidth, monHeight = mon.getSize()
local midX = monWidth / 2
local midY = monHeight / 2
local bootTime = 30
local writeSpeed = 0.1
local spinnerSpeed = 0.1
local cursorBlinkRate = 0.4

-- Boot text
local title = "=== Mini0n OS [v0.1.7] ==="
local state = "Booting..."

-- Main program
sleep(2)
-- Display boot sequence
monitor.textAllLines(mon, logo.get(), midX - 22, midY - 5, writeSpeed / 2, 0, true)
sleep(0.5)
monitor.text(mon, state, midX - (#state / 2), midY + 3, writeSpeed, true)
sleep(0.5)
monitor.spinner(mon, midX, midY + 5, spinnerSpeed, bootTime)

-- Show terminal
mon.clear()
monitor.text(mon, title, midX - (#title / 2), 1, writeSpeed, true)
monitor.text(mon, ">", 0, monHeight, writeSpeed, true)
sleep(0.5)
monitor.caret(mon, "_", 2, monHeight, cursorBlinkRate, 30)

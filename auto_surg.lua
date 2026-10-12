git inittool = "0"
itool = 1
lastTool = ""
min_delay = 400
max_delay = 1000
logToConsole("`0[`9Auto Surg`0] By `4Elgato91169 `0(`2Stable`0)")

function getDelay()
    local base = math.random(min_delay, max_delay)
    return base + math.random(-50, 100)
end

local TOOLS = {
    Sponge = 1258,
    Splint = 1268,
    Antibiotic = 1266,
    Anesthetic = 1262,
    Scalpel = 1260,
    Stitches = 1270,
    ["Lab kit"] = 4318,
    Pins = 4308,
    Clamp = 4314,
    Transfusion = 4310,
    Ultrasound = 4316,
    Defibrillator = 4312,
    ["Fix it"] = 1296
}

local queue = { task = {} }

function queue:add(fn, delay, ...)
    local lastTime = 0
    local now = getCurrentTimeInternal()

    if #self.task > 0 then
        lastTime = self.task[#self.task].runAt
    else
        lastTime = now
    end

    table.insert(self.task, {
        fn = fn,
        runAt = lastTime + delay,
        args = {...}
    })
end

function auto()
    local t = tool
    local id = TOOLS[t] or 0
    local d = getDelay()
    if id ~= 0 and t ~= lastTool then
        lastTool = t

        queue:add(function()
            sendPacket(2, "action|dialog_return\ndialog_name|surgery\nbuttonClicked|tool"..id)
            logToConsole("`9[`cTools`9] `c"..t.." `0("..d.."ms)")
        end, d)
    end
end

function surg(var)
   local handled = false

   local ok, err = pcall(function()

   if var[0]:find("OnDialogRequest") and var[1]:find("Status: `4Heart stopped!(.+)") and var[1]:find("tool4312") then
      tool = "Defibrillator"; auto(); handled = true
   elseif var[0]:find("OnDialogRequest") and var[1]:find("Incisions: `20(.+)") and var[1]:find("tool1296") then
      tool = "Fix it"; auto(); handled = true
   elseif var[0]:find("OnDialogRequest") and var[1]:find("Incisions: `30(.+)") and var[1]:find("tool1296") then
      tool = "Fix it"; auto(); handled = true
   elseif var[0]:find("OnDialogRequest") and var[1]:find("`4The patient wakes up!") and var[1]:find("tool1262") then
      tool = "Anesthetic"; auto(); handled = true
   elseif var[0]:find("OnDialogRequest") and var[1]:find("`4The patient screams and flails!") and var[1]:find("tool1262") then
      tool = "Anesthetic"; auto(); handled = true
   elseif var[0]:find("OnDialogRequest") and var[1]:find("Status: `6Coming to(.+)") and var[1]:find("tool1262") then
      tool = "Anesthetic"; auto(); handled = true
   elseif var[0]:find("OnDialogRequest") and var[1]:find("Pulse: `4(.+)") and var[1]:find("tool4310") then
      tool = "Transfusion"; auto(); handled = true
   elseif var[0]:find("OnDialogRequest") and var[1]:find("Temp: `4(%d+)(.+)") and var[1]:find("tool1266") then
      tool = "Antibiotic"; auto(); handled = true
   elseif var[0]:find("OnDialogRequest") and var[1]:find("Temp: `4(%d+)(.+)") and var[1]:find("tool4318") then
      tool = "Lab kit"; auto(); handled = true
   elseif var[0]:find("OnDialogRequest") and var[1]:find("Temp: `6(%d+)(.+)") and var[1]:find("tool1266") then
      tool = "Antibiotic"; auto(); handled = true
   elseif var[0]:find("OnDialogRequest") and var[1]:find("Temp: `6(%d+)(.+)") and var[1]:find("tool4318") then
      tool = "Lab kit"; auto(); handled = true
   elseif var[0]:find("OnDialogRequest") and var[1]:find("Temp: `3(%d+)(.+)") and var[1]:find("tool1266") then
      tool = "Antibiotic"; auto(); handled = true
   elseif var[0]:find("OnDialogRequest") and var[1]:find("Temp: `3(%d+)(.+)") and var[1]:find("tool4318") then
      tool = "Lab kit"; auto(); handled = true
   elseif var[0]:find("OnDialogRequest") and var[1]:find("Patient is losing blood `4very quickly!(.+)") and var[1]:find("tool4314") then
      tool = "Clamp"; auto(); handled = true
   elseif var[0]:find("OnDialogRequest") and var[1]:find("Patient is losing blood `4very quickly!(.+)") and var[1]:find("tool1270") then
      tool = "Stitches"; auto(); handled = true
   elseif var[0]:find("OnDialogRequest") and var[1]:find("Patient is `6losing blood!(.+)") and var[1]:find("tool4314") then
      tool = "Clamp"; auto(); handled = true
   elseif var[0]:find("OnDialogRequest") and var[1]:find("Patient is `6losing blood!(.+)") and var[1]:find("tool1270") then
      tool = "Stitches"; auto(); handled = true
   elseif var[0]:find("OnDialogRequest") and var[1]:find("The patient has not been diagnosed.") and var[1]:find("tool4316") then
      tool = "Ultrasound"; auto(); handled = true
   elseif var[0]:find("OnDialogRequest") and var[1]:find("Status: `4Awake(.+)") and var[1]:find("tool1262") then
      tool = "Anesthetic"; auto(); handled = true
   elseif var[0]:find("OnDialogRequest") and var[1]:find("Bones: `6(.+) broken``") and var[1]:find("tool1268") then
      tool = "Splint"; auto(); handled = true
   elseif var[0]:find("OnDialogRequest") and var[1]:find("Bones: `4(.+) broken``") and var[1]:find("tool1268") then
      tool = "Splint"; auto(); handled = true
   elseif var[0]:find("OnDialogRequest") and var[1]:find("Patient broke his arm.") and var[1]:find("tool1270") then
      tool = "Stitches"; auto(); handled = true
   elseif var[0]:find("OnDialogRequest") and var[1]:find("Status: `3Awake(.+)") and var[1]:find("tool1262") then
      tool = "Anesthetic"; auto(); handled = true
   elseif var[0]:find("OnDialogRequest") and var[1]:find("Pulse: `6(.+)") and var[1]:find("tool4310") then
      tool = "Transfusion"; auto(); handled = true
   elseif var[0]:find("OnDialogRequest") and var[1]:find("`4You can't see what you are doing!(.+)") and var[1]:find("tool1258") then
      tool = "Sponge"; auto(); handled = true
   elseif var[0]:find("OnDialogRequest") and var[1]:find("Patient is losing blood `3slowly.(.+)") and var[1]:find("tool4314") then
      tool = "Clamp"; auto(); handled = true
   elseif var[0]:find("OnDialogRequest") and var[1]:find("Bones: `6(.+), `6(.+) shattered(.+)") and var[1]:find("tool4308") then
      tool = "Pins"; auto(); handled = true
   elseif var[0]:find("OnDialogRequest") and var[1]:find("Bones: `6(.+), `6(.+) shattered(.+)") and var[1]:find("tool1260") then
      tool = "Scalpel"; auto(); handled = true
   elseif var[0]:find("OnDialogRequest") and var[1]:find("Bones: `4(.+), `6(.+) shattered(.+)") and var[1]:find("tool4308") then
      tool = "Pins"; auto(); handled = true
   elseif var[0]:find("OnDialogRequest") and var[1]:find("Bones: `4(.+), `6(.+) shattered(.+)") and var[1]:find("tool1260") then
      tool = "Scalpel"; auto(); handled = true
   elseif var[0]:find("OnDialogRequest") and var[1]:find("Bones: `6(.+), `4(.+) shattered(.+)") and var[1]:find("tool4308") then
      tool = "Pins"; auto(); handled = true
   elseif var[0]:find("OnDialogRequest") and var[1]:find("Bones: `6(.+), `4(.+) shattered(.+)") and var[1]:find("tool1260") then
      tool = "Scalpel"; auto(); handled = true
   elseif var[0]:find("OnDialogRequest") and var[1]:find("Bones: `4(.+), `4(.+) shattered(.+)") and var[1]:find("tool4308") then
      tool = "Pins"; auto(); handled = true
   elseif var[0]:find("OnDialogRequest") and var[1]:find("Bones: `4(.+), `4(.+) shattered(.+)") and var[1]:find("tool1260") then
      tool = "Scalpel"; auto(); handled = true
   elseif var[0]:find("OnDialogRequest") and var[1]:find("Bones: `6(.+) shattered(.+)") and var[1]:find("tool4308") then
      tool = "Pins"; auto(); handled = true
   elseif var[0]:find("OnDialogRequest") and var[1]:find("Bones: `6(.+) shattered(.+)") and var[1]:find("tool1260") then
      tool = "Scalpel"; auto(); handled = true
   elseif var[0]:find("OnDialogRequest") and var[1]:find("Bones: `4(.+) shattered(.+)") and var[1]:find("tool4308") then
      tool = "Pins"; auto(); handled = true
   elseif var[0]:find("OnDialogRequest") and var[1]:find("Bones: `4(.+) shattered(.+)") and var[1]:find("tool1260") then
      tool = "Scalpel"; auto(); handled = true
   elseif var[0]:find("OnDialogRequest") and var[1]:find("Patient broke his leg.") and var[1]:find("tool1270") then
      tool = "Stitches"; auto(); handled = true
   elseif var[0]:find("OnDialogRequest") and var[1]:find("tool1296") and var[1]:find("tool1270") then
      tool = "Stitches"; auto(); handled = true
   elseif var[0]:find("OnDialogRequest") and var[1]:find("tool1260") then
      tool = "Scalpel"; auto(); handled = true
   end

   end)

   if not ok then
       logToConsole("`4Error Surg: "..tostring(err))
   end

   return handled
end

AddHook("onvarlist", "as_main", surg)

AddHook("OnRender", "queue_executor", function()
    if #queue.task > 0 then
        local task = queue.task[1]

        if getCurrentTimeInternal() >= task.runAt then
            table.remove(queue.task, 1)

            local success, err = pcall(task.fn, table.unpack(task.args))
            if not success then
                logToConsole("`4Queue Error: "..tostring(err))
            end

            lastTool = ""
        end
    end
end)
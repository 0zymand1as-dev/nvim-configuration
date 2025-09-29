-- lua/plugins/notify.lua
return {
  "rcarriga/nvim-notify",
  opts = {
    stages = "slide",
    -- Set the duration of notifications to 1.5 seconds
    timeout = 1500,
    -- You can uncomment the line below to make notifications less transparent
    -- background_colour = "#000000",
  },
}
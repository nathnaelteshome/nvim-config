return {
  -- add night-owl
  {
    "oxfist/night-owl.nvim",

    config = function()
      local night_owl = require("night-owl")
      night_owl.setup({
        italics = false,
        transparent_background = true,
      })
    end,
  },
  -- Configure LazyVim to load night-owl
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "night-owl",
      italic = false,
      transparent_background = true,
      tranparent_background_value = 0,
    },
  },
}

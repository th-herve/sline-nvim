---@diagnostic disable: undefined-global
--  _  _  ____  _____  _  _  ____  __  __
-- ( \( )( ___)(  _  )( \/ )(_  _)(  \/  )
--  )  (  )__)  )(_)(  \  /  _)(_  )    (
-- (_)\_)(____)(_____)  \/  (____)(_/\/\_)

-- +-------------------------------+
-- |       General settings        |
-- +-------------------------------+

-- +-------------------------------+
-- |     Lazy.nvim installation    |
-- +-------------------------------+

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- +-------------------------------+
-- |        Plugins config         |
-- +-------------------------------+

require("lazy").setup({
  {
    dir = "~/programming/project/sline-nvim/",   -- Your path
    name = "sline",
    dependencies = { "nvim-tree/nvim-web-devicons", "tpope/vim-fugitive" },
    opts = {
      depth = 300,
      status_line = false,
    }
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
})

require("telescope").setup()

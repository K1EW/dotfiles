return {
	"akinsho/bufferline.nvim",
	event = "BufWinEnter",
	config = function()
		require("bufferline").setup({
			options = {
				diagnostics = "nvim_lsp",
				sort_by = "insert_at_end",
			},
		})
		vim.keymap.set("n", "<S-L>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "<S-H>", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })
	end,
}

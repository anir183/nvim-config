--[[ making custom commands ]]

local cmd = function(cmd_name, ...)
	vim.api.nvim_create_user_command(CONFIG.cmd_pre .. cmd_name, ...)
end
local isnum = function(str)
	return str:match("^%-?%d+$")
end

-- edit options
cmd("EditOptions", function()
	local ui = vim.api.nvim_list_uis()[1]
	local width = math.floor((ui.width * 0.7) + 0.5)
	local height = math.floor((ui.height * 0.75) + 0.5)

	vim.api.nvim_open_win(vim.api.nvim_create_buf(false, true), true, {
		relative = "editor",
		width = width,
		height = height,
		col = (ui.width - width) / 2,
		row = (ui.height - height) / 2,
		focusable = true,
		border = "rounded",
	})

	local opts_path = vim.fn.stdpath("config") .. "/lua/config.lua"
	local opts_file = io.open(opts_path, "r")

	if opts_file == nil then
		local def_opts_path = vim.fn.stdpath("config") .. "/lua/defaults.lua"
		local def_opts_file = io.open(def_opts_path, "r")

		if not def_opts_file then
			vim.notify("Default Options file not found. Creating empty!")
			return
		end

		local def_opts_content = def_opts_file:read("*a")
		def_opts_file:close()

		opts_file:close()
		opts_file = io.open(opts_path, "w")
		opts_file:write(def_opts_content)
	end

	opts_file:close()
	vim.cmd("e " .. opts_path)

	NMAP("q", vim.cmd.wq, {
		buffer = true,
		desc = "[custom]: close the config popup",
	})
end, { desc = "[custom]: edit configurations" })

-- change indentation style
cmd("ChangeIndent", function()
	vim.ui.select({
		"tabs",
		"spaces",
	}, {
		prompt = "indentation type: ",
	}, function(indent_type)
		vim.ui.select({
			"yes",
			"no",
		}, {
			prompt = "reindent: ",
		}, function(reindent)
			local tab_len = vim.opt.tabstop._value
			vim.ui.input({
				prompt = "tab length: ",
			}, function(tl)
				if tl and isnum(tl) then
					tab_len = tonumber(tl)
				end

				-- check parameters
				reindent = (reindent == "yes")
				if not indent_type then
					return
				end

				-- change indents to tabs which are easier to work with for reindenting
				if reindent then
					vim.opt.expandtab = false

					-- NOTE : retab command also replaces inline spaces, so we use a
					--        substituion command instead
					vim.cmd(
						"silent! %s/\\(^\\s*\\)\\@<="
							.. (" "):rep(vim.opt.tabstop._value)
							.. "/	/g"
					)
				end

				-- setting options
				vim.opt.expandtab = (indent_type == "spaces")
				vim.opt.tabstop = tab_len

				-- change indents to spaces if the user selected the same
				-- NOTE : at this point all indentation is already in tabs
				if indent_type == "spaces" and reindent then
					vim.cmd(
						"silent! %s/\\(^\\s*\\)\\@<=	/"
							.. (" "):rep(tab_len)
							.. "/g"
					)
				end
				vim.opt.listchars:append({
					leadmultispace = "▎" .. ("∙"):rep(tab_len - 1),
				})
			end)
		end)
	end)
end, { desc = "[custom]: change indentation style without reindenting" })

-- substitute standalone words or substrings
cmd("SubstituteWord", function()
	vim.ui.input({
		prompt = "target: ",
	}, function(target)
		-- check if target is entered
		if not target then
			return
		end

		-- get substitute
		vim.ui.input({
			prompt = "substitute: ",
		}, function(substitute)
			substitute = substitute or ""

			-- to replace substring occurences or not
			vim.ui.select({
				"yes",
				"no",
			}, {
				prompt = "substitute substring occurences: ",
			}, function(replace_substrings)
				replace_substrings = (replace_substrings == "yes")

				-- replace
				vim.api.nvim_feedkeys(
					vim.api.nvim_replace_termcodes(
						":%s/"
							.. (replace_substrings and "" or "\\<")
							.. target
							.. (replace_substrings and "/" or "\\>/")
							.. substitute
							.. "/gI",
						true,
						true,
						true
					),
					"n",
					false
				)
			end)
		end)
	end)
end, { desc = "[custom]: substitute a string (even non-standalone)" })

--[[
Utility functions for Neovim
---------------------------
This module provides utility functions for common operations in Neovim.

Usage:
1. Copy file path with line number:
   - Press Y in normal mode
   - If in a git repository:
     * Copies the web URL (e.g., https://github.com/user/repo/blob/main/file.lua#L42)
     * Supports various Git platforms (GitHub, GitLab, Enterprise Git, etc.)
   - If not in a git repository:
     * Copies the relative path with line number (e.g., src/file.lua:42)
     * Falls back to absolute path if relative path is not available
--]]

local M = {}

-- Convert SSH git URL to HTTPS URL
-- @param url string: The SSH URL to convert (e.g., git@github.com:user/repo)
-- @return string|nil: The HTTPS URL if conversion successful, nil otherwise
-- Examples:
-- * git@github.com:user/repo.git -> https://github.com/user/repo
-- * git@gitlab.com:user/repo -> https://gitlab.com/user/repo
local function convert_git_url(url)
    -- Remove trailing .git if present
    url = url:gsub('%.git$', '')

    -- Convert SSH URL to HTTPS URL
    -- Match pattern: git@host:org/repo or git@host/org/repo
    local host, path = url:match('git@([^:]+)[:/](.+)')
    if host and path then
        return string.format('https://%s/%s', host, path)
    end

    -- If already HTTPS, return as is
    if url:match('^https://') then
        return url
    end

    return nil
end

-- Get repository URL for current file
-- @return string|nil: The full repository URL for the current file, nil if not in a git repo
-- The URL format: https://host/org/repo/blob/branch/path/to/file
local function get_repo_url()
    -- Get git root directory
    local git_root = vim.fn.system('git rev-parse --show-toplevel 2>/dev/null'):gsub('\n', '')
    if git_root == '' then
        return nil
    end

    -- Get relative path from git root
    local file_path = vim.fn.expand('%:p')
    local relative_path = file_path:sub(#git_root + 2)  -- +2 to skip the trailing slash

    -- Get remote URL
    local remote_url = vim.fn.system('git config --get remote.origin.url'):gsub('\n', '')
    if remote_url == '' then
        return nil
    end

    -- Convert URL to HTTPS format
    local https_url = convert_git_url(remote_url)
    if not https_url then
        return nil
    end

    -- Get default branch (usually main or master)
    local default_branch = vim.fn.system('git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null'):gsub('\n', '')
    default_branch = default_branch:gsub('refs/remotes/origin/', '')
    if default_branch == '' then
        default_branch = 'main'  -- fallback to main
    end

    -- Construct repository URL
    return string.format('%s/blob/%s/%s', https_url, default_branch, relative_path)
end

-- Copy current file path with line number
-- This function is mapped to <leader>Y in normal mode
-- It will:
-- 1. Try to get the repository URL if in a git repository
-- 2. Fall back to relative path if not in a git repository
-- 3. Fall back to absolute path if relative path is not available
-- 4. Always append the current line number
M.copy_path_with_line = function()
    -- Try to get repository URL
    local repo_url = get_repo_url()
    
    if repo_url then
        -- Get current line number
        local line_nr = vim.fn.line('.')
        -- Format repository URL with line number
        local result = repo_url .. '#L' .. line_nr
        
        -- Copy to clipboard
        vim.fn.setreg('+', result)
        vim.notify('Copied repository URL: ' .. result)
    else
        -- Fallback to relative path with line number
        local file_path = vim.fn.expand('%:.')  -- :. gives path relative to current working directory
        if file_path == '' then
            file_path = vim.fn.expand('%:p')  -- fallback to absolute path if relative is not available
        end
        local line_nr = vim.fn.line('.')
        local result = file_path .. ':' .. line_nr
        
        -- Copy to clipboard
        vim.fn.setreg('+', result)
        vim.notify('Copied relative path: ' .. result)
    end
end

return M

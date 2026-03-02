# modules/mnw.nix
{
  inputs,
  pkgs,
  mnw,
  self,
}:

{
  mnw = mnw.lib.wrap pkgs {
    neovim = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;

    luaFiles = [ ./nvim/init.lua ];

    extraBinPath = with pkgs; [
      ripgrep
      fzf
      nodejs_24

      # LSP:
      lua-language-server
      nixd
      bash-language-server
      shellcheck
      beautysh
      vscode-css-languageserver
      markdownlint-cli2
      gdtoolkit_4
      roslyn-ls
      svelte-language-server
      vscode-langservers-extracted

      # Formatters:
      stylua
      nixfmt
      prettier
      prettierd
      csharpier
    ];

    # Along with listing the package here, each plugin should also be
    # defined through lua as per the Lazy.nvim spec
    #
    # Note: Plugins with dependencies should have their dependencies defined individually
    #       Both as a pkg in the list below, AND in a .lua file as per the Lazy.nvim spec
    #       (A plugin that is only listed as a dependency using the { dependencies } attribute
    #       will make nmw throw errors if is it not sourced individually.)
    plugins = {
      start = [
        pkgs.vimPlugins.lazy-nvim
        pkgs.vimPlugins.nvim-treesitter.withAllGrammars
      ];

      # Anything that is loaded by Lazy.nvim needs to be in opt
      # use 'lazy = false' in the lazy spec to not lazy-load any plugins
      # that are configured through Lazy.nvim
      opt = [
        pkgs.vimPlugins.plenary-nvim
        pkgs.vimPlugins.oil-nvim
        pkgs.vimPlugins.snacks-nvim
        pkgs.vimPlugins.lualine-nvim
        pkgs.vimPlugins.nvim-web-devicons
        pkgs.vimPlugins.friendly-snippets
        pkgs.vimPlugins.bufferline-nvim # dep: nvim-web-devicons
        pkgs.vimPlugins.nvim-lint
        pkgs.vimPlugins.nvim-lspconfig
        pkgs.vimPlugins.nvim-treesitter-textobjects
        pkgs.vimPlugins.nvim-ts-autotag
        pkgs.vimPlugins.nvim-ts-context-commentstring
        pkgs.vimPlugins.nvim-notify
        pkgs.vimPlugins.neogen

        {
          pname = "harpoon-lualine";

          src = pkgs.fetchFromGitHub {
            owner = "letieu";
            repo = "harpoon-lualine";
            rev = "215c0847dfb787b19268f7b42eed83bdcf06b966";
            hash = "sha256-HGbz/b2AVl8145BCy8I47dDrhBVMSQQIr+mWbOrmj5Q=";
          };

        }

        {
          pname = "hatch.nvim";

          src = pkgs.fetchFromGitHub {
            owner = "codevogel";
            repo = "hatch.nvim";
            rev = "a31a5b7da16312bc41abdb87231bd5b225925700";
            hash = "sha256-+Xnar472jLYuolOHCoQRGTWV0lhd1seqK6dmoQC0AtE=";
          };

        }
      ];

      # We can use optAttrs to rename plugins to their expected name
      # as defined by the lua files
      optAttrs = {
        "harpoon" = pkgs.vimPlugins.harpoon2;
        "blink.cmp" = pkgs.vimPlugins.blink-cmp;
        "conform.nvim" = pkgs.vimPlugins.conform-nvim;
        "kanagawa.nvim" = pkgs.vimPlugins.kanagawa-nvim;
        "lazydev.nvim" = pkgs.vimPlugins.lazydev-nvim;
        "mini.ai" = pkgs.vimPlugins.mini-ai;
        "mini.comment" = pkgs.vimPlugins.mini-comment;
        "mini.icons" = pkgs.vimPlugins.mini-icons;
        "noice.nvim" = pkgs.vimPlugins.noice-nvim; # deps: nui-nvim nvim-notify
        "persistence.nvim" = pkgs.vimPlugins.persistence-nvim;
        "todo-comments.nvim" = pkgs.vimPlugins.todo-comments-nvim;
        "ts-comments.nvim" = pkgs.vimPlugins.ts-comments-nvim;
        "which-key.nvim" = pkgs.vimPlugins.which-key-nvim;
        "gitsigns.nvim" = pkgs.vimPlugins.gitsigns-nvim;
        "nui.nvim" = pkgs.vimPlugins.nui-nvim;
        "fidget.nvim" = pkgs.vimPlugins.fidget-nvim;
        "roslyn.nvim" = pkgs.vimPlugins.roslyn-nvim;
        "nvim-colorizer.lua" = pkgs.vimPlugins.colorizer;
        "LuaSnip" = pkgs.vimPlugins.luasnip;
        "gdscript-extended-lsp.nvim" = pkgs.vimPlugins.gdscript-extended-lsp-nvim;
        "copilot.vim" = pkgs.vimPlugins.copilot-vim;
      };

      dev.codevogel = {
        pure = ./nvim;
        impure = "~/nixos/modules/shared/mnw/nvim";
      };
    };
  };

  dev = self.packages.x86_64-linux.mnw.devMode;
}

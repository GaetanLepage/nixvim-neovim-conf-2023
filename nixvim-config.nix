{
  colorschemes.onedark.enable = true;

  plugins = {
    alpha = {
      enable = true;
      layout = [
        {
          type = "padding";
          val = 10;
        }
        {
          opts = {
            hl = "Type";
            position = "center";
          };
          type = "text";
          val = [
            "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ██████╗ ██████╗ ███╗   ██╗███████╗ "
            "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║██╔════╝██╔═══██╗████╗  ██║██╔════╝ "
            "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║██║     ██║   ██║██╔██╗ ██║█████╗   "
            "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║██║     ██║   ██║██║╚██╗██║██╔══╝   "
            "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║╚██████╗╚██████╔╝██║ ╚████║██║      "
            "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝      "
            "                                                                                        "
            "  ██████╗  ██████╗ ██████╗ ██████╗                                                      "
            "  ╚════██╗██╔═████╗╚════██╗╚════██╗                                                     "
            "   █████╔╝██║██╔██║ █████╔╝ █████╔╝                                                     "
            "  ██╔═══╝ ████╔╝██║██╔═══╝  ╚═══██╗                                                     "
            "  ███████╗╚██████╔╝███████╗██████╔╝                                                     "
            "  ╚══════╝ ╚═════╝ ╚══════╝╚═════╝                                                      "
          ];
        }
        {
          type = "padding";
          val = 2;
        }
        {
          opts = {
            hl = "Keyword";
            position = "center";
          };
          type = "text";
          val = "Powered by Nixvim";
        }
        {
          type = "padding";
          val = 4;
        }
        {
          type = "group";
          val = [
            {
              command = "<CMD>ene <CR>";
              desc = "  New file";
              shortcut = "e";
            }
            {
              command = ":qa<CR>";
              desc = "  Quit Neovim";
              shortcut = "SPC q";
            }
          ];
        }
      ];
    };
  };
}

{ ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name = "ctes091x";
      user.email = "ctes091x@ctes091x.net";
      pull.rebase = false;
      init.defaultBranch = "main";
      credential.helper = "!gh auth git-credential";
    };
  };
}

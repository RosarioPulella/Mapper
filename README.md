This project is a campus mapping thing.

# Dev
This project uses nix to provide a reproducible development environment.
Go to <https://nixos.org/> to see how you can get nix.

To enter a development shell run `nix-shell` in the working directory.

## niv
[niv](https://github.com/nmattia/niv) is used to update nix sources in the repo.

Use `niv update` to update all sources.

## obelisk
This project uses [obelisk](https://github.com/obsidiansystems/obelisk) check it out for dev tools and patterns.

## Language server
The `shell.nix` provides [rnix-lsp](https://github.com/nix-community/rnix-lsp) a nix language server.
In your editor of choice you can make use of this language server.

For vscode open the project with `nix-shell --run 'code .` or use Nix Environment Selector.

Checkout [rnix-lsp's README.md](https://github.com/nix-community/rnix-lsp#integrate-with-your-editor) for how to integrate with your editor.



[TODO](TODO.md)
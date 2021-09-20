# TODO

## Provide more default development tools
While I have the goal of making as easy as possible to contribute/build/test on any platform with as minimal tools available as possible. I want to provide a **total** set of default tools and configuration that would be useful to as many contributors as possible. That means not only making it easy for the contributor to get and use the right versions of the low-level tools like compilers, but also making it easy for them to get helpful high-level tools like editors.

### Edit
Provide pre configured editor (prob vscode/codium) with out making it harder to get the other tools.

### HLS
All the "serious" building/running/testing needs should be done in the ob infra, and its being on nixpkgs and ghc so I cant really setup hls on the same infra. 

Provide a separate infrastructure for analyzing/building/testing the code with hls on newer nixpkgs and ghc, for a quicker less official feedback cycle.

# Other TODO files

[backend](backend/TODO)
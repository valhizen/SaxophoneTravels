{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    glfw
    pkg-config
    clang
    bear
    lldb
  ];

  shellHook = ''
    echo "Welcome to the development shell!"
    alias r=./build/main
  '';
}

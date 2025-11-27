{
  lib,
  stdenv,
  cmake,
  pkg-config,
  aquamarine,
  cairo,
  hyprgraphics,
  hyprlang,
  hyprtoolkit,
  hyprutils,
  libdrm,
  pixman,
  libxkbcommon,
  version ? "0",
}:
let
  inherit (lib.sources) cleanSource cleanSourceWith;
  inherit (lib.strings) hasSuffix;
in
stdenv.mkDerivation {
  pname = "hyprland-guiutils";
  inherit version;

  src = cleanSourceWith {
    filter =
      name: _type:
      let
        baseName = baseNameOf (toString name);
      in
      !(hasSuffix ".nix" baseName);
    src = cleanSource ../.;
  };

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  buildInputs = [
    aquamarine
    cairo
    hyprgraphics
    hyprlang
    hyprtoolkit
    hyprutils
    libdrm
    pixman
  ];

  meta = {
    description = "Hyprland GUI utilities (successor to hyprland-guiutils)";
    homepage = "https://github.com/hyprwm/hyprland-qtlibs";
    license = lib.licenses.bsd3;
    maintainers = [ lib.maintainers.fufexan ];
    platforms = lib.platforms.linux;
  };
}

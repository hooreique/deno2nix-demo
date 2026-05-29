{ deno2nix, lib }:
deno2nix.lib.buildDenoPackage {
  pname = "deno2nix-demo";
  version = "0.1.0";
  src = ./.;
  binaryEntrypointPath = "main.ts";

  denoDeps = deno2nix.lib.fetchDenoDeps {
    denoLock = ./deno.lock;
    hash = "sha256-xl4t8Yn7T7FmSXvq9ODahdLFA8vzdiHk5f9q2oGJaEU=";
  };

  denortPackage = deno2nix.packages.denort.overrideAttrs (_: {
    doInstallCheck = false;
  });

  checkPhase = ''
    runHook preCheck
    deno test --frozen --cached-only
    runHook postCheck
  '';

  installPhase = ''
    runHook preInstall
    install -Dm755 "$name" "$out/bin/$pname"
    runHook postInstall
  '';

  meta = {
    mainProgram = "deno2nix-demo";
    description = "deno2nix demo";
    homepage = "https://github.com/hooreique/deno2nix-demo";
    license = lib.licenses.mit;
  };
}

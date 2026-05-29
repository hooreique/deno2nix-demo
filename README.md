# deno2nix demo

This is a practical scaffold for packaging a Deno program with Nix.

It is for people who know Deno, but are new to Nix.
You can use it as a quick reference when you want to package a Deno app.

## What This Repo Shows

This repo is small enough to read quickly.
But it still uses real Nix project pieces:

- a [Nix flake](https://nix.dev/concepts/flakes.html)
- [flake-parts](https://flake.parts/)
- [deno2nix](https://github.com/aMOPel/deno2nix)
- a Deno lock file used in the Nix build
- a dev shell
- a package build
- a runnable CLI

## Why `deno.lock` Matters

Nix packaging cares a lot about reproducible builds.
The same inputs should build the same result later.
They should also build the same result on another machine.

For a Deno app, `deno.lock` records the exact Deno dependencies.
So when we package a Deno app with Nix, `deno.lock` is an important build input.

Nixpkgs does not have an official helper for Deno lock files yet.
This repo uses [aMOPel/deno2nix](https://github.com/aMOPel/deno2nix) for that part.

In this repo, `deno2nix` fetches the dependencies from `deno.lock`.
Then the build runs tests with `deno test --frozen --cached-only`.
This checks that the build only uses locked and cached dependencies.

## Requirements

You need Nix with these experimental features enabled:

```nix
experimental-features = nix-command flakes
```

> [!TIP]
> [Determinate Nix](https://determinate.systems/nix-installer/) is convenient because flakes work out of the box.

## Commands

```sh
nix develop --command -- deno task dev
```

Run a command inside the dev shell from this flake.
You do not need to install Deno by hand.
Nix provides Deno in the dev shell.

```sh
nix develop --command -- nvim
```

Run your editor inside the same dev shell.
This is useful when you want your editor to see tools from the dev shell.

```sh
nix build
```

Build the default package from this flake.
In this repo, `package.nix` uses `buildDenoPackage` to package the Deno program.

```sh
nix run . -- --help
```

Build and run the default package with arguments.
This is a quick way to check that the packaged CLI works with `--help`.

## Learn More

If you want to understand the Nix parts, start here:

- [Nix flakes](https://nix.dev/concepts/flakes.html): the project entry point, inputs, outputs, and lock file
- [flake-parts](https://flake.parts/): a structured way to write larger flakes

## Goal

The goal of this repo is to be a quick scaffold.
It shows the basic files needed to package a Deno program with Nix.

Start from `flake.nix`, `package.nix`, and `deno.lock`.
Then change them for your own Deno project.

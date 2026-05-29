import { parseArgs } from "@std/cli";

export const run = (args: readonly string[]): string => {
  const parsed = parseArgs(args, {
    boolean: ["help", "version"],
  });

  if (parsed.version) {
    return "0.1.0";
  }

  if (parsed.help) {
    return `deno2nix-demo

Usage:
  deno2nix-demo [--help] [--version]

Options:
  --help     Show this help message
  --version  Print version`;
  }

  return "hello deno2nix";
};

if (import.meta.main) {
  console.log(run(Deno.args));
}

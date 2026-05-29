import { assertEquals } from "@std/assert";
import { run } from "./main.ts";

Deno.test("prints greeting without args", () => {
  assertEquals(run([]), "hello deno2nix");
});

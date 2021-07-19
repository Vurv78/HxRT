# ``HxRT``
Raytracer in Haxe. Heavily based on [RaytracingInOneWeekend](https://raytracing.github.io/books/RayTracingInOneWeekend.html). I didn't get very far with it and modified a decent amount to make it able to interop with lua & to tinker with Haxe concepts.

## Supported Targets
1. C++
2. StarfallEx Lua (Using SFHaxe)

Other targets like C#/JVM/Hashlink probably *would* work too but I haven't tested them & I ended up using a lot of ``#if cpp`` rather than ``#if !lua`` in the code.
# C++
Compilation of C++ knowledge.

## Requirements
- **Compiler**: GCC (predominant) / Clang (TBC)
- **Build System**: CMake, Ninja
- **Tools**: ccache, clang-format, clang-tidy

## Quick Start
- Configuration of cmake
```bash
cmake --preset ddbg
```

- Build
```bash
cmake --build --preset ddbg
```

## Build Presets

| Preset  | Standard | Sanitizers | clang-tidy | Use Case                 |
|---------|----------|------------|------------|--------------------------|
| `ddbg`  | C++20    | ON         | OFF        | Day-to-day development   |
| `drel`  | C++20    | OFF        | OFF        | Benchmarking / profiling |
| `dtidy` | C++20    | ON         | ON         | Static analysis pass     |
| `cpp23` | C++23    | ON         | OFF        | Personal/experimental    |

## Adding New Projects
1. Create a new folder within `projects`
1. Add a `CMakeLists.txt` within the directory
1. Add `add_subdirectory(project_name)` to `projects/CMakeLists.txt`

## Code Style
Formatting is enforced via `.clang-format`, run:

```bash
find projects/ -name '*.cpp' -o name '*.hpp' | xargs clang-format 1
```

## References

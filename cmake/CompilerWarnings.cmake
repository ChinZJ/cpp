# Module defines a reusable function to apply warnings to any target.

function(set_project_warnings target_name)
    set(GCC_CLANG_WARNINGS
        -Wall
        -Wextra                  # Reasonable and standard
        -Wpedantic               # Enforce ISO C++ (Turner Ch. 5)
        -Wshadow                 # Warn if variable shadows another
        -Wnon-virtual-dtor       # Warn if class with virtual funcs has non-virtual dtor
        -Wold-style-cast         # Warn on C-style casts — use C++ casts instead
        -Wcast-align             # Warn on potential alignment issues
        -Wunused                 # Warn on anything unused
        -Woverloaded-virtual     # Warn if you overload (not override) a virtual function
        -Wconversion             # Warn on type conversions that may lose data
        -Wsign-conversion        # Warn on signed/unsigned conversion
        -Wnull-dereference       # Warn if null dereference detected
        -Wdouble-promotion       # Warn if float is implicitly promoted to double
        -Wformat=2               # Warn on format string issues
        -Wimplicit-fallthrough   # Warn on switch case fallthrough without [[fallthrough]]
        -Wmisleading-indentation # Warn on misleading indentation
    )

    # GCC-specific warnings
    set(GCC_ONLY_WARNINGS
        -Wduplicated-cond        # Warn if if/else has duplicated conditions
        -Wduplicated-branches    # Warn if if/else branches have same body
        -Wlogical-op             # Warn on suspicious uses of logical operators
        -Wuseless-cast           # Warn on unnecessary casts
        -Wsuggest-override       # Suggest override keyword (C++11)
    )

    if(CMAKE_CXX_COMPILER_ID MATCHES "GNU")
        target_compile_options(${target_name} PRIVATE
            ${GCC_CLANG_WARNINGS}
            ${GCC_ONLY_WARNINGS}
        )
    elseif(CMAKE_CXX_COMPILER_ID MATCHES "Clang")
        target_compile_options(${target_name} PRIVATE
            ${GCC_CLANG_WARNINGS}
        )
    endif()

    # Treat warnings as errors in Release builds to enforce discipline
    if(CMAKE_BUILD_TYPE STREQUAL "Release")
        target_compile_options(${target_name} PRIVATE -Werror)
    endif()
endfunction()

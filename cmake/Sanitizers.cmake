# Module defines a function to enable sanitizers on any target.

function(enable_sanitizers target_name)
    if(NOT ENABLE_SANITIZERS)
        return()
    endif()

    if(CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
        # Address Sanitizer (ASan): detects out-of-bounds, use-after-free, etc.
        # Undefined Behavior Sanitizer (UBSan): detects signed overflow, null deref, etc.
        target_compile_options(${target_name} PRIVATE
            -fsanitize=address,undefined
            -fno-omit-frame-pointer  # Better stack traces
        )
        target_link_options(${target_name} PRIVATE
            -fsanitize=address,undefined
        )
    endif()
endfunction()

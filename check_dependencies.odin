package nucker

import "core:fmt"
import  os "core:os/os2"

check_dependencies :: proc() ->(err: os.Error) {
    r, w := os.pipe() or_return
    defer os.close(r)

    p: os.Process; {
        defer os.close(w)

        p = os.process_start({
            command = { "command", "-v", "sssss" },
            stdout  = w,
        }) or_return
    }

    output := os.read_entire_file(r, context.temp_allocator) or_return

    _ = os.process_wait(p) or_return

    fmt.print(string(output))
    return
}
package cmd


import "core:fmt"
import  os "core:os/os2"
import "core:strings"

exec :: proc(commands: []string) ->(string, os.Error) {
    r, w , err := os.pipe()
    if err != nil{
        return "", err
    }
    defer os.close(r)
    p: os.Process; {
        defer os.close(w)

        p, err = os.process_start({
            command = commands,
            stdout  = w,
            env = nil
        })
        if err != nil{
            return "", err
        }
    }
    output:[]byte
    output, err = os.read_entire_file(r, context.temp_allocator)
    if err != nil{
        return "", err
    }
    return string(output), nil
}

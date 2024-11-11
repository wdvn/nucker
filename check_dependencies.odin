package nucker

import "core:fmt"
import  os "core:os/os2"
import "core:strings"

check_dependencies :: proc() ->(err: os.Error) {
    _ = exec({ "echo", "-v" }) or_return
    return
}

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

//TODO: check & store hash
install_dependencies :: proc(pkg:string) {
    if !os.is_dir("./vendor"){
        os.make_directory("./vendor")
    }
    fmt.printfln("Loading ", pkg)
    package_name := strings.trim_prefix(pkg, "https://")
    _, err := exec({ "git", "clone", pkg , strings.concatenate({ "./vendor/", package_name }) })
    if err != nil{
        panic(strings.concatenate({ "imhere", os.error_string(err) }))
    }
}

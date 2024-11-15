package nucker

import "core:encoding/json"
import "core:fmt"
import "core:os"

Module :: struct{
    repo: string,
    version: string
}

Nucker :: struct{
    package_name: string,
    author: string,
    version: string,
    replaces: []string,
    modules: []Module
}

all:Nucker

main :: proc() {
    all = new(Nucker)^
    // Kiểm tra tham số đầu vào
    if len(os.args) < 2 {
        show_help()
        return
    }

    // Lấy tham số đầu tiên làm lệnh
    command := os.args[1]

    switch command {
    case "init":
        init_project()
    case "get":
        if len(os.args) < 3 {
            show_help()
            return
        }
    case "update":
        update_dependencies()
    case "help", "-h", "--help":
        show_help()
    case:
        show_help()
    }
}

init_project :: proc() {
    if len(os.args) < 3 {
        show_help()
        return
    }
    if os.is_file("./nucker.json"){
        panic("Module already exist")
    }
    all.package_name = os.args[2]
    data, err := json.marshal(all, { pretty = true })
    if err != nil{
        fmt.panicf("%v", err)
    }

    os.write_entire_file("./nucker.json", data, true)

}


update_dependencies :: proc() {
    fmt.println("update")
}

show_help :: proc() {
    fmt.println(`
    nucker  The command manage package for Odin
    init    <name>    create work space
    get               install a package to vendor
    update            update a package
    rm/remove         remove a package
    list              list all installed package
    `)
}

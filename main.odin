package nucker

import "core:fmt"
import "core:os"

main :: proc() {
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
        install_dependencies()
    case "update":
        update_dependencies()
    case "help", "-h", "--help":
        show_help()
    case:
        show_help()
    }
}

init_project :: proc() {
    fmt.println("init")
}

install_dependencies :: proc() {
    fmt.println("get")
}

update_dependencies :: proc() {
    fmt.println("update")

}

show_help :: proc() {
    fmt.println(`
    nucker  The command manage package for Odin
    init        create work space
    get         install a package to vendor
    update      update a package
    rm/remove   remove a package
    list        list all installed package
    `)
}

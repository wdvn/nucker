package nucker
import "core:os"
check_dependencies::proc(){
    //TODO: check window later
    result, err := os.ex("command -v git")

    if err != nil {
        return false
    }
    fmt.printfln(result)
}
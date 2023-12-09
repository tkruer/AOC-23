import Foundation

func main() {
    do {
    let path = Bundle.main.path(forResource: "input", ofType: "txt") // file path for file "data.txt"
    let string = try! String(contentsOfFile: path!, encoding: String.Encoding.utf8)
    print(string)
    } catch {

    }
}


main()

import Foundation

import SQLite

struct Joke {
    let id: Int
    let name: String
    let isFav: Int
    let jokeID: Int
    let categoryName: String
}

class DatabaseManager {
    static let shared = DatabaseManager()

    private var db: Connection?

    private let usersTable = Table("Favourite")
    private var Id = Expression<Int>("Id")
    private let Breed = Expression<String>("Breed")
    private var ImageUrl = Expression<String>("ImageUrl")
    private init() {
        copyDatabaseIfNeeded()
        openDatabase()
    }

    private func copyDatabaseIfNeeded() {
        let fileManager = FileManager.default
        let bundlePath = Bundle.main.path(forResource: "DogBreed", ofType: "db")
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let destinationPath = (documentsPath as NSString).appendingPathComponent("DogBreed.db")

        if !fileManager.fileExists(atPath: destinationPath) {
            do {
                try fileManager.copyItem(atPath: bundlePath!, toPath: destinationPath)
                print("Database copied to \(destinationPath)")
            } catch {
                print("Error copying database: \(error)")
            }
        }
    }

    private func openDatabase() {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let databasePath = (documentsPath as NSString).appendingPathComponent("DogBreed.db")

        do {
            db = try Connection(databasePath)
            print("Database opened at \(databasePath)")
        } catch {
            print("Error opening database: \(error)")
        }
    }

    func isFav(_ imgUrl: String) -> Bool  {
        var resultBool = false
        do {
            let query = usersTable.select(Breed).filter(ImageUrl==imgUrl)
                for user in try db!.prepare(query) {
                    resultBool = true
                }
        } catch {
            print("Error fetching user: \(error)")
        }
        return resultBool
        
    }
    
    func filterCategory(_ breedName: String) -> [String]  {
        var resultArr = [String]()
        do {
            let query = usersTable.filter(Breed==breedName)
                for user in try db!.prepare(query) {
                    resultArr.append(try user.get(ImageUrl))
                }
        } catch {
            print("Error fetching user: \(error)")
        }
        return resultArr
        
    }
    
    func getDistictBreed() -> [String] {
        var resultArr = [String]()
        do {
            for user in try db!.prepare(usersTable) {
                resultArr.append(user[ImageUrl])
            }
        } catch {
            print("Select failed")
        }
        return resultArr
    }

    func getfavourite() -> [String] {
        var resultArr = [String]()
        do {
            for user in try db!.prepare(usersTable) {
                resultArr.append(user[ImageUrl])
            }
        } catch {
            print("Select failed")
        }
        return resultArr
    }
    func removeFav(_ imgUrl:String) {
        let user = usersTable.filter(ImageUrl == imgUrl)
        do {
            try db!.run(user.delete())
        } catch {
            print("Delete failed")
        }
    }
    func addFav(name:String,imgUrl:String) {
        let insert = usersTable.insert(self.Breed <- name, self.ImageUrl <- imgUrl)
        do {
            try db!.run(insert)
        } catch {
            print("Insert failed")
        }
    }
    func getUniqueCategory() -> [String] {
        var resultArr = [String]()
        do {
            let query = usersTable.select(distinct: Breed)
                for user in try db!.prepare(query) {
                    resultArr.append(try user.get(Breed))
                }
        } catch {
            print("Error fetching user: \(error)")
        }
        return resultArr
    }
    
}



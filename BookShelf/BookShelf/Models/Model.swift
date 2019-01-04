import UIKit

class Model {
    static let shared = Model()
    private init() {}
    
    let googleBooksAPI = GoogleBooksAPINetworkingClient()
    var bookSearchCVC: BookSearchCollectionViewController?
    var volumes: Volumes?
    var bookshelves: [Bookshelf] = []
    var favoritesBookshelf = Bookshelf.init(name: "Favorites", books: nil)
    var alreadyReadBookshelf = Bookshelf.init(name: "Already Read", books: nil)
    var wantToReadBookshelf = Bookshelf.init(name: "Want to Read", books: nil)
    var wantToBuyBookshelf = Bookshelf.init(name: "Want to Buy", books: nil)
    var reviewsDictionary: [String:String] = [:]
    
    func numberOfVolumes() -> Int {
        return volumes?.items.count ?? 0
    }
    func createBookShelves() {
        bookshelves.append(favoritesBookshelf)
        bookshelves.append(alreadyReadBookshelf)
        bookshelves.append(wantToReadBookshelf)
        bookshelves.append(wantToBuyBookshelf)
        
    }
    func searchForBooks(searchTerm: String, completionHandler: @escaping () -> Void) {
        googleBooksAPI.fetchBooks(searchQuery: searchTerm) { error in
            if let error = error {
                fatalError("Could not fetchBooks in Model.searchForBooks: \(error)")
            }
        }
    }
    func getImage(string: String) -> UIImage {
        let imageURL = string
            guard let url = URL(string: (imageURL)) else {fatalError("Could not turn string into url")}
            guard let imageData = try? Data(contentsOf: url) else {fatalError("Could not turn url into data")}
            guard let image = UIImage(data: imageData) else {fatalError("Could not turn data into image")}
        print(url)
            return image
    }
    func saveReview(bookTitle: String, review: String) {
        reviewsDictionary[bookTitle] = review
    }
    func saveFavorite(favorited: Bool, book: Book, indexPath: IndexPath) {
        if favorited == true {
            favoritesBookshelf.books?.append(book)
        } else {
            favoritesBookshelf.books?.remove(at: indexPath.row)
        }
    }
    func getReview(bookTitle: String) -> String {
        guard let returnValue = reviewsDictionary[bookTitle] else {return ""}
        return returnValue
    }
    func hasRead(book: Book) -> Bool {
        var response = false
        guard let books = alreadyReadBookshelf.books else {return false}
        response = books.contains { (book) -> Bool in
            if book.title == book.title {
                return true
            }
            return false
        }
        return response
    }
    func insertBook(book: Book) -> [Bookshelf] {

    }
    func removeBook(book: Book) -> [Bookshelf] {
        
    }
}

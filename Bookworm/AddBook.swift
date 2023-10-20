//
//  AddBook.swift
//  Bookworm
//
//  Created by Ray Nahimi on 07/10/2023.
//

import SwiftUI

struct AddBook: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private Int16 rating = 3
    @State private var genre = ""
    @State private var review = ""
    
    let date = Date.now
    
    
    
    var hasValidEntries: Bool {
        if author.isEmpty || title.isEmpty || genre.isEmpty || review.isEmpty {
            return false
        }
        return true
    }
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    var body: some View {
        NavigationView {
            Form {
                Section{
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self){
                            Text($0)
                        }
                    }
                }
                Section{
                    TextEditor(text: $review)
                    Rating(rating: $rating)
                    
                } header: {
                    Text("Write a review")
                }
                Section{
                    Button("Save"){
                        let newBook = Book(context: moc)
                        newBook.id = UUID()
                        newBook.title = title
                        newBook.author = author
                        newBook.rating = rating
                        newBook.genre = genre
                        newBook.review = review
                        newBook.date = date
                        
                        try? moc.save()
                        dismiss()
                    }
                    .disabled(hasValidEntries == false)
                }
            }
            .navigationTitle("Add Book")
        }
    }
}

struct AddBook_Previews: PreviewProvider {
    static var previews: some View {
        AddBook()
    }
}

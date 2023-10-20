//
//  ContentView.swift
//  Bookworm
//
//  Created by Ray Nahimi on 07/10/2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title),
        SortDescriptor(\.author)
    ]) var books: FetchedResults<Book>
    
    @State private var showingAddScreen = false
    
    /*var isLowRate: Bool {
        if books.rating(Int16) == 1 {
            return false
        }
        return true
    }*/
    
    let dateFormatter = DateFormatter()
    
    init(){
        // Set Date Format
        dateFormatter.dateFormat = "YY/MM/dd"
    }
    
    var body: some View {
        NavigationView{
            List{
                ForEach(books) { book in
                    NavigationLink{
                        DetailView(book: book)
                    } label: {
                        HStack {
                            Emoji(rating: book.rating)
                                .font(.largeTitle)
                            VStack(alignment: .leading){
                                Text(book.title ?? "Unknown Title")
                                    .font(.headline)
                                
                                Text(book.author ?? "Unknown Author")
                                    .foregroundColor(.secondary)
                                
                                Text(dateFormatter.string(from: book?.date) ?? "Unknown Date")
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationTitle("Bookworm")
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddScreen.toggle()
                    } label: {
                        Label("Add Book", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                    AddBook()
            }
        }
    }
    func deleteBooks(at offsets: IndexSet){
        for offset in offsets {
            let book = books[offset]
            moc.delete(book)
        }
        
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

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
    ])
    
    var books: FetchedResults<Book>
    
    @State private var showingAddScreen = false
    
    
    
    
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
                                    .foregroundColor(book.backgroundColour)
                                
                                Text(book.author ?? "Unknown Author")
                                    .foregroundColor(.secondary)
                                
                                //Text(dateFormatter.string(from: book.date) ?? "?")
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

extension Book {
    var backgroundColour: Color {
        return rating == 1 ? Color.red : Color.black
    }
}

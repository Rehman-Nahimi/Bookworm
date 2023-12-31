//
//  DetailView.swift
//  Bookworm
//
//  Created by Ray Nahimi on 16/10/2023.
//

import SwiftUI

struct DetailView: View {
    let book: Book
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss

    @State private var showingDeleteAlert = false
    
    var isLowRate: Bool {
        if Int(book.rating) == 1 {
            return true
        }
        return false
    }
    
    var backgroundColour: Color {
        return isLowRate ? Color.red : Color.black
    }
    
    var body: some View {
        ScrollView{
            ZStack(alignment: .bottomTrailing){
                Image(book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()
                
                Text(book.genre?.uppercased() ?? "FANTASY")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x: -5, y: -5)
                
            }
            
            Text(book.author ?? "Unknown Author")
                .font(.title)
                .foregroundColor(backgroundColour)
                
            Text(book.review ?? "No review")
                .padding()
            
            Rating(rating: .constant(Int(book.rating)))
                .font(.largeTitle)
            
            if let date = book.date { Text(date,style:.date)
            }
        }
        .navigationTitle(book.title ?? "Unknown book")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete book?", isPresented: $showingDeleteAlert){
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel){}
        } message: {
            Text("Are you sure")
        }
        .toolbar {
            Button {
                showingDeleteAlert = true
            } label: {
                Label("Delete this book", systemImage: "trash")
            }
        }
    }
    func deleteBook() {
        moc.delete(book)
        
        try? moc.save()
        dismiss()
    }
}


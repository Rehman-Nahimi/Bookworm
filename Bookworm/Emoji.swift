//
//  Emoji.swift
//  Bookworm
//
//  Created by Ray Nahimi on 12/10/2023.
//

import SwiftUI

struct Emoji: View {
    let rating: Int16

    var body: some View {
        switch rating {
        case 1:
            return Text ("🫥")
        case 2:
            return Text ("🙃")
        case 3:
            return Text ("😗")
        case 4:
            return Text ("😌")
        default:
            return Text ("🥰")
        }
    }
}

struct Emoji_Previews: PreviewProvider {
    static var previews: some View {
        Emoji(rating: 3)
    }
}

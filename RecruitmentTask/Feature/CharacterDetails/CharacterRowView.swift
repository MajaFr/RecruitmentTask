//
//  CharacterRowView.swift
//  RecruitmentTask
//
//  Created by Maja Frąk on 22/05/2025.
//

import SwiftUI

struct CharacterRowView: View {
    let character: CharacterModel
    
    var body: some View {
        HStack(spacing: .sizeMedium) {
            PersonImageView(imageURL: character.image, cornerRadius: .sizeSmall, size: .imageSizeList, placeholderIcon: Icons.person)
            Text(character.name)
                .font(.headline)
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: .sizeSmall)
                .fill(Color.contrast)
                .shadow(radius: .sizeXSmall)
        )
        .padding(.horizontal)
    }
}

#Preview {
    CharacterRowView(character: CharacterModel.mock)
}

private extension CharacterRowView {
    struct Icons {
        static let person = "person.crop.square.fill"
        static let heart = "heart"
        static let heartFill = "heart.fill"
    }
}

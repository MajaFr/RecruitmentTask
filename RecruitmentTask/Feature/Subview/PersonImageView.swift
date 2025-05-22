//
//  PersonImageView.swift
//  RecruitmentTask
//
//  Created by Maja Frąk on 22/05/2025.
//

import SwiftUI

struct PersonImageView: View {
    
    let imageURL: String?
    let cornerRadius: CGFloat
    let size: CGFloat
    let placeholderIcon: String
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: imageURL ?? "")) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                default:
                    Image(systemName: placeholderIcon)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .frame(width: size, height: size)
        }
    }
}

#Preview {
    PersonImageView(imageURL: CharacterModel.mock.image, cornerRadius: .sizeSmall, size: .imageSizeList, placeholderIcon: "person.circle")
}

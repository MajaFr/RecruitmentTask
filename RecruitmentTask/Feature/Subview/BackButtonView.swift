//
//  BackButtonView.swift
//  RecruitmentTask
//
//  Created by Maja Frąk on 22/05/2025.
//

import SwiftUI

struct BackButtonView: View {
    
    let title: String
    let onBack: () -> Void
    
    var body: some View {
        ZStack {
            Text(title)
                .font(.headline.bold())
                .frame(maxWidth: .infinity, alignment: .center)
            
            HStack {
                Button(action: onBack) {
                    Image(systemName: Icons.arrow)
                        .foregroundColor(.green)
                }
                Spacer()
            }
        }
        .frame(height: .sizeLarge)
    }
}

#Preview {
    BackButtonView(title: "Title") {
        print("Back tapped")
    }
}

private extension BackButtonView {
    struct Icons {
        static let arrow = "arrow.backward.square.fill"
    }
}

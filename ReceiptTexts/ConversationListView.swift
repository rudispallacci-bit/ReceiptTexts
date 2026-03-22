//
//  ConversationListView.swift
//  ReceiptTexts
//
//  Created by Rudi Spallacci on 3/20/26.
//

import SwiftUI

struct Conversation: Identifiable {
    let id = UUID()
    let name: String
    let lastMessage: String
    let date: String
}

struct ConversationListView: View {
    
    let conversations = [
        Conversation(name: "Mom", lastMessage: "Love you! Call me later", date: "Today"),
        Conversation(name: "John Smith", lastMessage: "Are we still on for Friday?", date: "Yesterday"),
        Conversation(name: "Sarah Johnson", lastMessage: "Thanks for everything!", date: "Mon"),
        Conversation(name: "Dad", lastMessage: "Check out this article", date: "Sun"),
        Conversation(name: "Mike", lastMessage: "Game was insane last night", date: "Sat"),
        Conversation(name: "Emma", lastMessage: "Can you send me that recipe?", date: "Fri"),
    ]
    
    var body: some View {
        ZStack {
            Color(hex: "0A0A0A")
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                VStack(spacing: 4) {
                    Text("Conversations")
                        .font(.custom("Didot", size: 32))
                        .foregroundColor(.white)
                        .tracking(1)
                    Text("Select a conversation to export")
                        .font(.system(size: 12, weight: .regular))
                        .tracking(2)
                        .textCase(.uppercase)
                        .foregroundColor(Color(hex: "52B788"))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 24)
                .background(Color(hex: "0A0A0A"))
                
                Divider()
                    .background(Color(hex: "1C1C1C"))
                
                // List
                ScrollView {
                    VStack(spacing: 1) {
                        ForEach(conversations) { conversation in
                            NavigationLink(destination: ConversationDetailView(conversationName: conversation.name)) {
                                HStack(spacing: 16) {
                                    // Avatar
                                    ZStack {
                                        Circle()
                                            .fill(Color(hex: "1B4332"))
                                            .frame(width: 46, height: 46)
                                        Circle()
                                            .strokeBorder(Color(hex: "52B788").opacity(0.4), lineWidth: 1)
                                            .frame(width: 46, height: 46)
                                        Text(String(conversation.name.prefix(1)))
                                            .font(.custom("Didot", size: 18))
                                            .foregroundColor(Color(hex: "52B788"))
                                    }
                                    
                                    // Info
                                    VStack(alignment: .leading, spacing: 4) {
                                        HStack {
                                            Text(conversation.name)
                                                .font(.system(size: 15, weight: .semibold))
                                                .foregroundColor(.white)
                                            Spacer()
                                            Text(conversation.date)
                                                .font(.system(size: 11, weight: .regular))
                                                .tracking(1)
                                                .foregroundColor(Color(hex: "555555"))
                                        }
                                        Text(conversation.lastMessage)
                                            .font(.system(size: 13, weight: .regular))
                                            .foregroundColor(Color(hex: "666666"))
                                            .lineLimit(1)
                                    }
                                    
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 11, weight: .medium))
                                        .foregroundColor(Color(hex: "333333"))
                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 14)
                                .background(Color(hex: "0F0F0F"))
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            Divider()
                                .background(Color(hex: "1A1A1A"))
                                .padding(.leading, 82)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ConversationListView()
}

//
//  ConversationDetailView.swift
//  ReceiptTexts
//
//  Created by Rudi Spallacci on 3/20/26.
//

import SwiftUI
import AppKit
import UniformTypeIdentifiers

struct ChatMessage: Identifiable {
    let id = UUID()
    let text: String
    let isFromMe: Bool
    let time: String
}

struct ConversationDetailView: View {
    let conversationName: String
    @State private var showExportSheet = false
    
    let messages = [
        ChatMessage(text: "Hey! Are you free this weekend?", isFromMe: false, time: "10:00 AM"),
        ChatMessage(text: "Yeah I think so! What's up?", isFromMe: true, time: "10:02 AM"),
        ChatMessage(text: "We should all get together, it's been forever", isFromMe: false, time: "10:03 AM"),
        ChatMessage(text: "100% agreed, I miss everyone", isFromMe: true, time: "10:05 AM"),
        ChatMessage(text: "Saturday work for you?", isFromMe: false, time: "10:05 AM"),
        ChatMessage(text: "Saturday is perfect!", isFromMe: true, time: "10:08 AM"),
        ChatMessage(text: "Amazing! I'll let the others know 🎉", isFromMe: false, time: "10:09 AM"),
    ]
    
    var body: some View {
        ZStack {
            Color(hex: "0A0A0A")
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                VStack(spacing: 4) {
                    Text(conversationName)
                        .font(.custom("Didot", size: 28))
                        .foregroundColor(.white)
                        .tracking(1)
                    Text("\(messages.count) messages")
                        .font(.system(size: 11, weight: .regular))
                        .tracking(2)
                        .textCase(.uppercase)
                        .foregroundColor(Color(hex: "52B788"))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(Color(hex: "0A0A0A"))
                
                Divider()
                    .background(Color(hex: "1C1C1C"))
                
                // Messages
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(messages) { message in
                            HStack {
                                if message.isFromMe { Spacer(minLength: 60) }
                                
                                VStack(alignment: message.isFromMe ? .trailing : .leading, spacing: 4) {
                                    Text(message.text)
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundColor(message.isFromMe ? .black : .white)
                                        .padding(.horizontal, 14)
                                        .padding(.vertical, 10)
                                        .background(
                                            message.isFromMe ?
                                            AnyView(LinearGradient(
                                                colors: [Color(hex: "52B788"), Color(hex: "2D6A4F")],
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )) :
                                            AnyView(Color(hex: "1A1A1A"))
                                        )
                                        .cornerRadius(16)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 16)
                                                .strokeBorder(
                                                    message.isFromMe ? Color.clear : Color(hex: "2C2C2C"),
                                                    lineWidth: 1
                                                )
                                        )
                                    
                                    Text(message.time)
                                        .font(.system(size: 10, weight: .regular))
                                        .tracking(1)
                                        .foregroundColor(Color(hex: "444444"))
                                        .padding(.horizontal, 4)
                                }
                                
                                if !message.isFromMe { Spacer(minLength: 60) }
                            }
                            .padding(.horizontal, 16)
                        }
                    }
                    .padding(.vertical, 20)
                }
                
                Divider()
                    .background(Color(hex: "1C1C1C"))
                
                // Export button
                Button(action: {
                    showExportSheet = true
                }) {
                    HStack(spacing: 10) {
                        Image(systemName: "square.and.arrow.up")
                            .font(.system(size: 13, weight: .semibold))
                        Text("Export Conversation")
                            .font(.system(size: 13, weight: .semibold))
                            .tracking(2)
                            .textCase(.uppercase)
                    }
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(
                        LinearGradient(
                            colors: [Color(hex: "52B788"), Color(hex: "2D6A4F")],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(4)
                    .shadow(color: Color(hex: "52B788").opacity(0.2), radius: 12, x: 0, y: 6)
                }
                .padding(20)
                .background(Color(hex: "0A0A0A"))
            }
        }
        .sheet(isPresented: $showExportSheet) {
            ExportView(conversationName: conversationName, messages: messages)
        }
    }
}

struct ExportView: View {
    let conversationName: String
    let messages: [ChatMessage]
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color(hex: "0A0A0A")
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                VStack(spacing: 8) {
                    ZStack {
                        Circle()
                            .fill(Color(hex: "1B4332"))
                            .frame(width: 70, height: 70)
                        Circle()
                            .strokeBorder(Color(hex: "52B788").opacity(0.4), lineWidth: 1)
                            .frame(width: 70, height: 70)
                        Image(systemName: "doc.richtext.fill")
                            .font(.system(size: 28))
                            .foregroundColor(Color(hex: "52B788"))
                    }
                    .padding(.top, 40)
                    
                    Text("Export")
                        .font(.custom("Didot", size: 32))
                        .foregroundColor(.white)
                        .tracking(1)
                    
                    Text("Conversation with \(conversationName)")
                        .font(.system(size: 12, weight: .regular))
                        .tracking(2)
                        .textCase(.uppercase)
                        .foregroundColor(Color(hex: "52B788"))
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom, 30)
                
                Divider()
                    .background(Color(hex: "1C1C1C"))
                
                // Stats
                VStack(spacing: 0) {
                    ExportStatRow(icon: "message.fill", label: "Messages", value: "\(messages.count)")
                    Divider().background(Color(hex: "1C1C1C"))
                    ExportStatRow(icon: "person.fill", label: "Conversation", value: conversationName)
                    Divider().background(Color(hex: "1C1C1C"))
                    ExportStatRow(icon: "calendar", label: "Exported", value: Date().formatted(date: .abbreviated, time: .omitted))
                }
                .padding(.vertical, 8)
                
                Divider()
                    .background(Color(hex: "1C1C1C"))
                
                Spacer()
                
                // Buttons
                VStack(spacing: 12) {
                    Button(action: { exportAsPDF() }) {
                        HStack(spacing: 10) {
                            Image(systemName: "arrow.down.doc.fill")
                                .font(.system(size: 13))
                            Text("Save as PDF")
                                .font(.system(size: 13, weight: .semibold))
                                .tracking(2)
                                .textCase(.uppercase)
                        }
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            LinearGradient(
                                colors: [Color(hex: "52B788"), Color(hex: "2D6A4F")],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(4)
                        .shadow(color: Color(hex: "52B788").opacity(0.2), radius: 12, x: 0, y: 6)
                    }
                    
                    Button(action: { dismiss() }) {
                        Text("Cancel")
                            .font(.system(size: 12, weight: .regular))
                            .tracking(2)
                            .textCase(.uppercase)
                            .foregroundColor(Color(hex: "555555"))
                    }
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 40)
            }
        }
    }
    
    func exportAsPDF() {
        var content = "Conversation with \(conversationName)\n"
        content += "Exported on \(Date().formatted(date: .long, time: .omitted))\n"
        content += String(repeating: "-", count: 50) + "\n\n"
        for message in messages {
            let prefix = message.isFromMe ? "Me" : conversationName
            content += "[\(message.time)] \(prefix): \(message.text)\n"
        }
        
        let savePanel = NSSavePanel()
        savePanel.title = "Save Conversation"
        savePanel.nameFieldStringValue = "Conversation with \(conversationName)"
        savePanel.allowedContentTypes = [UTType.plainText]
        
        DispatchQueue.main.async {
            if savePanel.runModal() == .OK {
                if let url = savePanel.url {
                    try? content.write(to: url, atomically: true, encoding: .utf8)
                }
            }
        }
    }
}

struct ExportStatRow: View {
    let icon: String
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 13))
                .foregroundColor(Color(hex: "52B788"))
                .frame(width: 20)
            Text(label)
                .font(.system(size: 13, weight: .regular))
                .foregroundColor(Color(hex: "666666"))
            Spacer()
            Text(value)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(Color(hex: "AEAEB2"))
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 14)
    }
}

#Preview {
    NavigationView {
        ConversationDetailView(conversationName: "Mom")
    }
}

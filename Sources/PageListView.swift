import SwiftUI

HStack(spacing: 0) {
    NotebookSpineView()
        .frame(width: 40)

        ScrollView {
            struct PageListView: View {
            @EnvironmentObject var pageStore: PageStore
    
            @State private var animateTear = false

        var body: some View {
            NavigationStack {
                List {
                    ForEach(pageStore.pages) { page in
                    NavigationLink {
                        LoadedPageView(page: page)
                        } label: {
                        VStack(alignment: .leading) {
                            Text(page.date.formatted(date: .long, time: .omitted))
                                .font(.headline)

                            if !page.journalText.isEmpty {
                                Text(page.journalText.prefix(50) + "...")
                                    .foregroundColor(.secondary)
                                }
                            }
                        }
                    }
                }
                .navigationTitle("My Scrapbook")
                .toolbar {
                    NavigationLink("New Page") {
                        ScrapbookPageView()
                    }
                }
                .overlay(
                    animateTear ?
                        TornAnimationView()
                            .transition(.move(edge: .leading).combined(with: .opacity))
                        : nil
                    )
                }
                .onDelete { indexSet in
                    withAnimation(.easeInOut(duration: 0.4)) {
                        animateTear = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        pageStore.pages.remove(atOffsets: indexSet)
                        pageStore.save()
                        pageStore.showTornEdgeOnNextPage = true
                        animateTear = false
                    }
                }
            }
        }
    }
}

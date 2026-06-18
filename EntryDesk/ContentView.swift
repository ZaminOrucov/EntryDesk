import SwiftUI
import Combine
class AppState: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var isLoggedIn: Bool = false
    @Published var userName: String = "Zamin"
    @Published var isDarkMode: Bool = false
    @Published var selectedTab: Tab = .home
    
    enum Tab {
        case home, chat, tracking, more
    }
}
struct ContentView: View {
    @StateObject private var appState = AppState()
    
    var body: some View {
        ZStack {
            if appState.isAuthenticated {
                MainTabView(appState: appState)
                    .environment(\.colorScheme, appState.isDarkMode ? .dark : .light)
            } else {
                LoginView(appState: appState)
                    .environment(\.colorScheme, appState.isDarkMode ? .dark : .light)
            }
        }
    }
}
struct LoginView: View {
    @ObservedObject var appState: AppState
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 25) {
                Spacer()
                VStack(spacing: 10) {
                    Image(systemName: "lock.shield.fill")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.blue)
                    
                    Text("İşçi Paneli")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Giriş üçün istifadəçi adı və şifrəni daxil edin")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.bottom, 30)
                VStack(spacing: 15) {
                    TextField("İstifadəçi Adı", text: $username)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    
                    SecureField("Şifrə", text: $password)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                Button(action: {
                    if username == "demo" && password == "123" {
                        appState.isAuthenticated = true
                    } else {
                    }
                }) {
                    Text("Giriş Et")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                Spacer()
                
                Text("Şifrəni unutmusunuz?")
                    .foregroundColor(.blue)
                    .font(.footnote)
                    .padding(.bottom)
                
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}
struct MainTabView: View {
    @ObservedObject var appState: AppState
    
    var body: some View {
        TabView(selection: $appState.selectedTab) {
            HomeView(appState: appState)
                .tabItem {
                    Label("Əsas", systemImage: "house.fill")
                }
                .tag(AppState.Tab.home)
            ChatView()
                .tabItem {
                    Label("Köməkçi Çat", systemImage: "message.fill")
                }
                .tag(AppState.Tab.chat)
            TrackingView()
                .tabItem {
                    Label("Nəzarət", systemImage: "chart.bar.doc.horizontal.fill")
                }
                .tag(AppState.Tab.tracking)
            MoreView(appState: appState)
                .tabItem {
                    Label("Daha Çox", systemImage: "ellipsis.circle.fill")
                }
                .tag(AppState.Tab.more)
        }
    }
}
struct HomeView: View {
    @ObservedObject var appState: AppState
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Şirkət Adı")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(.blue)
                        
                        Text("Yeniliklərdə Sizinləyik!")
                            .font(.headline)
                            .foregroundColor(.gray)
                        
                        Text("Bizim missiyamız, hər kəs üçün ən yaxşı iş şəraitini təmin etmək və əməkdaşlarımızın inkişafına dəstək olmaqdır.")
                            .font(.body)
                            .lineLimit(nil)
                            .padding(.top, 5)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(appState.isDarkMode ? Color.black : Color.white)
                            .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 5)
                    )
                    .padding(.horizontal)
                    VStack {
                        Text("🏆 Ayın Ən Yaxşı İşçisi")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.bottom, 5)
                        
                        Text("Nicat Qasımov")
                            .font(.largeTitle)
                            .fontWeight(.black)
                            .foregroundColor(.white)
                            .padding(.top, 5)
                        
                        Text("Təbriklər!")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.8))
                    }
                    .frame(maxWidth: .infinity)
                    .padding(25)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .cornerRadius(20)
                    .padding(.horizontal)
                    VStack {
                        Text(appState.isLoggedIn ? "İş Başındadır" : "İşdə Deil")
                            .font(.headline)
                            .foregroundColor(appState.isLoggedIn ? .green : .red)
                        
                        Button(action: {
                            appState.isLoggedIn.toggle()
                            print(appState.isLoggedIn ? "Giriş qeydə alındı." : "Çıxış qeydə alındı.")
                        }) {
                            Text(appState.isLoggedIn ? "Çıxış Vur" : "Giriş Vur")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(maxWidth: 200)
                                .padding(20)
                                .background(appState.isLoggedIn ? Color.red : Color.green)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                        }
                    }
                    .padding(.vertical, 20)
                    
                    Spacer()
                    
                }
                .padding(.top)
            }
            .navigationTitle("Əsas Ekran")
        }
    }
}
struct ChatView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("🤖 Süni İntellekt Köməkçisi")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                
                Text("Bu hissədə gələcəkdə süni intellekt əsaslı çat köməkçisi inkişaf etdiriləcək. (Məsələn, İT dəstəyi üçün)")
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Spacer()
            }
            .navigationTitle("Çat")
        }
    }
}
struct TrackingView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Giriş/Çıxış Tarixçəsi")) {
                    TrackingRow(date: "18 Noyabr", checkIn: "08:58", checkOut: "18:05")
                    TrackingRow(date: "17 Noyabr", checkIn: "09:02", checkOut: "18:01")
                    TrackingRow(date: "16 Noyabr", checkIn: "08:55", checkOut: "17:59")
                }
                
                Section(header: Text("Aylıq Göstəricilər")) {
                    HStack {
                        Text("Gecikmə sayı:")
                        Spacer()
                        Text("2")
                            .foregroundColor(.red)
                    }
                    HStack {
                        Text("Cəmi iş saatı:")
                        Spacer()
                        Text("170.5 saat")
                    }
                }
            }
            .navigationTitle("Nəzarət")
        }
    }
}

struct TrackingRow: View {
    var date: String
    var checkIn: String
    var checkOut: String
    
    var body: some View {
        HStack {
            Text(date)
                .fontWeight(.medium)
            Spacer()
            VStack(alignment: .trailing) {
                Text("Giriş: \(checkIn)")
                    .font(.subheadline)
                    .foregroundColor(.green)
                Text("Çıxış: \(checkOut)")
                    .font(.subheadline)
                    .foregroundColor(.red)
            }
        }
    }
}
struct MoreView: View {
    @ObservedObject var appState: AppState
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Ümumi Profil")) {
                    NavigationLink(destination: ProfileSettingsView()) {
                        Label("Profil Tənzimlənməsi", systemImage: "person.circle.fill")
                    }
                    HStack {
                        Label("İşçi Adı", systemImage: "person.text.rectangle.fill")
                        Spacer()
                        Text(appState.userName)
                            .foregroundColor(.gray)
                    }
                }
                Section(header: Text("Tətbiq Görünüşü")) {
                    Toggle(isOn: $appState.isDarkMode) {
                        Label("Qaranlıq Mod", systemImage: appState.isDarkMode ? "moon.fill" : "sun.max.fill")
                    }
                }
                Section(header: Text("Bildirişlər")) {
                    NavigationLink(destination: NotificationSettingsView()) {
                        Label("Giriş/Çıxış Bildirişləri", systemImage: "bell.badge.fill")
                    }
                }
                Section {
                    Button(action: {
                        appState.isAuthenticated = false
                        appState.isLoggedIn = false
                    }) {
                        Label("Çıxış Et", systemImage: "lock.open.fill")
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle("Daha Çox")
        }
    }
}
struct ProfileSettingsView: View {
    var body: some View {
        Form {
            TextField("Ad", text: .constant("Əli"))
            TextField("Soyad", text: .constant("Əliyev"))
            TextField("E-poçt", text: .constant("ali.aliyev@sirket.az"))
            
            Button("Yadda Saxla") {}
                .frame(maxWidth: .infinity)
        }
        .navigationTitle("Profil Tənzimlənməsi")
    }
}
struct NotificationSettingsView: View {
    @State private var checkInReminder: Bool = true
    @State private var checkOutReminder: Bool = true
    @State private var checkInTime: Double = 10 // dəqiqə
    @State private var checkOutTime: Double = 1 // dəqiqə
    
    var body: some View {
        Form {
            Section(header: Text("İşə Giriş Bildirişləri")) {
                Toggle("Bildirişi Aktiv Et", isOn: $checkInReminder)
                
                if checkInReminder {
                    VStack(alignment: .leading) {
                        Text("Girişdən nə qədər əvvəl xəbərdarlıq edilsin? (\(Int(checkInTime)) dəqiqə)")
                        Slider(value: $checkInTime, in: 1...30, step: 1)
                    }
                    .padding(.vertical)
                }
            }
            
            Section(header: Text("İşdən Çıxış Bildirişləri")) {
                Toggle("Bildirişi Aktiv Et", isOn: $checkOutReminder)
                
                if checkOutReminder {
                    VStack(alignment: .leading) {
                        Text("Çıxışa nə qədər qalmış xəbərdarlıq edilsin? (\(Int(checkOutTime)) dəqiqə)")
                        Slider(value: $checkOutTime, in: 1...10, step: 1)
                    }
                    .padding(.vertical)
                }
            }
            
            Text("Qeyd: Bildirişlər üçün real tətbiqdə iOS icazələri tələb olunur.")
                .font(.footnote)
                .foregroundColor(.gray)
        }
        .navigationTitle("Bildiriş Ayarları")
    }
}

// MARK: - Önizləmə (Preview)
#Preview {
    ContentView()
}

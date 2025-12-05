# OneTV – OneSport External Video Player  
### Secure HLS Streaming Player for Live Sports  
### Built with Flutter

**OneTV** is the official external video player of the **OneSport platform**, designed to deliver smooth and secure playback of live sports matches.  
It works as a lightweight, standalone Flutter application that receives a **secure stream URL or authentication token** from the main OneSport App and handles video playback with optimized performance.

---

## 🚀 Purpose of OneTV

The OneSport ecosystem uses three applications:
1. **Admin Dashboard** – Manage matches & streams  
2. **OneSport Main App** – Users browse matches  
3. **OneTV Player** – Handles the actual video playback  

**OneTV’s mission is to provide the most stable and secure video playback experience possible.**

---

## 🧩 Key Features

### 🎥 Live Video Playback  
- Supports **HLS (m3u8)** streaming  
- Optimized for live sports events  
- Full-screen mode  
- Auto player initialization  
- Adaptive streaming (plugin dependent)

### 🔐 Secure Access  
- Accepts secure video URLs sent from the OneSport main app  
- Supports:
  - Token-based streaming  
  - Signed URLs  
  - Temporary access links  

Example usage:
```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => PlayerScreen(streamUrl: match.videoUrl),
  ),
);

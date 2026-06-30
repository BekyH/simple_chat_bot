# Simple Chat Bot

A lightweight chat application with:
- **Backend:** FastAPI service that calls the Groq API
- **Frontend:** Vanilla HTML/CSS/JavaScript chat UI
- **Mobile:** Flutter app (`mobile/chat_bot`) for Android/iOS/web/desktop

## Project Structure

```text
ex/
├── backend/
│   └── main.py
├── frontend/
│   ├── index.html
│   ├── script.js
│   ├── styles.css
│   └── logo.jpg
├── mobile/
│   └── chat_bot/
│       ├── lib/
│       └── pubspec.yaml
└── README.md
```

## Prerequisites

- Python 3.9+
- A Groq API key (`GROQ_API_KEY`)

## Backend Setup

From the project root:

```bash
cd backend
python3 -m venv .venv
source .venv/bin/activate
pip install fastapi uvicorn groq python-dotenv
```

Create `backend/.env` and add:

```env
GROQ_API_KEY=your_groq_api_key_here
```

## Run the Backend

```bash
cd backend
source .venv/bin/activate
uvicorn main:app --reload --port 8002
```

The API will run at `http://127.0.0.1:8002`.

## Run the Frontend

Open `frontend/index.html` in your browser (double-click it, or use a local static server).

The frontend is configured to call:

- `POST http://127.0.0.1:8002/chat`

## Mobile App (Flutter)

The mobile client lives in `mobile/chat_bot`.

### Prerequisites

- Flutter SDK installed (`flutter --version`)

### Configure backend URL

The mobile app uses `mobile/chat_bot/lib/core/constants/api_constants.dart`.

It is currently set to port `8001`, while this backend runs on `8002`.
Update the URLs in `ApiConstants.baseUrl` to match your backend port if needed.

### Run mobile app

```bash
cd mobile/chat_bot
flutter pub get
flutter run
```

Make sure the backend is running before sending messages from mobile.

## API Example

```bash
curl -X POST "http://127.0.0.1:8002/chat" \
  -H "Content-Type: application/json" \
  -d '{"message":"Hello"}'
```

Expected response format:

```json
{
  "response": "..."
}
```

## Notes

- CORS is enabled for all origins in the backend.
- If you see `Missing GROQ_API_KEY`, confirm `backend/.env` exists and contains a valid key.

# Chat Bot Mobile

Flutter mobile client for the existing chatbot backend (`POST /chat`) using:

- Clean architecture (data/domain/presentation)
- GetX state management + dependency injection
- Dio for HTTP networking

## Project Structure

```text
lib/
	app/bindings/
	core/constants/
	core/network/
	features/chat/
		data/
		domain/
		presentation/
```

## Backend URL

`ApiConstants.baseUrl` in `lib/core/constants/api_constants.dart`:

- Android emulator: `http://10.0.2.2:8001`
- iOS simulator / desktop / web: `http://127.0.0.1:8001`

If your backend runs elsewhere, update that file accordingly.

## Run

```bash
flutter pub get
flutter run
```

Make sure the backend is running before sending messages.

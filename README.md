﻿﻿﻿﻿﻿
# Fluttipedia
Eine Flutter-App, um das Wikipedia-Spiel [Getting to Philosophy](https://en.wikipedia.org/wiki/Wikipedia:Getting_to_Philosophy) unter Verwendung des [Skiapoden](https://github.com/skiapoden/) [firstlink](https://skiapoden.herokuapp.com/) Microservices zu spielen.

## Getting Started

Das Projekt kann folgendermassen ausgeführt werden:

### 1. Vorhandene Emulatoren auflisten
```
flutter emulators
```
### 2. Bestimmten Emulator starten
```
flutter emulators --launch Pixel_2_XL_API_28
```

### 3. Projekt starten
```
flutter run
```

## Technische Anforderungen
Die nachfolgenden Anforderungen wurden in beschriebenen Codestellen umgesetzt.

### Verwendung von Flutter (3 Pkt.)
Die App wurde mit Flutter erstellt mit dem Material App Widget (`main.dart` Zeile 12 -23), welches die Definierung eines globalen Themes ermöglicht. Für dieses App wurden sowohl Stateful wie auch Stateless Widgets verwendet und teilweise eigene Widgets erstellt (`widgets/TargetCard.dart`, `widgets/TutorialCard.dart`).

### Implementierung & Verwendung einer eigenen Server-Komponente (1 Pkt.)

Um dem ersten Link eines Wikipedia-Artikels zu erhalten wurde eine externe Serverkomponente verwendet, welcher ein Begriff übergeben werden kann und als Antwort den ersten Link des Artikels liefert.

Die Serverkomponente wurde für das Modul Softwaretesting (SWT) als Gruppenarbeit erstellt. Weitere Infos auf (https://skiapoden.herokuapp.com/firstlink).

Im Code zu sehen ist dies in `screens/result.dart`, Zeile 62 - 66.

### Kommunikation über HTTP (1 Pkt.)

Die Kommunkiation mit der Serverkomponente erfolgt asynchron via HTTP.
Im Code zu sehen ist dies in `screens/result.dart`, Zeile 61 - 72.



### Lokale Persistenz mittels SharedPreferences (1 Pkt.)
```
fluttipedia\lib\screens\Settings.dart
```

Zeilen 34 - 63

## Sonstiges
Weitere Anmerkungen zur App.

### Struktur
Die App besteht aus einer MainPage und mehrere SubPages.

Die MainPage bildet das Grundgerüst der App durch die Verwendung des Flutter-Widget MaterialApp. Dort sind generelle Spezifikationen, wie z.B. die Colorpalette definiert.

Die jeweiligen SubPages bieten die effektive Funktionalität der App an. Es wurde darauf geachtet, dass in ersten Linie Flutter-Widgets verwendet wurden, um das Material Design einzuhalten.

### Navigation
Die Navigation findet hauptsächlich über die BottomNavigationBar statt. Beim Klick auf das entsprechende Icon wird die gewünschte SubPage von der Seite her eingeschoben.

### Persistenz
Für die Persistenz kommen die SharedPreferences zum Einsatz. Flutter bietet dieses Feature standardmässig nicht an, sodass folgende dependency verwendet werden muss:

``
shared_preferences: ^0.4.3
``




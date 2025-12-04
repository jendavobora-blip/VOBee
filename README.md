# VoBee - Czech Financial Education App 🐝💰

<p align="center">
  <img src="docs/images/logo.png" alt="VoBee Logo" width="200"/>
</p>

VoBee je open-source aplikace pro finanční vzdělání českých uživatelů, která kombinuje mluvícího AI avatara s komplexními nástroji pro správu osobních financí.

## 🎯 Funkce

- **🗣️ Mluvící Avatar**: Český AI asistent reagující na hlasové a textové dotazy
- **📈 Správa Investic**: Přehled a sledování investičního portfolia
- **₿ Kryptoměny**: Sledování kryptoaktiv s upozorněními
- **💰 Rozpočet**: Nástroje pro správu měsíčního rozpočtu (pravidlo 50/30/20)
- **💳 Správa Dluhů**: Strategie splácení dluhů (lavina, sněhová koule)
- **📚 Finanční Vzdělání**: Kurzy a tipy pro finanční gramotnost

## 🏗️ Architektura

```
┌─────────────────────────────────────────────────────────────┐
│                    Flutter Mobile App                        │
│                  (Android / iOS)                             │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                    FastAPI Backend                           │
│                                                              │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐          │
│  │   Chat API  │  │   TTS API   │  │  Avatar API │          │
│  │             │  │ (Coqui TTS) │  │ (SadTalker) │          │
│  └─────────────┘  └─────────────┘  └─────────────┘          │
└─────────────────────────────────────────────────────────────┘
```

## 🚀 Rychlý Start

### Požadavky

- Flutter 3.16+ (pro mobilní aplikaci)
- Python 3.11+ (pro backend)
- Docker & Docker Compose (volitelné)

### Spuštění Flutter Aplikace

```bash
cd vobee_app
flutter pub get
flutter run
```

### Spuštění Backend

```bash
cd backend
pip install -r requirements.txt
uvicorn app.main:app --reload
```

### Spuštění přes Docker

```bash
docker-compose up -d
```

## 📱 Screenshoty

| Hlavní Obrazovka | Investice | Rozpočet |
|------------------|-----------|----------|
| ![Home](docs/images/home.png) | ![Investments](docs/images/investments.png) | ![Budget](docs/images/budget.png) |

## 🎨 Design

Aplikace používá moderní tmavý design se zlatými akcenty:

- **Primární barva**: Zlatá (#D4AF37)
- **Pozadí**: Tmavě šedá (#121212)
- **Karty**: Tmavě šedá (#2C2C2C)

## 📚 Dokumentace

- [Instalace](docs/installation.md)
- [Architektura](docs/architecture.md)
- [API Reference](docs/api.md)
- [Přispívání](CONTRIBUTING.md)

## 🤝 Přispívání

Vítáme příspěvky od komunity! Prosím přečtěte si náš [průvodce přispíváním](CONTRIBUTING.md).

1. Forkněte repozitář
2. Vytvořte feature branch (`git checkout -b feature/AmazingFeature`)
3. Commitněte změny (`git commit -m 'Add some AmazingFeature'`)
4. Pushněte do branch (`git push origin feature/AmazingFeature`)
5. Otevřete Pull Request

## 📄 Licence

Tento projekt je licencován pod MIT licencí - viz [LICENSE](LICENSE) soubor.

## 🙏 Poděkování

- [Flutter](https://flutter.dev/)
- [FastAPI](https://fastapi.tiangolo.com/)
- [Coqui TTS](https://github.com/coqui-ai/TTS)
- [SadTalker](https://github.com/OpenTalker/SadTalker)

---

<p align="center">
  Vytvořeno s ❤️ v České republice
</p>

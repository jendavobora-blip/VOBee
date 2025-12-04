# Průvodce Přispíváním do VoBee

Děkujeme za váš zájem přispět do projektu VoBee! 🐝

## 🚀 Jak Začít

1. **Fork & Clone**
   ```bash
   git clone https://github.com/YOUR_USERNAME/VOBee.git
   cd VOBee
   ```

2. **Nastavte vývojové prostředí**
   
   Pro Flutter:
   ```bash
   cd vobee_app
   flutter pub get
   ```
   
   Pro Backend:
   ```bash
   cd backend
   python -m venv venv
   source venv/bin/activate  # Na Windows: venv\Scripts\activate
   pip install -r requirements.txt
   ```

## 📝 Typy Příspěvků

### 🐛 Opravy Chyb
- Najděte chybu v [Issues](https://github.com/jendavobora-blip/VOBee/issues)
- Přiřaďte si issue
- Vytvořte fix a otestujte

### ✨ Nové Funkce
- Diskutujte nápad v [Discussions](https://github.com/jendavobora-blip/VOBee/discussions)
- Po schválení vytvořte Pull Request

### 📚 Dokumentace
- Opravy překlepů
- Nové tutoriály
- Překlady

## 🔧 Vývojový Workflow

1. Vytvořte branch
   ```bash
   git checkout -b feature/moje-funkce
   ```

2. Dělejte malé, atomické commity
   ```bash
   git commit -m "feat: přidána nová funkce XYZ"
   ```

3. Pushněte a vytvořte PR
   ```bash
   git push origin feature/moje-funkce
   ```

## ✅ Kontrolní Seznam pro PR

- [ ] Kód je formátován (`flutter format .` / `black .`)
- [ ] Testy procházejí (`flutter test` / `pytest`)
- [ ] Dokumentace je aktualizována
- [ ] Commit messages následují [Conventional Commits](https://www.conventionalcommits.org/)

## 📋 Pravidla Kódu

### Flutter/Dart
- Používejte `const` kde je to možné
- Dokumentujte veřejné API
- Maximální délka řádku: 80 znaků

### Python
- Následujte PEP 8
- Používejte type hints
- Dokumentujte funkce docstringy

## 🎨 Styl Commit Messages

```
feat: přidána nová funkcionalita
fix: opravena chyba
docs: aktualizována dokumentace
style: formátování kódu
refactor: refaktoring bez změny funkcionality
test: přidány testy
chore: údržba projektu
```

## 📞 Kontakt

Máte otázky? Vytvořte issue nebo napište do diskuse!

Děkujeme za váš příspěvek! 💪

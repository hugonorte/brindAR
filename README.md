# 🍷 BrindAR

### Aplicativo para amantes de vinho

BrindAR é um aplicativo mobile premium para entusiastas de vinho. Utilizando a câmera do smartphone e Realidade Aumentada (AR), o app permite escanear rótulos e códigos de barras de garrafas para acessar instantaneamente dados de viticultura, notas de sommelier e sugestões de harmonização.

---

## 📦 Stack do Projeto

| Camada | Tecnologia |
|---|---|
| **Framework** | [Flutter](https://flutter.dev/) (Cross-platform iOS / Android) |
| **Linguagem** | [Dart](https://dart.dev/) `^3.11.1` |
| **Gerenciamento de Estado** | [Provider](https://pub.dev/packages/provider) `^6.1.5+1` |
| **Tipografia** | [Google Fonts](https://pub.dev/packages/google_fonts) `^8.0.2` (Noto Serif + Manrope) |
| **Câmera / Scanner** | [camera](https://pub.dev/packages/camera) `^0.12.0+1` |
| **Animações** | [flutter_animate](https://pub.dev/packages/flutter_animate) `^4.5.2` |
| **Ícones** | [lucide_icons](https://pub.dev/packages/lucide_icons) `^0.257.0` |
| **Internacionalização** | [intl](https://pub.dev/packages/intl) `^0.20.2` |
| **Armazenamento local** | [path_provider](https://pub.dev/packages/path_provider) `^2.1.5` + [path](https://pub.dev/packages/path) `^1.9.1` |
| **Ícones nativos iOS** | [cupertino_icons](https://pub.dev/packages/cupertino_icons) `^1.0.8` |
| **Linting** | [flutter_lints](https://pub.dev/packages/flutter_lints) `^6.0.0` |

---

## 🖥️ Como subir o ambiente de desenvolvimento (local)

Este guia descreve como preparar um computador **Linux, macOS ou Windows** para rodar o projeto em modo de desenvolvimento.

### Pré-requisitos

Antes de começar, certifique-se de ter instalado:

- **Git** — para clonar o repositório
- **Flutter SDK** — versão estável mais recente (compatível com Dart `^3.11.1`)
- **Dart SDK** — já incluído no Flutter
- **Android Studio** ou **VS Code** com a extensão Flutter instalada

### Passo 1 — Instalar o Flutter SDK

1. Acesse [flutter.dev/docs/get-started/install](https://docs.flutter.dev/get-started/install) e siga as instruções para o seu sistema operacional.
2. Após a instalação, adicione o Flutter ao seu `PATH`. Exemplo para Linux/macOS (no seu `~/.bashrc` ou `~/.zshrc`):
   ```bash
   export PATH="$PATH:/caminho/para/flutter/bin"
   ```
3. Recarregue o terminal:
   ```bash
   source ~/.bashrc   # ou source ~/.zshrc
   ```
4. Verifique a instalação:
   ```bash
   flutter --version
   ```

### Passo 2 — Verificar o ambiente com Flutter Doctor

Execute o diagnóstico do Flutter para garantir que tudo está configurado corretamente:

```bash
flutter doctor
```

Resolva todos os itens marcados com `[✗]` ou `[!]` antes de prosseguir. Dê atenção especial à licença do Android e à configuração do Xcode (macOS).

### Passo 3 — Clonar o repositório

```bash
git clone <url-do-repositorio>
cd brindar/app
```

### Passo 4 — Instalar as dependências do projeto

Com o terminal na raiz do projeto (onde está o `pubspec.yaml`):

```bash
flutter pub get
```

Isso baixa todos os pacotes listados no `pubspec.yaml`.

### Passo 5 — Rodar o projeto no desktop (modo desenvolvimento)

Para desenvolvimento rápido sem um dispositivo físico, você pode rodar no desktop (Linux, macOS ou Windows):

```bash
# Linux
flutter run -d linux

# macOS
flutter run -d macos

# Windows
flutter run -d windows
```

> **Dica:** Para listar todos os dispositivos disponíveis (físicos e emuladores):
> ```bash
> flutter devices
> ```

### Passo 6 — Rodar no navegador (opcional)

```bash
flutter run -d chrome
```

---

## 🤖 Como rodar o projeto em um smartphone Android

### Pré-requisitos

- **Android Studio** instalado
- **JDK 17+** instalado e configurado
- Um dispositivo Android físico **ou** um AVD (Android Virtual Device / Emulador)
- Android SDK instalado via Android Studio (API Level 21 ou superior recomendado)

### Opção A — Rodar em um dispositivo físico Android

#### Passo 1 — Habilitar opções de desenvolvedor no celular

1. Abra **Configurações** no seu Android.
2. Vá em **Sobre o telefone**.
3. Toque **7 vezes** em `informações do software>número de compilação` até ver a mensagem *"Você agora é um desenvolvedor"*.
4. Volte para **Configurações** → **Opções do desenvolvedor** (pode estar em *Sistema* dependendo do modelo).
5. Ative **Depuração USB**.

#### Passo 2 — Conectar o dispositivo ao computador

1. Conecte o dispositivo ao computador via cabo USB.
2. No celular, quando aparecer o popup de autorização de depuração USB, toque em **Permitir**.
3. Verifique se o dispositivo é reconhecido:
   ```bash
   flutter devices
   ```
   Você deve ver o nome do seu aparelho na lista.

#### Passo 3 — Rodar o app

```bash
flutter run
```

O Flutter irá compilar e instalar o app automaticamente no dispositivo conectado.

---

### Opção B — Rodar em um Emulador Android (AVD)

#### Passo 1 — Criar um AVD no Android Studio

1. Abra o **Android Studio**.
2. Vá em **Virtual Device Manager** (ícone de celular na barra lateral ou menu *Tools*).
3. Clique em **Create Device**.
4. Escolha um modelo de dispositivo (ex: **Pixel 8**) e clique em **Next**.
5. Baixe a imagem do sistema desejada (ex: **API 34 / Android 14**) e clique em **Next** → **Finish**.

#### Passo 2 — Iniciar o emulador

Inicie o AVD diretamente pelo Android Studio (botão ▶) ou via terminal:

```bash
emulator -avd <nome_do_avd>
```

Para listar os AVDs disponíveis:
```bash
emulator -list-avds
```

#### Passo 3 — Rodar o app

Com o emulador aberto e aparecendo em `flutter devices`:

```bash
flutter run
```

---

## 🍎 Como rodar o projeto em um smartphone iOS

> ⚠️ **Requisito obrigatório:** Um computador com **macOS** é necessário para compilar e rodar apps Flutter no iOS. Não é possível rodar em dispositivos iOS a partir de Linux ou Windows.

### Pré-requisitos

- **macOS** com **Xcode** instalado (versão 15 ou superior recomendada)
- **CocoaPods** instalado
- Uma conta Apple (gratuita ou paga) para assinar o app

### Passo 1 — Instalar o Xcode

1. Abra a **App Store** no seu Mac e instale o **Xcode**.
2. Após instalar, abra o Xcode uma vez para aceitar os termos de licença.
3. Instale as ferramentas de linha de comando:
   ```bash
   xcode-select --install
   ```
4. Aceite a licença do Xcode:
   ```bash
   sudo xcodebuild -license accept
   ```

### Passo 2 — Instalar o CocoaPods

CocoaPods é necessário para gerenciar dependências nativas do iOS.

```bash
sudo gem install cocoapods
```

Ou, se o seu sistema usar Homebrew:
```bash
brew install cocoapods
```

### Passo 3 — Instalar as dependências iOS do projeto

```bash
cd ios
pod install
cd ..
```

### Opção A — Rodar em um dispositivo físico iOS

#### Passo 4A — Configurar assinatura no Xcode

1. Abra o arquivo `ios/Runner.xcworkspace` no Xcode (use **sempre** o `.xcworkspace`, nunca o `.xcodeproj`):
   ```bash
   open ios/Runner.xcworkspace
   ```
2. No painel esquerdo, selecione o projeto **Runner**.
3. Vá na aba **Signing & Capabilities**.
4. Em **Team**, selecione a sua conta Apple. Se não aparecer, clique em **Add an Account...** e faça login.
5. Certifique-se de que o **Bundle Identifier** seja único (ex: `com.seunome.brindar`).

#### Passo 5A — Confiar no certificado do desenvolvedor no iPhone

1. Conecte o iPhone ao Mac via cabo.
2. No iPhone, vá em **Configurações** → **Geral** → **VPN e Gerenciamento de Dispositivo**.
3. Encontre o perfil do seu Apple ID e toque em **Confiar**.

#### Passo 6A — Rodar o app

```bash
flutter run
```

O Flutter detectará o dispositivo iOS conectado e irá compilar e instalar o app.

---

### Opção B — Rodar no Simulador iOS

#### Passo 4B — Abrir o Simulador

```bash
open -a Simulator
```

Ou, via Xcode: menu **Xcode** → **Open Developer Tool** → **Simulator**.

Você pode mudar o modelo simulado em: **File** → **Open Simulator** → escolha o dispositivo desejado (ex: iPhone 16).

#### Passo 5B — Rodar o app

Com o simulador aberto e aparecendo em `flutter devices`:

```bash
flutter run
```

---

## 🛠️ Comandos úteis

| Comando | Descrição |
|---|---|
| `flutter pub get` | Instala as dependências |
| `flutter run` | Roda o app no dispositivo/emulador detectado |
| `flutter run -d <device_id>` | Roda em um dispositivo específico |
| `flutter devices` | Lista todos os dispositivos disponíveis |
| `flutter doctor` | Verifica o ambiente de desenvolvimento |
| `flutter build apk` | Gera o APK de release para Android |
| `flutter build ios` | Gera o build de release para iOS |
| `flutter pub upgrade` | Atualiza as dependências para versões compatíveis |
| `flutter analyze` | Executa análise estática do código |
| `flutter test` | Roda os testes automatizados |

---

## 🎨 Design System

O projeto segue o design system **"The Sommelier's Lens"**:

- **Cor primária:** Burgundy `#210000`
- **Cor secundária:** Cream `#FCF9F3`
- **Tipografia Headlines:** Noto Serif (editorial)
- **Tipografia Corpo:** Manrope (clean e preciso)
- **Estilo visual:** Glassmorphism, micro-animações suaves, sem bordas rígidas (uso de tonal shifts)

---

## 📁 Estrutura do Projeto

```
brindar/app/
├── lib/                    # Código-fonte principal (Dart)
│   ├── main.dart           # Ponto de entrada do app
│   ├── screens/            # Telas do aplicativo
│   ├── widgets/            # Componentes reutilizáveis
│   ├── providers/          # Gerenciamento de estado (Provider)
│   └── services/           # Lógica de negócio e acesso a dados
├── assets/
│   └── images/             # Imagens e assets visuais
├── android/                # Configurações específicas Android
├── ios/                    # Configurações específicas iOS
├── test/                   # Testes automatizados
├── pubspec.yaml            # Dependências e configurações do projeto
└── Technical_Specification.md  # Especificação técnica detalhada
```
# brindAR

---
description: Sobe um dispositivo virtual e executa a aplicação Flutter com verificações de saúde
---

Este workflow automatiza o processo de iniciar um emulador Android e executar o aplicativo BrindAR, incluindo passos de verificação e solução de problemas.

### Passo a Passo de Execução:

1. **Listar emuladores disponíveis**
   // turbo
   `flutter emulators`

2. **Verificar se já existe um dispositivo pronto**
   // turbo
   `adb devices`
   *(Se o dispositivo estiver listed como `device`, pule o passo 3. Se estiver `offline` ou não listado, prossiga).*

3. **Iniciar o dispositivo virtual**
   // turbo
   `flutter emulators --launch Pixel_6_API_34`

4. **Aguardar inicialização funcional**
   // turbo
   `adb wait-for-device`

5. **Executar a aplicação**
   Sempre use a flag `-d` para garantir que o Flutter não tente compilar para Linux Desktop por engano se o emulador demorar a ser reconhecido.
   // turbo
   `flutter run -d emulator-5554`

### Solução de Problemas (Troubleshooting):

- **Erro de Linker (ld/ld.lld):** Se ver um erro de "Failed to find any of [ld.lld, ld]", instale as dependências nativas:
  `sudo apt update && sudo apt install -y clang cmake ninja-build pkg-config libgtk-3-dev liblzma-dev libstdc++-12-dev`

- **Dispositivo Offline:** Se o ADB travar, reinicie o servidor:
  `adb kill-server && adb start-server`

- **Problemas de KVM/Permissão:** Verifique se seu usuário tem acesso ao hardware:
  `umask 000 && sudo chmod 666 /dev/kvm`

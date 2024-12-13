# ASES - Acompanhamento de Acionamento

## Visão Geral
O **ASES** é um aplicativo móvel desenvolvido em Flutter/Dart para fornecer acompanhamento em tempo real dos passageiros e suas viagens. Este projeto focou em uma experiência de usuário simples e intuitiva, onde passageiros, pilotos e acompanhantes possam trocar informações e acompanhar trajetos voluntários fornecidos pela ASES Brasil.
---

## Funcionalidades Principais
- **Acompanhamento em Tempo Real:** O passageiro, piloto e acompanhante podem atualizar suas posições conforme sua localização do celular. 
- **Chat:** O piloto pode trocar mensagens com o passageiro para informações de encontro, partida e orientações. 

---

## Tecnologias Utilizadas
- **Framework:** [Flutter](https://flutter.dev/)
- **Linguagem:** Dart

---

## Estrutura do Projeto
```plaintext
/lib
  ├── models            # Modelos de dados
  ├── screens           # Telas do aplicativo
  ├── services          # Serviços (API, banco de dados, etc.)
  ├── services          # Serviços (API, banco de dados, etc.)
  ├── utils             # Funções utilitárias e constantes
  └── main.dart         # Arquivo principal
```
## Requisitos
Para executar o projeto, você precisa ter as seguintes ferramentas instaladas:
- **Flutter SDK:** versão mínima 3.0.0
- **Dart SDK:** incluído com o Flutter
- **Editor de Código:** [Visual Studio Code](https://code.visualstudio.com/) ou [Android Studio](https://developer.android.com/studio)

---

## Configuração do Ambiente
1. **Clone o Repositório:**
   ```bash
   git clone https://github.com/usuario/asesprojeto.git
   cd asesprojeto
   ```

2. **Instale as Dependências:**
   ```bash
   flutter pub get
   ```

3. **Execute o Flutter Doctor:**
   Certifique-se de que todos os requisitos do Flutter estão configurados corretamente:
   ```bash
   flutter doctor
   ```
   O comando verifica a instalação do Flutter, das ferramentas do Android SDK, do Xcode (para desenvolvimento iOS) e do emulador/dispositivos conectados. Resolva eventuais pendências apontadas antes de continuar.

4. **Execute o Aplicativo:**
   ```bash
   flutter run
   ```
---

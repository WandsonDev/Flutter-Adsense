## 1.0.0

**Lançamento Inicial**

### Novidades
* **Core** — `FlutterAdsense` (Singleton) para injeção centralizada do script
  `adsbygoogle.js` no `<head>`, evitando duplicações no DOM.
* **Widget** — `AdsenseWidget` usando a API moderna `HtmlElementView.fromTagName`
  com configuração via `onElementCreated`.
* **Wasm-ready** — usa `package:web` e `dart:js_interop`; totalmente compatível
  com o compilador `dart2wasm`.
* **Conditional exports** — stubs no-op para plataformas não-web, garantindo
  compilação segura em projetos mobile/desktop.
* **Timing correto** — o push do anúncio é disparado via
  `SchedulerBinding.addPostFrameCallback`, garantindo que o elemento `<ins>`
  esteja no DOM antes da chamada.

### Recursos suportados
* Configuração de `adClient` e `adSlot`.
* Blocos responsivos (`fullWidthResponsive`).
* Formato customizável (`adFormat`).
* Dimensões explícitas (`width` / `height`).
* Getter `isInitialized` para verificar o estado do core.

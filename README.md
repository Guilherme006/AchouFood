# AchouFood

AchouFood é um aplicativo iOS de delivery de comida construído com UIKit e interface totalmente programática. O app permite navegar por restaurantes próximos, alternar entre visualização em lista e mapa, abrir detalhes do restaurante, consultar o cardápio, adicionar itens ao pedido e revisar o resumo do pedido.

## Visão Geral

O projeto é organizado por cenas de funcionalidade e por um coordinator compartilhado. A base atual usa dados mockados embarcados no app, imagens remotas para restaurantes e itens do cardápio, além de MapKit para exibir localizações e abrir rotas no Apple Maps.

Principais recursos:

- Listagem de restaurantes a partir de `places.json`.
- Busca textual de restaurantes.
- Alternância entre lista e mapa na tela inicial.
- Tela de detalhes com endereço, descrição, imagem, estacionamento e localização no mapa.
- Solicitação de permissão de localização para traçar rota.
- Abertura de rota de carro no Apple Maps.
- Cardápio dividido por seções.
- Sincronização entre seção selecionada e rolagem da tabela do cardápio.
- Adição e remoção de quantidades de itens.
- Resumo do pedido com quantidade de itens e valor total.
- Limpeza/reset de seleções do cardápio.

## Tecnologias

- Swift 5
- UIKit
- SnapKit `5.7.1+` para Auto Layout programático
- Kingfisher `8.6.0+` para carregamento e cache de imagens remotas
- MapKit e CoreLocation para mapas, pins, localização e rotas
- UserDefaults encapsulado em `StorageManager`
- Swift Package Manager gerenciado pelo Xcode

As configurações atuais do projeto apontam para iPhone e iPad com `IPHONEOS_DEPLOYMENT_TARGET = 26.0`.

## Estrutura do Projeto

```text
AchouFood/
├── Common/
│   ├── Constants/          Cores, tipografia, métricas, ícones e textos compartilhados
│   ├── Extensions/         Helpers locais, como localização de String
│   ├── Models/             Modelos de restaurante, cardápio e anotação de mapa
│   ├── Protocols/          ViewCodeProtocol para montagem de UI programática
│   └── Shared/             Coordinator, estado do pedido e armazenamento local
├── Delegates/              AppDelegate e SceneDelegate
├── Mock/                   JSON embarcado com restaurantes e cardápios
├── Resources/              Assets, launch screen e localização
└── Scenes/
    ├── HomeDelivery/       Descoberta e busca de restaurantes
    ├── PlaceDetail/        Detalhe do restaurante e ações de rota/cardápio
    ├── PlaceMenu/          Cardápio e seleção de itens
    └── Order/              Resumo e confirmação do pedido
```

## Arquitetura

O app segue uma arquitetura UIKit baseada em cenas, factories e coordinators:

- `DeliveryScenesCoordinator` cria o `UITabBarController`, mantém a pilha de navegação da Home e coordena navegação entre cenas.
- Cada cena possui uma `Factory` responsável por montar o view controller e suas dependências.
- View controllers cuidam de ciclo de vida, layout inicial e ligação entre callbacks da view e ações de coordinator/view model.
- Views são programáticas e usam `ViewCodeProtocol` para separar hierarquia, constraints e configurações.
- O estado do pedido ativo fica em memória em `OrderManager.shared`.
- Valores locais simples, como endereço de entrega, são persistidos por `StorageManager.shared`.

Essa divisão mantém navegação fora das views e reduz o acoplamento entre telas.

## Fluxo do App

1. `SceneDelegate` salva um endereço de entrega de exemplo e inicia `DeliveryScenesCoordinator`.
2. O coordinator cria uma tab bar com duas abas:
   - Home: descoberta de restaurantes dentro de um `UINavigationController`.
   - Pedido: resumo do pedido atual.
3. `HomeDeliveryServiceMock` carrega `Mock/places.json` e retorna restaurantes após um atraso simulado.
4. `HomeDeliveryView` exibe os restaurantes em lista ou mapa e aplica filtros de busca.
5. A seleção de um restaurante abre `PlaceDetailViewController`.
6. Na tela de detalhe, o usuário pode:
   - Voltar para a tela anterior.
   - Traçar rota no Apple Maps.
   - Abrir o cardápio do restaurante.
7. `PlaceMenuView` exibe categorias e itens do cardápio. Mudanças de quantidade atualizam `OrderManager`.
8. Ao tocar no resumo do pedido, o app muda para a aba Pedido e exibe o restaurante/itens selecionados.

## Modelo de Dados

Os restaurantes são decodificados de `AchouFood/Mock/places.json`.

### `Place`

- `restaurantID`
- `restaurantName`
- `address`
- `type`
- `parkingLot`
- `latitude`
- `longitude`
- `imageUrl`
- `description`
- `menu`

### `MenuCategory`

- `category`
- `items`

### `MenuItem`

- `name`
- `price`
- `imageUrl`
- `selectedCount`

`selectedCount` representa estado de tela/pedido e não vem persistido no JSON. Ao decodificar os itens, o valor inicial é `0`.

## Dependências

As dependências são resolvidas pelo Swift Package Manager através do projeto Xcode.

| Pacote | Repositório | Uso |
| --- | --- | --- |
| SnapKit | `https://github.com/SnapKit/SnapKit` | Constraints programáticas |
| Kingfisher | `https://github.com/onevcat/Kingfisher` | Download e cache de imagens |

Ao abrir ou compilar o projeto no Xcode, os pacotes devem ser resolvidos automaticamente.

## Localização

As strings localizadas ficam em:

```text
AchouFood/Resources/en.lproj/Localizable.strings
```

O acesso é feito por uma extensão de `String`, usando chaves como:

- `home.find.places`
- `home.header.addressTitle`
- `alert.title`
- `alert.message`
- `placeMenu.title`
- `order.title`
- `confirmOrderDetails.order.buttonTitle`

## Assets

Os assets ficam em:

```text
AchouFood/Resources/Assets.xcassets
```

O catálogo contém ícones de abas, lista/mapa, pins, rota, cardápio, pedido e botões de adicionar, remover e voltar.

## Como Executar

1. Abra `AchouFood.xcodeproj` no Xcode.
2. Aguarde a resolução dos pacotes SnapKit e Kingfisher.
3. Selecione o scheme `AchouFood`.
4. Escolha um simulador iOS ou dispositivo físico.
5. Compile e execute.

O app usa dados mockados embarcados, então não é necessário configurar backend.

## Permissões

O recurso de rota depende de autorização de localização:

- Se a permissão ainda não foi definida, o app solicita autorização de uso durante o app.
- Se a permissão foi concedida, o app abre o Apple Maps com rota de carro entre a localização atual do usuário e o restaurante.
- Se a permissão foi negada ou restrita, o app mostra um alerta com opção para abrir Ajustes.

## Pontos de Manutenção

- A UI é construída com UIKit, SnapKit e views programáticas.
- O projeto não usa storyboard para telas principais. `LaunchScreen.storyboard` é usado apenas na tela de lançamento.
- A origem de restaurantes é mockada em `HomeDeliveryServiceMock`.
- O estado do pedido é mantido em memória por `OrderManager`.
- O endereço inicial é definido em `SceneDelegate`.
- Não há targets de teste dedicados no projeto atual.

## Melhorias Futuras

- Adicionar testes unitários para `OrderManager`, decodificação do JSON, filtro de busca e comportamento de permissão de localização.
- Adicionar testes de UI para descoberta de restaurantes, seleção de itens e confirmação de pedido.
- Criar uma implementação remota para `HomeDeliveryService`.
- Mover a definição do endereço inicial para uma camada de configuração ou onboarding.
- Persistir o pedido ativo se a restauração de estado for necessária.
- Revisar descrições de privacidade de localização para distribuição na App Store.


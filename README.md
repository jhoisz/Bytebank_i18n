<h1 align="center"> Bytebank 6️⃣: Entendendo abordagens de internacionalização ✈️ </h1>

## ℹ️ Sobre o projeto

Aplicação **mobile** desenvolvida durante o curso [Flutter i18n: entenda abordagens de internacionalização](https://cursos.alura.com.br/course/flutter-i18n-internacionalizacao) de Flutter, na plataforma **[Alura](https://www.alura.com.br/)**, pelo instrutor [Guilherme Silveira](https://cursos.alura.com.br/user/guilherme-silveira).

## 🧳 _Internacionalization_ (i18n)

> Curiosidade: A sigla i18n foi criada por ter 18 letras entre o _i_ e o _n_ da palavra _internacionalization_.

A localização (l18n) é relacionada a formatações de moeadas, data, números em neral, entre outros. Ou seja, sua aplicação se adapta ao local onde o usuário estiver. Enquanto a internacionalização é relacionada a atender vários idiomas.

### 🪛 Exemplo de aplicação da i18n ao projeto

Utilizando o projeto [Bytebank com BLoC]() foram aplicadas algumas traduções `pt-br (português brasileiro)` e `en` (inglês). Primeiro foi criado um Cubit de localização (_localization_):

> Classe `CurrentLocaleCubit` responsável por prover o idioma do local.

```
class CurrentLocaleCubit extends Cubit<String> {
  CurrentLocaleCubit() : super("pt-br");
}
```

Também foram criadas as classes `LocalizationContainer` e `ViewI18N`:

> Classe `LocalizationContainer`, que possui o _BLoC Provider_ e irá receber um _child_ (o _dashboard_ do app).

```
class LocalizationContainer extends BlocContainer {
  final Widget child;
  const LocalizationContainer({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CurrentLocaleCubit>(
      create: ((context) => CurrentLocaleCubit()),
      child: child,
    );
  }
}
```

> Classe `ViewI18N`, que recebe a localização de `CurrentLocaleCubit` e a retorna utilizando a função `localize`.

```
class ViewI18N {
  String? language;
  ViewI18N(BuildContext context) {
    language = BlocProvider.of<CurrentLocaleCubit>(context).state;
  }

  String? localize(Map<String, String> values) {
    print("linguagem:  $language");
    return values[language];
  }
}
```

Essa função `localize` é usada no nosso `DashboardView` (o qual estende de `ViewI18N`), que traduz os títulos dos botões da página de Dashborad utilizando um _map_ de linguagem e tradução.

> Classe `DashboardViewI18N`.

```
class DashboardViewI18N extends ViewI18N {
  DashboardViewI18N(BuildContext context) : super(context);

  String get transfer =>
      localize({
        "pt-br": "Transferir",
        "en": "Transfer",
      }) ??
      "Transfer";

  String get transactionFeed =>
      localize({
        "pt-br": "Transações",
        "en": "Transaction Feed",
      }) ??
      "Transaction Feed";

  String get changeName =>
      localize({
        "pt-br": "Mudar nome",
        "en": "Change name",
      }) ??
      "Change name";
}
```

Assim, utilizando uma instância de `DashboardViewI18N` chamada `i18n`, traduzimos os nomes da página apenas usando `i18n.transfer`, `i18n.transactionFeed` ou `i18n.changeName`, por exemplo.

> `i18n`, instância de `DashboardViewI18N`.

```
var i18n = DashboardViewI18N(context);

```

## :sparkles: Funcionalidades do projeto

<!-- A aplicação possui as mesmas funcionalidades do projeto [Bytebank API](https://github.com/jhoisz/Bytebank-api), e como adição possui tratamento e demonstração dos diferentes tipos de erros que podem ocorrer.

<p align="center">
  <img src="https://github.com/jhoisz/Bytebank-api-v2/blob/main/bytebankv2apiv2.gif" alt= "Gif colorido da aplicação desenvolvida demonstrando os erros possiveis." />
</p> -->

> :construction: Projeto em construção :construction:

## :hammer: Tecnologias usadas

Neste projeto foram usadas as seguintes tecnologias:

> Framework [Flutter](https://flutter.dev/)

> Linguagem [Dart](https://dart.dev/)

## :arrow_forward: Como executar

Primeiro você deve [instalar flutter](https://docs.flutter.dev/get-started/install).

Então, você pode clocar e entrar na pasta do projeto:

```bash
git clone https://github.com/jhoisz/Bytebank_i18n
cd Bytebank_i18n
```

Agora, para testar, você deve instalar os pacotes/dependêncas e usar um dispositivo conectado ao seu computador ou usar um emulador:

```bash
Flutter get packages
flutter run
```

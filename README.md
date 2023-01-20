# marvel-comics
Marvel comics browser using Marvel API

OPIS:
Ma to być prosta aplikacja, która pobiera dane z REST API Marvela, a następnie wyświetla je użytkownikowi w formie listy komiksów. Dodatkowo użytkownik może wyszukiwać komiksy po wybranej frazie, a także kliknąć w wybrany komiks, aby przejść do ekranu z jego detalami.
DO IMPLEMENTACJI:
1. Użytkownik może przeglądać listę komiksów w formie przewijalnej listy.
2. Użytkownik może wyszukiwać komiksy po nazwie tytułu. Fajnie jakby wyniki wyszukiwania pojawiały się
dynamicznie, czyli, np. po wpisaniu literki "a" pojawiają się wszystkie komiksy, które zawierają w tytule literkę "a" lub "A". Dynamiczne, to znaczy, że użytkownik nie musi kliknąć żadnego przycisku szukaj, a wyniki pokazują się w trakcie wpisywania kolejnych liter szukanej frazy.
3. Użytkownik jest informowany o braku szukanego komiksu, w momencie, gdy wyszukiwana fraza nie zgadza się z żadnym tytułem komiksów na liście.
4. Użytkownik może kliknąć w wybrany komiks i przeniesie go to do nowego widoku, w którym znajdują się informacje o wybranym komiksie.
5. Fajnie jakby projekt znalazł się na GitHub, żeby łatwiej móc sobie o nim pogadać, gdyby pojawiały się jakieś problemy w trakcie jego tworzenia.

SKUP SIĘ NA:
1. Jakości pisanego kodu - niech będzie czytelny, zrozumiały i zgodny z zasadami SOLID.
2. UX/UI - niech działa i wygląda dobrze :D

MATERIAŁY:
1. API Marvela znajduje się pod tym linkiem: https://developer.marvel.com  - należy się tam zarejestrować, aby otrzymać dostęp. Potrzebne informacje znajdują się na ich stronie.
2. Klikalny mockup stworzony w aplikacji Figma znajduje się pod tym linkiem - https://www.figma.com/proto/CET2h3XyxsvNMi8Wz2P5HW/Comics-app?node-id=103:2815&viewport=769,-1151,0.47655215859413147&scaling=min-zoom - warto sobie przeklikać, żeby zobaczyć jak appka ma wyglądać.

PODPOWIEDZI:
1. Polecam zrobić projekt w architekturze MVC (Model-View-Controller).
2. Odczytywanie pobranych danych dobrze jest zrobić poprzez dekodowanie JSON'a przy pomocy
struktur zgodnych z protokołem Decodable.
3. Ważna tu jest wiedza o domknięciach (closures) - gdy pobieranie danych z API się zakończy, wtedy
appka ma wypełnić listę komiksami.
4. Do pobierania zdjęć można wykorzystać bibliotekę Kingfisher (ważna jest tu znajomość instalowania
frameworków, np. przy pomocy CocoaPods).

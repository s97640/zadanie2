# Zadanie drugie - PAwChO - Jakub Kopacki
Repozytorium zawierające rozwiązanie zadanie drugiego z przedmiotu Programowanie aplikacji w chmurze obliczeniowej

## Etap pierwszy - wykorzystanie aplikacji z zadania pierwszego

- Plik Dockerfile z zadania pierwszego nie wymagał praktycznie żadnych zmian. Zmieniono jedynie metadane:

[![image.png](https://i.postimg.cc/YqbdYCqj/image.png)](https://postimg.cc/pp5Qtxjt)

## Etap drugi - stworzenie łańcucha CI

- Sprawdzenie statusu zalogowania do githuba:

[![image.png](https://i.postimg.cc/t4n4W7tz/image.png)](https://postimg.cc/WdjVPNyD)

- Dodanie zmiennej oraz sekretów:

[![image.png](https://i.postimg.cc/fbh5ht82/image.png)](https://postimg.cc/cvXfRHyw)

[![image.png](https://i.postimg.cc/502BxwL3/image.png)](https://postimg.cc/d7gk6ZWk)

Klucz SSH został skonfigurowany podczas realizacji poprzedniego ćwiczenia.

- Uruchomienie łańcucha CI:

[![image.png](https://i.postimg.cc/SNFwKs19/image.png)](https://postimg.cc/bdg6CzhY)

- Sprawdzenie poprawności wykonanych działań:

Github Actions:

[![image.png](https://i.postimg.cc/0NFVHWLS/image.png)](https://postimg.cc/06GGzf55)

Dockerhub:

[![image.png](https://i.postimg.cc/Wz93VH0N/image.png)](https://postimg.cc/64vwLzHg)

GHCR:

[![image.png](https://i.postimg.cc/763GF9Bh/image.png)](https://postimg.cc/sQ2gSYCC)

- Sprawdzenie, czy obraz nie zawiera zagrożeń wysokich lub krytycznych zostało wykonane za pomocą Trivy. Na początku Trivy został zainstalowany, następnie zostało wykonane sprawdzenie zagrożeń, a potem, jeżeli test nie wykazał znaczących luk, następowało logowanie do GHCR, gdzie potem obraz był przesyłany.

[![image.png](https://i.postimg.cc/854WFwL3/image.png)](https://postimg.cc/HcJjRwZ4)

- Do połączenia SSH został wykorzystany webfactory ssh-agent, który eksportuje zmienną env.SSH_AUTH_SOCK z kluczem SSH.

[![image.png](https://i.postimg.cc/8CBwHRhd/image.png)](https://postimg.cc/rdsSytZz)
# Zadanie pierwsze - PAwChO - Jakub Kopacki
Repozytorium zawierające rozwiązanie zadanie pierwszego z przedmiotu Programowanie aplikacji w chmurze obliczeniowej

- Tworzenie buildera wykorzystującego sterownik docker-container:

```cmd  
docker buildx create --name zadanie1builder --driver docker-container --bootstrap
```

```cmd
docker buildx ls
```

```cmd
docker buildx use zadanie1builder
```

[![image.png](https://i.postimg.cc/j2h5151Z/image.png)](https://postimg.cc/ZvC4BT4d)

- Logowanie do GitHub za pomocą GitHub CLI:

[![image.png](https://i.postimg.cc/PqxfdDfw/image.png)](https://postimg.cc/3ksQBdv8)

- Utworzenie programu serwera w JavaScript korzystając z Express oraz ipapi:

[![image.png](https://i.postimg.cc/g2RLswtf/image.png)](https://postimg.cc/k2J5X5mc)

- Utworzenie pliku Dockerfile wykorzystującego rozszerzony frontend, wieloetapowość, pobieranie plików projektu z repozytorium za pomocą połączenia ssh oraz sprawdzanie stanu aplikacji.

[![image.png](https://i.postimg.cc/x19mgvhB/image.png)](https://postimg.cc/gnBr2ZYK)

- Polecenia służące do zbudowania obrazu i uruchomienia kontenera:

```cmd
docker buildx build --build-arg VERSION=1.0 --ssh hpl21git=C:\Users\jkopa\.ssh\id_ed25519 -t docker.io/hpl21/zadanie1:latest --platform linux/amd64,linux/arm64 --cache-to=type=registry,mode=max,ref=docker.io/hpl21/zadanie1:cache --cache-from=type=registry,mode=max,ref=docker.io/hpl21/zadanie1:cache --push .
```

```cmd
docker pull docker.io/hpl21/zadanie1:latest
```

```cmd
docker run -p 3000:3000 docker.io/hpl21/zadanie1:latest
```

[![image.png](https://i.postimg.cc/FRG3JD99/image.png)](https://postimg.cc/S22JBL25)

- Polecenie do sprawdzenia informacji o obrazie:

```cmd
docker image inspect docker.io/hpl21/zadanie1:latest
```

[![image.png](https://i.postimg.cc/MHpR9jWb/image.png)](https://postimg.cc/TLBpw15p)

- Wykorzystanie narzędzia Docker Scout do oceny jakości obrazu:

```cmd
docker scout enroll hpl21
```

```cmd
docker scout repo enable --org hpl21 hpl21/zadanie1
```

```cmd
docker scout quickview hpl21/zadanie1:latest
```

```cmd
docker scout cves hpl21/zadanie1:latest
```

[![image.png](https://i.postimg.cc/wT7HpTMW/image.png)](https://postimg.cc/1fhb0Sp6)

- Repozytorium widoczne w serwisie Docker Hub:

[![image.png](https://i.postimg.cc/RVV1C2xp/image.png)](https://postimg.cc/WtCqXW30)
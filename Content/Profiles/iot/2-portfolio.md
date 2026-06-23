# Portfolio

## Projektübersicht

- **IoT & Embedded Systems**
  - [regenfass.eu](#regenfasseu) IoT Smart-Home-Eigenprodukt
  - [CoffeeBin](#coffeebin) Sensor-Datenerfassung und Analytics
  - [Digitaler Agenturkicker](#digitaler-agenturkicker) IoT Multichannel-Experiment

- **Cloud & Observability**
  - [EDEKA - Observability PoC](#EDEKA-Observability-PoC)
    OpenTelemetry im SAP-Kontext
  - [EDEKA - Kassensoftware Integration](#edeka-pos-integration)
    Integration der Gebit-Kassenlösung für EDEKA

- **Webentwicklung**
  - [kieks.me](#kieksme) Consulting- und Freelance-GbR
  - [AIDA board portal](#aida-board-portal) Gästeportal für AIDA Cruises
  - [dynamo-dresden.de](#dynamo-dresdende) High-Performance-Webanwendung
  - [Blugento](#blugento) Docker, Marketing-Automation, AWS

- **CI/CD**
  - [Universal Music - Shop-Manager](#universal-music--shop-manager) Schulungen, Docker, CI/CD, Cloud (AWS, Azure)

- **[Weitere Projekte](#weitere-projekte)**
  - [Bashlight](#bashlight) Kommandozeilen-Erweiterung

---

## IoT & Embedded Systems

### regenfass.eu

_2024 – heute_

**regenfass.eu** ist ein IoT-Eigenprodukt für Smart-Home-Anwendungen. Das
Produkt verbindet Hardware-Sensoren mit einer Cloud-basierten Datenplattform
zur Überwachung und Steuerung von Smart-Home-Komponenten. Die gesamte Kette –
von der Firmware auf dem Mikrocontroller über das LoRaWAN-Gateway bis zur
Cloud-API und Visualisierung – wird eigenständig entwickelt und betrieben.

**Meine Aufgaben:** Produktentwicklung, Firmware-Entwicklung, Cloud-Architektur,
IoT-Integration, Dokumentation.

| Technologische Highlights      |                                  |
|--------------------------------|----------------------------------|
| IoT / Mikrocontroller (ESP32)  | Firmware & Hardware-Integration  |
| LoRaWAN / MQTT                 | Gerätekommunikation              |
| [Node-RED][node-red]           | Datenfluss & Automation          |
| [InfluxDB][influxdb]           | Zeitreihenspeicherung            |
| [Grafana][grafana]             | Datenvisualisierung              |
| [OpenTelemetry][opentelemetry] | Observability                    |

| Links         |                              |
|---------------|------------------------------|
| Dokumentation | <https://docs.regenfass.eu/> |

---

### CoffeeBin

_2020_

![img.png](Media/Portfolio/coffee-bin-nodered.png)

Big-Data-Applikation zur Erfassung von Kaffee-Trink-Daten bei
[Netresearch DTT GmbH][netresearch]. Ein Taster am Kaffeevollautomaten sendet
via WLAN einen Event. Die Daten werden in einer zeitbasierten Datenbank
gespeichert. Das Interessante daran ist, welche Schlüsse man aus den zunächst
banal erscheinenden Daten ziehen kann – z.B. lässt sich ein Stresslevel
ablesen, wenn man die Daten mit JIRA-Ticket-Volumina korreliert.

**Technologische Highlights:** Firmware in C++ (Tasmota) auf einem ESP8266,
Node-RED zur Steuerung und Verarbeitung der Datenströme, InfluxDB als
Zeitreihendatenbank, Grafana zur Visualisierung.

![CoffeeBin Dashboard](Media/Portfolio/coffee-bin.png)

| Technologische Highlights         |                                                                                                      |
|-----------------------------------|------------------------------------------------------------------------------------------------------|
| [Tasmota][tasmota]                | C++ Firmware zur Sensor-Datenerfassung (ESP8266)                                                     |
| [Node-RED][node-red]              | zur Steuerung von Events und Versenden von Nachrichten an Twitter und den firmeninternen Slack-Chat  |
| [InfluxDB][influxdb]              | zeitbasierte Speicherung der Daten                                                                   |
| [Grafana][grafana]                | zur Visualisierung der Daten                                                                         |

### Digitaler Agenturkicker

_2015 - 2016_

![](Media/Portfolio/piball-header.png)
![](Media/Portfolio/piball.png)

Die Digitalisierung des Agentur-Kickers ist ein _Multichannel-Experiment_,
das im Rahmen meiner Research-&-Development-Zeit bei der [Netresearch DTT
GmbH][netresearch] entstanden ist. Ziel war es, möglichst viele Ausspielkanäle
mit einer zentralen Datenbasis zu bedienen. Besondere Herausforderung: die
Integration von Hardware-Komponenten (Raspberry Pi, Gabellichtschranken) und
das Flottenmanagement von dockerisierten Anwendungen auf ARM-Architektur.

| Technologische Highlights                                 |                                                                                                                                                                    |
|-----------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Docker][docker]                                          | auf einer ARM-Architektur (Raspberry Pi)                                                                                                                           |
| [Python][python]                                          | zum Ansprechen von Hardware-Komponenten (GPIO, Gabellichtschranken)                                                                                                |
| [Google Firebase][google-firebase]                        | Echtzeit-Datenbank für Spielstände                                                                                                                                 |
| [Node-RED][node-red]                                      | zur Steuerung von Events und Versenden von Nachrichten                                                                                                             |
| [Vue.js][vue.js]                                          | Anzeigeoberfläche                                                                                                                                                  |
| [Ionic Framework][ionic-framework]                        | native App für iOS und Android                                                                                                                                     |
| [Google Chrome Extension][google-chrome-extension-piball] | zur Anzeige der Ergebnisse direkt im Browser                                                                                                                       |
| [Belana.io][belana.io]                                    | Flottenmanagement der dockerisierten Anwendung                                                                                                                     |

[google-chrome-extension-piball]: https://chrome.google.com/webstore/detail/piball/ejahllipniehmpdjkfjmhhadeeamdebh?authuser=1&gclid=Cj0KCQiAqvaNBhDLARIsAH1Pq53cYjAiaEGVxuANGCggDpF6nSdgcij-7fla8VVSs3KuESNg-YiemskaAgZREALw_wcB

| Links                                                     |                                                      |
|-----------------------------------------------------------|------------------------------------------------------|
| Präsentation                                              | <https://prezi.com/khpva--2yv25/foosball/?present=1> |
| GitHub Repository                                         | <https://github.com/vergissberlin/piball>            |
| Web interface                                             | <https://vivid-fire-2266.web.app>                    |

---

## Cloud & Observability

### Observability EDEKA PoC

_2023_

EDEKA möchte mehr Transparenz in seine Prozesse bringen. Viele Microservices
laufen in einem Orchester ohne Dirigenten. Mit der Observability-Plattform
wird es möglich, die Prozesse zu überwachen und bei Bedarf zu
intervenieren. In diesem PoC galt es, den Nachweis der Machbarkeit zu liefern,
dass OpenTelemetry im SAP-Kontext eingesetzt werden kann.

**Meine Aufgaben** waren die Team- und Projektleitung. Ich habe die
Softwarearchitektur entwickelt und die Installation der Software auf den
Demonstrationsservern durchgeführt.

| Technologische Highlights          |                |
|------------------------------------|----------------|
| [OpenTelemetry][opentelemetry]     | Im SAP-Kontext |
| [Jaeger][jaeger]                   | Tracing        |
| [Prometheus][prometheus]           | Monitoring     |
| [DataDog][datadog]                 | Observability  |

### kieks.me

_2025 – heute_

**[kieks.me][kieksme]** ist eine Consulting- und Freelance-GbR für
Web-Entwicklung, SaaS-Websites, Corporate Design und Landing Pages,
die ich 2025 mitgegründet habe.

**Meine Aufgaben:** Mitgründer, Softwarearchitektur, Full-Stack-Entwicklung.

| Technologische Highlights |                           |
|---------------------------|---------------------------|
| [TypeScript][typescript]  | Frontend & Backend        |
| [Vue.js][vue.js]          | Frontend-Entwicklung      |
| [Node.js][nodejs]         | Backend-Entwicklung       |

| Links   |                         |
|---------|-------------------------|
| Website | <https://kieks.me/>     |

---

### AIDA board portal

_2013-2016_

![AIDA Bordportal](Media/Portfolio/aida-bordportal.png)

Das AIDA-Bordportal ist auf AIDA-Schiffen installiert und dient Gästen und
Besatzung zur Orientierung und zur Buchung von Ausflügen und Restaurantplätzen.
Es ist optimiert für TV, Mobile und spezielle Displays in den Gängen.

**Meine Aufgaben** waren die Team- und Projektleitung, die Installation der
Software auf dem Schiff und die Erstellung eines Demosystems.

| Technologische Highlights          |                                    |
|------------------------------------|------------------------------------|
| [Docker-Registry][docker-registry] | auf GitLab                         |
| [Docker Compose][docker-compose]   | für verschiedene Environments      |
| [AWS ECS][aws-ecs]                 | für das Container-Deployment       |
| [AWS EC2][aws-ec2]                 | für das Container-Deployment       |
| [AWS EFS][aws-efs]                 | zum verteilten Speichern von Daten |
| [AWS RDS][aws-rds]                 | zum Datenbank-Deployment           |
| [Concourse CI][concourse-ci]       | als Pipeline-Tool für CI/CD        |

| Links |                                    |
|-------|------------------------------------|
| Demo  | (nicht öffentlich verfügbar)       |

### dynamo-dresden.de

_2014 - 2015_

![Dynamo Dresden Website](Media/Portfolio/dynamo-dresden.png)

Als technischer Leiter war ich für die Planung verantwortlich. Ich war Teil
des Pitches. Außerdem war ich verantwortlich für Lasttests und
Leistungsverbesserungen.

| Technologische Highlights                |                         |
|------------------------------------------|-------------------------|
| [Varnish][varnish]                       | Reverse Proxy           |
| [Edge Side Includes][edge-side-includes] | Edge Side Includes      |
| [Load Testing][jmeter]                   | Lasttests mit JMeter    |
| [TYPO3][typo3]                           | TYPO3 CMS               |

| Links                                                     |                                                              |
|:----------------------------------------------------------|--------------------------------------------------------------|
| Website                                                   | <https://www.dynamo-dresden.de>                              |
| Chrome Extensions Dynamo                                  | <https://chrome.google.com/webstore/search/dynamo%20dresden> |

## Softwareentwicklung

### EDEKA POS Integration

_2023_ - `now()`

Der Kunde beauftragte die Gebit mit der Integration der Kassenlösung in die
EDEKA-Infrastruktur und beauftragte Thinkport als technischen Dienstleister.

Die **Technologie-Highlights** sind **Flutter** für die App-Entwicklung,
**Java** für die Backend-Entwicklung und **Docker** für die Bereitstellung der
Anwendung. **OpenTelemetry** wird für die Observability eingesetzt.

| Technologische Highlights      |                              |
|--------------------------------|------------------------------|
| [Flutter][flutter]             | Frontend-Entwicklung         |
| [Java][java]                   | Backend-Entwicklung          |
| [Kubernetes][kubernetes]       | Bereitstellung der Anwendung |
| [OpenTelemetry][opentelemetry] | Observability                |

### Bashlight

![Bashlight](Media/Portfolio/bashlight.png)

Eine Erweiterung der Kommandozeilen-Eingabeaufforderung, die unter anderem den
Git-Zweig und den Git-Status anzeigt.

| Technologische Highlights |                                    |
|---------------------------|------------------------------------|
| [bash scripting][bash]    | Prompt, Git, Testing, Auto-Update  |

| Links         |                                              |
|---------------|----------------------------------------------|
| Dokumentation | <http://vergissberlin.github.io/bashlight/>  |
| Repository    | <https://github.com/vergissberlin/bashlight> |

### Blugento

_2017 - 2018_

![blugento](Media/Portfolio/blugento.png)

Blugento ist ein Verwaltungssystem für Docker-Anwendungen auf entfernten Servern.

| Technologische Highlights                                 |                                                                         |
|-----------------------------------------------------------|-------------------------------------------------------------------------|
| [Docker-API][docker]                                      | Starten und Stoppen von Anwendungen auf Remote-Systemen                 |
| [Docker Compose][docker-compose]                          | für verschiedene Environments                                           |
| [GraphQL][graphql]                                        | mit [Apollo.js][apollojs] zur Bereitstellung nutzerbasierter Daten      |
| [Vue.js][vue.js]                                          | Frontend                                                                |
| [AWS ECS][aws-ecs] / [AWS EC2][aws-ec2]                   | Container-Deployment                                                    |

| Links                                                     |                            |
|-----------------------------------------------------------|----------------------------|
| Website                                                   | <https://blugento.com>     |

## DevOps

### Universal Music – Shop Manager

_2018-2019_

![Universal Music](Media/Portfolio/umg.png)

Release-Management eines Docker-Basis-Images innerhalb eines internationalen
Teams (Australien, USA, Indien). Schulungen zur entwickelten Software.

| Technologische Highlights          |                                    |
|------------------------------------|------------------------------------|
| [Docker-Registry][docker-registry] | auf GitLab                         |
| [Docker Compose][docker-compose]   | für verschiedene Environments      |
| [AWS ECS][aws-ecs]                 | für das Container-Deployment       |
| [Concourse CI][concourse-ci]       | als Pipeline-Tool für CI/CD        |

| Links                              |                                  |
|------------------------------------|----------------------------------|
| Universal Music Group              | <https://www.universalmusic.com> |

## Weitere Projekte

… auf die ich stolz bin.

| Projekt                  |                                                   |
|:-------------------------|:--------------------------------------------------|
| Node-RED mjml            | Node-RED-Node zur Gestaltung von E-Mail-Templates |
| Node-RED say             | Node-RED-Node zur Ausgabe von Sprachnachrichten   |

[apollojs]: https://www.apollographql.com/


[aws-ecs]: https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ECS_Basics.html

[aws-ec2]: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-types.html

[aws-efs]: https://docs.aws.amazon.com/efs/latest/ug/

[aws-rds]: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MySQL.html


[bash]: https://www.gnu.org/software/bash/

[belana.io]: https://belana.io/

[concourse-ci]: https://docs.concourse.ci/

[docker]: https://www.docker.com/

[docker-compose]: https://docs.docker.com/compose/

[docker-registry]: https://docs.docker.com/registry/

[edge-side-includes]: https://en.wikipedia.org/wiki/Edge_Side_Includes

[flutter]: https://flutter.dev/



[google-firebase]: https://firebase.google.com/

[graphql]: https://graphql.org/

[grafana]: https://grafana.com/

[java]: https://www.java.com/

[kubernetes]: https://kubernetes.io/

[influxdb]: https://influxdb.com/

[ionic-framework]: https://ionicframework.com/

[jmeter]: https://jmeter.apache.org/

[netresearch]: https://www.netresearch.de/

[node-red]: https://nodered.org/


[python]: https://www.python.org/

[tasmota]: https://tasmota.github.io/docs/


[typo3]: https://typo3.org/


[vue.js]: https://vuejs.org/

[varnish]: https://www.varnish-cache.org/


[datadog]: https://www.datadoghq.com/

[opentelemetry]: https://opentelemetry.io/

[jaeger]: https://www.jaegertracing.io/

[prometheus]: https://prometheus.io/

[kieksme]: https://kieks.me/

[typescript]: https://www.typescriptlang.org/

[nodejs]: https://nodejs.org/

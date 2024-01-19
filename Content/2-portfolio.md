# Portfolio

> [Introduction](./0-introduction.md) | [CV](./1-curriculum-vitae.md) | [Portfolio](./2-portfolio.md) | [Contact](3-contact.md)

## Projektübersicht

- **IoT**
    - [CoffeeBin](#-CoffeeBin) Datenvisualisierung und Analytics
    - [Digitaler Agenturkicker](#-Digitaler-Agenturkicker) IoT Multichannel

- **App development**
    - [Flughafen Leipzig/Halle Nachbarschaftsportal](#-lej-nachbarn-app) App development
    - [Tap!Tap!](#-tap-tap) App development
    - [CamFight](#-CamFight) Mobile Web App

- **Web development**
    - [AIDA board portal](#-AIDA-board-portal) Gästeportal für AIDA Cruises
    - [dynamo-dresden.de](#-dynamo-dresdende) High Performance Web Application
    - [Blugento](#-blugento) Docker, Marketing Automation, AWS

- **Desktop**
    - [KiTa Tagesplaner](#-KiTa-Tagesplaner) PWA App
    - [EDEKA neue Kasse](#-edeka-neue-kasse) Kassen-Software für den Einzelhandel

- **CICD**
    - [Universal Mucis - Shop-Manager](#-universal-music--shop-manager) Schulungen, Docker, CICD, Cloud (AWS, Azure)
    - [Flughafen Leipzig/Halle Nachbarschaftsportal](#-lej-nachbarn-app) App development

- **[Weitere Projekte](#-Weitere-Projekte)**
    - [Bashlight](#-Bashlight) Commandline enhancer
    - [EDEKA Distributed Tracing](#-edeka-distributed-tracing-mit-opentelemetry)

---

## Consulting


### [[↑](#projektübersicht)] KiTa Tagesplaner

_2020 - 2021_

![KiTa Tagesplaner](Media/Portfolio/kita-tagesplaner.png)

Erzieherinnen und Erziehern soll ein Werkzeug an die Hand gegeben werden, um den Tagesablauf in der Kita mit Bildern zu
beschreiben. Die Bilder können per Drag-and-Drop ausgewählt und sortiert werden. Zusätzliche Textfelder können eingefügt
werden.

Die **Technologie-Highlights** sind *Vue.js* im Frontend mit *jspdf* für die Erstellung von PDFs. Es handelt sich um
eine einseitige Anwendung, die ohne Internetverbindung genutzt werden kann und auf Desktop-Geräten installierbar ist.
Die Anwendung erkennt den bevorzugten Lichtmodus des Systems und ändert das Styling in den *Dunkelmodus*, wenn dieser
aktiviert ist. Sie verwendet benutzerdefinierte Eigenschaften. Für das Backend habe ich auch eine *REST API* mit *
OpenAPI* erstellt. [fastify](https://www.fastify.io/) war meine Wahl für das Framework.

**Meine Aufgaben:** Full-Stack-Entwicklung, Projektmanagement, Software-Architektur, Kundenbetreuung.

| Technik Highlights                 |                                              |
|------------------------------------|----------------------------------------------|
| [Vue.JS][vue.js]                   | Mobile App mit der Vuetify Component Library |
| [fastify][fastify]                 | Backend-Framework für NodeJS                 |
| [jspdf][jspdf]                     | als Pipeline-Tool für CI/CD                  |
| [OpenAPI][openapi]                 | REST-API-Generierung und Dokumentation       |
| [Heroku][heroku]                   | Deployment pipeline für eine REST API        |

| Links                              |                                                                  |
|------------------------------------|------------------------------------------------------------------|
| App                                | <https://kita-tagesplaner.onrender.com>                          |
| Repository der App                 | <https://github.com/NULLzuEINS/kindergarten-day-planner-app>     |
| Repositorie des Service            | <https://github.com/NULLzuEINS/kindergarten-day-planner-service> |



### [[↑](#projektübersicht)] EDEKA Distributed Tracing mit OpenTelemetry

_03/2023 – 10/2023​_, Projektleitung & Software Architect

Der Kunde betreibt eine hohe Anzahl an verteilten Systemen durch die verschiedenste Fachprozesse laufen. Sei es in 
der Warenwirtschaft, Personalverwaltung, oder dem Lagerbestand. Prozesse wie eine Preisänderung, oder eine Bestellung 
nehmen einen langen Weg durch die Systeme. Ein Demo-Projekt aufzusetzen welches Innerhalb kürzester Zeit transparent 
zu machen kann, wo es zu Problemen kommt, war Ziele dieses Projektes. Ermöglicht wird die durch Distributed Tracing. 
Die implementierung OpenTelemetry hat sich hier zum Marktstandard entwickelt und ich konnte mit meiner Expertise dem 
Kunden helfen diese Demo umzusetzen.​

| Technik Highlights                 |                                                                                                                                              |
|------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------|
| [OpenTelementy][opentelemetry]     | OpenTelemetry ermöglicht verteiltes Tracing & Monitoring für Anwendungen.                                                                    |
| [SAP ABAP][sap-abap]               | Programmiersprache für SAP-Systeme. Datenverarbeitung, Berichte, Schnittstellen.                                                             |
| [SAP PI][sap-pi]                   | SAP PI (Process Integration): Integrierte Plattform für Daten- und Prozesskommunikation.                                                     |
| [SAP RFC][sap-rfc]                 | RFC (Remote Function Call) in SAP: Kommunikationsmechanismus für den Aufruf von Funktionen zwischen verschiedenen SAP-Systemen.              |
| [Java][java]                       | Ist auch eine Insel                                                                                                                          |
| [Datadog][datadog]                 | Datadog: Cloud-Monitoring & Analyseplattform. Überwacht, alarmiert und optimiert die Leistung von Anwendungen.                               |
| [Jaeger][jaeger]                   | Browserbasiertes Interface für die Visualisierung von Tracing-Daten. Erlaubt detaillierte Einblicke in Anwendungsperformance und -verhalten. |


## Projektleitung


### [[↑](#projektübersicht)] AIDA board portal

_2013-2016_, Projektleitung, Teamleiter

![AIDA Bordportal](Media/Portfolio/aida-bordportal.png)

Das AIDA Bordportal ist auf AIDA Schiffen installiert und dient Gästen und Besatzung zur Orientierung und zur Buchung
von Ausflügen und Restaurantplätzen. Es ist optimiert für TV, Mobile und spezielle Displays in den Gängen.

**Meine Aufgaben** waren die Team- und Projektleitung, die Installation der Software auf dem Schiff und die Erstellung
eines Demosystems.

Die **Technologie-Highlights** sind die Unterstützung von *Low-Power-Hardware* (LG TV), *Kartenleser* zum Einloggen in
Benutzerkonten, Bedienung über *Fernbedienung*, Erstellung und Aktualisierung einer Chrome-Erweiterung aus der Ferne,
*verschiedene APIs* auf dem Schiff (Restaurants, Ausflüge, Terminbuchungen …)

| Technologische Highlights          |                                    |
|------------------------------------|------------------------------------|
| [Docker-Registry][docker-registry] | auf GitLab                         |
| [Docker Compose][docker-compose]   | für verschiedene Environments      |
| [AWS ECS][aws-ecs]                 | für das Container-Deployment       |
| [AWS EC2][aws-ec2]                 | für das Container-Deployment       |
| [AWS EFS][aws-efs]                 | zum verteilten Speichern von Daten |
| [AWS RDS][aws-rds]                 | zum Datenbank-Deployment           |
| [Concourse CI][concourse-ci]       | als Pipeline tool für CI/CD        |

| Links |                                                         |
|-------|---------------------------------------------------------|
| Demo  | <https://nr:reiseberater@reiseberater2go.herokuapp.com> |



### [[↑](#projektübersicht)] dynamo-dresden.de

_2014 - 2015_

![Dynamo Dresden Website](Media/Portfolio/dynamo-dresden.png)

Als technischer Leiter war ich für die Planung verantwortlich. Ich war ein Teil des Pitches.
Des Weiteren war ich verantwortlich für Lasttests und Leistungsverbesserungen.

| Technologische Highlights                |                         |
|------------------------------------------|-------------------------|
| [Varnish][varnish]                       | Reverse Proxy           |
| [Edge Side Includes][edge-side-includes] | Edge Side Includes      |
| [Load Testing][jmeter]                   | Load Testing mit jMeter |
| [TYPO3][typo3]                           | TYPO3 CMS               |

| Links                                                     |                                                              |
|:----------------------------------------------------------|--------------------------------------------------------------|
| Website                                                   | <https://www.dynamo-dresden.de>                              |
| Chrome Extensions Dynamo                                  | <https://chrome.google.com/webstore/search/dynamo%20dresden> |


## Software Developement


### EDEKA Neue Kasse

_03-2023 – 07-2024​_, Senior Software Engineer​ 

Der Kunde ist verantwortlich für die Software von über 30.000 Kassen in Deutschland die nun eine völlig neue 
Kassenanwendung bekommen sollen. Mit einer modernen Microservice-Architektur,  Usability Tests, Offlinefähigkeit 
und Online-Services möchte der Kunde den Ansprüchen der Gegenwart entgegentreten. In einem großen Team, mit 
verschiedenen Partnern wird eine neue Kassenlösung entwickelt und Schrittweise auf die Märkte ausgerollt. 
Ich unterstützte dabei durch die Entwicklung das Userinterfaces, sowie bei der Weiterentwicklung der Micro-Services.​

​| Technologische Highlights          |                                                                                                                                                            |
|------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Dart][dart]                       | Programmiersprache von Google, für Web & Mobile. Kombiniert Klasse & Funktion, schnell & effizient. Entwicklerfreundlich, leicht lesbar, gute Performance. |
| [Flutter][flutter]                 | Flutter, von Google entwickelt, ist ein UI-Toolkit für plattformübergreifende App-Entwicklung.                                                             |
| [Java][java]                       | Ist auch eine Insel                                                                                                                                        |
| [Datadog][datadog]                 | Datadog: Cloud-Monitoring & Analyseplattform. Überwacht, alarmiert und optimiert die Leistung von Anwendungen.                                             |
| [OpenTelementy][opentelemetry]     | OpenTelemetry ermöglicht verteiltes Tracing & Monitoring für Anwendungen.                                                                                  |



### [[↑](#projektübersicht)] LEJ Nachbarn App

_2022_

![LEJ Nachbarn App](Media/Portfolio/lejn-store-ios.png)

Der Kunde, Flughafen Leipzig/Halle suchte eine Möglichkeit mit seinen direkten Nachbarn auf digitalem Weg ins Gespräch
zu kommen. Mein Part war die Umsetzung der App-Variante. **React-Native** zeigt hier seine Stärken, da die App für
iOS und Android entwickelt werden konnte und somit die Kosten für die Entwicklung deutlich gesenkt werden konnten.

Durch das Senden von Push-Benachrichtigungen können die Nutzer über neue Nachrichten informiert werden. Die App ist
in der Lage, die Benachrichtigungen auch im Hintergrund zu empfangen und zu verarbeiten.

Die **Technologie-Highlights** Ich habe *React-Native* mit *Expo* (https://expo.dev/) verwendet, um die App zu
erstellen. Ich habe viel über die Richtlinien/Anforderungen des *Google Play Store* gelernt.

![LEJN Pipeline](Media/Portfolio/lejn-pipeline.png)

Teil des Projektes war die Erstellung einer CI/CD-Pipeline. Die Pipeline habe ich mit GitLab CI erstellt.
Sie enthält die folgenden Schritte:

1. Build der App
2. Testen der App
3. Deployment der App auf Expo _(Bereitstellung einer Review-App bei Merge-Requests)_
4. Deployment der App auf Google Play Store
5. Deployment der App auf Apple App Store


| Technologische Highlights              |                                  |
|----------------------------------------|----------------------------------|
| [React Native][react-native]           | auf GitLab                       |
| [Expo][expo]                           | Zur Appentwicklung im Browser    |
| [Google Play Store][google-play-store] | Veröffentlichung der Anwendung   |
| Push Benachrichtigungen                | Push Benachrichtigungen mit Expo |

| Links             |                                                                        |
|-------------------|------------------------------------------------------------------------|
| Website           | <https://taptap.andrelademann.de>                                      |
| Repository        | <https://github.com/vergissberlin/tap-tap->                            |
| Google Play Store | <https://play.google.com/store/apps/details?id=com.netresearch.portal> |
| Apple AppStore    | <https://apps.apple.com/de/app/lej-nachbarn/id1620877158?uo=4>         |


### [[↑](#projektübersicht)] Tap! Tap!

_2020_

![Tap! Tap! Play store](Media/Portfolio/tap-tap.png)

Dies ist ein **React-Native** Game-Experiment. Ein Bildschirm - zwei Spieler. Mit jedem Klick auf den Button wird der
Button größer und der Button des Gegners kleiner. Man gewinnt, wenn der eigene Button die gesamte Spielfläche abdeckt.
Inspiriert wurde ich von einem Spiel, das wir in der Schule auf unseren Taschenrechnern gespielt haben.

Die **Technologie-Highlights** Ich habe *React-Native* mit *Expo* (https://expo.dev/) verwendet, um die App zu
erstellen. Ich habe viel über die Richtlinien/Anforderungen des *Google Play Store* gelernt.

| Technologische Highlights              |                                |
|----------------------------------------|--------------------------------|
| [React Native][react-native]           | auf GitLab                     |
| [Expo][expo]                           | Zur Appentwicklung im Browser  |
| [Google Play Store][google-play-store] | Veröffentlichung der Anwendung |

| Links             |                                                                          |
|-------------------|--------------------------------------------------------------------------|
| Website           | <https://taptap.andrelademann.de>                                        |
| Repository        | <https://github.com/vergissberlin/tap-tap->                              |
| Google Play Store | <https://play.google.com/store/apps/details?id=com.vergissberlin.taptap> |

### [[↑](#projektübersicht)] Bashlight

![Bashlight](Media/Portfolio/bashlight.png)

Eine Erweiterung der Kommandozeilen-Eingabeaufforderung, die unter anderem den Git-Zweig und den Git-Status anzeigt. In
der Zwischenzeit gibt es Andere, bessere OpenSource-Projekte zu diesem Thema. Aus diesem Grund habe ich das Projekt
archiviert.

| Technologische Highlights |                                    |
|---------------------------|------------------------------------|
| [bash scripting][bash]    | Prompt, Git, Testing,  Auto update |

| Links         |                                              |
|---------------|----------------------------------------------|
| Dokumentation | <http://vergissberlin.github.io/bashlight/>  |
| Repository    | <https://github.com/vergissberlin/bashlight> |


### [[↑](#projektübersicht)] CoffeeBin

_2020_

![img.png](Media/Portfolio/coffee-bin-nodered.png)

Big-Data-Applikation zur Erfassung von Kaffee-Trink-Daten bei Netresearch DTT GmbH. Die Daten werden in einer zeitbasierten Datenbank gespeichert.
Das Interessante daran ist nun, welche Schlüsse man aus den zunächst banal erscheinenden Daten ziehen kann. Setzt man die Daten in Beziehung zu anderen Daten wie der Anzahl der Tickets im JIRA, lässt sich so eventuell ein Stresslevel ablesen.
Mit Fachgebiet der Datenanalyse beschäftige ich mich hauptsächlich in meiner Freizeit.

**Technologische Highlights** neben der Entwicklung in C++ zur Erfassung der Daten, kam hier Node-RED zur Steuerung und
verarbeitung der Datenströme zum Einsatz. Die Speicherung erfolgt in der zeitbasierenden Datenbank InfluxDB und die
Visualiserung mit Grafana.

![Camp Fight Prototyp](Media/Portfolio/coffee-bin.png)

| Technologische Highlights         |                                                                                                      |
|-----------------------------------|------------------------------------------------------------------------------------------------------|
| [Tasmota][tasmota]                | C++ zur Erfassung der Daten                                                                          |
| [NodeRED][node-red]               | zur Steuerung von Events und versenden von Nachrichten an Twitter und den Firmeninternen Slack-Chat. |
| [InfluxDB][influxdb]              | zeitbasierende Speicherung der Daten                                                                 |
| [Grafana][grafana]                | zur Visualisierung der Daten                                                                         |

### [[↑](#projektübersicht)] CamFight

_2017_

![Camp Fight Prototyp](Media/Portfolio/cam-fight.png)

WebApp erstellt für ein Team-Event. Es handelt sich um eine digitalisierte Form
einer [Fotorallye](http://www.games-wiki.org/wiki/Photo_rally/). Die Teilnehmer werden nach dem Zufallsprinzip einem
Team zugewiesen und müssen innerhalb einer bestimmten Zeit Aufgaben lösen. Das Ergebnis jeder Aufgabe ist immer ein
Foto, das dann am Ende zum Sieger gekürt werden kann. Entstanden als F&E-Projekt innerhalb einer Woche.

Das Besondere dabei war, dass wir zu zweit nur 4 Tage Zeit hatten, um die App zu realisieren. **Rapid Prototyping** mit
Papierprototypen und Figma direkt mit dem Kunden. **Meine Aufgaben waren** die Erstellung der App, des Frontends, das
Projektmanagement, die Softwarearchitektur und der Kundensupport.

**Technologische Highlights** waren Vue.js im Frontend mit Vuetify als Komponentenbibliothek, surge.sh statischer
Dateiserver mit TravisCI Deployment-Automatisierung und REST API mit PHP-Backend und PostMan als Dokumentationstool und
Amazon S3 für Benutzer-Uploads. Die App war auf mobilen Geräten installierbar. Derzeit gibt es keine aktive
Herausforderung.

| Technologische Highlights        |                                                   |
|----------------------------------|---------------------------------------------------|
| [Heroku][heroku]                 | Deployment der REST API                           |
| [Vue.JS][vue.js]                 | Mobile App mit der Vuetify Komponenten-Bibliothek |
| [Vuetify][vuetify]               | Komponenten-Bibliothek für vue.JS                 |
| [AWS S3][aws-s3]                 | Zum Upload der Fotos durch die Nutzer             |
| [Travis CI][travis-ci]           | als Pipeline tool für CI/CD                       |
| [Postman][postman]               | API Dokumentation                                 |

| Links                            |                                              |
|----------------------------------|----------------------------------------------|
| App                              | <https://cam-fight.surge.sh>                 |
| Repository                       | <https://github.com/vergissberlin/cam-fight> |
| Prototype                        | <https://marvelapp.com/prototype/ahg35jj>    |

### [[↑](#projektübersicht)] Digitaler Agenturkicker

_2015 - 2016_

![](Media/Portfolio/piball-header.png)
![](Media/Portfolio/piball.png)

Die Digitalisierung des Agentur-Kickers ist ein *Multichannel-Experiment* welches im Rahmen meiner Research &
Development Zeit bei der [Netresearch DTT GmbH][netresearch] entstanden ist. Ziel war es möglichst viele Ausspielkanäle
mit einer zentralen Datenbasis zu bedienen. Zusätzliche Herausforderungen waren hier die Hardwarekomponenten und das
Flottenmanagement mit Belana für dockerisierte Anwendungen. Im Rahmen der Entwicklung habe ich mich mit vielen neuen
Technologien auseinandergesetzt was mir große Freude bereitete. Es steht daher auch für mich ein großes Interesse an der
Entwicklung von Software und Hardware.

| Technologische Highlights                                 |                                                                                                                                                                    |
|-----------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Docker][docker]                                          | auf einer ARM Architektur                                                                                                                                          |
| [Vue.JS][vue.js]                                          | Mobile App mit der Vuetify Komponenten-Bibliothek                                                                                                                  |
| [Python][python]                                          | zum Ansprechen von Hardware-Komponenten                                                                                                                            |
| [Google Firebase][google-firebase]                        | zur Authentifizierung und Nutzung der Echtzeit-Datenbank                                                                                                           |
| [Google Chrome Extension][google-chrome-extension-piball] | zur Anzeige der Ergebnisse direkt im Browser und zum Auslösen von Notifications. Verfügbar im [Chrome Web Store][google-chrome-extension-piball].                  |
| [Ionic Framework][ionic-framework]                        | zur Erstellung einer Native App fpr iOS und Androidm                                                                                                               |
| [Belana.io][belana.io]                                    | zum Flottenmanagement der dockerisierten Anwendung und Node-RED zum Steuern von Events und versenden von Nachrichten an Twitter und den Firmeninternen Slack-Chat. |
| [NodeRED][node-red]                                       | zur Steuerung von Events und versenden von Nachrichten an Twitter und den Firmeninternen Slack-Chat.                                                               |

[google-chrome-extension-piball]: https://chrome.google.com/webstore/detail/piball/ejahllipniehmpdjkfjmhhadeeamdebh?authuser=1&gclid=Cj0KCQiAqvaNBhDLARIsAH1Pq53cYjAiaEGVxuANGCggDpF6nSdgcij-7fla8VVSs3KuESNg-YiemskaAgZREALw_wcB

| Links                                                     |                                                      |
|-----------------------------------------------------------|------------------------------------------------------|
| Präsentation                                              | <https://prezi.com/khpva--2yv25/foosball/?present=1> |
| GitHub Repository                                         | <https://github.com/vergissberlin/piball>            |
| Web interface                                             | <https://vivid-fire-2266.web.app>                    |


### [[↑](#projektübersicht)] Blugento

_2017 - 2018_

![blugento](Media/Portfolio/blugento.png)

Blugento ist ein Verwaltungssystem für Docker-Anwendungen. Hiermit ist es möglich auf entfernten Server Docker-Images
starten, konfigurieren, anpassen, starten, aktualisieren und stoppen. Durch die eingebaute Web-Console ist es auch
Möglich das System aus der Ferne zu debuggen.

Environments können durch die Nutzer verwaltet werden. Die Server können in der Cloud oder lokal auf dem Server
gestartet werden. Durch ein Benutzer-Rechte-System ist es möglich auch Kunden Zugriff auf die Anwendung zu gewähren.
Durch _blugento_ können im Handumdrehen Demo-Instanzen hochgefahren werden, aber auch Systeme für den Live-Betrieb
verwalten.

| Technologische Highlights                                 |                                                                         |
|-----------------------------------------------------------|-------------------------------------------------------------------------|
| [Docker-API][docker]                                      | Zum Starten und Stoppen von Anwendungen auf Remote-Systemen             |
| [Docker-Registry][docker-registry]                        | auf selbst-gehostetem GitLab                                            |
| [Docker Compose][docker-compose]                          | für verschiedene Environments                                           |
| [Concourse CI][concourse-ci]                              | als Pipeline tool für CI/CD                                             |
| [GraphQL][graphql]                                        | Mit dem [Apollo.JS][apollojs] zur Bereitstellung nutzer-basierter Daten |
| [Travis CI][travis-ci]                                    | als Pipeline tool für CI/CD                                             |
| [Vue.JS][vue.js]                                          | Mobile App mit der Vuetify Komponenten-Bibliothek                       |
| [Autopilot Marketing Automation][autopilot]               | Marketing-Automatisation und Nutzerunterstützung                        |
| [Hubspot Marketing Automation][hubspot]                   | Marketing Funnel für Beta-Tester                                        |
| [Sphinx][sphinx]                                          | Bereitstellung einer Dokumentation                                      |

| Links                                                     |                            |
|-----------------------------------------------------------|----------------------------|
| Website                                                   | <https://blugento.com>     |
| App                                                       | <https://app.blugento.com> |


## DevOps

### [[↑](#projektübersicht)] Universal Music – Shop Manager

_2018-2019_

![Universal Music](Media/Portfolio/umg.png)

Mit der entwickelten Software ist es dem Kunden UMG möglich umgehend neue Magento Webshops für seine Klienten
aufzusetzen und zu gestalten, ohne dazu auf Entwickler beauftragen zu müssen.

Innerhalb eines internationalen Teams (Australien, USA, Indien) war ich für das Release-Management des von mir
verwaltetet Docker-Basis-Images für die UMG Shops verantwortlich. Ich gab dem Kunden und dem Team eine eigene Version
des Images mit einer eigenen Softwarebasis. Diese Software basiert auf
der [Docker Compose](https://docs.docker.com/compose/overview/) und wurde mit einer eigenen Docker-Registry verwaltet.
Die stetige Weiterentwicklung des dabei verwendeten Docker-Images gehörte zu meinen Aufgaben.

Ich gab dem Team und dem Kunden Schulungen zur Verwendung der entwickelten Software.

| Technologische Highlights          |                                    |
|------------------------------------|------------------------------------|
| [Docker-Registry][docker-registry] | auf GitLab                         |
| [Docker Compose][docker-compose]   | für verschiedene Environments      |
| [AWS ECS][aws-ecs]                 | für das Container-Deployment       |
| [AWS EC2][aws-ec2]                 | für das Container-Deployment       |
| [AWS EFS][aws-efs]                 | zum verteilten Speichern von Daten |
| [AWS RDS][aws-rds]                 | zum Datenbank-Deployment           |
| [Concourse CI][concourse-ci]       | als Pipeline tool für CI/CD        |

| Links                              |                                  |
|------------------------------------|----------------------------------|
| Universal Music Group              | <https://www.universalmusic.com> |


## [[↑](#projektübersicht)] Weitere Projekte

… auf die ich stolz bin.

| Projekt                                                                                |                                                   |
|:---------------------------------------------------------------------------------------|:--------------------------------------------------|
| [Node-RED mjml ↗](https://flows.nodered.org/node/@example/node-red-contrib-mjml) | Node-RED node zur Gestaltung von E-Mail templates |
| [Node-RED say ↗](https://flows.nodered.org/node/@example/node-red-contrib-say)   | Node-RED node zur Ausgabe von Sprachnachrichten   |


[apollojs]: https://www.apollographql.com/

[autopilot]: https://www.autopilot.io/

[aws-ecs]: https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ECS_Basics.html

[aws-ec2]: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-types.html

[aws-efs]: https://docs.aws.amazon.com/efs/latest/ug/

[aws-rds]: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MySQL.html

[aws-s3]: https://aws.amazon.com/s3/

[bash]: https://www.gnu.org/software/bash/

[belana.io]: https://belana.io/

[concourse-ci]: https://docs.concourse.ci/

[datadog]: https://www.datadoghq.com/

[docker]: https://www.docker.com/

[docker-compose]: https://docs.docker.com/compose/

[docker-registry]: https://docs.docker.com/registry/

[edge-side-includes]: https://en.wikipedia.org/wiki/Edge_Side_Includes

[expo]: https://expo.io/

[fastify]: https://www.fastify.io/

[google-chrome-extension]: https://chrome.google.com/webstore/detail/google-chrome-extension-for-t/nmmhkkegccagdldgiimedpiccmgmiednk

[google-chrome-extension-dynamo]: https://chrome.google.com/webstore/search/dynamo

[google-firebase]: https://firebase.google.com/

[google-play-store]: https://play.google.com/store/apps/details?id=com.example.taptap

[graphql]: https://graphql.org/

[grafana]: https://grafana.com/

[heroku]: https://dashboard.heroku.com/apps/camfight-app

[hubspot]: https://www.hubspot.com/

[influxdb]: https://influxdb.com/

[ionic-framework]: https://ionicframework.com/

[jaeger]: https://www.jaegertracing.io/

[java]: https://www.java.com/de/

[jmeter]: https://jmeter.apache.org/

[jspdf]: https://parall.ax/products/jspdf

[netresearch]: https://www.netresearch.de/

[node-red]: https://nodered.org/

[openapi]: https://swagger.io/specification/

[opentelemetry]: https://opentelemetry.io/

[postman]: https://www.getpostman.com/

[python]: https://www.python.org/

[react-native]: https://reactnative.dev/

[sap-abap]: https://learning.sap.com/learning-journeys/acquire-core-abap-skills/understanding-the-basics-of-abap_c0e5346f-a136-4b9f-a167-9031eca12932

[sap-pi]: https://help.sap.com/doc/saphelp_nw75/7.5.5/de-DE/8e/995afa7a8d467f95a473afafafa07e/content.htm?no_cache=true

[sap-rfc]: https://help.sap.com/doc/saphelp_em92/9.2/de-DE/48/9f1952a81417cee10000000a421937/content.htm?no_cache=true

[sphinx]: https://www.sphinx-doc.org/

[tasmota]: https://tasmota.github.io/docs/

[travis-ci]: https://travis-ci.org/

[typo3]: https://typo3.org/

[vue.js]: https://vuejs.org/

[varnish]: https://www.varnish-cache.org/

[vuetify]: https://vuetifyjs.com/

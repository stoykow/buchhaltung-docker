## Deployment

1. `.env` aus `.env.example` erstellen und Werte setzen.
2. `docker compose up -d --build`

Hinweis: Beim Container-Start wird Composer automatisch ausgefuehrt.
Falls eine composer.lock nicht zu composer.json passt, faellt der Startprozess
auf `composer update --no-dev` zurueck, damit Abhaengigkeiten wie
`horstoeko/zugferd` vorhanden sind.

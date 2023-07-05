# Strapi

[Strapi](https://strapi.io/) - Open Source Node.js Headless CMS

## Stack

- Strapi 4+
- Node.js 18+
- MariaDB 10.10+
- SQLite (for development)

## Configuration

We use these plugins in Strapi:

- upload ([aws-s3](https://www.npmjs.com/package/@strapi/provider-upload-aws-s3))
- email ([nodemail](https://www.npmjs.com/package/@strapi/provider-email-sendmail))
- sentry ([sentry](https://www.npmjs.com/package/@strapi/plugin-sentry))

## Development

**Makefile**

```
➜ make
Usage:
  make <target>

Targets:
  clean                Clean strapi files
  dev                  Start Strapi for local development
  docker-build         Docker image build
  docker-dev           Run docker image
  docker-mariadb       Run mariadb container
  docker-push          Push docker image to registry
  docker-up            Run docker containers
  install              Install all dependencies
  start                Strapi start sequence (build + start)
  strapi-admin         Strapi GUI development
  strapi-build         Build Strapi CMS
```

**ENV**

```env
# Strapi
HOST=0.0.0.0
PORT=1337
DOMAIN=http://localhost:1337
APP_KEYS=strapi
API_TOKEN_SALT=strapi
ADMIN_JWT_SECRET=strapi
JWT_SECRET=strapi

# Database
DATABASE_TYPE=sqlite
DATABASE_URL=postgres://postgres:strapi@0.0.0.0:5432/strapi

# S3
S3_ENABLED=false
S3_ACCESS_KEY_ID=strapi
S3_ACCESS_SECRET=strapi
S3_ENDPOINT=https://s3.yourserver
S3_BUCKET=strapi

# Emails
SMTP_ENABLED=false
SMTP_HOST=smtp.yourserver
SMTP_PORT=587
SMTP_USERNAME=
SMTP_PASSWORD=

# Sentry
SENTRY_ENABLED=false
SENTRY_DSN=sentry

```

module.exports = ({ env }) => {
  const plugins = {};

  // File uploads
  if (env.bool("S3_ENABLED", false)) {
    plugins['upload'] = {
      config: {
        provider: "aws-s3",
        providerOptions: {
          accessKeyId: env("S3_ACCESS_KEY_ID"),
          secretAccessKey: env("S3_ACCESS_SECRET"),
          endpoint: env("S3_ENDPOINT"),
          params: {
            Bucket: env("S3_BUCKET")
          },
          s3ForcePathStyle: true
        },
        actionOptions: {
          upload: {},
          uploadStream: {},
          delete: {}
        }
      }
    }
  }

  // Emails
  if (env.bool("SMTP_ENABLED", false)) {
    plugins['email'] = {
      config: {
        provider: "nodemailer",
        providerOptions: {
          host: env("SMTP_HOST"),
          port: env("SMTP_PORT", 587),
          auth: {
            user: env("SMTP_USERNAME"),
            pass: env("SMTP_PASSWORD")
          }
        },
        settings: {
          defaultFrom: env("SMTP_FROM", "strapi@localhost"),
          defaultReplyTo: env("SMTP_REPLY_TO", "strapi@localhost"),
        }
      }
    }
  }

  // Sentry
  if (env.bool("SENTRY_ENABLED", false)) {
    plugins['sentry'] = {
      enabled: env.bool('SENTRY_ENABLED', false),
      config: {
        dsn: env('SENTRY_DSN'),
      },
    }
  }

  return plugins;
};

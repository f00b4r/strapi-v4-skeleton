const path = require("path");
const parse = require('pg-connection-string').parse;

module.exports = ({ env }) => {
  const client = env("DATABASE_TYPE", "postgres");

  // SQLite
  if (client === "sqlite") {
    return {
      connection: {
        client: "sqlite",
        connection: {
          filename: path.join(__dirname, "..", env("DATABASE_FILENAME", ".tmp/data.db"))
        },
        useNullAsDefault: true
      }
    };
  }

  // MySQL/MariaDB
  if (client === "mysql") {
    const config = parse(String(env('DATABASE_URL')));

    return {
      connection: {
        client: env("DATABASE_TYPE", "mysql"),
        connection: {
          host: config.host,
          port: config.port,
          database: config.database,
          user: config.user,
          password: config.password,
          ssl: env.bool('DATABASE_SSL', false),
        },
        debug: env.bool("DATABASE_DEBUG", false),
      }
    };
  }

  // PostgreSQL
  if (client === "postgres") {
    const config = parse(String(env('DATABASE_URL')));

    return {
      connection: {
        client: env("DATABASE_TYPE", "postgres"),
        connection: {
          host: config.host,
          port: config.port,
          database: config.database,
          user: config.user,
          password: config.password,
          ssl: env.bool('DATABASE_SSL', false),
        },
        debug: env.bool("DATABASE_DEBUG", false),
      }
    };
  }

  throw `Unsupported DATABASE_TYPE "${env("DATABASE_TYPE")}", please setup database.js`;
}

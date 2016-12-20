virtual-user-db-dir:
  file.directory:
    - name: /var/lib/dovecot/authdb

virtual-user-db:
  sqlite3.table_present:
    - db: /var/lib/dovecot/authdb/authdb.sqlite3
    - name: users
    - schema:
      - username VARCHAR(128) NOT NULL
      - domain VARCHAR(128) NOT NULL
      - password VARCHAR(64) NOT NULL
      - active CHAR(1) DEFAULT 'Y' NOT NULL
    - require:
      - file: virtual-user-db-dir

# pg_sessions
Postgresql active session history including pid and timestamp

This project is made because of the lack of admin view on Postgres

I have forked the pg_stat_statements extension in order to be abble to have
all the sql queries run associated to a pg pid and to have the last start date.

This is a work in progress, I would like to snapshot the system metrics in order to
have a least a per pid/queyid the system statistics.

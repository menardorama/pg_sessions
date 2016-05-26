# pg_sessions
Postgresql active session history including pid and timestamp

This project is made because of the lack of admin view on Postgresql

# What has been done ?
* based on pg_stat_statement
* added the pid and the last run of the query
* implemented the system statistics based on pg_proctab extension

# Future addons :
* Wait events on postgresql 9.6 but may be difficult if not catchable using the hooks
* Add a custom background worker to collect and store for historical
* Go to a per pid/queryid/timestamp metric.

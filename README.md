# pg_sessions
Postgresql active session history including pid and timestamp

This project is made because of the lack of admin view on Postgresql

# What has been done ?
* based on pg_stat_statement
* added the pid and the last run of the query
* implemented the system statistics based on pg_proctab extension

# How to install

Simply fetch the repository

And as root : 
<pre>
export PATH=$PATH:/usr/pgsql/bin
make
make install
</pre>

# Configuration

in the postgresql.conf
<pre>
shared_preload_libraries = 'pg_sessions'
pg_sessions.max = 5000 # Number of rows to keep in memory
pg_sessions.track = all # Type of statement to keep (none, top, all)
pg_sessions.track_utility = true # Track all utility statements (CREATE, FUNCTIONS...)
pg_sessions.save = false # Enable dump to a file on shutdown
pg_sessions.track_all_steps = true # Log for all Executor Hooks (small overhead but gives you an incremental view of the query consumtion)
pg_sessions.track_system_metrics = true # Disable the system metrics
</pre>

And in postgresql : 
<pre>
CREATE EXTENSION pg_sessions;
</pre>

# View and function :

pg_sessions view :
<pre>
postgres=# \d pg_sessions;
                     View "public.pg_sessions"
         Column          |            Type             | Modifiers 
-------------------------+-----------------------------+-----------
 usename                 | name                        | 
 datname                 | name                        | 
 pid                     | bigint                      | 
 queryid                 | bigint                      | 
 query                   | text                        | 
 calls                   | bigint                      | 
 last_executed_timestamp | timestamp without time zone | 
 status                  | text                        | 
 total_time              | double precision            | 
 min_time                | double precision            | 
 max_time                | double precision            | 
 mean_time               | double precision            | 
 stddev_time             | double precision            | 
 rows                    | bigint                      | 
 shared_blks_hit         | bigint                      | 
 shared_blks_read        | bigint                      | 
 shared_blks_dirtied     | bigint                      | 
 shared_blks_written     | bigint                      | 
 local_blks_hit          | bigint                      | 
 local_blks_read         | bigint                      | 
 local_blks_dirtied      | bigint                      | 
 local_blks_written      | bigint                      | 
 temp_blks_read          | bigint                      | 
 temp_blks_written       | bigint                      | 
 blk_read_time           | double precision            | 
 blk_write_time          | double precision            | 
 user_time               | bigint                      | 
 system_time             | bigint                      | 
 virtual_memory_size     | text                        | 
 resident_memory_size    | text                        | 
 bytes_reads             | text                        | 
 bytes_writes            | text                        | 
 iops_reads              | bigint                      | 
 iops_writes             | bigint                      | 
 bytes_preads            | text                        | 
 bytes_pwrites           | text                        | 
</pre>

Keep in mind that the metrics are pid/queryid based



# Future addons :
* Wait events on postgresql 9.6 but may be difficult if not catchable using the hooks
* Add a custom background worker to collect and store for historical
* Go to a per pid/queryid/timestamp metric.

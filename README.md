Dockerl - an Erlang based Docker management server
==================================================

The dock is a system where in we run a priviledged docker container
that spawns other docker containers:

```
┌───────────┐                      ┌───────────┐ 
│           │ ──────────────────►  │           │ 
│           │       epmd           │           │ 
│   dock    │ ◄──────────────────  │    dock   │ 
│           │                      │           │ 
└┬─────────┬┘                      └┬─────────┬┘  
 │         │                        │         │  
 │         │                        │         │ 
 ├─────────┤                        ├─────────┤ 
 │         │                        │         │ 
 │         │                        │         │ 
 ├─────────┤     containers         ├─────────┤ 
 │         │                        │         │ 
 ├─────────┤                        ├─────────┤ 
 │         │                        │         │ 
 └─────────┘                        └─────────┘
```

We take advantage of supervisor trees and a distributed database
to recreate any node that fails.  We also get the ability to inspect
and monitor all of the services running across the cluster using
Erlang's native peering and process monitoring.



#define N 5  // Number of processes

mtype = { REQUEST, RELEASE, GRANT };

chan request_chan[N] = [N] of { mtype, byte };
chan grant_chan[N] = [N] of { mtype };

bool lock_available = true;
int current_holder = -1;

proctype process(int id)
{
    do
    :: true ->
        // Non-critical section

        // Request lock
        request_chan[id]!REQUEST, id;
        //assert(request_chan[id]?REQUEST, id);

        // Critical section
        //assert(lock_available);
        grant_chan[id]?GRANT;
        atomic{
        lock_available = false;
        current_holder = id;
        printf("State changed: lock_available: %d current_holder: %d\n", lock_available, current_holder);
        }

        // Use the lock

        // Release lock
        atomic{
        //request_chan[id]!RELEASE;
        //assert(request_chan[id]?RELEASE);
        lock_available = true;
        current_holder = -1;
        printf("State changed: lock_available: %d current_holder: %d\n", lock_available, current_holder);
        }

        // End of critical section
    od
}

proctype lock_server()
{
    byte requesters[N];
    bool granted[N];
    mtype msg;
    byte mid;
    int i;
    do
    :: true ->
        // Wait for lock requests

       for (i : 0 .. N-1)
       {
        if
        :: request_chan[i]?msg,mid->
            if
            :: msg == REQUEST->
                // Check if lock is available
                if
                :: lock_available ->
                    // Grant lock
                    grant_chan[mid]!GRANT;
                    granted[mid] = true;
                :: else ->
                    // Deny lock
                    granted[mid] = false;
                fi;
            :: msg == RELEASE ->
                // Release lock
                granted[mid] = false;
            fi;
        :: else ->
            // Handle the case when the channel is empty (null message)
            // You can choose to skip or add any necessary handling here
            skip;
        fi;


        }


    od
}

init
{
    run lock_server();
    run process(0);
    run process(1);
    run process(2);
    run process(3);
    run process(4);
}

mtype = { VALUE, DECISION };
chan process_chan[2] = [2] of { mtype, int };
chan coordinator_chan = [1] of { mtype, int };

int votes[2];
int decisions[2];

active proctype Process(int id)
{
    int value;
    bool voted = false;

    do
    :: process_chan[id]?VALUE, value ->
        // Receive value from another process
        votes[id] = value;
        voted = true;
    :: process_chan[1-id]?VALUE, value ->
        // Receive value from the other process
        votes[1-id] = value;
        voted = true;
    :: coordinator_chan?DECISION, value ->
        // Receive decision from coordinator
        decisions[id] = value;
        voted = false;
    :: atomic {
        // If process hasn't voted, randomly choose a value
        if
        :: !voted -> votes[id] = id * 10 + id;  // Assign a unique value based on process id
        fi;

        // Send the chosen value to the other process
        process_chan[1-id]!VALUE, votes[id];
    }
        // Send the final decision to coordinator
    coordinator_chan!DECISION, votes[id];
    od


}

active proctype Coordinator()
{
    int decisions_received = 0;
    int final_decision;
    int value;

    do
    :: coordinator_chan?DECISION, value ->
        // Receive decision from a process
        final_decision = value;
        decisions_received++;
    :: decisions_received == 2 ->
        // All decisions received, terminate the simulation
        break;
    od

    // Print the final decision
    printf("Final decision: %d\n", final_decision);
}

init
{
    run Process(0);
    run Process(1);
    run Coordinator();
}

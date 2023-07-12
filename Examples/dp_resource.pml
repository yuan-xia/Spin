#define N 15

mtype = { REQUEST, GRANT };

int chopsticks[N] = { 1, 1, 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1};

chan request_chan[N] = [1] of { mtype };  // Separate channel for each philosopher
chan grant_chan[N] = [1] of { mtype };    // Separate channel for each philosopher
int sum = 15;



proctype philosopher(int my_id) {
    int left = my_id;
    int right = (my_id + 1) % N;
    do
    :: true -> {
        //printf("Philosopher %d is thinking\\n", my_id);
        request_chan[my_id]!REQUEST;
        grant_chan[my_id] ? GRANT;
        //printf("Philosopher %d received left fork\\n", my_id);

        //printf("Philosopher %d received right fork\\n", my_id);

        // eat
        //printf("Philosopher %d is eating\\n", my_id);

        // Release forks
        atomic{
        chopsticks[left] = 1;
        chopsticks[right] = 1;

        printf("state changed %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d\n",chopsticks[0],chopsticks[1], chopsticks[2], chopsticks[3],chopsticks[4],chopsticks[5],chopsticks[6],chopsticks[7],chopsticks[8],chopsticks[9],chopsticks[10],chopsticks[11],chopsticks[12],chopsticks[13],chopsticks[14]);
        int i;
        sum = 0;
        for (i : 0 .. N-1) {
            sum = sum + chopsticks[i];
        }
        }
        //printf("Philosopher %d released forks\\n", my_id);

        // think

    }
    od
}

proctype resource_manager() {
    int philosopher_id = -1;  // Initialize philosopher_id as -1
    do
    :: true -> {

        mtype msg;
        philosopher_id = (philosopher_id + 1) % N;

        request_chan[philosopher_id] ? msg;
        if
        :: chopsticks[philosopher_id] == 1 && chopsticks[(philosopher_id + 1) % N] == 1 ->
           atomic{
            chopsticks[philosopher_id] = 0;

            chopsticks[(philosopher_id + 1) % N] = 0;

            grant_chan[philosopher_id]!GRANT;
            //printf("state changed %d %d %d %d %d\n",chopsticks[0],chopsticks[1], chopsticks[2], chopsticks[3],chopsticks[4]);
            printf("state changed %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d\n",chopsticks[0],chopsticks[1], chopsticks[2], chopsticks[3],chopsticks[4],chopsticks[5],chopsticks[6],chopsticks[7],chopsticks[8],chopsticks[9],chopsticks[10],chopsticks[11],chopsticks[12],chopsticks[13],chopsticks[14]);
            int i;
            sum = 0;
            for (i : 0 .. N-1) {
                sum = sum + chopsticks[i];
            }
            }

        fi;

    }
    od
}



init {
/*
    run philosopher(0);

    run philosopher(1);

    run philosopher(2);
    run philosopher(3);
    */
    int i;
	for (i : 0 .. N-1) {
		run philosopher(i);
	}
    run resource_manager();
    run resource_manager();
    run resource_manager();
    run resource_manager();
    run resource_manager();
    run resource_manager();
}
/*
ltl deadlock_freedom {
    [] (!<> (chopsticks[0] == 0 && chopsticks[1] == 0 && chopsticks[2] == 0 && chopsticks[3] == 0 && chopsticks[4] == 0))
}
ltl mutual_exclusion {
    [] (!(chopsticks[0] == 0 && chopsticks[1] == 0) || !(chopsticks[1] == 0 && chopsticks[2] == 0) || !(chopsticks[2] == 0 && chopsticks[3] == 0) || !(chopsticks[3] == 0 && chopsticks[4] == 0) || !(chopsticks[4] == 0 && chopsticks[0] == 0))
}*/
//ltl p0{[]  ((chopsticks[11] == 0 || chopsticks[11] == 1) && (1<=sum) &&(sum<= 15))}
//ltl p0{[]  (chopsticks[1] == 1 && chopsticks[12] == 1 && chopsticks[13] == 1 )}
ltl p0{[]((((chopsticks[1] == 1) && (
  ((chopsticks[3] == 1) && (
    ((chopsticks[5] == 1) && (
      ((chopsticks[7] == 0) && (chopsticks[0] == 1)) ||
      ((! (chopsticks[7] == 0)) && (chopsticks[7] == 1))
    )) ||
    ((! (chopsticks[5] == 1)) && (chopsticks[0] == 1))
  )) ||
  ((! (chopsticks[3] == 1)) && (
    ((chopsticks[12] == 1) && (chopsticks[0] == 1)) ||
    ((! (chopsticks[12] == 1)) && (chopsticks[0] == 1))
  ))
))) ||
((! (chopsticks[1] == 1)) && (
  (chopsticks[1] == 0) && (chopsticks[5] == 1) && (chopsticks[2] == 1)
)))



}

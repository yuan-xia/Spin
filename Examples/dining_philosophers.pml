#define N 5  // Number of philosophers

mtype = { THINKING, HUNGRY, EATING };

mtype state[N];
chan forks[N];

active proctype Philosopher(int id)
{
    do
    :: true ->
        state[id] = THINKING;
        printf("Philosopher %d is thinking\\n", id);

        if
        :: (id + 1) % N != id ->
            atomic {
                state[id] = HUNGRY;
                printf("Philosopher %d is hungry\\n", id);
                forks[id]!id;
            }
        :: else -> skip
        fi;

        forks[id]?id;
        forks[(id + 1) % N]?id;

        state[id] = EATING;
        printf("Philosopher %d is eating\\n", id);

        atomic {
            forks[id]!id;
            forks[(id + 1) % N]!id;
        }
    od
}

init
{
    int i;
    atomic {
        for (i = 0; i < N; i++) {
            state[i] = THINKING;
            run Philosopher(i);
        }

        // Initialize forks channels
        for (i = 0; i < N; i++)
            forks[i] = [1] of { mtype };
    }
}

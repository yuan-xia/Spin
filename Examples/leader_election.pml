#define N 5

mtype = { ELECTION, COORDINATOR };

chan msg[N] = [1] of { mtype };
bool is_leader = false;
int my_id;

proctype process() {
    do
        :: true -> {
            msg[my_id]!ELECTION;
            bool leader_found = false;
            int i = 0;
            do
            :: i < N -> {
                if
                    :: i != my_id && msg[i]?ELECTION ->
                        leader_found = true;
                        if
                        :: i > my_id ->
                            leader_found = false;
                            break;



                    :: else -> skip;

                i = i+1;
                }
            :: else -> break;

            od

            if (!leader_found) {
                is_leader = true;
                i = 0;
                  do
                  :: i < N ->
                  {
                    if
                        :: i != my_id -> {
                            msg[i]!COORDINATOR;
                        }
                    :: else -> skip;
                    fi
                    i = i+1;
                    }
                   :: else -> break;
                  od

            }
        }
    od
}

init {
    atomic {
                  do
                  :: i < N ->
                  {
                        run process();
                        i = i+1
                  }
                  :: else -> break;
                  od
    }
    assert(is_leader);
}
#define COORDINATOR 0
#define PARTICIPANT 1

mtype { REQUEST, VOTE, COMMIT, ABORT }

chan coordinator_to_participant[2] = [1] of { mtype, int };
chan participant_to_coordinator[2] = [1] of { mtype };

proctype coordinator()
{
    byte decision_count = 0;
    mtype msg;

    do
    :: coordinator_to_participant[COORDINATOR] ? msg;
       if
       :: msg == VOTE ->
          if
          :: decision_count == 0 -> decision_count++;
                                     participant_to_coordinator[COORDINATOR] ! VOTE;
          :: decision_count == 1 -> decision_count++;
                                     participant_to_coordinator[PARTICIPANT] ! VOTE;
          fi;
       :: msg == COMMIT ->
          if
          :: decision_count == 1 -> decision_count++;
          :: decision_count == 2 -> break;
          fi;
       :: msg == ABORT ->
          if
          :: decision_count < 2 -> break;
          fi;
       fi;
    od;

    if
    :: decision_count == 3 -> printf("Transaction committed\n");
    :: decision_count < 3 -> printf("Transaction aborted\n");
    fi;

    printf("Coordinator process finished\n");
}

proctype participant(byte id)
{
    mtype msg;

    do
    :: participant_to_coordinator[id] ? msg;
       if
       :: msg == VOTE ->
          coordinator_to_participant[id] ! VOTE;
       fi;
    od;

    if
    :: id == COORDINATOR -> coordinator_to_participant[id] ! COMMIT;
    :: id == PARTICIPANT -> coordinator_to_participant[id] ! ABORT;
    fi;

    printf("Participant %d finished\n", id);
}

init
{
    atomic
    {
        run coordinator();
        run participant(COORDINATOR);
        run participant(PARTICIPANT);
    }
}

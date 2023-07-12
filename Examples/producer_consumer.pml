#define N 100

mtype buffer[N];
int front = 0;
int rear = 0;
int count = 0;

mtype = { PRODUCE, CONSUME };

chan queue = [N] of { mtype };
//ltl p0 { [] ( front >= 0 && front < N && rear >= 0 && rear < N && ((count %N) == ((rear-front)+N )% N)) }

active proctype producer() {
    do

        :: count < N -> atomic {
            buffer[rear] = PRODUCE;
            rear = (rear + 1) % N;
            count++;
            //printf("State changed: front: %d rear: %d count: %d\n",front, rear,count);
        }
        :: else -> skip;

    od
}

active proctype consumer() {
    do
        :: count > 0 -> atomic {
            mtype item = buffer[front];
            front = (front + 1) % N;
            count--;
            //printf("State changed: front %d rear: %d count: %d\n", front,rear, count);
        }
        :: else -> skip;
    od
}

/*
ltl p0 {[] (((rear <= 37) && (
  (front <= 74 && (
    (count <= 7 && (
      (((count % N) - (((rear - front) + N) % N)) >= 0) &&
      (((count % N) - (((rear - front) + N) % N)) <= 0) &&
      (rear >= 0)
    )) || (
      (count > 7 && (
        (((count % N) - (((rear - front) + N) % N)) >= 0) &&
        (((count % N) - (((rear - front) + N) % N)) <= 0) &&
        (rear >= 0)
      ))
    ))
  )) || (
    (front > 74 && (
      (count <= 16 && (
        (((count % N) - (((rear - front) + N) % N)) >= 0) &&
        (((count % N) - (((rear - front) + N) % N)) <= 0) &&
        (front <= 99)
      )) || (
        (count > 16 && (
          (((count % N) - (((rear - front) + N) % N)) >= 0) &&
          (((count % N) - (((rear - front) + N) % N)) <= 0) &&
          (front <= 99)
        ))
      ))
    ))
  )
 || (
  (rear > 37 && (
    (front <= 48 && (
      (count <= 15 && (
        (((count % N) - (((rear - front) + N) % N)) <= 0) &&
        (((count % N) - (((rear - front) + N) % N)) >= 0) &&
        (front >= 0)
      )) || (
        (count > 15 && (
          (((count % N) - (((rear - front) + N) % N)) <= 0) &&
          (((count % N) - (((rear - front) + N) % N)) >= 0) &&
          (front >= 0)
        ))
      ))
    )) || (
      (front > 48 && (
        (count <= 10 && (
          (((count % N) - (((rear - front) + N) % N)) <= 0) &&
          (((count % N) - (((rear - front) + N) % N)) >= 0) &&
          (front <= 99)
        )) || (
          (count > 10 && (
            (((count % N) - (((rear - front) + N) % N)) <= 0) &&
            (((count % N) - (((rear - front) + N) % N)) >= 0) &&
            (front <= 88)
          ))
        ))
      ))
    )
  ))
}*/

/*ltl p0 {[] ((0<= rear <=37 &&  front<= 74 &&  ((count %N) == ( ((rear-front)+N )% N)))
|| (rear <= 37 && 74<front<=99  && ((count %N) == ( ((rear-front)+N )% N)))
|| (rear > 37 && 0 <= front <= 48 && ((count %N) == ( ((rear-front)+N )% N)) )
||(rear > 37 && 48< front <=99 && count <=10 && ((count %N) == ( ((rear-front)+N )% N)))
||(rear > 37 && 48< front <=88 && count >10 && ((count %N) == ( ((rear-front)+N )% N))))}*/
/*
ltl p0 {[](((
  (rear <= 46) && (
    (front <= 50) && (
      (count <= 7) && (
        (((count % N) - (((rear - front) + N) % N)) >= 0) &&
        (((count % N) - (((rear - front) + N) % N)) <= 0) &&
        (front >= 0)
      )
    ) || (
      (count > 7) && (
        (((count % N) - (((rear - front) + N) % N)) >= 0) &&
        (((count % N) - (((rear - front) + N) % N)) <= 0) &&
        (front >= 0)
      )
    )
  )
) || (
  (front > 50) && (
    (count <= 13) && (
      (((count % N) - (((rear - front) + N) % N)) <= 0) &&
      (((count % N) - (((rear - front) + N) % N)) >= 0) &&
      (front <= 99)
    )
  ) || (
    (count > 13) && (
      (((count % N) - (((rear - front) + N) % N)) <= 0) &&
      (((count % N) - (((rear - front) + N) % N)) >= 0) &&
      (front <= 99)
    )
  )
)) || (
  (rear > 46) && (
    (front <= 63) && (
      (count <= 12) && (
        (((count % N) - (((rear - front) + N) % N)) >= 0) &&
        (((count % N) - (((rear - front) + N) % N)) <= 0) &&
        (front >= 0)
      )
    ) || (
      (count > 12) && (
        (((count % N) - (((rear - front) + N) % N)) <= 0) &&
        (((count % N) - (((rear - front) + N) % N)) >= 0) &&
        (front >= 0)
      )
    )
  ) || (
    (front > 63) && (
      (count <= 10) && (
        (((count % N) - (((rear - front) + N) % N)) >= 0) &&
        (((count % N) - (((rear - front) + N) % N)) <= 0) &&
        (front <= 99)
      )
    ) || (
      (count > 10) && (
        (((count % N) - (((rear - front) + N) % N)) >= 0) &&
        (((count % N) - (((rear - front) + N) % N)) <= 0) &&
        (front <= 88)
      )
    )
  )
))}
*/

/*ltl p0 {[]((
  (front <= 51) && (
    (rear <= 38) && (
      (count <= 7) && (
        (((count % N) - (((rear - front) + N) % N)) >= 0) &&
        (((count % N) - (((rear - front) + N) % N)) <= 0) &&
        (front >= 0)
      )
    ) || (
      (count > 7) && (
        (((count % N) - (((rear - front) + N) % N)) >= 0) &&
        (((count % N) - (((rear - front) + N) % N)) <= 0) &&
        (front >= 0)
      )
    )
  ) || (
    (rear > 38) && (
      (count <= 18) && (
        (((count % N) - (((rear - front) + N) % N)) >= 0) &&
        (((count % N) - (((rear - front) + N) % N)) <= 0) &&
        (front >= 0)
      )
    ) || (
      (count > 18) && (
        (((count % N) - (((rear - front) + N) % N)) >= 0) &&
        (((count % N) - (((rear - front) + N) % N)) <= 0) &&
        (front >= 0)
      )
    )
  )
) || (
  (front > 51) && (
    (count <= 13) && (
      (rear <= 75) && (
        (((count % N) - (((rear - front) + N) % N)) >= 0) &&
        (((count % N) - (((rear - front) + N) % N)) <= 0) &&
        (front <= 99)
      )
    ) || (
      (rear > 75) && (
        (((count % N) - (((rear - front) + N) % N)) >= 0) &&
        (((count % N) - (((rear - front) + N) % N)) <= 0) &&
        (front <= 99)
      )
    )
  ) || (
    (count > 13) && (
      (rear <= 82) && (
        (((count % N) - (((rear - front) + N) % N)) >= 0) &&
        (((count % N) - (((rear - front) + N) % N)) <= 0) &&
        (front <= 99)
      )
    ) || (
      (rear > 82) && (
        (((count % N) - (((rear - front) + N) % N)) >= 0) &&
        (((count % N) - (((rear - front) + N) % N)) <= 0) &&
        (front <= 85)
      )
    )
  )
))
}*/
ltl p0 {[]
((
  (rear <= 53) && (
    (front <= 41) && (
      (count <= 20) && (
        (((count % N) - (((rear - front) + N) % N)) >= 0) &&
        (((count % N) - (((rear - front) + N) % N)) <= 0) &&
        (((rear >= 0) && (front >= 0)))
      )
    ) || (
      (count > 20) && (
        (((count % N) - (((rear - front) + N) % N)) >= 0) &&
        (((count % N) - (((rear - front) + N) % N)) <= 0) &&
        (((rear >= 0) && (front >= 0)) && (count <= 98))
      )
    )
  ) || (
    (front > 41) && (
      (count <= 40) && (
        (((count % N) - (((rear - front) + N) % N)) >= 0) &&
        (((count % N) - (((rear - front) + N) % N)) <= 0) &&
        (((rear >= 0) && (front <= 99)))
      )
    )
  )
) || (
  (rear > 53) && (
    (front <= 56) && (
      (count <= 34) && (
        (((count % N) - (((rear - front) + N) % N)) >= 0) &&
        (((count % N) - (((rear - front) + N) % N)) <= 0) &&
        (((rear <= 94) && (front >= 0)))
      )
    ) || (
      (count > 34) && (
        (((count % N) - (((rear - front) + N) % N)) >= 0) &&
        (((count % N) - (((rear - front) + N) % N)) <= 0) &&
        (((rear >= 0) && (front >= 0)) && (count <= 98))
      )
    )
  ) || (
    (front > 56) && (
      (count <= 25) && (
        (((count % N) - (((rear - front) + N) % N)) >= 0) &&
        (((count % N) - (((rear - front) + N) % N)) <= 0) &&
        (((rear <= 100) && (front <= 99)))
      )
    ) || (
      (count > 25) && (
        (((count % N) - (((rear - front) + N) % N)) >= 0) &&
        (((count % N) - (((rear - front) + N) % N)) <= 0) &&
        (((rear <= 99) && (front <= 99)))
      )
    )
  )
))
}

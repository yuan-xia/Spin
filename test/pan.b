	switch (t->back) {
	default: Uerror("bad return move");
	case  0: goto R999; /* nothing to undo */

		 /* CLAIM invariant */
;
		
	case 3: // STATE 1
		goto R999;

	case 4: // STATE 10
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC user */
;
		;
		
	case 6: // STATE 2
		;
		now.flag[ Index(((P0 *)_this)->_pid, 2) ] = trpt->bup.oval;
		;
		goto R999;

	case 7: // STATE 3
		;
		now.turn = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 9: // STATE 5
		;
		now.ncrit = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 11: // STATE 7
		;
		now.ncrit = trpt->bup.oval;
		;
		goto R999;

	case 12: // STATE 8
		;
		now.flag[ Index(((P0 *)_this)->_pid, 2) ] = trpt->bup.oval;
		;
		goto R999;
	}


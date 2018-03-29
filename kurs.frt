( print odd if the number is odd, print even if the number is even )
: isOdd 2 % if 1 else 0 then ;

( push 1 if the number is prime, else push 0 )
: isPrimeDoLoop
	dup 2 < if 
		0
	else
		dup 2 do
		 	dup r@ swap 1 - = if
				1
			else
				dup r@ % 0 = if
					cr r> drop dup 1 - >r drop 0
				then
			then
		loop
	then
;

( a b -- a b a b )
: dupTwo swap dup rot dup rot rot ;

: isPrime
	dup 2 < if
		0
	else
		dup 1 - repeat
			dup 1 = if
				drop drop 1 1
			else
				dupTwo % 0 = if
					drop drop 0 1
				else
					1 - 0
				then
			then
		until
	then
;

( write to the memory a number from stack, push to the stack the memory address )
: writeToMem 1 allot dup rot swap ! ;

( write to the memory 1 if the number is prime, else write 0 to the memory, push the memory address )
: isPrimeDoLoopToMem isPrimeDoLoop writeToMem ;

( push length of the string )
: strlen
  0 swap
  repeat
    dup c@ 0 = if
      drop 1 " end"
    else
      1 + swap 1 + swap 0
    then
  until
  drop
;



( push the total length of 2 strings )
: two-str-len
  dupTwo strlen swap strlen +
;

( a b -- a+1 b+1 )
: incTwo
  1 + swap 1 + swap
;

( store string to the another memory location )
: restore-str
  swap
  repeat
    dupTwo c@ dup 0 = if
      drop drop drop 1
    else
      swap c! incTwo 0
    then
  until
;

( concatenate 2 strings )
: concate
  swap two-str-len rot rot two-str-len heap-alloc restore-str restore-str swap -
;

( make colatz series on the stack )
: colatz
	dup . cr
	repeat
		dup 1 = if
		else
			dup 2 % 0 = if
				2 / dup . cr
			else
				3 * 1 + dup . cr
			then
			0
		then
	until
;
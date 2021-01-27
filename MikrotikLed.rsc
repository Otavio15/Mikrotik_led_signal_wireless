
:global minvalue 54
:global maxvalue 64

:global diferencebetweenvalues (($maxvalue - $minvalue) / 5)

:local signal [:tonum [:pick [/interface wireless registration-table get value-name=signal-strength 0 ] 1 3]]

:local led1value ($minvalue + $diferencebetweenvalues * 1)
:local led2value ($minvalue + $diferencebetweenvalues * 2)
:local led3value ($minvalue + $diferencebetweenvalues * 3)
:local led4value ($minvalue + $diferencebetweenvalues * 4)
:local led5value ($minvalue + $diferencebetweenvalues * 5)

if ($led1value < 0) do={
$led1value [$led1value * -1]
}

if ($led2value < 0) do={
$led2value [$led2value * -1]
}

if ($led3value < 0) do={
$led3value [$led3value * -1]
}

if ($led4value < 0) do={
$led4value [$led4value * -1]
}

if ($led5value < 0) do={
$led5value [$led5value * -1]
}

:put $signal
:put $led1value
:put $led2value
:put $led3value
:put $led4value
:put $led5value

/system leds add leds=led1 type=off
/system leds add leds=led2 type=off
/system leds add leds=led3 type=off
/system leds add leds=led4 type=off
/system leds add leds=led5 type=off

if ($signal <= $led1value && $signal > $led2value) do={

/system leds set numbers=1 leds=led1 type=on
/system leds set numbers=2 leds=led2 type=off
/system leds set numbers=3 leds=led3 type=off
/system leds set numbers=4 leds=led4 type=off
/system leds set numbers=5 leds=led5 type=off

:beep frequency=500 length=200ms;

}

if ($signal <= $led2value && $signal > $led3value) do={

/system leds set numbers=1 leds=led1 type=on
/system leds set numbers=2 leds=led2 type=on
/system leds set numbers=3 leds=led3 type=off
/system leds set numbers=4 leds=led4 type=off
/system leds set numbers=5 leds=led5 type=off

:beep frequency=1000 length=200ms;

}

if ($signal <= $led3value && $signal > $led4value) do={

/system leds set numbers=1 leds=led1 type=on
/system leds set numbers=2 leds=led2 type=on
/system leds set numbers=3 leds=led3 type=on
/system leds set numbers=4 leds=led4 type=off
/system leds set numbers=5 leds=led5 type=off

:beep frequency=1500 length=200ms;

}

if ($signal <= $led4value && $signal > $led5value) do={

/system leds set numbers=1 leds=led1 type=on
/system leds set numbers=2 leds=led2 type=on
/system leds set numbers=3 leds=led3 type=on
/system leds set numbers=4 leds=led4 type=on
/system leds set numbers=5 leds=led5 type=off

:beep frequency=2000 length=200ms;

}

if ($signal <= $led5value && $signal > $minvalue) do={

/system leds set numbers=1 leds=led1 type=on
/system leds set numbers=2 leds=led2 type=on
/system leds set numbers=3 leds=led3 type=on
/system leds set numbers=4 leds=led4 type=on
/system leds set numbers=5 leds=led5 type=on

:beep frequency=2500 length=200ms;

}

:if ($signal < $minvalue) do={

/system leds set numbers=1 leds=led1 type=on
/system leds set numbers=2 leds=led2 type=on
/system leds set numbers=3 leds=led3 type=on
/system leds set numbers=4 leds=led4 type=on
/system leds set numbers=5 leds=led5 type=on

:for i from=1 to=10 do={:beep frequency=3000 length=100ms; :delay 130ms;}

}

:if ($signal > $maxvalue) do={

/system leds set numbers=1 leds=led1 type=off
/system leds set numbers=2 leds=led2 type=off
/system leds set numbers=3 leds=led3 type=off
/system leds set numbers=4 leds=led4 type=off
/system leds set numbers=5 leds=led5 type=off

:for i from=1 to=10 do={:beep frequency=300 length=100ms; :delay 130ms;}

}

:delay 300ms;
system leds remove numbers=1,2,3,4,5
:put "Script de alinhamento executado, sinal $signal"
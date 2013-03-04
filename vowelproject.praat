dir$ = "c:\teaching\taken\ling446\"

filedelete 'dir$'dan3.txt
fileappend 'dir$'dan3.txt Start'tab$'End'tab$'Duration'tab$'1/3'tab$'F1'tab$'F2'tab$'2/3'tab$'F1'tab$'F2'tab$'Speaker'tab$'Word'newline$'

procedure processFile .name$

  # open the textgrid and sound files
  Read from file... 'dir$''.name$'.TextGrid
  Read from file... 'dir$''.name$'.wav

  # get the sound file
  select Sound '.name$'
  # calculate formants
  To Formant (burg)... 0 4 5500 0.025 30

  # find the vowel tier
  select TextGrid '.name$'
#  Edit
  .ntier = Get number of tiers
  for i from 1 to .ntier
    .lbl$ = Get tier name... 'i'
    if .lbl$ = "text"
      .txt = i
    endif
    if .lbl$ = "measure"
      .meas = i
    endif
  endfor

  # get the labeled intervals
  .nintv = Get number of intervals... '.txt'
  for j from 1 to .nintv
    select TextGrid '.name$'
    .word$ = Get label of interval... '.txt' 'j'
    if .word$ <> ""
      .beg = Get starting point... '.txt' 'j'
      .end = Get end point... '.txt' 'j'
      # determine the interval size
      .dur = .end - .beg
      .incr = .dur / 3
      .onset = .beg + .incr
      .glide = .end - .incr
      # measure the first third
      select Formant '.name$'
      .of1 = Get value at time... 1 '.onset' Hertz Linear
      .of2 = Get value at time... 2 '.onset' Hertz Linear
      # measure the second third
      .gf1 = Get value at time... 1 '.glide' Hertz Linear
      .gf2 = Get value at time... 2 '.glide' Hertz Linear
      fileappend "'dir$'vowelproject2.txt" '.beg:3''tab$''.end:3''tab$''.dur:3''tab$''.onset:3''tab$''.of1:0''tab$''.of2:0''tab$''.glide:3''tab$''.gf1:0''tab$''.gf2:0''tab$''.name$''tab$''.word$''newline$'
#      # mark measurement points
#      editor TextGrid '.name$'
#      Move cursor to... '.onset'
#      Add interval on tier 2
#      Move cursor to... '.glide'
#      Add interval on tier 2
    endif
  endfor

#  # save updated TextGrid
#  Save TextGrid as text file... '.dir$''.name$'2.TextGrid

  # clean up
  select TextGrid '.name$'
  plus Sound '.name$'
  plus Formant '.name$'
  Remove
endproc

# call processFile dan
call processFile Jennifer


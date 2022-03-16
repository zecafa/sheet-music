\version "2.20.2"
#(set-global-staff-size 18)
 \paper {
  #(define fonts
     (set-global-fonts
      #:factor (/ staff-height pt 20)))
}

\paper {
  #(set-paper-size "letter")
  indent = 0\mm
  between-system-space = 1.5\cm
  between-system-padding = #0

  markup-system-spacing = #'((basic-distance . 2)
                             (minimum-distance . 2)
                             (padding . 1))
  ragged-right = ##f
  systems-per-page = 12
  bottom-margin = 0
}

title = #"iiVI Exercises"
composer = #"-Stephen Cox"
meter = #"(Med. Swing)"

realBookTitle = \markup {
  \score {
    {
      \override TextScript.extra-offset = #'(0 . -4.5)
      s4
      s^\markup {
        \fill-line {
          \fontsize #1 \lower #1 \rotate #7 \concat { " " #meter }
          \fontsize #8
          \override #'(offset . 7)
          \override #'(thickness . 6)
          \underline \sans #title
          \fontsize #1 \lower #1 \concat { #composer " " }
        }
      }
      s
    }
    \layout {
      \once \override Staff.Clef.stencil = ##f
      \once \override Staff.TimeSignature.stencil = ##f
      \once \override Staff.KeySignature.stencil = ##f
      ragged-right = ##f
      \override TextScript.font-name = #"Pea Missy with a Marker"
    }
  }
}

\header {
  title = \realBookTitle
  tagline = ##f
}

theNotes = \relative c' {
   d4 f( a) c( | b) d( f) d( | e) g r b( | b2) r2
  \bar "||" \break
}

theChords =
\chords
{
  \override ChordNames.ChordName.font-name = "musejazz"
  \override ChordNames . ChordName.font-size = #2
  \set chordChanges = ##t
  \set Score.majorSevenSymbol = \markup {Maj7}
  \set chordNameSeparator = \markup { "/" }
  \set minorChordModifier = \markup{"-"}
      d1:m | g:7 | c:maj |
}


theLick = <<
    \new ChordNames \theChords
    \new Staff \theNotes
  >>

pitches = { d g c f bes ees aes des fis b e a }

transLick = 
	#(define-music-function
		(lick)
		(ly:music?)
		#{ 
		  $@(map
		  (lambda (p) #{ 
		  	\transpose f #p #lick 
		   #})
		  (music-pitches pitches))		
		#}
	)
%{
	$@(map
	(lambda (pitch) \transpose f #pitch #lick)
	(music-pitches pitches))
%}			

\score {
	\transLick \theLick
	\layout {
	 
  }
  \midi {
    \tempo 4 = 88
  }
}
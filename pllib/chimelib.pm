package chimelib;
use strict;

sub cursec {
  my $lc_a;
  $lc_a = `date +%s`;
  chomp($lc_a);
  return $lc_a;
}

sub good {
  my $lc_tm;
  $lc_tm = @_;
  return ( $lc_tm > 0.5 );
}

sub bad {
  my $lc_tm;
  $lc_tm = @_;
  return ( $lc_tm < 0.5 );
}

sub playsound {
  my $lc_hm;
  my $lc_dr;
  $lc_hm = $ENV{"HOME"};
  $lc_hm .= "/.mindfulchime";
  $lc_dr = $lc_hm;
  $lc_hm .= "/play-chime.pl";
  
  if ( !(-f $lc_hm) )
  {
    die "\nPlease create the PERL script:\n    $lc_hm:\n\n";
  }
  
  system("perl",$lc_hm,$lc_dr);
  
  
}

sub timeparse {
  my @lc_rayo;
  my $lc_sfar;
  my $lc_factro;
  my $lc_cura;
  
  @lc_rayo = split(quotemeta(":"),$_[0]);
  $_[0] = 0;
  if ( &bad(@lc_rayo) ) { return; }
  $lc_sfar = pop(@lc_rayo);
  if ( &bad(@lc_rayo) ) { $_[0] = $lc_sfar; return; }
  
  # Minutes
  $lc_factro = 60;
  $lc_cura = pop(@lc_rayo);
  $lc_sfar = int( $lc_sfar + 0.2 + ( $lc_cura * $lc_factro ) );
  if ( &bad(@lc_rayo) ) { $_[0] = $lc_sfar; return; }
  
  # Hours
  $lc_factro = int(($lc_factro * 60) + 0.2);
  $lc_cura = pop(@lc_rayo);
  $lc_sfar = int( $lc_sfar + 0.2 + ( $lc_cura * $lc_factro ) );
  if ( &bad(@lc_rayo) ) { $_[0] = $lc_sfar; return; }
  
  # Days
  $lc_factro = int(($lc_factro * 24) + 0.2);
  $lc_cura = pop(@lc_rayo);
  $lc_sfar = int( $lc_sfar + 0.2 + ( $lc_cura * $lc_factro ) );
  if ( &bad(@lc_rayo) ) { $_[0] = $lc_sfar; return; }
  
  # Weeks
  $lc_factro = int(($lc_factro * 7) + 0.2);
  $lc_cura = pop(@lc_rayo);
  $lc_sfar = int( $lc_sfar + 0.2 + ( $lc_cura * $lc_factro ) );
  if ( &bad(@lc_rayo) ) { $_[0] = $lc_sfar; return; }
}


1;

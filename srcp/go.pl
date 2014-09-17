use chimelib;
use strict;

my $hme; # Home Directory:
my $mindref;
my $andnow; # Latest reckoning of the current second
my $andgoal; # The moment for which the next chime is scheduled
my $andhypo; # The averaganti moment for the next chime scheduling
my $advanceavg;
my $offpercena;
my $fluidity;

$hme = $ENV{"HOME"};
$mindref = $hme . "/.mindfulchime";
system("mkdir","-p",$mindref);


# We set the starting values for the advancements:
($advanceavg,$offpercena,$fluidity) = @ARGV;
if ( $offpercena eq "" ) { $offpercena = 80; }
if ( $fluidity eq "" ) { $fluidity = 50; }
if ( $advanceavg eq "" ) { $advanceavg = "15:0"; }
&chimelib::timeparse($advanceavg);


# Before we begin, we treat it as though the chime has just rung right
# now - and is on average schedule
$andnow = &chimelib::cursec;
$andhypo = $andnow;
$andgoal = $andnow;

# Now for each round
while ( 2 > 1 )
{
  my $lc_offset;
  my $lc_avstretch;
  my $lc_maxdistort;
  my $lc_minstretch;
  my $lc_dostretch;
  
  # First, we find the basic offset ...
  # The further we are ahead of schedule, the greater the offset.
  # So therefore, greater offsets will need to slow us down.
  $lc_offset = ( $andhypo - $andgoal );
  
  # And now how much do we tone down the offset?
  $lc_offset = $lc_offset * ( 1 - ( $fluidity / 100 ) );
  
  # So how long is our current stretch based on the offset?
  $lc_avstretch = int( $advanceavg + $lc_offset + 0.495 );
  system("echo","So our current stretch average possibility is: " . $lc_avstretch);
  $lc_maxdistort = ( $lc_avstretch * ( $offpercena / 100 ) );
  system("echo","Maximum distortion: $lc_maxdistort");
  $lc_minstretch = ( $lc_avstretch - $lc_maxdistort );
  system("echo","Minimal stretch (before rounding) is: " . $lc_minstretch);
  $lc_dostretch = ( $lc_minstretch + rand($lc_maxdistort * 2) );
  $lc_dostretch = int($lc_dostretch + 0.495);
  system("echo","Our stretch will be: " . $lc_dostretch);
  
  # Before the Big Wait let us advance the two basic markers:
  $andgoal = int($andgoal + $lc_dostretch + 0.2);
  $andhypo = int($andhypo + $advanceavg + 0.2);
  
  $andnow = &chimelib::cursec;
  while ( $andnow < $andgoal )
  {
    my $lc2_dif;
    my $lc2_wait;
    $lc2_dif = ( $andgoal - $andnow );
    $lc2_wait = $lc2_dif;
    if ( $lc2_wait > 10 ) { $lc2_wait = 10; }
    
    
    system("echo","Seconds Remaining: " . $lc2_dif . ":");
    sleep($lc2_wait);
    $andnow = &chimelib::cursec;
  }
  
  &chimelib::playsound();
}










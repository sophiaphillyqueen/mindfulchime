my @comondos;
my $comondsiz;
my $comnom;

@comondos = @ARGV;
$comondsiz = @comondos;
if ( $comondsiz < 0.5 )
{
  die "\nAt very least, a specific action must be named.\n\n";
}
$comnom = shift(@comondos);

$ENV{"MIND_SCRIP_DIRECTORY"} = $scripdir;
$ENV{"MIND_LIB_DIRECTORY"} = $incpdir;
exec("perl","-I",$incpdir,$scripdir . "/" . $comnom . ".pl", @comondos);


# This installer will later be replaced with something better.
# It makes various unsafe assumptions --- including the assumption
# that within your home directory is a sub-directory named "bin"
# and that it is on your execution PATH. Such antiuniversalities
# must be fixed - but that fix can wait till later.
#
# Unfortunately, for now, I am implementing things in PERL,
# but (as has been done before -- by myself and others) I
# can write something in PERL now and re-implement it in C
# later.
#
# Possibly the worst temporarity is that I am using the a
# sub-directory of the source-code distribution as the
# script-residence directory. This will change eventually
# - even if the live one remains a mere copy of the
# source one.

dirac="$(dirname "${0}")"
dirac="$(cd "${dirac}" && pwd)"

echo "${dirac}"

rm -rf ~/bin/mindfulchime
(
echo "#! $(which perl)"
echo "use strict;"
echo "my \$scripdir = \"${dirac}/srcp\";"
echo "my \$incpdir = \"${dirac}/pllib\";"
cat "${dirac}/main.plsg"
) > ~/bin/mindfulchime

perl -c ~/bin/mindfulchime
chmod 755 ~/bin/mindfulchime


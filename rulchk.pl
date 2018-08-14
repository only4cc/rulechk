
use strict;
use warnings;
 
my $file = shift;
die "Error.\nUso: $0 <filename>\n" if ( ! $file );

#$/ = undef;
open my $fh, '<', $file or die;
my @data = <$fh>;
close $fh;
chomp(@data);


# Patrones de Busqueda  # Especificar en otro archivo de defs.
my $rPAT = load_rules();
my @PAT = @$rPAT;


# Revision del archivo linea x linea
my $i = 1;
foreach my $data ( @data ) {  
    verifica( $data, $i );  
    ++$i;
}


sub verifica {
    my $data = shift;
    my $linea = shift;
    foreach my $PAT ( @PAT ) {
         my @pat = ($data =~ /(.*)($PAT)(.*)/ig);
         if ( @pat ) { 
            print "linea $i : \t" .$data ."\n";
            my $aviso = ": encontre: " . $pat[1];
            print "* Regla [ $PAT ] ". $aviso ."\n";
        }
    }
}



sub load_rules {
    my $rulesfile = 'rules.txt';
    open my $fhr, '<', $rulesfile or die;
    my @datar = <$fhr>;
    close $fhr;
    chomp(@datar);
    return \@datar;
}

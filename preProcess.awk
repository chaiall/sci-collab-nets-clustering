#!/usr/bin/awk -f

{
    if( NF > 1 )
        for( i=1; i<=NF; i++ )
            for( j=1; j<=NF; j++ )
                if( $i < $j )
                    print $i, $j, 1/NF
}

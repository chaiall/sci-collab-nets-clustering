#!/usr/bin/awk -f

{
    if( NF > 1 )
        for( i=1; i<=NF; i++ )
            for( j=1; j<=NF; j++ )
                if( $i < $j )
                    a[$i" "$j] += 1/NF
}
END{
    for( k in a )
    {
        print k, a[k]
    }
}

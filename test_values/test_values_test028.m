function test_values_test028 ( )

%*****************************************************************************80
%
%% TEST028 demonstrates the use of BESSEL_KO_INT_VALUES.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    02 February 2009
%
%  Author:
%
%    John Burkardt
%
  fprintf ( 1, '\n' );
  fprintf ( 1, 'TEST028:\n' );
  fprintf ( 1, '  BESSEL_K0_INT_VALUES stores values of \n' );
  fprintf ( 1, '  the integral of the Bessel function K0.\n' );
  fprintf ( 1, '\n' );
  fprintf ( 1, '      X           FX\n' );
  fprintf ( 1, '\n' );

  n_data = 0;

  while ( 1 )

    [ n_data, x, fx ] = bessel_k0_int_values ( n_data );

    if ( n_data == 0 )
      break
    end

    fprintf ( 1, '  %12f  %24.16f\n', x, fx );

  end

  return
end
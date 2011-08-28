package Thorium::Roles::SocketClient;
{
  $Thorium::Roles::SocketClient::VERSION = '0.505';
}

# ABSTRACT: Adds socket operations to a class

use Thorium::Protection;

use Moose::Role;

has 'host' => (
    'is'            => 'rw',
    'isa'           => 'Str',
    'required'      => 1,
    'documentation' => 'Host to connect to'
);

has 'port' => (
    'is'            => 'rw',
    'isa'           => 'Int',
    'required'      => 1,
    'documentation' => 'Host port'
);

has 'socket_connect_timeout' => (
    'is'            => 'rw',
    'isa'           => 'Int',
    'default'       => sub { 5 },
    'documentation' => 'Socket connect timeout'
);

has 'socket_error' => (
    'is' => 'rw',
    'isa' => 'Str',
    'default' => '',
    'documentation' => 'Error string for socket operations'
);

sub socket_read_data {
    my ($self, $socket, $bytes, $timeout) = @_;

    my ($rin, $ein, $rout, $eout) = '';
    my ($data, $msg);

    my $sn = fileno($socket);

    vec($rin, $sn, 1) = 1;

    $ein = $rin;

    while ($timeout > 0) {

        my ($time_left) = select($rout = $rin, undef, $eout = $ein, $timeout);

        $timeout = $time_left;

        return if vec($eout, $sn, 1);

        if (vec($rout, $sn, 1)) {
            unless (defined($socket->recv($msg, $bytes))) {
                $self->socket_error('recv() returned undef on socket ' . $socket->fileno . ": $!");

                $self->log->error($self->socket_error);

                return;
            }

            $self->log->trace('Read ', length($msg), ' bytes on socket ', $socket->fileno);

            $bytes -= length($msg);
            $data .= $msg;

            if ($bytes == 0) {
                $self->log->trace('Read ', length($data), ' total bytes on socket ', $socket->fileno);
                return $data;
            }
        }
    }

    return;
}

sub socket_close {
    my ($self, $socket) = @_;

    # 2 = I/we have stopped using this socket
    if ($socket->shutdown(2) == 0) {
        my $msg = 'shutdown() on socket ' . $socket->fileno . " error: $!";

        $self->log->error($msg);

        $self->socket_error($msg);

        return;
    }

    return 1;
}

no Moose::Role;

1;



=pod

=head1 NAME

Thorium::Roles::SocketClient - Adds socket operations to a class

=head1 VERSION

version 0.505

=head1 DESCRIPTION

Assists when writing client libraries that communicate over a raw TCP/IP socket.

=head1 AUTHOR

Adam Flott <adam@npjh.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Adam Flott <adam@npjh.com>, CIDC.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__


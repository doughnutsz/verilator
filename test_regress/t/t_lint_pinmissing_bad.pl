#!/usr/bin/env perl
if (!$::Driver) { use FindBin; exec("$FindBin::Bin/bootstrap.pl", @ARGV, $0); die; }
# DESCRIPTION: Verilator: Verilog Test driver/expect definition
#
# Copyright 2008 by Wilson Snyder. This program is free software; you
# can redistribute it and/or modify it under the terms of either the GNU
# Lesser General Public License Version 3 or the Perl Artistic License
# Version 2.0.
# SPDX-License-Identifier: LGPL-3.0-only OR Artistic-2.0

scenarios(linter => 1);

my $root = "..";

if (!-r "$root/.git") {
    skip("Not in a git repository");
} else {
    lint(
        fails => 1,
        expect_filename => $Self->{golden_filename},
        );

    extract(
        in => $Self->{top_filename},
        out => "../docs/gen/ex_PINMISSING_faulty.rst",
        lines => "7-12");

    extract(
        in => $Self->{golden_filename},
        out => "../docs/gen/ex_PINMISSING_msg.rst",
        lines => "1-1");
}

ok(1);
1;

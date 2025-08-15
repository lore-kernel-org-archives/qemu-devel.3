Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9444CA0EE4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 10:01:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umrEL-0006f4-L6; Fri, 15 Aug 2025 06:00:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1umrEK-0006dz-IM
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 06:00:12 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1umrEF-0001Tw-6I
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 06:00:12 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 5F7BD6115D;
 Fri, 15 Aug 2025 10:00:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C2EC4CEEB;
 Fri, 15 Aug 2025 10:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1755252005;
 bh=Ng/HoEJdWkVfMM8CTFRGT+tr/mjppz9b4xSDotrXVlo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=B+L0s6n8GVH4KOW/1bWVV1ZriQ5uXwupnWEgSOkekkHIcWT4A5V7OYE1WNsPLQjIJ
 RLnU9/XNHOzmpSjYcD3oiiigsm0p9VLqgIyGbYXj4Qja4FJk9csyY2Fs150aMVLs12
 yh3ImXygerGCl09IZiJ49eNWtRc0wvVtwsVb3N57M3SEer81YWxmFX3hce8eoE4qUa
 y5Ro6dI4w+14Qtzj34n6jjiFKXagnY0ePtgopWDUXnqX/QFGi2r44vFucGC1ZOqX9S
 Q6OLksOa/skBky8dDt05Ep3TZpyxXse8NUw2o5XVmfniLpIDhUGdJP84y5O0DVg0rN
 xvCO1sMZQn4tw==
Date: Fri, 15 Aug 2025 12:00:00 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, John Snow
 <jsnow@redhat.com>
Subject: Re: [PATCH for-10.2 3/8] scripts: Import Python kerneldoc from
 Linux kernel
Message-ID: <20250815120000.34eef4f1@foz.lan>
In-Reply-To: <20250814171324.1614516-4-peter.maydell@linaro.org>
References: <20250814171324.1614516-1-peter.maydell@linaro.org>
 <20250814171324.1614516-4-peter.maydell@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=172.105.4.254;
 envelope-from=mchehab+huawei@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Em Thu, 14 Aug 2025 18:13:18 +0100
Peter Maydell <peter.maydell@linaro.org> escreveu:

> We last synced our copy of kerneldoc with Linux back in 2020.  In the
> interim, upstream has entirely rewritten the script in Python, and
> the new Python version is split into a main script plus some
> libraries in the kernel's scripts/lib/kdoc.
>=20
> Import all these files.  These are the versions as of kernel commit
> 0cc53520e68be, with no local changes.

I would place here the patch name, as it makes easier to identify
from where this got forked:

 0cc53520e68b ("Merge tag 'probes-fixes-v6.17-rc1' of git://git.kernel.org/=
pub/scm/linux/kernel/git/trace/linux-trace")

Btw, as I pointed on patch 0/8, docs-next is bringing several
cleanups to it:

	$ git diff 0cc53520e68b scripts/lib/kdoc scripts/kernel-doc.py|diffstat -p=
1=20
	 scripts/kernel-doc.py           |   34 +-
	 scripts/lib/kdoc/kdoc_parser.py |  499 ++++++++++++++++++++--------------=
------
	 2 files changed, 282 insertions(+), 251 deletions(-)

Better to backport them once v6.17 is released.

> We use the same lib/kdoc/ directory as the kernel does here, so we
> can avoid having to edit the top-level script just to adjust a
> pathname, even though it is probably not the naming we would have
> picked if this was a purely QEMU script.
>=20
> The Sphinx conf.py still points at the Perl version of the script,
> so this Python code will not be invoked to build the docs yet.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

I didn't apply it locally to check if they match upstream...

> ---
>  scripts/kernel-doc.py           |  325 ++++++
>  scripts/lib/kdoc/kdoc_files.py  |  291 ++++++
>  scripts/lib/kdoc/kdoc_item.py   |   42 +
>  scripts/lib/kdoc/kdoc_output.py |  749 ++++++++++++++
>  scripts/lib/kdoc/kdoc_parser.py | 1669 +++++++++++++++++++++++++++++++
>  scripts/lib/kdoc/kdoc_re.py     |  270 +++++

Yet:=20

$ git diff v6.15..0cc53520e68b scripts/lib/kdoc scripts/kernel-doc.py|diffs=
tat -p1=20
 scripts/kernel-doc.py           |  325 +++++++
 scripts/lib/kdoc/kdoc_files.py  |  291 ++++++
 scripts/lib/kdoc/kdoc_item.py   |   42 +
 scripts/lib/kdoc/kdoc_output.py |  749 +++++++++++++++++
 scripts/lib/kdoc/kdoc_parser.py | 1669 +++++++++++++++++++++++++++++++++++=
+++++
 scripts/lib/kdoc/kdoc_re.py     |  270 ++++++

diffstat is identical. So:

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

>  6 files changed, 3346 insertions(+)
>  create mode 100755 scripts/kernel-doc.py
>  create mode 100644 scripts/lib/kdoc/kdoc_files.py
>  create mode 100644 scripts/lib/kdoc/kdoc_item.py
>  create mode 100644 scripts/lib/kdoc/kdoc_output.py
>  create mode 100644 scripts/lib/kdoc/kdoc_parser.py
>  create mode 100644 scripts/lib/kdoc/kdoc_re.py
>=20
> diff --git a/scripts/kernel-doc.py b/scripts/kernel-doc.py
> new file mode 100755
> index 00000000000..fc3d46ef519
> --- /dev/null
> +++ b/scripts/kernel-doc.py
> @@ -0,0 +1,325 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright(c) 2025: Mauro Carvalho Chehab <mchehab@kernel.org>.
> +#
> +# pylint: disable=3DC0103,R0915
> +#
> +# Converted from the kernel-doc script originally written in Perl
> +# under GPLv2, copyrighted since 1998 by the following authors:
> +#
> +#    Aditya Srivastava <yashsri421@gmail.com>
> +#    Akira Yokosawa <akiyks@gmail.com>
> +#    Alexander A. Klimov <grandmaster@al2klimov.de>
> +#    Alexander Lobakin <aleksander.lobakin@intel.com>
> +#    Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> +#    Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> +#    Anna-Maria Behnsen <anna-maria@linutronix.de>
> +#    Armin Kuster <akuster@mvista.com>
> +#    Bart Van Assche <bart.vanassche@sandisk.com>
> +#    Ben Hutchings <ben@decadent.org.uk>
> +#    Borislav Petkov <bbpetkov@yahoo.de>
> +#    Chen-Yu Tsai <wenst@chromium.org>
> +#    Coco Li <lixiaoyan@google.com>
> +#    Conch=C3=BAr Navid <conchur@web.de>
> +#    Daniel Santos <daniel.santos@pobox.com>
> +#    Danilo Cesar Lemes de Paula <danilo.cesar@collabora.co.uk>
> +#    Dan Luedtke <mail@danrl.de>
> +#    Donald Hunter <donald.hunter@gmail.com>
> +#    Gabriel Krisman Bertazi <krisman@collabora.co.uk>
> +#    Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> +#    Harvey Harrison <harvey.harrison@gmail.com>
> +#    Horia Geanta <horia.geanta@freescale.com>
> +#    Ilya Dryomov <idryomov@gmail.com>
> +#    Jakub Kicinski <kuba@kernel.org>
> +#    Jani Nikula <jani.nikula@intel.com>
> +#    Jason Baron <jbaron@redhat.com>
> +#    Jason Gunthorpe <jgg@nvidia.com>
> +#    J=C3=A9r=C3=A9my Bobbio <lunar@debian.org>
> +#    Johannes Berg <johannes.berg@intel.com>
> +#    Johannes Weiner <hannes@cmpxchg.org>
> +#    Jonathan Cameron <Jonathan.Cameron@huawei.com>
> +#    Jonathan Corbet <corbet@lwn.net>
> +#    Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> +#    Kamil Rytarowski <n54@gmx.com>
> +#    Kees Cook <kees@kernel.org>
> +#    Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> +#    Levin, Alexander (Sasha Levin) <alexander.levin@verizon.com>
> +#    Linus Torvalds <torvalds@linux-foundation.org>
> +#    Lucas De Marchi <lucas.demarchi@profusion.mobi>
> +#    Mark Rutland <mark.rutland@arm.com>
> +#    Markus Heiser <markus.heiser@darmarit.de>
> +#    Martin Waitz <tali@admingilde.org>
> +#    Masahiro Yamada <masahiroy@kernel.org>
> +#    Matthew Wilcox <willy@infradead.org>
> +#    Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> +#    Michal Wajdeczko <michal.wajdeczko@intel.com>
> +#    Michael Zucchi
> +#    Mike Rapoport <rppt@linux.ibm.com>
> +#    Niklas S=C3=B6derlund <niklas.soderlund@corigine.com>
> +#    Nishanth Menon <nm@ti.com>
> +#    Paolo Bonzini <pbonzini@redhat.com>
> +#    Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> +#    Pavel Pisa <pisa@cmp.felk.cvut.cz>
> +#    Peter Maydell <peter.maydell@linaro.org>
> +#    Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> +#    Randy Dunlap <rdunlap@infradead.org>
> +#    Richard Kennedy <richard@rsk.demon.co.uk>
> +#    Rich Walker <rw@shadow.org.uk>
> +#    Rolf Eike Beer <eike-kernel@sf-tec.de>
> +#    Sakari Ailus <sakari.ailus@linux.intel.com>
> +#    Silvio Fricke <silvio.fricke@gmail.com>
> +#    Simon Huggins
> +#    Tim Waugh <twaugh@redhat.com>
> +#    Tomasz Warnie=C5=82=C5=82o <tomasz.warniello@gmail.com>
> +#    Utkarsh Tripathi <utripathi2002@gmail.com>
> +#    valdis.kletnieks@vt.edu <valdis.kletnieks@vt.edu>
> +#    Vegard Nossum <vegard.nossum@oracle.com>
> +#    Will Deacon <will.deacon@arm.com>
> +#    Yacine Belkadi <yacine.belkadi.1@gmail.com>
> +#    Yujie Liu <yujie.liu@intel.com>
> +
> +"""
> +kernel_doc
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Print formatted kernel documentation to stdout
> +
> +Read C language source or header FILEs, extract embedded
> +documentation comments, and print formatted documentation
> +to standard output.
> +
> +The documentation comments are identified by the "/**"
> +opening comment mark.
> +
> +See Documentation/doc-guide/kernel-doc.rst for the
> +documentation comment syntax.
> +"""
> +
> +import argparse
> +import logging
> +import os
> +import sys
> +
> +# Import Python modules
> +
> +LIB_DIR =3D "lib/kdoc"
> +SRC_DIR =3D os.path.dirname(os.path.realpath(__file__))
> +
> +sys.path.insert(0, os.path.join(SRC_DIR, LIB_DIR))
> +
> +from kdoc_files import KernelFiles                      # pylint: disabl=
e=3DC0413
> +from kdoc_output import RestFormat, ManFormat           # pylint: disabl=
e=3DC0413
> +
> +DESC =3D """
> +Read C language source or header FILEs, extract embedded documentation c=
omments,
> +and print formatted documentation to standard output.
> +
> +The documentation comments are identified by the "/**" opening comment m=
ark.
> +
> +See Documentation/doc-guide/kernel-doc.rst for the documentation comment=
 syntax.
> +"""
> +
> +EXPORT_FILE_DESC =3D """
> +Specify an additional FILE in which to look for EXPORT_SYMBOL informatio=
n.
> +
> +May be used multiple times.
> +"""
> +
> +EXPORT_DESC =3D """
> +Only output documentation for the symbols that have been
> +exported using EXPORT_SYMBOL() and related macros in any input
> +FILE or -export-file FILE.
> +"""
> +
> +INTERNAL_DESC =3D """
> +Only output documentation for the symbols that have NOT been
> +exported using EXPORT_SYMBOL() and related macros in any input
> +FILE or -export-file FILE.
> +"""
> +
> +FUNCTION_DESC =3D """
> +Only output documentation for the given function or DOC: section
> +title. All other functions and DOC: sections are ignored.
> +
> +May be used multiple times.
> +"""
> +
> +NOSYMBOL_DESC =3D """
> +Exclude the specified symbol from the output documentation.
> +
> +May be used multiple times.
> +"""
> +
> +FILES_DESC =3D """
> +Header and C source files to be parsed.
> +"""
> +
> +WARN_CONTENTS_BEFORE_SECTIONS_DESC =3D """
> +Warns if there are contents before sections (deprecated).
> +
> +This option is kept just for backward-compatibility, but it does nothing,
> +neither here nor at the original Perl script.
> +"""
> +
> +
> +class MsgFormatter(logging.Formatter):
> +    """Helper class to format warnings on a similar way to kernel-doc.pl=
"""
> +
> +    def format(self, record):
> +        record.levelname =3D record.levelname.capitalize()
> +        return logging.Formatter.format(self, record)
> +
> +def main():
> +    """Main program"""
> +
> +    parser =3D argparse.ArgumentParser(formatter_class=3Dargparse.RawTex=
tHelpFormatter,
> +                                     description=3DDESC)
> +
> +    # Normal arguments
> +
> +    parser.add_argument("-v", "-verbose", "--verbose", action=3D"store_t=
rue",
> +                        help=3D"Verbose output, more warnings and other =
information.")
> +
> +    parser.add_argument("-d", "-debug", "--debug", action=3D"store_true",
> +                        help=3D"Enable debug messages")
> +
> +    parser.add_argument("-M", "-modulename", "--modulename",
> +                        default=3D"Kernel API",
> +                        help=3D"Allow setting a module name at the outpu=
t.")
> +
> +    parser.add_argument("-l", "-enable-lineno", "--enable_lineno",
> +                        action=3D"store_true",
> +                        help=3D"Enable line number output (only in ReST =
mode)")
> +
> +    # Arguments to control the warning behavior
> +
> +    parser.add_argument("-Wreturn", "--wreturn", action=3D"store_true",
> +                        help=3D"Warns about the lack of a return markup =
on functions.")
> +
> +    parser.add_argument("-Wshort-desc", "-Wshort-description", "--wshort=
-desc",
> +                        action=3D"store_true",
> +                        help=3D"Warns if initial short description is mi=
ssing")
> +
> +    parser.add_argument("-Wcontents-before-sections",
> +                        "--wcontents-before-sections", action=3D"store_t=
rue",
> +                        help=3DWARN_CONTENTS_BEFORE_SECTIONS_DESC)
> +
> +    parser.add_argument("-Wall", "--wall", action=3D"store_true",
> +                        help=3D"Enable all types of warnings")
> +
> +    parser.add_argument("-Werror", "--werror", action=3D"store_true",
> +                        help=3D"Treat warnings as errors.")
> +
> +    parser.add_argument("-export-file", "--export-file", action=3D'appen=
d',
> +                        help=3DEXPORT_FILE_DESC)
> +
> +    # Output format mutually-exclusive group
> +
> +    out_group =3D parser.add_argument_group("Output format selection (mu=
tually exclusive)")
> +
> +    out_fmt =3D out_group.add_mutually_exclusive_group()
> +
> +    out_fmt.add_argument("-m", "-man", "--man", action=3D"store_true",
> +                         help=3D"Output troff manual page format.")
> +    out_fmt.add_argument("-r", "-rst", "--rst", action=3D"store_true",
> +                         help=3D"Output reStructuredText format (default=
).")
> +    out_fmt.add_argument("-N", "-none", "--none", action=3D"store_true",
> +                         help=3D"Do not output documentation, only warni=
ngs.")
> +
> +    # Output selection mutually-exclusive group
> +
> +    sel_group =3D parser.add_argument_group("Output selection (mutually =
exclusive)")
> +    sel_mut =3D sel_group.add_mutually_exclusive_group()
> +
> +    sel_mut.add_argument("-e", "-export", "--export", action=3D'store_tr=
ue',
> +                         help=3DEXPORT_DESC)
> +
> +    sel_mut.add_argument("-i", "-internal", "--internal", action=3D'stor=
e_true',
> +                         help=3DINTERNAL_DESC)
> +
> +    sel_mut.add_argument("-s", "-function", "--symbol", action=3D'append=
',
> +                         help=3DFUNCTION_DESC)
> +
> +    # Those are valid for all 3 types of filter
> +    parser.add_argument("-n", "-nosymbol", "--nosymbol", action=3D'appen=
d',
> +                        help=3DNOSYMBOL_DESC)
> +
> +    parser.add_argument("-D", "-no-doc-sections", "--no-doc-sections",
> +                        action=3D'store_true', help=3D"Don't outputt DOC=
 sections")
> +
> +    parser.add_argument("files", metavar=3D"FILE",
> +                        nargs=3D"+", help=3DFILES_DESC)
> +
> +    args =3D parser.parse_args()
> +
> +    if args.wall:
> +        args.wreturn =3D True
> +        args.wshort_desc =3D True
> +        args.wcontents_before_sections =3D True
> +
> +    logger =3D logging.getLogger()
> +
> +    if not args.debug:
> +        logger.setLevel(logging.INFO)
> +    else:
> +        logger.setLevel(logging.DEBUG)
> +
> +    formatter =3D MsgFormatter('%(levelname)s: %(message)s')
> +
> +    handler =3D logging.StreamHandler()
> +    handler.setFormatter(formatter)
> +
> +    logger.addHandler(handler)
> +
> +    python_ver =3D sys.version_info[:2]
> +    if python_ver < (3,6):
> +        logger.warning("Python 3.6 or later is required by kernel-doc")
> +
> +        # Return 0 here to avoid breaking compilation
> +        sys.exit(0)
> +
> +    if python_ver < (3,7):
> +        logger.warning("Python 3.7 or later is required for correct resu=
lts")
> +
> +    if args.man:
> +        out_style =3D ManFormat(modulename=3Dargs.modulename)
> +    elif args.none:
> +        out_style =3D None
> +    else:
> +        out_style =3D RestFormat()
> +
> +    kfiles =3D KernelFiles(verbose=3Dargs.verbose,
> +                         out_style=3Dout_style, werror=3Dargs.werror,
> +                         wreturn=3Dargs.wreturn, wshort_desc=3Dargs.wsho=
rt_desc,
> +                         wcontents_before_sections=3Dargs.wcontents_befo=
re_sections)
> +
> +    kfiles.parse(args.files, export_file=3Dargs.export_file)
> +
> +    for t in kfiles.msg(enable_lineno=3Dargs.enable_lineno, export=3Darg=
s.export,
> +                        internal=3Dargs.internal, symbol=3Dargs.symbol,
> +                        nosymbol=3Dargs.nosymbol, export_file=3Dargs.exp=
ort_file,
> +                        no_doc_sections=3Dargs.no_doc_sections):
> +        msg =3D t[1]
> +        if msg:
> +            print(msg)
> +
> +    error_count =3D kfiles.errors
> +    if not error_count:
> +        sys.exit(0)
> +
> +    if args.werror:
> +        print(f"{error_count} warnings as errors")
> +        sys.exit(error_count)
> +
> +    if args.verbose:
> +        print(f"{error_count} errors")
> +
> +    if args.none:
> +        sys.exit(0)
> +
> +    sys.exit(error_count)
> +
> +
> +# Call main method
> +if __name__ =3D=3D "__main__":
> +    main()
> diff --git a/scripts/lib/kdoc/kdoc_files.py b/scripts/lib/kdoc/kdoc_files=
.py
> new file mode 100644
> index 00000000000..9e09b45b02f
> --- /dev/null
> +++ b/scripts/lib/kdoc/kdoc_files.py
> @@ -0,0 +1,291 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright(c) 2025: Mauro Carvalho Chehab <mchehab@kernel.org>.
> +#
> +# pylint: disable=3DR0903,R0913,R0914,R0917
> +
> +"""
> +Parse lernel-doc tags on multiple kernel source files.
> +"""
> +
> +import argparse
> +import logging
> +import os
> +import re
> +
> +from kdoc_parser import KernelDoc
> +from kdoc_output import OutputFormat
> +
> +
> +class GlobSourceFiles:
> +    """
> +    Parse C source code file names and directories via an Interactor.
> +    """
> +
> +    def __init__(self, srctree=3DNone, valid_extensions=3DNone):
> +        """
> +        Initialize valid extensions with a tuple.
> +
> +        If not defined, assume default C extensions (.c and .h)
> +
> +        It would be possible to use python's glob function, but it is
> +        very slow, and it is not interactive. So, it would wait to read =
all
> +        directories before actually do something.
> +
> +        So, let's use our own implementation.
> +        """
> +
> +        if not valid_extensions:
> +            self.extensions =3D (".c", ".h")
> +        else:
> +            self.extensions =3D valid_extensions
> +
> +        self.srctree =3D srctree
> +
> +    def _parse_dir(self, dirname):
> +        """Internal function to parse files recursively"""
> +
> +        with os.scandir(dirname) as obj:
> +            for entry in obj:
> +                name =3D os.path.join(dirname, entry.name)
> +
> +                if entry.is_dir():
> +                    yield from self._parse_dir(name)
> +
> +                if not entry.is_file():
> +                    continue
> +
> +                basename =3D os.path.basename(name)
> +
> +                if not basename.endswith(self.extensions):
> +                    continue
> +
> +                yield name
> +
> +    def parse_files(self, file_list, file_not_found_cb):
> +        """
> +        Define an interator to parse all source files from file_list,
> +        handling directories if any
> +        """
> +
> +        if not file_list:
> +            return
> +
> +        for fname in file_list:
> +            if self.srctree:
> +                f =3D os.path.join(self.srctree, fname)
> +            else:
> +                f =3D fname
> +
> +            if os.path.isdir(f):
> +                yield from self._parse_dir(f)
> +            elif os.path.isfile(f):
> +                yield f
> +            elif file_not_found_cb:
> +                file_not_found_cb(fname)
> +
> +
> +class KernelFiles():
> +    """
> +    Parse kernel-doc tags on multiple kernel source files.
> +
> +    There are two type of parsers defined here:
> +        - self.parse_file(): parses both kernel-doc markups and
> +          EXPORT_SYMBOL* macros;
> +        - self.process_export_file(): parses only EXPORT_SYMBOL* macros.
> +    """
> +
> +    def warning(self, msg):
> +        """Ancillary routine to output a warning and increment error cou=
nt"""
> +
> +        self.config.log.warning(msg)
> +        self.errors +=3D 1
> +
> +    def error(self, msg):
> +        """Ancillary routine to output an error and increment error coun=
t"""
> +
> +        self.config.log.error(msg)
> +        self.errors +=3D 1
> +
> +    def parse_file(self, fname):
> +        """
> +        Parse a single Kernel source.
> +        """
> +
> +        # Prevent parsing the same file twice if results are cached
> +        if fname in self.files:
> +            return
> +
> +        doc =3D KernelDoc(self.config, fname)
> +        export_table, entries =3D doc.parse_kdoc()
> +
> +        self.export_table[fname] =3D export_table
> +
> +        self.files.add(fname)
> +        self.export_files.add(fname)      # parse_kdoc() already check e=
xports
> +
> +        self.results[fname] =3D entries
> +
> +    def process_export_file(self, fname):
> +        """
> +        Parses EXPORT_SYMBOL* macros from a single Kernel source file.
> +        """
> +
> +        # Prevent parsing the same file twice if results are cached
> +        if fname in self.export_files:
> +            return
> +
> +        doc =3D KernelDoc(self.config, fname)
> +        export_table =3D doc.parse_export()
> +
> +        if not export_table:
> +            self.error(f"Error: Cannot check EXPORT_SYMBOL* on {fname}")
> +            export_table =3D set()
> +
> +        self.export_table[fname] =3D export_table
> +        self.export_files.add(fname)
> +
> +    def file_not_found_cb(self, fname):
> +        """
> +        Callback to warn if a file was not found.
> +        """
> +
> +        self.error(f"Cannot find file {fname}")
> +
> +    def __init__(self, verbose=3DFalse, out_style=3DNone,
> +                 werror=3DFalse, wreturn=3DFalse, wshort_desc=3DFalse,
> +                 wcontents_before_sections=3DFalse,
> +                 logger=3DNone):
> +        """
> +        Initialize startup variables and parse all files
> +        """
> +
> +        if not verbose:
> +            verbose =3D bool(os.environ.get("KBUILD_VERBOSE", 0))
> +
> +        if out_style is None:
> +            out_style =3D OutputFormat()
> +
> +        if not werror:
> +            kcflags =3D os.environ.get("KCFLAGS", None)
> +            if kcflags:
> +                match =3D re.search(r"(\s|^)-Werror(\s|$)/", kcflags)
> +                if match:
> +                    werror =3D True
> +
> +            # reading this variable is for backwards compat just in case
> +            # someone was calling it with the variable from outside the
> +            # kernel's build system
> +            kdoc_werror =3D os.environ.get("KDOC_WERROR", None)
> +            if kdoc_werror:
> +                werror =3D kdoc_werror
> +
> +        # Some variables are global to the parser logic as a whole as th=
ey are
> +        # used to send control configuration to KernelDoc class. As such,
> +        # those variables are read-only inside the KernelDoc.
> +        self.config =3D argparse.Namespace
> +
> +        self.config.verbose =3D verbose
> +        self.config.werror =3D werror
> +        self.config.wreturn =3D wreturn
> +        self.config.wshort_desc =3D wshort_desc
> +        self.config.wcontents_before_sections =3D wcontents_before_secti=
ons
> +
> +        if not logger:
> +            self.config.log =3D logging.getLogger("kernel-doc")
> +        else:
> +            self.config.log =3D logger
> +
> +        self.config.warning =3D self.warning
> +
> +        self.config.src_tree =3D os.environ.get("SRCTREE", None)
> +
> +        # Initialize variables that are internal to KernelFiles
> +
> +        self.out_style =3D out_style
> +
> +        self.errors =3D 0
> +        self.results =3D {}
> +
> +        self.files =3D set()
> +        self.export_files =3D set()
> +        self.export_table =3D {}
> +
> +    def parse(self, file_list, export_file=3DNone):
> +        """
> +        Parse all files
> +        """
> +
> +        glob =3D GlobSourceFiles(srctree=3Dself.config.src_tree)
> +
> +        for fname in glob.parse_files(file_list, self.file_not_found_cb):
> +            self.parse_file(fname)
> +
> +        for fname in glob.parse_files(export_file, self.file_not_found_c=
b):
> +            self.process_export_file(fname)
> +
> +    def out_msg(self, fname, name, arg):
> +        """
> +        Return output messages from a file name using the output style
> +        filtering.
> +
> +        If output type was not handled by the syler, return None.
> +        """
> +
> +        # NOTE: we can add rules here to filter out unwanted parts,
> +        # although OutputFormat.msg already does that.
> +
> +        return self.out_style.msg(fname, name, arg)
> +
> +    def msg(self, enable_lineno=3DFalse, export=3DFalse, internal=3DFals=
e,
> +            symbol=3DNone, nosymbol=3DNone, no_doc_sections=3DFalse,
> +            filenames=3DNone, export_file=3DNone):
> +        """
> +        Interacts over the kernel-doc results and output messages,
> +        returning kernel-doc markups on each interaction
> +        """
> +
> +        self.out_style.set_config(self.config)
> +
> +        if not filenames:
> +            filenames =3D sorted(self.results.keys())
> +
> +        glob =3D GlobSourceFiles(srctree=3Dself.config.src_tree)
> +
> +        for fname in filenames:
> +            function_table =3D set()
> +
> +            if internal or export:
> +                if not export_file:
> +                    export_file =3D [fname]
> +
> +                for f in glob.parse_files(export_file, self.file_not_fou=
nd_cb):
> +                    function_table |=3D self.export_table[f]
> +
> +            if symbol:
> +                for s in symbol:
> +                    function_table.add(s)
> +
> +            self.out_style.set_filter(export, internal, symbol, nosymbol,
> +                                      function_table, enable_lineno,
> +                                      no_doc_sections)
> +
> +            msg =3D ""
> +            if fname not in self.results:
> +                self.config.log.warning("No kernel-doc for file %s", fna=
me)
> +                continue
> +
> +            for arg in self.results[fname]:
> +                m =3D self.out_msg(fname, arg.name, arg)
> +
> +                if m is None:
> +                    ln =3D arg.get("ln", 0)
> +                    dtype =3D arg.get('type', "")
> +
> +                    self.config.log.warning("%s:%d Can't handle %s",
> +                                            fname, ln, dtype)
> +                else:
> +                    msg +=3D m
> +
> +            if msg:
> +                yield fname, msg
> diff --git a/scripts/lib/kdoc/kdoc_item.py b/scripts/lib/kdoc/kdoc_item.py
> new file mode 100644
> index 00000000000..b3b22576455
> --- /dev/null
> +++ b/scripts/lib/kdoc/kdoc_item.py
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# A class that will, eventually, encapsulate all of the parsed data that=
 we
> +# then pass into the output modules.
> +#
> +
> +class KdocItem:
> +    def __init__(self, name, type, start_line, **other_stuff):
> +        self.name =3D name
> +        self.type =3D type
> +        self.declaration_start_line =3D start_line
> +        self.sections =3D {}
> +        self.sections_start_lines =3D {}
> +        self.parameterlist =3D []
> +        self.parameterdesc_start_lines =3D []
> +        self.parameterdescs =3D {}
> +        self.parametertypes =3D {}
> +        #
> +        # Just save everything else into our own dict so that the output
> +        # side can grab it directly as before.  As we move things into m=
ore
> +        # structured data, this will, hopefully, fade away.
> +        #
> +        self.other_stuff =3D other_stuff
> +
> +    def get(self, key, default =3D None):
> +        return self.other_stuff.get(key, default)
> +
> +    def __getitem__(self, key):
> +        return self.get(key)
> +
> +    #
> +    # Tracking of section and parameter information.
> +    #
> +    def set_sections(self, sections, start_lines):
> +        self.sections =3D sections
> +        self.section_start_lines =3D start_lines
> +
> +    def set_params(self, names, descs, types, starts):
> +        self.parameterlist =3D names
> +        self.parameterdescs =3D descs
> +        self.parametertypes =3D types
> +        self.parameterdesc_start_lines =3D starts
> diff --git a/scripts/lib/kdoc/kdoc_output.py b/scripts/lib/kdoc/kdoc_outp=
ut.py
> new file mode 100644
> index 00000000000..ea8914537ba
> --- /dev/null
> +++ b/scripts/lib/kdoc/kdoc_output.py
> @@ -0,0 +1,749 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright(c) 2025: Mauro Carvalho Chehab <mchehab@kernel.org>.
> +#
> +# pylint: disable=3DC0301,R0902,R0911,R0912,R0913,R0914,R0915,R0917
> +
> +"""
> +Implement output filters to print kernel-doc documentation.
> +
> +The implementation uses a virtual base class (OutputFormat) which
> +contains a dispatches to virtual methods, and some code to filter
> +out output messages.
> +
> +The actual implementation is done on one separate class per each type
> +of output. Currently, there are output classes for ReST and man/troff.
> +"""
> +
> +import os
> +import re
> +from datetime import datetime
> +
> +from kdoc_parser import KernelDoc, type_param
> +from kdoc_re import KernRe
> +
> +
> +function_pointer =3D KernRe(r"([^\(]*\(\*)\s*\)\s*\(([^\)]*)\)", cache=
=3DFalse)
> +
> +# match expressions used to find embedded type information
> +type_constant =3D KernRe(r"\b``([^\`]+)``\b", cache=3DFalse)
> +type_constant2 =3D KernRe(r"\%([-_*\w]+)", cache=3DFalse)
> +type_func =3D KernRe(r"(\w+)\(\)", cache=3DFalse)
> +type_param_ref =3D KernRe(r"([\!~\*]?)\@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)=
", cache=3DFalse)
> +
> +# Special RST handling for func ptr params
> +type_fp_param =3D KernRe(r"\@(\w+)\(\)", cache=3DFalse)
> +
> +# Special RST handling for structs with func ptr params
> +type_fp_param2 =3D KernRe(r"\@(\w+->\S+)\(\)", cache=3DFalse)
> +
> +type_env =3D KernRe(r"(\$\w+)", cache=3DFalse)
> +type_enum =3D KernRe(r"\&(enum\s*([_\w]+))", cache=3DFalse)
> +type_struct =3D KernRe(r"\&(struct\s*([_\w]+))", cache=3DFalse)
> +type_typedef =3D KernRe(r"\&(typedef\s*([_\w]+))", cache=3DFalse)
> +type_union =3D KernRe(r"\&(union\s*([_\w]+))", cache=3DFalse)
> +type_member =3D KernRe(r"\&([_\w]+)(\.|->)([_\w]+)", cache=3DFalse)
> +type_fallback =3D KernRe(r"\&([_\w]+)", cache=3DFalse)
> +type_member_func =3D type_member + KernRe(r"\(\)", cache=3DFalse)
> +
> +
> +class OutputFormat:
> +    """
> +    Base class for OutputFormat. If used as-is, it means that only
> +    warnings will be displayed.
> +    """
> +
> +    # output mode.
> +    OUTPUT_ALL          =3D 0 # output all symbols and doc sections
> +    OUTPUT_INCLUDE      =3D 1 # output only specified symbols
> +    OUTPUT_EXPORTED     =3D 2 # output exported symbols
> +    OUTPUT_INTERNAL     =3D 3 # output non-exported symbols
> +
> +    # Virtual member to be overriden at the  inherited classes
> +    highlights =3D []
> +
> +    def __init__(self):
> +        """Declare internal vars and set mode to OUTPUT_ALL"""
> +
> +        self.out_mode =3D self.OUTPUT_ALL
> +        self.enable_lineno =3D None
> +        self.nosymbol =3D {}
> +        self.symbol =3D None
> +        self.function_table =3D None
> +        self.config =3D None
> +        self.no_doc_sections =3D False
> +
> +        self.data =3D ""
> +
> +    def set_config(self, config):
> +        """
> +        Setup global config variables used by both parser and output.
> +        """
> +
> +        self.config =3D config
> +
> +    def set_filter(self, export, internal, symbol, nosymbol, function_ta=
ble,
> +                   enable_lineno, no_doc_sections):
> +        """
> +        Initialize filter variables according with the requested mode.
> +
> +        Only one choice is valid between export, internal and symbol.
> +
> +        The nosymbol filter can be used on all modes.
> +        """
> +
> +        self.enable_lineno =3D enable_lineno
> +        self.no_doc_sections =3D no_doc_sections
> +        self.function_table =3D function_table
> +
> +        if symbol:
> +            self.out_mode =3D self.OUTPUT_INCLUDE
> +        elif export:
> +            self.out_mode =3D self.OUTPUT_EXPORTED
> +        elif internal:
> +            self.out_mode =3D self.OUTPUT_INTERNAL
> +        else:
> +            self.out_mode =3D self.OUTPUT_ALL
> +
> +        if nosymbol:
> +            self.nosymbol =3D set(nosymbol)
> +
> +
> +    def highlight_block(self, block):
> +        """
> +        Apply the RST highlights to a sub-block of text.
> +        """
> +
> +        for r, sub in self.highlights:
> +            block =3D r.sub(sub, block)
> +
> +        return block
> +
> +    def out_warnings(self, args):
> +        """
> +        Output warnings for identifiers that will be displayed.
> +        """
> +
> +        for log_msg in args.warnings:
> +            self.config.warning(log_msg)
> +
> +    def check_doc(self, name, args):
> +        """Check if DOC should be output"""
> +
> +        if self.no_doc_sections:
> +            return False
> +
> +        if name in self.nosymbol:
> +            return False
> +
> +        if self.out_mode =3D=3D self.OUTPUT_ALL:
> +            self.out_warnings(args)
> +            return True
> +
> +        if self.out_mode =3D=3D self.OUTPUT_INCLUDE:
> +            if name in self.function_table:
> +                self.out_warnings(args)
> +                return True
> +
> +        return False
> +
> +    def check_declaration(self, dtype, name, args):
> +        """
> +        Checks if a declaration should be output or not based on the
> +        filtering criteria.
> +        """
> +
> +        if name in self.nosymbol:
> +            return False
> +
> +        if self.out_mode =3D=3D self.OUTPUT_ALL:
> +            self.out_warnings(args)
> +            return True
> +
> +        if self.out_mode in [self.OUTPUT_INCLUDE, self.OUTPUT_EXPORTED]:
> +            if name in self.function_table:
> +                return True
> +
> +        if self.out_mode =3D=3D self.OUTPUT_INTERNAL:
> +            if dtype !=3D "function":
> +                self.out_warnings(args)
> +                return True
> +
> +            if name not in self.function_table:
> +                self.out_warnings(args)
> +                return True
> +
> +        return False
> +
> +    def msg(self, fname, name, args):
> +        """
> +        Handles a single entry from kernel-doc parser
> +        """
> +
> +        self.data =3D ""
> +
> +        dtype =3D args.type
> +
> +        if dtype =3D=3D "doc":
> +            self.out_doc(fname, name, args)
> +            return self.data
> +
> +        if not self.check_declaration(dtype, name, args):
> +            return self.data
> +
> +        if dtype =3D=3D "function":
> +            self.out_function(fname, name, args)
> +            return self.data
> +
> +        if dtype =3D=3D "enum":
> +            self.out_enum(fname, name, args)
> +            return self.data
> +
> +        if dtype =3D=3D "typedef":
> +            self.out_typedef(fname, name, args)
> +            return self.data
> +
> +        if dtype in ["struct", "union"]:
> +            self.out_struct(fname, name, args)
> +            return self.data
> +
> +        # Warn if some type requires an output logic
> +        self.config.log.warning("doesn't now how to output '%s' block",
> +                                dtype)
> +
> +        return None
> +
> +    # Virtual methods to be overridden by inherited classes
> +    # At the base class, those do nothing.
> +    def out_doc(self, fname, name, args):
> +        """Outputs a DOC block"""
> +
> +    def out_function(self, fname, name, args):
> +        """Outputs a function"""
> +
> +    def out_enum(self, fname, name, args):
> +        """Outputs an enum"""
> +
> +    def out_typedef(self, fname, name, args):
> +        """Outputs a typedef"""
> +
> +    def out_struct(self, fname, name, args):
> +        """Outputs a struct"""
> +
> +
> +class RestFormat(OutputFormat):
> +    """Consts and functions used by ReST output"""
> +
> +    highlights =3D [
> +        (type_constant, r"``\1``"),
> +        (type_constant2, r"``\1``"),
> +
> +        # Note: need to escape () to avoid func matching later
> +        (type_member_func, r":c:type:`\1\2\3\\(\\) <\1>`"),
> +        (type_member, r":c:type:`\1\2\3 <\1>`"),
> +        (type_fp_param, r"**\1\\(\\)**"),
> +        (type_fp_param2, r"**\1\\(\\)**"),
> +        (type_func, r"\1()"),
> +        (type_enum, r":c:type:`\1 <\2>`"),
> +        (type_struct, r":c:type:`\1 <\2>`"),
> +        (type_typedef, r":c:type:`\1 <\2>`"),
> +        (type_union, r":c:type:`\1 <\2>`"),
> +
> +        # in rst this can refer to any type
> +        (type_fallback, r":c:type:`\1`"),
> +        (type_param_ref, r"**\1\2**")
> +    ]
> +    blankline =3D "\n"
> +
> +    sphinx_literal =3D KernRe(r'^[^.].*::$', cache=3DFalse)
> +    sphinx_cblock =3D KernRe(r'^\.\.\ +code-block::', cache=3DFalse)
> +
> +    def __init__(self):
> +        """
> +        Creates class variables.
> +
> +        Not really mandatory, but it is a good coding style and makes
> +        pylint happy.
> +        """
> +
> +        super().__init__()
> +        self.lineprefix =3D ""
> +
> +    def print_lineno(self, ln):
> +        """Outputs a line number"""
> +
> +        if self.enable_lineno and ln is not None:
> +            ln +=3D 1
> +            self.data +=3D f".. LINENO {ln}\n"
> +
> +    def output_highlight(self, args):
> +        """
> +        Outputs a C symbol that may require being converted to ReST using
> +        the self.highlights variable
> +        """
> +
> +        input_text =3D args
> +        output =3D ""
> +        in_literal =3D False
> +        litprefix =3D ""
> +        block =3D ""
> +
> +        for line in input_text.strip("\n").split("\n"):
> +
> +            # If we're in a literal block, see if we should drop out of =
it.
> +            # Otherwise, pass the line straight through unmunged.
> +            if in_literal:
> +                if line.strip():  # If the line is not blank
> +                    # If this is the first non-blank line in a literal b=
lock,
> +                    # figure out the proper indent.
> +                    if not litprefix:
> +                        r =3D KernRe(r'^(\s*)')
> +                        if r.match(line):
> +                            litprefix =3D '^' + r.group(1)
> +                        else:
> +                            litprefix =3D ""
> +
> +                        output +=3D line + "\n"
> +                    elif not KernRe(litprefix).match(line):
> +                        in_literal =3D False
> +                    else:
> +                        output +=3D line + "\n"
> +                else:
> +                    output +=3D line + "\n"
> +
> +            # Not in a literal block (or just dropped out)
> +            if not in_literal:
> +                block +=3D line + "\n"
> +                if self.sphinx_literal.match(line) or self.sphinx_cblock=
.match(line):
> +                    in_literal =3D True
> +                    litprefix =3D ""
> +                    output +=3D self.highlight_block(block)
> +                    block =3D ""
> +
> +        # Handle any remaining block
> +        if block:
> +            output +=3D self.highlight_block(block)
> +
> +        # Print the output with the line prefix
> +        for line in output.strip("\n").split("\n"):
> +            self.data +=3D self.lineprefix + line + "\n"
> +
> +    def out_section(self, args, out_docblock=3DFalse):
> +        """
> +        Outputs a block section.
> +
> +        This could use some work; it's used to output the DOC: sections,=
 and
> +        starts by putting out the name of the doc section itself, but th=
at
> +        tends to duplicate a header already in the template file.
> +        """
> +        for section, text in args.sections.items():
> +            # Skip sections that are in the nosymbol_table
> +            if section in self.nosymbol:
> +                continue
> +
> +            if out_docblock:
> +                if not self.out_mode =3D=3D self.OUTPUT_INCLUDE:
> +                    self.data +=3D f".. _{section}:\n\n"
> +                    self.data +=3D f'{self.lineprefix}**{section}**\n\n'
> +            else:
> +                self.data +=3D f'{self.lineprefix}**{section}**\n\n'
> +
> +            self.print_lineno(args.section_start_lines.get(section, 0))
> +            self.output_highlight(text)
> +            self.data +=3D "\n"
> +        self.data +=3D "\n"
> +
> +    def out_doc(self, fname, name, args):
> +        if not self.check_doc(name, args):
> +            return
> +        self.out_section(args, out_docblock=3DTrue)
> +
> +    def out_function(self, fname, name, args):
> +
> +        oldprefix =3D self.lineprefix
> +        signature =3D ""
> +
> +        func_macro =3D args.get('func_macro', False)
> +        if func_macro:
> +            signature =3D name
> +        else:
> +            if args.get('functiontype'):
> +                signature =3D args['functiontype'] + " "
> +            signature +=3D name + " ("
> +
> +        ln =3D args.declaration_start_line
> +        count =3D 0
> +        for parameter in args.parameterlist:
> +            if count !=3D 0:
> +                signature +=3D ", "
> +            count +=3D 1
> +            dtype =3D args.parametertypes.get(parameter, "")
> +
> +            if function_pointer.search(dtype):
> +                signature +=3D function_pointer.group(1) + parameter + f=
unction_pointer.group(3)
> +            else:
> +                signature +=3D dtype
> +
> +        if not func_macro:
> +            signature +=3D ")"
> +
> +        self.print_lineno(ln)
> +        if args.get('typedef') or not args.get('functiontype'):
> +            self.data +=3D f".. c:macro:: {name}\n\n"
> +
> +            if args.get('typedef'):
> +                self.data +=3D "   **Typedef**: "
> +                self.lineprefix =3D ""
> +                self.output_highlight(args.get('purpose', ""))
> +                self.data +=3D "\n\n**Syntax**\n\n"
> +                self.data +=3D f"  ``{signature}``\n\n"
> +            else:
> +                self.data +=3D f"``{signature}``\n\n"
> +        else:
> +            self.data +=3D f".. c:function:: {signature}\n\n"
> +
> +        if not args.get('typedef'):
> +            self.print_lineno(ln)
> +            self.lineprefix =3D "   "
> +            self.output_highlight(args.get('purpose', ""))
> +            self.data +=3D "\n"
> +
> +        # Put descriptive text into a container (HTML <div>) to help set
> +        # function prototypes apart
> +        self.lineprefix =3D "  "
> +
> +        if args.parameterlist:
> +            self.data +=3D ".. container:: kernelindent\n\n"
> +            self.data +=3D f"{self.lineprefix}**Parameters**\n\n"
> +
> +        for parameter in args.parameterlist:
> +            parameter_name =3D KernRe(r'\[.*').sub('', parameter)
> +            dtype =3D args.parametertypes.get(parameter, "")
> +
> +            if dtype:
> +                self.data +=3D f"{self.lineprefix}``{dtype}``\n"
> +            else:
> +                self.data +=3D f"{self.lineprefix}``{parameter}``\n"
> +
> +            self.print_lineno(args.parameterdesc_start_lines.get(paramet=
er_name, 0))
> +
> +            self.lineprefix =3D "    "
> +            if parameter_name in args.parameterdescs and \
> +               args.parameterdescs[parameter_name] !=3D KernelDoc.undesc=
ribed:
> +
> +                self.output_highlight(args.parameterdescs[parameter_name=
])
> +                self.data +=3D "\n"
> +            else:
> +                self.data +=3D f"{self.lineprefix}*undescribed*\n\n"
> +            self.lineprefix =3D "  "
> +
> +        self.out_section(args)
> +        self.lineprefix =3D oldprefix
> +
> +    def out_enum(self, fname, name, args):
> +
> +        oldprefix =3D self.lineprefix
> +        ln =3D args.declaration_start_line
> +
> +        self.data +=3D f"\n\n.. c:enum:: {name}\n\n"
> +
> +        self.print_lineno(ln)
> +        self.lineprefix =3D "  "
> +        self.output_highlight(args.get('purpose', ''))
> +        self.data +=3D "\n"
> +
> +        self.data +=3D ".. container:: kernelindent\n\n"
> +        outer =3D self.lineprefix + "  "
> +        self.lineprefix =3D outer + "  "
> +        self.data +=3D f"{outer}**Constants**\n\n"
> +
> +        for parameter in args.parameterlist:
> +            self.data +=3D f"{outer}``{parameter}``\n"
> +
> +            if args.parameterdescs.get(parameter, '') !=3D KernelDoc.und=
escribed:
> +                self.output_highlight(args.parameterdescs[parameter])
> +            else:
> +                self.data +=3D f"{self.lineprefix}*undescribed*\n\n"
> +            self.data +=3D "\n"
> +
> +        self.lineprefix =3D oldprefix
> +        self.out_section(args)
> +
> +    def out_typedef(self, fname, name, args):
> +
> +        oldprefix =3D self.lineprefix
> +        ln =3D args.declaration_start_line
> +
> +        self.data +=3D f"\n\n.. c:type:: {name}\n\n"
> +
> +        self.print_lineno(ln)
> +        self.lineprefix =3D "   "
> +
> +        self.output_highlight(args.get('purpose', ''))
> +
> +        self.data +=3D "\n"
> +
> +        self.lineprefix =3D oldprefix
> +        self.out_section(args)
> +
> +    def out_struct(self, fname, name, args):
> +
> +        purpose =3D args.get('purpose', "")
> +        declaration =3D args.get('definition', "")
> +        dtype =3D args.type
> +        ln =3D args.declaration_start_line
> +
> +        self.data +=3D f"\n\n.. c:{dtype}:: {name}\n\n"
> +
> +        self.print_lineno(ln)
> +
> +        oldprefix =3D self.lineprefix
> +        self.lineprefix +=3D "  "
> +
> +        self.output_highlight(purpose)
> +        self.data +=3D "\n"
> +
> +        self.data +=3D ".. container:: kernelindent\n\n"
> +        self.data +=3D f"{self.lineprefix}**Definition**::\n\n"
> +
> +        self.lineprefix =3D self.lineprefix + "  "
> +
> +        declaration =3D declaration.replace("\t", self.lineprefix)
> +
> +        self.data +=3D f"{self.lineprefix}{dtype} {name}" + ' {' + "\n"
> +        self.data +=3D f"{declaration}{self.lineprefix}" + "};\n\n"
> +
> +        self.lineprefix =3D "  "
> +        self.data +=3D f"{self.lineprefix}**Members**\n\n"
> +        for parameter in args.parameterlist:
> +            if not parameter or parameter.startswith("#"):
> +                continue
> +
> +            parameter_name =3D parameter.split("[", maxsplit=3D1)[0]
> +
> +            if args.parameterdescs.get(parameter_name) =3D=3D KernelDoc.=
undescribed:
> +                continue
> +
> +            self.print_lineno(args.parameterdesc_start_lines.get(paramet=
er_name, 0))
> +
> +            self.data +=3D f"{self.lineprefix}``{parameter}``\n"
> +
> +            self.lineprefix =3D "    "
> +            self.output_highlight(args.parameterdescs[parameter_name])
> +            self.lineprefix =3D "  "
> +
> +            self.data +=3D "\n"
> +
> +        self.data +=3D "\n"
> +
> +        self.lineprefix =3D oldprefix
> +        self.out_section(args)
> +
> +
> +class ManFormat(OutputFormat):
> +    """Consts and functions used by man pages output"""
> +
> +    highlights =3D (
> +        (type_constant, r"\1"),
> +        (type_constant2, r"\1"),
> +        (type_func, r"\\fB\1\\fP"),
> +        (type_enum, r"\\fI\1\\fP"),
> +        (type_struct, r"\\fI\1\\fP"),
> +        (type_typedef, r"\\fI\1\\fP"),
> +        (type_union, r"\\fI\1\\fP"),
> +        (type_param, r"\\fI\1\\fP"),
> +        (type_param_ref, r"\\fI\1\2\\fP"),
> +        (type_member, r"\\fI\1\2\3\\fP"),
> +        (type_fallback, r"\\fI\1\\fP")
> +    )
> +    blankline =3D ""
> +
> +    date_formats =3D [
> +        "%a %b %d %H:%M:%S %Z %Y",
> +        "%a %b %d %H:%M:%S %Y",
> +        "%Y-%m-%d",
> +        "%b %d %Y",
> +        "%B %d %Y",
> +        "%m %d %Y",
> +    ]
> +
> +    def __init__(self, modulename):
> +        """
> +        Creates class variables.
> +
> +        Not really mandatory, but it is a good coding style and makes
> +        pylint happy.
> +        """
> +
> +        super().__init__()
> +        self.modulename =3D modulename
> +
> +        dt =3D None
> +        tstamp =3D os.environ.get("KBUILD_BUILD_TIMESTAMP")
> +        if tstamp:
> +            for fmt in self.date_formats:
> +                try:
> +                    dt =3D datetime.strptime(tstamp, fmt)
> +                    break
> +                except ValueError:
> +                    pass
> +
> +        if not dt:
> +            dt =3D datetime.now()
> +
> +        self.man_date =3D dt.strftime("%B %Y")
> +
> +    def output_highlight(self, block):
> +        """
> +        Outputs a C symbol that may require being highlighted with
> +        self.highlights variable using troff syntax
> +        """
> +
> +        contents =3D self.highlight_block(block)
> +
> +        if isinstance(contents, list):
> +            contents =3D "\n".join(contents)
> +
> +        for line in contents.strip("\n").split("\n"):
> +            line =3D KernRe(r"^\s*").sub("", line)
> +            if not line:
> +                continue
> +
> +            if line[0] =3D=3D ".":
> +                self.data +=3D "\\&" + line + "\n"
> +            else:
> +                self.data +=3D line + "\n"
> +
> +    def out_doc(self, fname, name, args):
> +        if not self.check_doc(name, args):
> +            return
> +
> +        self.data +=3D f'.TH "{self.modulename}" 9 "{self.modulename}" "=
{self.man_date}" "API Manual" LINUX' + "\n"
> +
> +        for section, text in args.sections.items():
> +            self.data +=3D f'.SH "{section}"' + "\n"
> +            self.output_highlight(text)
> +
> +    def out_function(self, fname, name, args):
> +        """output function in man"""
> +
> +        self.data +=3D f'.TH "{name}" 9 "{name}" "{self.man_date}" "Kern=
el Hacker\'s Manual" LINUX' + "\n"
> +
> +        self.data +=3D ".SH NAME\n"
> +        self.data +=3D f"{name} \\- {args['purpose']}\n"
> +
> +        self.data +=3D ".SH SYNOPSIS\n"
> +        if args.get('functiontype', ''):
> +            self.data +=3D f'.B "{args["functiontype"]}" {name}' + "\n"
> +        else:
> +            self.data +=3D f'.B "{name}' + "\n"
> +
> +        count =3D 0
> +        parenth =3D "("
> +        post =3D ","
> +
> +        for parameter in args.parameterlist:
> +            if count =3D=3D len(args.parameterlist) - 1:
> +                post =3D ");"
> +
> +            dtype =3D args.parametertypes.get(parameter, "")
> +            if function_pointer.match(dtype):
> +                # Pointer-to-function
> +                self.data +=3D f'".BI "{parenth}{function_pointer.group(=
1)}" " ") ({function_pointer.group(2)}){post}"' + "\n"
> +            else:
> +                dtype =3D KernRe(r'([^\*])$').sub(r'\1 ', dtype)
> +
> +                self.data +=3D f'.BI "{parenth}{dtype}"  "{post}"' + "\n"
> +            count +=3D 1
> +            parenth =3D ""
> +
> +        if args.parameterlist:
> +            self.data +=3D ".SH ARGUMENTS\n"
> +
> +        for parameter in args.parameterlist:
> +            parameter_name =3D re.sub(r'\[.*', '', parameter)
> +
> +            self.data +=3D f'.IP "{parameter}" 12' + "\n"
> +            self.output_highlight(args.parameterdescs.get(parameter_name=
, ""))
> +
> +        for section, text in args.sections.items():
> +            self.data +=3D f'.SH "{section.upper()}"' + "\n"
> +            self.output_highlight(text)
> +
> +    def out_enum(self, fname, name, args):
> +        self.data +=3D f'.TH "{self.modulename}" 9 "enum {name}" "{self.=
man_date}" "API Manual" LINUX' + "\n"
> +
> +        self.data +=3D ".SH NAME\n"
> +        self.data +=3D f"enum {name} \\- {args['purpose']}\n"
> +
> +        self.data +=3D ".SH SYNOPSIS\n"
> +        self.data +=3D f"enum {name}" + " {\n"
> +
> +        count =3D 0
> +        for parameter in args.parameterlist:
> +            self.data +=3D f'.br\n.BI "    {parameter}"' + "\n"
> +            if count =3D=3D len(args.parameterlist) - 1:
> +                self.data +=3D "\n};\n"
> +            else:
> +                self.data +=3D ", \n.br\n"
> +
> +            count +=3D 1
> +
> +        self.data +=3D ".SH Constants\n"
> +
> +        for parameter in args.parameterlist:
> +            parameter_name =3D KernRe(r'\[.*').sub('', parameter)
> +            self.data +=3D f'.IP "{parameter}" 12' + "\n"
> +            self.output_highlight(args.parameterdescs.get(parameter_name=
, ""))
> +
> +        for section, text in args.sections.items():
> +            self.data +=3D f'.SH "{section}"' + "\n"
> +            self.output_highlight(text)
> +
> +    def out_typedef(self, fname, name, args):
> +        module =3D self.modulename
> +        purpose =3D args.get('purpose')
> +
> +        self.data +=3D f'.TH "{module}" 9 "{name}" "{self.man_date}" "AP=
I Manual" LINUX' + "\n"
> +
> +        self.data +=3D ".SH NAME\n"
> +        self.data +=3D f"typedef {name} \\- {purpose}\n"
> +
> +        for section, text in args.sections.items():
> +            self.data +=3D f'.SH "{section}"' + "\n"
> +            self.output_highlight(text)
> +
> +    def out_struct(self, fname, name, args):
> +        module =3D self.modulename
> +        purpose =3D args.get('purpose')
> +        definition =3D args.get('definition')
> +
> +        self.data +=3D f'.TH "{module}" 9 "{args.type} {name}" "{self.ma=
n_date}" "API Manual" LINUX' + "\n"
> +
> +        self.data +=3D ".SH NAME\n"
> +        self.data +=3D f"{args.type} {name} \\- {purpose}\n"
> +
> +        # Replace tabs with two spaces and handle newlines
> +        declaration =3D definition.replace("\t", "  ")
> +        declaration =3D KernRe(r"\n").sub('"\n.br\n.BI "', declaration)
> +
> +        self.data +=3D ".SH SYNOPSIS\n"
> +        self.data +=3D f"{args.type} {name} " + "{" + "\n.br\n"
> +        self.data +=3D f'.BI "{declaration}\n' + "};\n.br\n\n"
> +
> +        self.data +=3D ".SH Members\n"
> +        for parameter in args.parameterlist:
> +            if parameter.startswith("#"):
> +                continue
> +
> +            parameter_name =3D re.sub(r"\[.*", "", parameter)
> +
> +            if args.parameterdescs.get(parameter_name) =3D=3D KernelDoc.=
undescribed:
> +                continue
> +
> +            self.data +=3D f'.IP "{parameter}" 12' + "\n"
> +            self.output_highlight(args.parameterdescs.get(parameter_name=
))
> +
> +        for section, text in args.sections.items():
> +            self.data +=3D f'.SH "{section}"' + "\n"
> +            self.output_highlight(text)
> diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_pars=
er.py
> new file mode 100644
> index 00000000000..fe730099eca
> --- /dev/null
> +++ b/scripts/lib/kdoc/kdoc_parser.py
> @@ -0,0 +1,1669 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright(c) 2025: Mauro Carvalho Chehab <mchehab@kernel.org>.
> +#
> +# pylint: disable=3DC0301,C0302,R0904,R0912,R0913,R0914,R0915,R0917,R1702
> +
> +"""
> +kdoc_parser
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Read a C language source or header FILE and extract embedded
> +documentation comments
> +"""
> +
> +import sys
> +import re
> +from pprint import pformat
> +
> +from kdoc_re import NestedMatch, KernRe
> +from kdoc_item import KdocItem
> +
> +#
> +# Regular expressions used to parse kernel-doc markups at KernelDoc clas=
s.
> +#
> +# Let's declare them in lowercase outside any class to make easier to
> +# convert from the python script.
> +#
> +# As those are evaluated at the beginning, no need to cache them
> +#
> +
> +# Allow whitespace at end of comment start.
> +doc_start =3D KernRe(r'^/\*\*\s*$', cache=3DFalse)
> +
> +doc_end =3D KernRe(r'\*/', cache=3DFalse)
> +doc_com =3D KernRe(r'\s*\*\s*', cache=3DFalse)
> +doc_com_body =3D KernRe(r'\s*\* ?', cache=3DFalse)
> +doc_decl =3D doc_com + KernRe(r'(\w+)', cache=3DFalse)
> +
> +# @params and a strictly limited set of supported section names
> +# Specifically:
> +#   Match @word:
> +#         @...:
> +#         @{section-name}:
> +# while trying to not match literal block starts like "example::"
> +#
> +known_section_names =3D 'description|context|returns?|notes?|examples?'
> +known_sections =3D KernRe(known_section_names, flags =3D re.I)
> +doc_sect =3D doc_com + \
> +    KernRe(r'\s*(\@[.\w]+|\@\.\.\.|' + known_section_names + r')\s*:([^:=
].*)?$',
> +           flags=3Dre.I, cache=3DFalse)
> +
> +doc_content =3D doc_com_body + KernRe(r'(.*)', cache=3DFalse)
> +doc_inline_start =3D KernRe(r'^\s*/\*\*\s*$', cache=3DFalse)
> +doc_inline_sect =3D KernRe(r'\s*\*\s*(@\s*[\w][\w\.]*\s*):(.*)', cache=
=3DFalse)
> +doc_inline_end =3D KernRe(r'^\s*\*/\s*$', cache=3DFalse)
> +doc_inline_oneline =3D KernRe(r'^\s*/\*\*\s*(@[\w\s]+):\s*(.*)\s*\*/\s*$=
', cache=3DFalse)
> +attribute =3D KernRe(r"__attribute__\s*\(\([a-z0-9,_\*\s\(\)]*\)\)",
> +               flags=3Dre.I | re.S, cache=3DFalse)
> +
> +export_symbol =3D KernRe(r'^\s*EXPORT_SYMBOL(_GPL)?\s*\(\s*(\w+)\s*\)\s*=
', cache=3DFalse)
> +export_symbol_ns =3D KernRe(r'^\s*EXPORT_SYMBOL_NS(_GPL)?\s*\(\s*(\w+)\s=
*,\s*"\S+"\)\s*', cache=3DFalse)
> +
> +type_param =3D KernRe(r"\@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)", cache=3DFal=
se)
> +
> +#
> +# Tests for the beginning of a kerneldoc block in its various forms.
> +#
> +doc_block =3D doc_com + KernRe(r'DOC:\s*(.*)?', cache=3DFalse)
> +doc_begin_data =3D KernRe(r"^\s*\*?\s*(struct|union|enum|typedef)\b\s*(\=
w*)", cache =3D False)
> +doc_begin_func =3D KernRe(str(doc_com) +			# initial " * '
> +                        r"(?:\w+\s*\*\s*)?" + 		# type (not captured)
> +                        r'(?:define\s+)?' + 		# possible "define" (not c=
aptured)
> +                        r'(\w+)\s*(?:\(\w*\))?\s*' +	# name and optional=
 "(...)"
> +                        r'(?:[-:].*)?$',		# description (not captured)
> +                        cache =3D False)
> +
> +#
> +# A little helper to get rid of excess white space
> +#
> +multi_space =3D KernRe(r'\s\s+')
> +def trim_whitespace(s):
> +    return multi_space.sub(' ', s.strip())
> +
> +class state:
> +    """
> +    State machine enums
> +    """
> +
> +    # Parser states
> +    NORMAL        =3D 0        # normal code
> +    NAME          =3D 1        # looking for function name
> +    DECLARATION   =3D 2        # We have seen a declaration which might =
not be done
> +    BODY          =3D 3        # the body of the comment
> +    SPECIAL_SECTION =3D 4      # doc section ending with a blank line
> +    PROTO         =3D 5        # scanning prototype
> +    DOCBLOCK      =3D 6        # documentation block
> +    INLINE_NAME   =3D 7        # gathering doc outside main block
> +    INLINE_TEXT   =3D 8	     # reading the body of inline docs
> +
> +    name =3D [
> +        "NORMAL",
> +        "NAME",
> +        "DECLARATION",
> +        "BODY",
> +        "SPECIAL_SECTION",
> +        "PROTO",
> +        "DOCBLOCK",
> +        "INLINE_NAME",
> +        "INLINE_TEXT",
> +    ]
> +
> +
> +SECTION_DEFAULT =3D "Description"  # default section
> +
> +class KernelEntry:
> +
> +    def __init__(self, config, ln):
> +        self.config =3D config
> +
> +        self._contents =3D []
> +        self.prototype =3D ""
> +
> +        self.warnings =3D []
> +
> +        self.parameterlist =3D []
> +        self.parameterdescs =3D {}
> +        self.parametertypes =3D {}
> +        self.parameterdesc_start_lines =3D {}
> +
> +        self.section_start_lines =3D {}
> +        self.sections =3D {}
> +
> +        self.anon_struct_union =3D False
> +
> +        self.leading_space =3D None
> +
> +        # State flags
> +        self.brcount =3D 0
> +        self.declaration_start_line =3D ln + 1
> +
> +    #
> +    # Management of section contents
> +    #
> +    def add_text(self, text):
> +        self._contents.append(text)
> +
> +    def contents(self):
> +        return '\n'.join(self._contents) + '\n'
> +
> +    # TODO: rename to emit_message after removal of kernel-doc.pl
> +    def emit_msg(self, log_msg, warning=3DTrue):
> +        """Emit a message"""
> +
> +        if not warning:
> +            self.config.log.info(log_msg)
> +            return
> +
> +        # Delegate warning output to output logic, as this way it
> +        # will report warnings/info only for symbols that are output
> +
> +        self.warnings.append(log_msg)
> +        return
> +
> +    #
> +    # Begin a new section.
> +    #
> +    def begin_section(self, line_no, title =3D SECTION_DEFAULT, dump =3D=
 False):
> +        if dump:
> +            self.dump_section(start_new =3D True)
> +        self.section =3D title
> +        self.new_start_line =3D line_no
> +
> +    def dump_section(self, start_new=3DTrue):
> +        """
> +        Dumps section contents to arrays/hashes intended for that purpos=
e.
> +        """
> +        #
> +        # If we have accumulated no contents in the default ("descriptio=
n")
> +        # section, don't bother.
> +        #
> +        if self.section =3D=3D SECTION_DEFAULT and not self._contents:
> +            return
> +        name =3D self.section
> +        contents =3D self.contents()
> +
> +        if type_param.match(name):
> +            name =3D type_param.group(1)
> +
> +            self.parameterdescs[name] =3D contents
> +            self.parameterdesc_start_lines[name] =3D self.new_start_line
> +
> +            self.new_start_line =3D 0
> +
> +        else:
> +            if name in self.sections and self.sections[name] !=3D "":
> +                # Only warn on user-specified duplicate section names
> +                if name !=3D SECTION_DEFAULT:
> +                    self.emit_msg(self.new_start_line,
> +                                  f"duplicate section name '{name}'\n")
> +                # Treat as a new paragraph - add a blank line
> +                self.sections[name] +=3D '\n' + contents
> +            else:
> +                self.sections[name] =3D contents
> +                self.section_start_lines[name] =3D self.new_start_line
> +                self.new_start_line =3D 0
> +
> +#        self.config.log.debug("Section: %s : %s", name, pformat(vars(se=
lf)))
> +
> +        if start_new:
> +            self.section =3D SECTION_DEFAULT
> +            self._contents =3D []
> +
> +
> +class KernelDoc:
> +    """
> +    Read a C language source or header FILE and extract embedded
> +    documentation comments.
> +    """
> +
> +    # Section names
> +
> +    section_context =3D "Context"
> +    section_return =3D "Return"
> +
> +    undescribed =3D "-- undescribed --"
> +
> +    def __init__(self, config, fname):
> +        """Initialize internal variables"""
> +
> +        self.fname =3D fname
> +        self.config =3D config
> +
> +        # Initial state for the state machines
> +        self.state =3D state.NORMAL
> +
> +        # Store entry currently being processed
> +        self.entry =3D None
> +
> +        # Place all potential outputs into an array
> +        self.entries =3D []
> +
> +        #
> +        # We need Python 3.7 for its "dicts remember the insertion
> +        # order" guarantee
> +        #
> +        if sys.version_info.major =3D=3D 3 and sys.version_info.minor < =
7:
> +            self.emit_msg(0,
> +                          'Python 3.7 or later is required for correct r=
esults')
> +
> +    def emit_msg(self, ln, msg, warning=3DTrue):
> +        """Emit a message"""
> +
> +        log_msg =3D f"{self.fname}:{ln} {msg}"
> +
> +        if self.entry:
> +            self.entry.emit_msg(log_msg, warning)
> +            return
> +
> +        if warning:
> +            self.config.log.warning(log_msg)
> +        else:
> +            self.config.log.info(log_msg)
> +
> +    def dump_section(self, start_new=3DTrue):
> +        """
> +        Dumps section contents to arrays/hashes intended for that purpos=
e.
> +        """
> +
> +        if self.entry:
> +            self.entry.dump_section(start_new)
> +
> +    # TODO: rename it to store_declaration after removal of kernel-doc.pl
> +    def output_declaration(self, dtype, name, **args):
> +        """
> +        Stores the entry into an entry array.
> +
> +        The actual output and output filters will be handled elsewhere
> +        """
> +
> +        item =3D KdocItem(name, dtype, self.entry.declaration_start_line=
, **args)
> +        item.warnings =3D self.entry.warnings
> +
> +        # Drop empty sections
> +        # TODO: improve empty sections logic to emit warnings
> +        sections =3D self.entry.sections
> +        for section in ["Description", "Return"]:
> +            if section in sections and not sections[section].rstrip():
> +                del sections[section]
> +        item.set_sections(sections, self.entry.section_start_lines)
> +        item.set_params(self.entry.parameterlist, self.entry.parameterde=
scs,
> +                        self.entry.parametertypes,
> +                        self.entry.parameterdesc_start_lines)
> +        self.entries.append(item)
> +
> +        self.config.log.debug("Output: %s:%s =3D %s", dtype, name, pform=
at(args))
> +
> +    def reset_state(self, ln):
> +        """
> +        Ancillary routine to create a new entry. It initializes all
> +        variables used by the state machine.
> +        """
> +
> +        self.entry =3D KernelEntry(self.config, ln)
> +
> +        # State flags
> +        self.state =3D state.NORMAL
> +
> +    def push_parameter(self, ln, decl_type, param, dtype,
> +                       org_arg, declaration_name):
> +        """
> +        Store parameters and their descriptions at self.entry.
> +        """
> +
> +        if self.entry.anon_struct_union and dtype =3D=3D "" and param =
=3D=3D "}":
> +            return  # Ignore the ending }; from anonymous struct/union
> +
> +        self.entry.anon_struct_union =3D False
> +
> +        param =3D KernRe(r'[\[\)].*').sub('', param, count=3D1)
> +
> +        if dtype =3D=3D "" and param.endswith("..."):
> +            if KernRe(r'\w\.\.\.$').search(param):
> +                # For named variable parameters of the form `x...`,
> +                # remove the dots
> +                param =3D param[:-3]
> +            else:
> +                # Handles unnamed variable parameters
> +                param =3D "..."
> +
> +            if param not in self.entry.parameterdescs or \
> +                not self.entry.parameterdescs[param]:
> +
> +                self.entry.parameterdescs[param] =3D "variable arguments"
> +
> +        elif dtype =3D=3D "" and (not param or param =3D=3D "void"):
> +            param =3D "void"
> +            self.entry.parameterdescs[param] =3D "no arguments"
> +
> +        elif dtype =3D=3D "" and param in ["struct", "union"]:
> +            # Handle unnamed (anonymous) union or struct
> +            dtype =3D param
> +            param =3D "{unnamed_" + param + "}"
> +            self.entry.parameterdescs[param] =3D "anonymous\n"
> +            self.entry.anon_struct_union =3D True
> +
> +        # Handle cache group enforcing variables: they do not need
> +        # to be described in header files
> +        elif "__cacheline_group" in param:
> +            # Ignore __cacheline_group_begin and __cacheline_group_end
> +            return
> +
> +        # Warn if parameter has no description
> +        # (but ignore ones starting with # as these are not parameters
> +        # but inline preprocessor statements)
> +        if param not in self.entry.parameterdescs and not param.startswi=
th("#"):
> +            self.entry.parameterdescs[param] =3D self.undescribed
> +
> +            if "." not in param:
> +                if decl_type =3D=3D 'function':
> +                    dname =3D f"{decl_type} parameter"
> +                else:
> +                    dname =3D f"{decl_type} member"
> +
> +                self.emit_msg(ln,
> +                              f"{dname} '{param}' not described in '{dec=
laration_name}'")
> +
> +        # Strip spaces from param so that it is one continuous string on
> +        # parameterlist. This fixes a problem where check_sections()
> +        # cannot find a parameter like "addr[6 + 2]" because it actually
> +        # appears as "addr[6", "+", "2]" on the parameter list.
> +        # However, it's better to maintain the param string unchanged for
> +        # output, so just weaken the string compare in check_sections()
> +        # to ignore "[blah" in a parameter string.
> +
> +        self.entry.parameterlist.append(param)
> +        org_arg =3D KernRe(r'\s\s+').sub(' ', org_arg)
> +        self.entry.parametertypes[param] =3D org_arg
> +
> +
> +    def create_parameter_list(self, ln, decl_type, args,
> +                              splitter, declaration_name):
> +        """
> +        Creates a list of parameters, storing them at self.entry.
> +        """
> +
> +        # temporarily replace all commas inside function pointer definit=
ion
> +        arg_expr =3D KernRe(r'(\([^\),]+),')
> +        while arg_expr.search(args):
> +            args =3D arg_expr.sub(r"\1#", args)
> +
> +        for arg in args.split(splitter):
> +            # Strip comments
> +            arg =3D KernRe(r'\/\*.*\*\/').sub('', arg)
> +
> +            # Ignore argument attributes
> +            arg =3D KernRe(r'\sPOS0?\s').sub(' ', arg)
> +
> +            # Strip leading/trailing spaces
> +            arg =3D arg.strip()
> +            arg =3D KernRe(r'\s+').sub(' ', arg, count=3D1)
> +
> +            if arg.startswith('#'):
> +                # Treat preprocessor directive as a typeless variable ju=
st to fill
> +                # corresponding data structures "correctly". Catch it la=
ter in
> +                # output_* subs.
> +
> +                # Treat preprocessor directive as a typeless variable
> +                self.push_parameter(ln, decl_type, arg, "",
> +                                    "", declaration_name)
> +
> +            elif KernRe(r'\(.+\)\s*\(').search(arg):
> +                # Pointer-to-function
> +
> +                arg =3D arg.replace('#', ',')
> +
> +                r =3D KernRe(r'[^\(]+\(\*?\s*([\w\[\]\.]*)\s*\)')
> +                if r.match(arg):
> +                    param =3D r.group(1)
> +                else:
> +                    self.emit_msg(ln, f"Invalid param: {arg}")
> +                    param =3D arg
> +
> +                dtype =3D KernRe(r'([^\(]+\(\*?)\s*' + re.escape(param))=
.sub(r'\1', arg)
> +                self.push_parameter(ln, decl_type, param, dtype,
> +                                    arg, declaration_name)
> +
> +            elif KernRe(r'\(.+\)\s*\[').search(arg):
> +                # Array-of-pointers
> +
> +                arg =3D arg.replace('#', ',')
> +                r =3D KernRe(r'[^\(]+\(\s*\*\s*([\w\[\]\.]*?)\s*(\s*\[\s=
*[\w]+\s*\]\s*)*\)')
> +                if r.match(arg):
> +                    param =3D r.group(1)
> +                else:
> +                    self.emit_msg(ln, f"Invalid param: {arg}")
> +                    param =3D arg
> +
> +                dtype =3D KernRe(r'([^\(]+\(\*?)\s*' + re.escape(param))=
.sub(r'\1', arg)
> +
> +                self.push_parameter(ln, decl_type, param, dtype,
> +                                    arg, declaration_name)
> +
> +            elif arg:
> +                arg =3D KernRe(r'\s*:\s*').sub(":", arg)
> +                arg =3D KernRe(r'\s*\[').sub('[', arg)
> +
> +                args =3D KernRe(r'\s*,\s*').split(arg)
> +                if args[0] and '*' in args[0]:
> +                    args[0] =3D re.sub(r'(\*+)\s*', r' \1', args[0])
> +
> +                first_arg =3D []
> +                r =3D KernRe(r'^(.*\s+)(.*?\[.*\].*)$')
> +                if args[0] and r.match(args[0]):
> +                    args.pop(0)
> +                    first_arg.extend(r.group(1))
> +                    first_arg.append(r.group(2))
> +                else:
> +                    first_arg =3D KernRe(r'\s+').split(args.pop(0))
> +
> +                args.insert(0, first_arg.pop())
> +                dtype =3D ' '.join(first_arg)
> +
> +                for param in args:
> +                    if KernRe(r'^(\*+)\s*(.*)').match(param):
> +                        r =3D KernRe(r'^(\*+)\s*(.*)')
> +                        if not r.match(param):
> +                            self.emit_msg(ln, f"Invalid param: {param}")
> +                            continue
> +
> +                        param =3D r.group(1)
> +
> +                        self.push_parameter(ln, decl_type, r.group(2),
> +                                            f"{dtype} {r.group(1)}",
> +                                            arg, declaration_name)
> +
> +                    elif KernRe(r'(.*?):(\w+)').search(param):
> +                        r =3D KernRe(r'(.*?):(\w+)')
> +                        if not r.match(param):
> +                            self.emit_msg(ln, f"Invalid param: {param}")
> +                            continue
> +
> +                        if dtype !=3D "":  # Skip unnamed bit-fields
> +                            self.push_parameter(ln, decl_type, r.group(1=
),
> +                                                f"{dtype}:{r.group(2)}",
> +                                                arg, declaration_name)
> +                    else:
> +                        self.push_parameter(ln, decl_type, param, dtype,
> +                                            arg, declaration_name)
> +
> +    def check_sections(self, ln, decl_name, decl_type):
> +        """
> +        Check for errors inside sections, emitting warnings if not found
> +        parameters are described.
> +        """
> +        for section in self.entry.sections:
> +            if section not in self.entry.parameterlist and \
> +               not known_sections.search(section):
> +                if decl_type =3D=3D 'function':
> +                    dname =3D f"{decl_type} parameter"
> +                else:
> +                    dname =3D f"{decl_type} member"
> +                self.emit_msg(ln,
> +                              f"Excess {dname} '{section}' description i=
n '{decl_name}'")
> +
> +    def check_return_section(self, ln, declaration_name, return_type):
> +        """
> +        If the function doesn't return void, warns about the lack of a
> +        return description.
> +        """
> +
> +        if not self.config.wreturn:
> +            return
> +
> +        # Ignore an empty return type (It's a macro)
> +        # Ignore functions with a "void" return type (but not "void *")
> +        if not return_type or KernRe(r'void\s*\w*\s*$').search(return_ty=
pe):
> +            return
> +
> +        if not self.entry.sections.get("Return", None):
> +            self.emit_msg(ln,
> +                          f"No description found for return value of '{d=
eclaration_name}'")
> +
> +    def dump_struct(self, ln, proto):
> +        """
> +        Store an entry for an struct or union
> +        """
> +
> +        type_pattern =3D r'(struct|union)'
> +
> +        qualifiers =3D [
> +            "__attribute__",
> +            "__packed",
> +            "__aligned",
> +            "____cacheline_aligned_in_smp",
> +            "____cacheline_aligned",
> +        ]
> +
> +        definition_body =3D r'\{(.*)\}\s*' + "(?:" + '|'.join(qualifiers=
) + ")?"
> +        struct_members =3D KernRe(type_pattern + r'([^\{\};]+)(\{)([^\{\=
}]*)(\})([^\{\}\;]*)(\;)')
> +
> +        # Extract struct/union definition
> +        members =3D None
> +        declaration_name =3D None
> +        decl_type =3D None
> +
> +        r =3D KernRe(type_pattern + r'\s+(\w+)\s*' + definition_body)
> +        if r.search(proto):
> +            decl_type =3D r.group(1)
> +            declaration_name =3D r.group(2)
> +            members =3D r.group(3)
> +        else:
> +            r =3D KernRe(r'typedef\s+' + type_pattern + r'\s*' + definit=
ion_body + r'\s*(\w+)\s*;')
> +
> +            if r.search(proto):
> +                decl_type =3D r.group(1)
> +                declaration_name =3D r.group(3)
> +                members =3D r.group(2)
> +
> +        if not members:
> +            self.emit_msg(ln, f"{proto} error: Cannot parse struct or un=
ion!")
> +            return
> +
> +        if self.entry.identifier !=3D declaration_name:
> +            self.emit_msg(ln,
> +                          f"expecting prototype for {decl_type} {self.en=
try.identifier}. Prototype was for {decl_type} {declaration_name} instead\n=
")
> +            return
> +
> +        args_pattern =3D r'([^,)]+)'
> +
> +        sub_prefixes =3D [
> +            (KernRe(r'\/\*\s*private:.*?\/\*\s*public:.*?\*\/', re.S | r=
e.I), ''),
> +            (KernRe(r'\/\*\s*private:.*', re.S | re.I), ''),
> +
> +            # Strip comments
> +            (KernRe(r'\/\*.*?\*\/', re.S), ''),
> +
> +            # Strip attributes
> +            (attribute, ' '),
> +            (KernRe(r'\s*__aligned\s*\([^;]*\)', re.S), ' '),
> +            (KernRe(r'\s*__counted_by\s*\([^;]*\)', re.S), ' '),
> +            (KernRe(r'\s*__counted_by_(le|be)\s*\([^;]*\)', re.S), ' '),
> +            (KernRe(r'\s*__packed\s*', re.S), ' '),
> +            (KernRe(r'\s*CRYPTO_MINALIGN_ATTR', re.S), ' '),
> +            (KernRe(r'\s*____cacheline_aligned_in_smp', re.S), ' '),
> +            (KernRe(r'\s*____cacheline_aligned', re.S), ' '),
> +
> +            # Unwrap struct_group macros based on this definition:
> +            # __struct_group(TAG, NAME, ATTRS, MEMBERS...)
> +            # which has variants like: struct_group(NAME, MEMBERS...)
> +            # Only MEMBERS arguments require documentation.
> +            #
> +            # Parsing them happens on two steps:
> +            #
> +            # 1. drop struct group arguments that aren't at MEMBERS,
> +            #    storing them as STRUCT_GROUP(MEMBERS)
> +            #
> +            # 2. remove STRUCT_GROUP() ancillary macro.
> +            #
> +            # The original logic used to remove STRUCT_GROUP() using an
> +            # advanced regex:
> +            #
> +            #   \bSTRUCT_GROUP(\(((?:(?>[^)(]+)|(?1))*)\))[^;]*;
> +            #
> +            # with two patterns that are incompatible with
> +            # Python re module, as it has:
> +            #
> +            #   - a recursive pattern: (?1)
> +            #   - an atomic grouping: (?>...)
> +            #
> +            # I tried a simpler version: but it didn't work either:
> +            #   \bSTRUCT_GROUP\(([^\)]+)\)[^;]*;
> +            #
> +            # As it doesn't properly match the end parenthesis on some c=
ases.
> +            #
> +            # So, a better solution was crafted: there's now a NestedMat=
ch
> +            # class that ensures that delimiters after a search are prop=
erly
> +            # matched. So, the implementation to drop STRUCT_GROUP() wil=
l be
> +            # handled in separate.
> +
> +            (KernRe(r'\bstruct_group\s*\(([^,]*,)', re.S), r'STRUCT_GROU=
P('),
> +            (KernRe(r'\bstruct_group_attr\s*\(([^,]*,){2}', re.S), r'STR=
UCT_GROUP('),
> +            (KernRe(r'\bstruct_group_tagged\s*\(([^,]*),([^,]*),', re.S)=
, r'struct \1 \2; STRUCT_GROUP('),
> +            (KernRe(r'\b__struct_group\s*\(([^,]*,){3}', re.S), r'STRUCT=
_GROUP('),
> +
> +            # Replace macros
> +            #
> +            # TODO: use NestedMatch for FOO($1, $2, ...) matches
> +            #
> +            # it is better to also move those to the NestedMatch logic,
> +            # to ensure that parenthesis will be properly matched.
> +
> +            (KernRe(r'__ETHTOOL_DECLARE_LINK_MODE_MASK\s*\(([^\)]+)\)', =
re.S), r'DECLARE_BITMAP(\1, __ETHTOOL_LINK_MODE_MASK_NBITS)'),
> +            (KernRe(r'DECLARE_PHY_INTERFACE_MASK\s*\(([^\)]+)\)', re.S),=
 r'DECLARE_BITMAP(\1, PHY_INTERFACE_MODE_MAX)'),
> +            (KernRe(r'DECLARE_BITMAP\s*\(' + args_pattern + r',\s*' + ar=
gs_pattern + r'\)', re.S), r'unsigned long \1[BITS_TO_LONGS(\2)]'),
> +            (KernRe(r'DECLARE_HASHTABLE\s*\(' + args_pattern + r',\s*' +=
 args_pattern + r'\)', re.S), r'unsigned long \1[1 << ((\2) - 1)]'),
> +            (KernRe(r'DECLARE_KFIFO\s*\(' + args_pattern + r',\s*' + arg=
s_pattern + r',\s*' + args_pattern + r'\)', re.S), r'\2 *\1'),
> +            (KernRe(r'DECLARE_KFIFO_PTR\s*\(' + args_pattern + r',\s*' +=
 args_pattern + r'\)', re.S), r'\2 *\1'),
> +            (KernRe(r'(?:__)?DECLARE_FLEX_ARRAY\s*\(' + args_pattern + r=
',\s*' + args_pattern + r'\)', re.S), r'\1 \2[]'),
> +            (KernRe(r'DEFINE_DMA_UNMAP_ADDR\s*\(' + args_pattern + r'\)'=
, re.S), r'dma_addr_t \1'),
> +            (KernRe(r'DEFINE_DMA_UNMAP_LEN\s*\(' + args_pattern + r'\)',=
 re.S), r'__u32 \1'),
> +            (KernRe(r'VIRTIO_DECLARE_FEATURES\s*\(' + args_pattern + r'\=
)', re.S), r'u64 \1; u64 \1_array[VIRTIO_FEATURES_DWORDS]'),
> +        ]
> +
> +        # Regexes here are guaranteed to have the end limiter matching
> +        # the start delimiter. Yet, right now, only one replace group
> +        # is allowed.
> +
> +        sub_nested_prefixes =3D [
> +            (re.compile(r'\bSTRUCT_GROUP\('), r'\1'),
> +        ]
> +
> +        for search, sub in sub_prefixes:
> +            members =3D search.sub(sub, members)
> +
> +        nested =3D NestedMatch()
> +
> +        for search, sub in sub_nested_prefixes:
> +            members =3D nested.sub(search, sub, members)
> +
> +        # Keeps the original declaration as-is
> +        declaration =3D members
> +
> +        # Split nested struct/union elements
> +        #
> +        # This loop was simpler at the original kernel-doc perl version,=
 as
> +        #   while ($members =3D~ m/$struct_members/) { ... }
> +        # reads 'members' string on each interaction.
> +        #
> +        # Python behavior is different: it parses 'members' only once,
> +        # creating a list of tuples from the first interaction.
> +        #
> +        # On other words, this won't get nested structs.
> +        #
> +        # So, we need to have an extra loop on Python to override such
> +        # re limitation.
> +
> +        while True:
> +            tuples =3D struct_members.findall(members)
> +            if not tuples:
> +                break
> +
> +            for t in tuples:
> +                newmember =3D ""
> +                maintype =3D t[0]
> +                s_ids =3D t[5]
> +                content =3D t[3]
> +
> +                oldmember =3D "".join(t)
> +
> +                for s_id in s_ids.split(','):
> +                    s_id =3D s_id.strip()
> +
> +                    newmember +=3D f"{maintype} {s_id}; "
> +                    s_id =3D KernRe(r'[:\[].*').sub('', s_id)
> +                    s_id =3D KernRe(r'^\s*\**(\S+)\s*').sub(r'\1', s_id)
> +
> +                    for arg in content.split(';'):
> +                        arg =3D arg.strip()
> +
> +                        if not arg:
> +                            continue
> +
> +                        r =3D KernRe(r'^([^\(]+\(\*?\s*)([\w\.]*)(\s*\).=
*)')
> +                        if r.match(arg):
> +                            # Pointer-to-function
> +                            dtype =3D r.group(1)
> +                            name =3D r.group(2)
> +                            extra =3D r.group(3)
> +
> +                            if not name:
> +                                continue
> +
> +                            if not s_id:
> +                                # Anonymous struct/union
> +                                newmember +=3D f"{dtype}{name}{extra}; "
> +                            else:
> +                                newmember +=3D f"{dtype}{s_id}.{name}{ex=
tra}; "
> +
> +                        else:
> +                            arg =3D arg.strip()
> +                            # Handle bitmaps
> +                            arg =3D KernRe(r':\s*\d+\s*').sub('', arg)
> +
> +                            # Handle arrays
> +                            arg =3D KernRe(r'\[.*\]').sub('', arg)
> +
> +                            # Handle multiple IDs
> +                            arg =3D KernRe(r'\s*,\s*').sub(',', arg)
> +
> +                            r =3D KernRe(r'(.*)\s+([\S+,]+)')
> +
> +                            if r.search(arg):
> +                                dtype =3D r.group(1)
> +                                names =3D r.group(2)
> +                            else:
> +                                newmember +=3D f"{arg}; "
> +                                continue
> +
> +                            for name in names.split(','):
> +                                name =3D KernRe(r'^\s*\**(\S+)\s*').sub(=
r'\1', name).strip()
> +
> +                                if not name:
> +                                    continue
> +
> +                                if not s_id:
> +                                    # Anonymous struct/union
> +                                    newmember +=3D f"{dtype} {name}; "
> +                                else:
> +                                    newmember +=3D f"{dtype} {s_id}.{nam=
e}; "
> +
> +                members =3D members.replace(oldmember, newmember)
> +
> +        # Ignore other nested elements, like enums
> +        members =3D re.sub(r'(\{[^\{\}]*\})', '', members)
> +
> +        self.create_parameter_list(ln, decl_type, members, ';',
> +                                   declaration_name)
> +        self.check_sections(ln, declaration_name, decl_type)
> +
> +        # Adjust declaration for better display
> +        declaration =3D KernRe(r'([\{;])').sub(r'\1\n', declaration)
> +        declaration =3D KernRe(r'\}\s+;').sub('};', declaration)
> +
> +        # Better handle inlined enums
> +        while True:
> +            r =3D KernRe(r'(enum\s+\{[^\}]+),([^\n])')
> +            if not r.search(declaration):
> +                break
> +
> +            declaration =3D r.sub(r'\1,\n\2', declaration)
> +
> +        def_args =3D declaration.split('\n')
> +        level =3D 1
> +        declaration =3D ""
> +        for clause in def_args:
> +
> +            clause =3D clause.strip()
> +            clause =3D KernRe(r'\s+').sub(' ', clause, count=3D1)
> +
> +            if not clause:
> +                continue
> +
> +            if '}' in clause and level > 1:
> +                level -=3D 1
> +
> +            if not KernRe(r'^\s*#').match(clause):
> +                declaration +=3D "\t" * level
> +
> +            declaration +=3D "\t" + clause + "\n"
> +            if "{" in clause and "}" not in clause:
> +                level +=3D 1
> +
> +        self.output_declaration(decl_type, declaration_name,
> +                                definition=3Ddeclaration,
> +                                purpose=3Dself.entry.declaration_purpose)
> +
> +    def dump_enum(self, ln, proto):
> +        """
> +        Stores an enum inside self.entries array.
> +        """
> +
> +        # Ignore members marked private
> +        proto =3D KernRe(r'\/\*\s*private:.*?\/\*\s*public:.*?\*\/', fla=
gs=3Dre.S).sub('', proto)
> +        proto =3D KernRe(r'\/\*\s*private:.*}', flags=3Dre.S).sub('}', p=
roto)
> +
> +        # Strip comments
> +        proto =3D KernRe(r'\/\*.*?\*\/', flags=3Dre.S).sub('', proto)
> +
> +        # Strip #define macros inside enums
> +        proto =3D KernRe(r'#\s*((define|ifdef|if)\s+|endif)[^;]*;', flag=
s=3Dre.S).sub('', proto)
> +
> +        #
> +        # Parse out the name and members of the enum.  Typedef form firs=
t.
> +        #
> +        r =3D KernRe(r'typedef\s+enum\s*\{(.*)\}\s*(\w*)\s*;')
> +        if r.search(proto):
> +            declaration_name =3D r.group(2)
> +            members =3D r.group(1).rstrip()
> +        #
> +        # Failing that, look for a straight enum
> +        #
> +        else:
> +            r =3D KernRe(r'enum\s+(\w*)\s*\{(.*)\}')
> +            if r.match(proto):
> +                declaration_name =3D r.group(1)
> +                members =3D r.group(2).rstrip()
> +        #
> +        # OK, this isn't going to work.
> +        #
> +            else:
> +                self.emit_msg(ln, f"{proto}: error: Cannot parse enum!")
> +                return
> +        #
> +        # Make sure we found what we were expecting.
> +        #
> +        if self.entry.identifier !=3D declaration_name:
> +            if self.entry.identifier =3D=3D "":
> +                self.emit_msg(ln,
> +                              f"{proto}: wrong kernel-doc identifier on =
prototype")
> +            else:
> +                self.emit_msg(ln,
> +                              f"expecting prototype for enum {self.entry=
.identifier}. "
> +                              f"Prototype was for enum {declaration_name=
} instead")
> +            return
> +
> +        if not declaration_name:
> +            declaration_name =3D "(anonymous)"
> +        #
> +        # Parse out the name of each enum member, and verify that we
> +        # have a description for it.
> +        #
> +        member_set =3D set()
> +        members =3D KernRe(r'\([^;)]*\)').sub('', members)
> +        for arg in members.split(','):
> +            if not arg:
> +                continue
> +            arg =3D KernRe(r'^\s*(\w+).*').sub(r'\1', arg)
> +            self.entry.parameterlist.append(arg)
> +            if arg not in self.entry.parameterdescs:
> +                self.entry.parameterdescs[arg] =3D self.undescribed
> +                self.emit_msg(ln,
> +                              f"Enum value '{arg}' not described in enum=
 '{declaration_name}'")
> +            member_set.add(arg)
> +        #
> +        # Ensure that every described member actually exists in the enum.
> +        #
> +        for k in self.entry.parameterdescs:
> +            if k not in member_set:
> +                self.emit_msg(ln,
> +                              f"Excess enum value '%{k}' description in =
'{declaration_name}'")
> +
> +        self.output_declaration('enum', declaration_name,
> +                                purpose=3Dself.entry.declaration_purpose)
> +
> +    def dump_declaration(self, ln, prototype):
> +        """
> +        Stores a data declaration inside self.entries array.
> +        """
> +
> +        if self.entry.decl_type =3D=3D "enum":
> +            self.dump_enum(ln, prototype)
> +        elif self.entry.decl_type =3D=3D "typedef":
> +            self.dump_typedef(ln, prototype)
> +        elif self.entry.decl_type in ["union", "struct"]:
> +            self.dump_struct(ln, prototype)
> +        else:
> +            # This would be a bug
> +            self.emit_message(ln, f'Unknown declaration type: {self.entr=
y.decl_type}')
> +
> +    def dump_function(self, ln, prototype):
> +        """
> +        Stores a function of function macro inside self.entries array.
> +        """
> +
> +        func_macro =3D False
> +        return_type =3D ''
> +        decl_type =3D 'function'
> +
> +        # Prefixes that would be removed
> +        sub_prefixes =3D [
> +            (r"^static +", "", 0),
> +            (r"^extern +", "", 0),
> +            (r"^asmlinkage +", "", 0),
> +            (r"^inline +", "", 0),
> +            (r"^__inline__ +", "", 0),
> +            (r"^__inline +", "", 0),
> +            (r"^__always_inline +", "", 0),
> +            (r"^noinline +", "", 0),
> +            (r"^__FORTIFY_INLINE +", "", 0),
> +            (r"__init +", "", 0),
> +            (r"__init_or_module +", "", 0),
> +            (r"__deprecated +", "", 0),
> +            (r"__flatten +", "", 0),
> +            (r"__meminit +", "", 0),
> +            (r"__must_check +", "", 0),
> +            (r"__weak +", "", 0),
> +            (r"__sched +", "", 0),
> +            (r"_noprof", "", 0),
> +            (r"__printf\s*\(\s*\d*\s*,\s*\d*\s*\) +", "", 0),
> +            (r"__(?:re)?alloc_size\s*\(\s*\d+\s*(?:,\s*\d+\s*)?\) +", ""=
, 0),
> +            (r"__diagnose_as\s*\(\s*\S+\s*(?:,\s*\d+\s*)*\) +", "", 0),
> +            (r"DECL_BUCKET_PARAMS\s*\(\s*(\S+)\s*,\s*(\S+)\s*\)", r"\1, =
\2", 0),
> +            (r"__attribute_const__ +", "", 0),
> +
> +            # It seems that Python support for re.X is broken:
> +            # At least for me (Python 3.13), this didn't work
> +#            (r"""
> +#              __attribute__\s*\(\(
> +#                (?:
> +#                    [\w\s]+          # attribute name
> +#                    (?:\([^)]*\))?   # attribute arguments
> +#                    \s*,?            # optional comma at the end
> +#                )+
> +#              \)\)\s+
> +#             """, "", re.X),
> +
> +            # So, remove whitespaces and comments from it
> +            (r"__attribute__\s*\(\((?:[\w\s]+(?:\([^)]*\))?\s*,?)+\)\)\s=
+", "", 0),
> +        ]
> +
> +        for search, sub, flags in sub_prefixes:
> +            prototype =3D KernRe(search, flags).sub(sub, prototype)
> +
> +        # Macros are a special case, as they change the prototype format
> +        new_proto =3D KernRe(r"^#\s*define\s+").sub("", prototype)
> +        if new_proto !=3D prototype:
> +            is_define_proto =3D True
> +            prototype =3D new_proto
> +        else:
> +            is_define_proto =3D False
> +
> +        # Yes, this truly is vile.  We are looking for:
> +        # 1. Return type (may be nothing if we're looking at a macro)
> +        # 2. Function name
> +        # 3. Function parameters.
> +        #
> +        # All the while we have to watch out for function pointer parame=
ters
> +        # (which IIRC is what the two sections are for), C types (these
> +        # regexps don't even start to express all the possibilities), and
> +        # so on.
> +        #
> +        # If you mess with these regexps, it's a good idea to check that
> +        # the following functions' documentation still comes out right:
> +        # - parport_register_device (function pointer parameters)
> +        # - atomic_set (macro)
> +        # - pci_match_device, __copy_to_user (long return type)
> +
> +        name =3D r'[a-zA-Z0-9_~:]+'
> +        prototype_end1 =3D r'[^\(]*'
> +        prototype_end2 =3D r'[^\{]*'
> +        prototype_end =3D fr'\(({prototype_end1}|{prototype_end2})\)'
> +
> +        # Besides compiling, Perl qr{[\w\s]+} works as a non-capturing g=
roup.
> +        # So, this needs to be mapped in Python with (?:...)? or (?:...)+
> +
> +        type1 =3D r'(?:[\w\s]+)?'
> +        type2 =3D r'(?:[\w\s]+\*+)+'
> +
> +        found =3D False
> +
> +        if is_define_proto:
> +            r =3D KernRe(r'^()(' + name + r')\s+')
> +
> +            if r.search(prototype):
> +                return_type =3D ''
> +                declaration_name =3D r.group(2)
> +                func_macro =3D True
> +
> +                found =3D True
> +
> +        if not found:
> +            patterns =3D [
> +                rf'^()({name})\s*{prototype_end}',
> +                rf'^({type1})\s+({name})\s*{prototype_end}',
> +                rf'^({type2})\s*({name})\s*{prototype_end}',
> +            ]
> +
> +            for p in patterns:
> +                r =3D KernRe(p)
> +
> +                if r.match(prototype):
> +
> +                    return_type =3D r.group(1)
> +                    declaration_name =3D r.group(2)
> +                    args =3D r.group(3)
> +
> +                    self.create_parameter_list(ln, decl_type, args, ',',
> +                                               declaration_name)
> +
> +                    found =3D True
> +                    break
> +        if not found:
> +            self.emit_msg(ln,
> +                          f"cannot understand function prototype: '{prot=
otype}'")
> +            return
> +
> +        if self.entry.identifier !=3D declaration_name:
> +            self.emit_msg(ln,
> +                          f"expecting prototype for {self.entry.identifi=
er}(). Prototype was for {declaration_name}() instead")
> +            return
> +
> +        self.check_sections(ln, declaration_name, "function")
> +
> +        self.check_return_section(ln, declaration_name, return_type)
> +
> +        if 'typedef' in return_type:
> +            self.output_declaration(decl_type, declaration_name,
> +                                    typedef=3DTrue,
> +                                    functiontype=3Dreturn_type,
> +                                    purpose=3Dself.entry.declaration_pur=
pose,
> +                                    func_macro=3Dfunc_macro)
> +        else:
> +            self.output_declaration(decl_type, declaration_name,
> +                                    typedef=3DFalse,
> +                                    functiontype=3Dreturn_type,
> +                                    purpose=3Dself.entry.declaration_pur=
pose,
> +                                    func_macro=3Dfunc_macro)
> +
> +    def dump_typedef(self, ln, proto):
> +        """
> +        Stores a typedef inside self.entries array.
> +        """
> +
> +        typedef_type =3D r'((?:\s+[\w\*]+\b){0,7}\s+(?:\w+\b|\*+))\s*'
> +        typedef_ident =3D r'\*?\s*(\w\S+)\s*'
> +        typedef_args =3D r'\s*\((.*)\);'
> +
> +        typedef1 =3D KernRe(r'typedef' + typedef_type + r'\(' + typedef_=
ident + r'\)' + typedef_args)
> +        typedef2 =3D KernRe(r'typedef' + typedef_type + typedef_ident + =
typedef_args)
> +
> +        # Strip comments
> +        proto =3D KernRe(r'/\*.*?\*/', flags=3Dre.S).sub('', proto)
> +
> +        # Parse function typedef prototypes
> +        for r in [typedef1, typedef2]:
> +            if not r.match(proto):
> +                continue
> +
> +            return_type =3D r.group(1).strip()
> +            declaration_name =3D r.group(2)
> +            args =3D r.group(3)
> +
> +            if self.entry.identifier !=3D declaration_name:
> +                self.emit_msg(ln,
> +                              f"expecting prototype for typedef {self.en=
try.identifier}. Prototype was for typedef {declaration_name} instead\n")
> +                return
> +
> +            decl_type =3D 'function'
> +            self.create_parameter_list(ln, decl_type, args, ',', declara=
tion_name)
> +
> +            self.output_declaration(decl_type, declaration_name,
> +                                    typedef=3DTrue,
> +                                    functiontype=3Dreturn_type,
> +                                    purpose=3Dself.entry.declaration_pur=
pose)
> +            return
> +
> +        # Handle nested parentheses or brackets
> +        r =3D KernRe(r'(\(*.\)\s*|\[*.\]\s*);$')
> +        while r.search(proto):
> +            proto =3D r.sub('', proto)
> +
> +        # Parse simple typedefs
> +        r =3D KernRe(r'typedef.*\s+(\w+)\s*;')
> +        if r.match(proto):
> +            declaration_name =3D r.group(1)
> +
> +            if self.entry.identifier !=3D declaration_name:
> +                self.emit_msg(ln,
> +                              f"expecting prototype for typedef {self.en=
try.identifier}. Prototype was for typedef {declaration_name} instead\n")
> +                return
> +
> +            self.output_declaration('typedef', declaration_name,
> +                                    purpose=3Dself.entry.declaration_pur=
pose)
> +            return
> +
> +        self.emit_msg(ln, "error: Cannot parse typedef!")
> +
> +    @staticmethod
> +    def process_export(function_set, line):
> +        """
> +        process EXPORT_SYMBOL* tags
> +
> +        This method doesn't use any variable from the class, so declare =
it
> +        with a staticmethod decorator.
> +        """
> +
> +        # We support documenting some exported symbols with different
> +        # names.  A horrible hack.
> +        suffixes =3D [ '_noprof' ]
> +
> +        # Note: it accepts only one EXPORT_SYMBOL* per line, as having
> +        # multiple export lines would violate Kernel coding style.
> +
> +        if export_symbol.search(line):
> +            symbol =3D export_symbol.group(2)
> +        elif export_symbol_ns.search(line):
> +            symbol =3D export_symbol_ns.group(2)
> +        else:
> +            return False
> +        #
> +        # Found an export, trim out any special suffixes
> +        #
> +        for suffix in suffixes:
> +            # Be backward compatible with Python < 3.9
> +            if symbol.endswith(suffix):
> +                symbol =3D symbol[:-len(suffix)]
> +        function_set.add(symbol)
> +        return True
> +
> +    def process_normal(self, ln, line):
> +        """
> +        STATE_NORMAL: looking for the /** to begin everything.
> +        """
> +
> +        if not doc_start.match(line):
> +            return
> +
> +        # start a new entry
> +        self.reset_state(ln)
> +
> +        # next line is always the function name
> +        self.state =3D state.NAME
> +
> +    def process_name(self, ln, line):
> +        """
> +        STATE_NAME: Looking for the "name - description" line
> +        """
> +        #
> +        # Check for a DOC: block and handle them specially.
> +        #
> +        if doc_block.search(line):
> +
> +            if not doc_block.group(1):
> +                self.entry.begin_section(ln, "Introduction")
> +            else:
> +                self.entry.begin_section(ln, doc_block.group(1))
> +
> +            self.entry.identifier =3D self.entry.section
> +            self.state =3D state.DOCBLOCK
> +        #
> +        # Otherwise we're looking for a normal kerneldoc declaration lin=
e.
> +        #
> +        elif doc_decl.search(line):
> +            self.entry.identifier =3D doc_decl.group(1)
> +
> +            # Test for data declaration
> +            if doc_begin_data.search(line):
> +                self.entry.decl_type =3D doc_begin_data.group(1)
> +                self.entry.identifier =3D doc_begin_data.group(2)
> +            #
> +            # Look for a function description
> +            #
> +            elif doc_begin_func.search(line):
> +                self.entry.identifier =3D doc_begin_func.group(1)
> +                self.entry.decl_type =3D "function"
> +            #
> +            # We struck out.
> +            #
> +            else:
> +                self.emit_msg(ln,
> +                              f"This comment starts with '/**', but isn'=
t a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst\n{line=
}")
> +                self.state =3D state.NORMAL
> +                return
> +            #
> +            # OK, set up for a new kerneldoc entry.
> +            #
> +            self.state =3D state.BODY
> +            self.entry.identifier =3D self.entry.identifier.strip(" ")
> +            # if there's no @param blocks need to set up default section=
 here
> +            self.entry.begin_section(ln + 1)
> +            #
> +            # Find the description portion, which *should* be there but
> +            # isn't always.
> +            # (We should be able to capture this from the previous parsi=
ng - someday)
> +            #
> +            r =3D KernRe("[-:](.*)")
> +            if r.search(line):
> +                self.entry.declaration_purpose =3D trim_whitespace(r.gro=
up(1))
> +                self.state =3D state.DECLARATION
> +            else:
> +                self.entry.declaration_purpose =3D ""
> +
> +            if not self.entry.declaration_purpose and self.config.wshort=
_desc:
> +                self.emit_msg(ln,
> +                              f"missing initial short description on lin=
e:\n{line}")
> +
> +            if not self.entry.identifier and self.entry.decl_type !=3D "=
enum":
> +                self.emit_msg(ln,
> +                              f"wrong kernel-doc identifier on line:\n{l=
ine}")
> +                self.state =3D state.NORMAL
> +
> +            if self.config.verbose:
> +                self.emit_msg(ln,
> +                              f"Scanning doc for {self.entry.decl_type} =
{self.entry.identifier}",
> +                                  warning=3DFalse)
> +        #
> +        # Failed to find an identifier. Emit a warning
> +        #
> +        else:
> +            self.emit_msg(ln, f"Cannot find identifier on line:\n{line}")
> +
> +    #
> +    # Helper function to determine if a new section is being started.
> +    #
> +    def is_new_section(self, ln, line):
> +        if doc_sect.search(line):
> +            self.state =3D state.BODY
> +            #
> +            # Pick out the name of our new section, tweaking it if need =
be.
> +            #
> +            newsection =3D doc_sect.group(1)
> +            if newsection.lower() =3D=3D 'description':
> +                newsection =3D 'Description'
> +            elif newsection.lower() =3D=3D 'context':
> +                newsection =3D 'Context'
> +                self.state =3D state.SPECIAL_SECTION
> +            elif newsection.lower() in ["@return", "@returns",
> +                                        "return", "returns"]:
> +                newsection =3D "Return"
> +                self.state =3D state.SPECIAL_SECTION
> +            elif newsection[0] =3D=3D '@':
> +                self.state =3D state.SPECIAL_SECTION
> +            #
> +            # Initialize the contents, and get the new section going.
> +            #
> +            newcontents =3D doc_sect.group(2)
> +            if not newcontents:
> +                newcontents =3D ""
> +            self.dump_section()
> +            self.entry.begin_section(ln, newsection)
> +            self.entry.leading_space =3D None
> +
> +            self.entry.add_text(newcontents.lstrip())
> +            return True
> +        return False
> +
> +    #
> +    # Helper function to detect (and effect) the end of a kerneldoc comm=
ent.
> +    #
> +    def is_comment_end(self, ln, line):
> +        if doc_end.search(line):
> +            self.dump_section()
> +
> +            # Look for doc_com + <text> + doc_end:
> +            r =3D KernRe(r'\s*\*\s*[a-zA-Z_0-9:\.]+\*/')
> +            if r.match(line):
> +                self.emit_msg(ln, f"suspicious ending line: {line}")
> +
> +            self.entry.prototype =3D ""
> +            self.entry.new_start_line =3D ln + 1
> +
> +            self.state =3D state.PROTO
> +            return True
> +        return False
> +
> +
> +    def process_decl(self, ln, line):
> +        """
> +        STATE_DECLARATION: We've seen the beginning of a declaration
> +        """
> +        if self.is_new_section(ln, line) or self.is_comment_end(ln, line=
):
> +            return
> +        #
> +        # Look for anything with the " * " line beginning.
> +        #
> +        if doc_content.search(line):
> +            cont =3D doc_content.group(1)
> +            #
> +            # A blank line means that we have moved out of the declarati=
on
> +            # part of the comment (without any "special section" paramet=
er
> +            # descriptions).
> +            #
> +            if cont =3D=3D "":
> +                self.state =3D state.BODY
> +            #
> +            # Otherwise we have more of the declaration section to soak =
up.
> +            #
> +            else:
> +                self.entry.declaration_purpose =3D \
> +                    trim_whitespace(self.entry.declaration_purpose + ' '=
 + cont)
> +        else:
> +            # Unknown line, ignore
> +            self.emit_msg(ln, f"bad line: {line}")
> +
> +
> +    def process_special(self, ln, line):
> +        """
> +        STATE_SPECIAL_SECTION: a section ending with a blank line
> +        """
> +        #
> +        # If we have hit a blank line (only the " * " marker), then this
> +        # section is done.
> +        #
> +        if KernRe(r"\s*\*\s*$").match(line):
> +            self.entry.begin_section(ln, dump =3D True)
> +            self.state =3D state.BODY
> +            return
> +        #
> +        # Not a blank line, look for the other ways to end the section.
> +        #
> +        if self.is_new_section(ln, line) or self.is_comment_end(ln, line=
):
> +            return
> +        #
> +        # OK, we should have a continuation of the text for this section.
> +        #
> +        if doc_content.search(line):
> +            cont =3D doc_content.group(1)
> +            #
> +            # If the lines of text after the first in a special section =
have
> +            # leading white space, we need to trim it out or Sphinx will=
 get
> +            # confused.  For the second line (the None case), see what we
> +            # find there and remember it.
> +            #
> +            if self.entry.leading_space is None:
> +                r =3D KernRe(r'^(\s+)')
> +                if r.match(cont):
> +                    self.entry.leading_space =3D len(r.group(1))
> +                else:
> +                    self.entry.leading_space =3D 0
> +            #
> +            # Otherwise, before trimming any leading chars, be *sure*
> +            # that they are white space.  We should maybe warn if this
> +            # isn't the case.
> +            #
> +            for i in range(0, self.entry.leading_space):
> +                if cont[i] !=3D " ":
> +                    self.entry.leading_space =3D i
> +                    break
> +            #
> +            # Add the trimmed result to the section and we're done.
> +            #
> +            self.entry.add_text(cont[self.entry.leading_space:])
> +        else:
> +            # Unknown line, ignore
> +            self.emit_msg(ln, f"bad line: {line}")
> +
> +    def process_body(self, ln, line):
> +        """
> +        STATE_BODY: the bulk of a kerneldoc comment.
> +        """
> +        if self.is_new_section(ln, line) or self.is_comment_end(ln, line=
):
> +            return
> +
> +        if doc_content.search(line):
> +            cont =3D doc_content.group(1)
> +            self.entry.add_text(cont)
> +        else:
> +            # Unknown line, ignore
> +            self.emit_msg(ln, f"bad line: {line}")
> +
> +    def process_inline_name(self, ln, line):
> +        """STATE_INLINE_NAME: beginning of docbook comments within a pro=
totype."""
> +
> +        if doc_inline_sect.search(line):
> +            self.entry.begin_section(ln, doc_inline_sect.group(1))
> +            self.entry.add_text(doc_inline_sect.group(2).lstrip())
> +            self.state =3D state.INLINE_TEXT
> +        elif doc_inline_end.search(line):
> +            self.dump_section()
> +            self.state =3D state.PROTO
> +        elif doc_content.search(line):
> +            self.emit_msg(ln, f"Incorrect use of kernel-doc format: {lin=
e}")
> +            self.state =3D state.PROTO
> +        # else ... ??
> +
> +    def process_inline_text(self, ln, line):
> +        """STATE_INLINE_TEXT: docbook comments within a prototype."""
> +
> +        if doc_inline_end.search(line):
> +            self.dump_section()
> +            self.state =3D state.PROTO
> +        elif doc_content.search(line):
> +            self.entry.add_text(doc_content.group(1))
> +        # else ... ??
> +
> +    def syscall_munge(self, ln, proto):         # pylint: disable=3DW0613
> +        """
> +        Handle syscall definitions
> +        """
> +
> +        is_void =3D False
> +
> +        # Strip newlines/CR's
> +        proto =3D re.sub(r'[\r\n]+', ' ', proto)
> +
> +        # Check if it's a SYSCALL_DEFINE0
> +        if 'SYSCALL_DEFINE0' in proto:
> +            is_void =3D True
> +
> +        # Replace SYSCALL_DEFINE with correct return type & function name
> +        proto =3D KernRe(r'SYSCALL_DEFINE.*\(').sub('long sys_', proto)
> +
> +        r =3D KernRe(r'long\s+(sys_.*?),')
> +        if r.search(proto):
> +            proto =3D KernRe(',').sub('(', proto, count=3D1)
> +        elif is_void:
> +            proto =3D KernRe(r'\)').sub('(void)', proto, count=3D1)
> +
> +        # Now delete all of the odd-numbered commas in the proto
> +        # so that argument types & names don't have a comma between them
> +        count =3D 0
> +        length =3D len(proto)
> +
> +        if is_void:
> +            length =3D 0  # skip the loop if is_void
> +
> +        for ix in range(length):
> +            if proto[ix] =3D=3D ',':
> +                count +=3D 1
> +                if count % 2 =3D=3D 1:
> +                    proto =3D proto[:ix] + ' ' + proto[ix + 1:]
> +
> +        return proto
> +
> +    def tracepoint_munge(self, ln, proto):
> +        """
> +        Handle tracepoint definitions
> +        """
> +
> +        tracepointname =3D None
> +        tracepointargs =3D None
> +
> +        # Match tracepoint name based on different patterns
> +        r =3D KernRe(r'TRACE_EVENT\((.*?),')
> +        if r.search(proto):
> +            tracepointname =3D r.group(1)
> +
> +        r =3D KernRe(r'DEFINE_SINGLE_EVENT\((.*?),')
> +        if r.search(proto):
> +            tracepointname =3D r.group(1)
> +
> +        r =3D KernRe(r'DEFINE_EVENT\((.*?),(.*?),')
> +        if r.search(proto):
> +            tracepointname =3D r.group(2)
> +
> +        if tracepointname:
> +            tracepointname =3D tracepointname.lstrip()
> +
> +        r =3D KernRe(r'TP_PROTO\((.*?)\)')
> +        if r.search(proto):
> +            tracepointargs =3D r.group(1)
> +
> +        if not tracepointname or not tracepointargs:
> +            self.emit_msg(ln,
> +                          f"Unrecognized tracepoint format:\n{proto}\n")
> +        else:
> +            proto =3D f"static inline void trace_{tracepointname}({trace=
pointargs})"
> +            self.entry.identifier =3D f"trace_{self.entry.identifier}"
> +
> +        return proto
> +
> +    def process_proto_function(self, ln, line):
> +        """Ancillary routine to process a function prototype"""
> +
> +        # strip C99-style comments to end of line
> +        line =3D KernRe(r"\/\/.*$", re.S).sub('', line)
> +        #
> +        # Soak up the line's worth of prototype text, stopping at { or ;=
 if present.
> +        #
> +        if KernRe(r'\s*#\s*define').match(line):
> +            self.entry.prototype =3D line
> +        elif not line.startswith('#'):   # skip other preprocessor stuff
> +            r =3D KernRe(r'([^\{]*)')
> +            if r.match(line):
> +                self.entry.prototype +=3D r.group(1) + " "
> +        #
> +        # If we now have the whole prototype, clean it up and declare vi=
ctory.
> +        #
> +        if '{' in line or ';' in line or KernRe(r'\s*#\s*define').match(=
line):
> +            # strip comments and surrounding spaces
> +            self.entry.prototype =3D KernRe(r'/\*.*\*/').sub('', self.en=
try.prototype).strip()
> +            #
> +            # Handle self.entry.prototypes for function pointers like:
> +            #       int (*pcs_config)(struct foo)
> +            # by turning it into
> +            #	    int pcs_config(struct foo)
> +            #
> +            r =3D KernRe(r'^(\S+\s+)\(\s*\*(\S+)\)')
> +            self.entry.prototype =3D r.sub(r'\1\2', self.entry.prototype)
> +            #
> +            # Handle special declaration syntaxes
> +            #
> +            if 'SYSCALL_DEFINE' in self.entry.prototype:
> +                self.entry.prototype =3D self.syscall_munge(ln,
> +                                                          self.entry.pro=
totype)
> +            else:
> +                r =3D KernRe(r'TRACE_EVENT|DEFINE_EVENT|DEFINE_SINGLE_EV=
ENT')
> +                if r.search(self.entry.prototype):
> +                    self.entry.prototype =3D self.tracepoint_munge(ln,
> +                                                                 self.en=
try.prototype)
> +            #
> +            # ... and we're done
> +            #
> +            self.dump_function(ln, self.entry.prototype)
> +            self.reset_state(ln)
> +
> +    def process_proto_type(self, ln, line):
> +        """Ancillary routine to process a type"""
> +
> +        # Strip C99-style comments and surrounding whitespace
> +        line =3D KernRe(r"//.*$", re.S).sub('', line).strip()
> +        if not line:
> +            return # nothing to see here
> +
> +        # To distinguish preprocessor directive from regular declaration=
 later.
> +        if line.startswith('#'):
> +            line +=3D ";"
> +        #
> +        # Split the declaration on any of { } or ;, and accumulate pieces
> +        # until we hit a semicolon while not inside {brackets}
> +        #
> +        r =3D KernRe(r'(.*?)([{};])')
> +        for chunk in r.split(line):
> +            if chunk:  # Ignore empty matches
> +                self.entry.prototype +=3D chunk
> +                #
> +                # This cries out for a match statement ... someday after=
 we can
> +                # drop Python 3.9 ...
> +                #
> +                if chunk =3D=3D '{':
> +                    self.entry.brcount +=3D 1
> +                elif chunk =3D=3D '}':
> +                    self.entry.brcount -=3D 1
> +                elif chunk =3D=3D ';' and self.entry.brcount <=3D 0:
> +                    self.dump_declaration(ln, self.entry.prototype)
> +                    self.reset_state(ln)
> +                    return
> +        #
> +        # We hit the end of the line while still in the declaration; put
> +        # in a space to represent the newline.
> +        #
> +        self.entry.prototype +=3D ' '
> +
> +    def process_proto(self, ln, line):
> +        """STATE_PROTO: reading a function/whatever prototype."""
> +
> +        if doc_inline_oneline.search(line):
> +            self.entry.begin_section(ln, doc_inline_oneline.group(1))
> +            self.entry.add_text(doc_inline_oneline.group(2))
> +            self.dump_section()
> +
> +        elif doc_inline_start.search(line):
> +            self.state =3D state.INLINE_NAME
> +
> +        elif self.entry.decl_type =3D=3D 'function':
> +            self.process_proto_function(ln, line)
> +
> +        else:
> +            self.process_proto_type(ln, line)
> +
> +    def process_docblock(self, ln, line):
> +        """STATE_DOCBLOCK: within a DOC: block."""
> +
> +        if doc_end.search(line):
> +            self.dump_section()
> +            self.output_declaration("doc", self.entry.identifier)
> +            self.reset_state(ln)
> +
> +        elif doc_content.search(line):
> +            self.entry.add_text(doc_content.group(1))
> +
> +    def parse_export(self):
> +        """
> +        Parses EXPORT_SYMBOL* macros from a single Kernel source file.
> +        """
> +
> +        export_table =3D set()
> +
> +        try:
> +            with open(self.fname, "r", encoding=3D"utf8",
> +                      errors=3D"backslashreplace") as fp:
> +
> +                for line in fp:
> +                    self.process_export(export_table, line)
> +
> +        except IOError:
> +            return None
> +
> +        return export_table
> +
> +    #
> +    # The state/action table telling us which function to invoke in
> +    # each state.
> +    #
> +    state_actions =3D {
> +        state.NORMAL:			process_normal,
> +        state.NAME:			process_name,
> +        state.BODY:			process_body,
> +        state.DECLARATION:		process_decl,
> +        state.SPECIAL_SECTION:		process_special,
> +        state.INLINE_NAME:		process_inline_name,
> +        state.INLINE_TEXT:		process_inline_text,
> +        state.PROTO:			process_proto,
> +        state.DOCBLOCK:			process_docblock,
> +        }
> +
> +    def parse_kdoc(self):
> +        """
> +        Open and process each line of a C source file.
> +        The parsing is controlled via a state machine, and the line is p=
assed
> +        to a different process function depending on the state. The proc=
ess
> +        function may update the state as needed.
> +
> +        Besides parsing kernel-doc tags, it also parses export symbols.
> +        """
> +
> +        prev =3D ""
> +        prev_ln =3D None
> +        export_table =3D set()
> +
> +        try:
> +            with open(self.fname, "r", encoding=3D"utf8",
> +                      errors=3D"backslashreplace") as fp:
> +                for ln, line in enumerate(fp):
> +
> +                    line =3D line.expandtabs().strip("\n")
> +
> +                    # Group continuation lines on prototypes
> +                    if self.state =3D=3D state.PROTO:
> +                        if line.endswith("\\"):
> +                            prev +=3D line.rstrip("\\")
> +                            if not prev_ln:
> +                                prev_ln =3D ln
> +                            continue
> +
> +                        if prev:
> +                            ln =3D prev_ln
> +                            line =3D prev + line
> +                            prev =3D ""
> +                            prev_ln =3D None
> +
> +                    self.config.log.debug("%d %s: %s",
> +                                          ln, state.name[self.state],
> +                                          line)
> +
> +                    # This is an optimization over the original script.
> +                    # There, when export_file was used for the same file,
> +                    # it was read twice. Here, we use the already-existi=
ng
> +                    # loop to parse exported symbols as well.
> +                    #
> +                    if (self.state !=3D state.NORMAL) or \
> +                       not self.process_export(export_table, line):
> +                        # Hand this line to the appropriate state handler
> +                        self.state_actions[self.state](self, ln, line)
> +
> +        except OSError:
> +            self.config.log.error(f"Error: Cannot open file {self.fname}=
")
> +
> +        return export_table, self.entries
> diff --git a/scripts/lib/kdoc/kdoc_re.py b/scripts/lib/kdoc/kdoc_re.py
> new file mode 100644
> index 00000000000..612223e1e72
> --- /dev/null
> +++ b/scripts/lib/kdoc/kdoc_re.py
> @@ -0,0 +1,270 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright(c) 2025: Mauro Carvalho Chehab <mchehab@kernel.org>.
> +
> +"""
> +Regular expression ancillary classes.
> +
> +Those help caching regular expressions and do matching for kernel-doc.
> +"""
> +
> +import re
> +
> +# Local cache for regular expressions
> +re_cache =3D {}
> +
> +
> +class KernRe:
> +    """
> +    Helper class to simplify regex declaration and usage,
> +
> +    It calls re.compile for a given pattern. It also allows adding
> +    regular expressions and define sub at class init time.
> +
> +    Regular expressions can be cached via an argument, helping to speedup
> +    searches.
> +    """
> +
> +    def _add_regex(self, string, flags):
> +        """
> +        Adds a new regex or re-use it from the cache.
> +        """
> +        self.regex =3D re_cache.get(string, None)
> +        if not self.regex:
> +            self.regex =3D re.compile(string, flags=3Dflags)
> +            if self.cache:
> +                re_cache[string] =3D self.regex
> +
> +    def __init__(self, string, cache=3DTrue, flags=3D0):
> +        """
> +        Compile a regular expression and initialize internal vars.
> +        """
> +
> +        self.cache =3D cache
> +        self.last_match =3D None
> +
> +        self._add_regex(string, flags)
> +
> +    def __str__(self):
> +        """
> +        Return the regular expression pattern.
> +        """
> +        return self.regex.pattern
> +
> +    def __add__(self, other):
> +        """
> +        Allows adding two regular expressions into one.
> +        """
> +
> +        return KernRe(str(self) + str(other), cache=3Dself.cache or othe=
r.cache,
> +                  flags=3Dself.regex.flags | other.regex.flags)
> +
> +    def match(self, string):
> +        """
> +        Handles a re.match storing its results
> +        """
> +
> +        self.last_match =3D self.regex.match(string)
> +        return self.last_match
> +
> +    def search(self, string):
> +        """
> +        Handles a re.search storing its results
> +        """
> +
> +        self.last_match =3D self.regex.search(string)
> +        return self.last_match
> +
> +    def findall(self, string):
> +        """
> +        Alias to re.findall
> +        """
> +
> +        return self.regex.findall(string)
> +
> +    def split(self, string):
> +        """
> +        Alias to re.split
> +        """
> +
> +        return self.regex.split(string)
> +
> +    def sub(self, sub, string, count=3D0):
> +        """
> +        Alias to re.sub
> +        """
> +
> +        return self.regex.sub(sub, string, count=3Dcount)
> +
> +    def group(self, num):
> +        """
> +        Returns the group results of the last match
> +        """
> +
> +        return self.last_match.group(num)
> +
> +
> +class NestedMatch:
> +    """
> +    Finding nested delimiters is hard with regular expressions. It is
> +    even harder on Python with its normal re module, as there are several
> +    advanced regular expressions that are missing.
> +
> +    This is the case of this pattern:
> +
> +            '\\bSTRUCT_GROUP(\\(((?:(?>[^)(]+)|(?1))*)\\))[^;]*;'
> +
> +    which is used to properly match open/close parenthesis of the
> +    string search STRUCT_GROUP(),
> +
> +    Add a class that counts pairs of delimiters, using it to match and
> +    replace nested expressions.
> +
> +    The original approach was suggested by:
> +        https://stackoverflow.com/questions/5454322/python-how-to-match-=
nested-parentheses-with-regex
> +
> +    Although I re-implemented it to make it more generic and match 3 typ=
es
> +    of delimiters. The logic checks if delimiters are paired. If not, it
> +    will ignore the search string.
> +    """
> +
> +    # TODO: make NestedMatch handle multiple match groups
> +    #
> +    # Right now, regular expressions to match it are defined only up to
> +    #       the start delimiter, e.g.:
> +    #
> +    #       \bSTRUCT_GROUP\(
> +    #
> +    # is similar to: STRUCT_GROUP\((.*)\)
> +    # except that the content inside the match group is delimiter's alig=
ned.
> +    #
> +    # The content inside parenthesis are converted into a single replace
> +    # group (e.g. r`\1').
> +    #
> +    # It would be nice to change such definition to support multiple
> +    # match groups, allowing a regex equivalent to.
> +    #
> +    #   FOO\((.*), (.*), (.*)\)
> +    #
> +    # it is probably easier to define it not as a regular expression, but
> +    # with some lexical definition like:
> +    #
> +    #   FOO(arg1, arg2, arg3)
> +
> +    DELIMITER_PAIRS =3D {
> +        '{': '}',
> +        '(': ')',
> +        '[': ']',
> +    }
> +
> +    RE_DELIM =3D re.compile(r'[\{\}\[\]\(\)]')
> +
> +    def _search(self, regex, line):
> +        """
> +        Finds paired blocks for a regex that ends with a delimiter.
> +
> +        The suggestion of using finditer to match pairs came from:
> +        https://stackoverflow.com/questions/5454322/python-how-to-match-=
nested-parentheses-with-regex
> +        but I ended using a different implementation to align all three =
types
> +        of delimiters and seek for an initial regular expression.
> +
> +        The algorithm seeks for open/close paired delimiters and place t=
hem
> +        into a stack, yielding a start/stop position of each match  when=
 the
> +        stack is zeroed.
> +
> +        The algorithm shoud work fine for properly paired lines, but will
> +        silently ignore end delimiters that preceeds an start delimiter.
> +        This should be OK for kernel-doc parser, as unaligned delimiters
> +        would cause compilation errors. So, we don't need to rise except=
ions
> +        to cover such issues.
> +        """
> +
> +        stack =3D []
> +
> +        for match_re in regex.finditer(line):
> +            start =3D match_re.start()
> +            offset =3D match_re.end()
> +
> +            d =3D line[offset - 1]
> +            if d not in self.DELIMITER_PAIRS:
> +                continue
> +
> +            end =3D self.DELIMITER_PAIRS[d]
> +            stack.append(end)
> +
> +            for match in self.RE_DELIM.finditer(line[offset:]):
> +                pos =3D match.start() + offset
> +
> +                d =3D line[pos]
> +
> +                if d in self.DELIMITER_PAIRS:
> +                    end =3D self.DELIMITER_PAIRS[d]
> +
> +                    stack.append(end)
> +                    continue
> +
> +                # Does the end delimiter match what it is expected?
> +                if stack and d =3D=3D stack[-1]:
> +                    stack.pop()
> +
> +                    if not stack:
> +                        yield start, offset, pos + 1
> +                        break
> +
> +    def search(self, regex, line):
> +        """
> +        This is similar to re.search:
> +
> +        It matches a regex that it is followed by a delimiter,
> +        returning occurrences only if all delimiters are paired.
> +        """
> +
> +        for t in self._search(regex, line):
> +
> +            yield line[t[0]:t[2]]
> +
> +    def sub(self, regex, sub, line, count=3D0):
> +        """
> +        This is similar to re.sub:
> +
> +        It matches a regex that it is followed by a delimiter,
> +        replacing occurrences only if all delimiters are paired.
> +
> +        if r'\1' is used, it works just like re: it places there the
> +        matched paired data with the delimiter stripped.
> +
> +        If count is different than zero, it will replace at most count
> +        items.
> +        """
> +        out =3D ""
> +
> +        cur_pos =3D 0
> +        n =3D 0
> +
> +        for start, end, pos in self._search(regex, line):
> +            out +=3D line[cur_pos:start]
> +
> +            # Value, ignoring start/end delimiters
> +            value =3D line[end:pos - 1]
> +
> +            # replaces \1 at the sub string, if \1 is used there
> +            new_sub =3D sub
> +            new_sub =3D new_sub.replace(r'\1', value)
> +
> +            out +=3D new_sub
> +
> +            # Drop end ';' if any
> +            if line[pos] =3D=3D ';':
> +                pos +=3D 1
> +
> +            cur_pos =3D pos
> +            n +=3D 1
> +
> +            if count and count >=3D n:
> +                break
> +
> +        # Append the remaining string
> +        l =3D len(line)
> +        out +=3D line[cur_pos:l]
> +
> +        return out



Thanks,
Mauro


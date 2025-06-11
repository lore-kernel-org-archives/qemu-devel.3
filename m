Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 023CFC7113E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 19:24:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPR3o-0007bu-CA; Wed, 11 Jun 2025 15:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@jedlik.phy.bme.hu>)
 id 1uPR3l-0007bW-UO
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 15:24:29 -0400
Received: from jedlik.phy.bme.hu ([152.66.102.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@jedlik.phy.bme.hu>)
 id 1uPR3j-000158-Gs
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 15:24:29 -0400
Received: by jedlik.phy.bme.hu (Postfix, from userid 1000)
 id 17CD3A0127; Wed, 11 Jun 2025 21:18:36 +0200 (CEST)
Date: Wed, 11 Jun 2025 21:18:36 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Stefan Hajnoczi <stefanha@redhat.com>
cc: qemu-devel@nongnu.org, Mahmoud Mandour <ma.mandourr@gmail.com>, 
 Mads Ynddal <mads@ynddal.dk>, Alexandre Iooss <erdnaxe@crans.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
 oltolm <oleg.tolmatcev@gmail.com>
Subject: Re: [PULL 1/1] meson: fix Windows build
In-Reply-To: <20250611182902.201331-2-stefanha@redhat.com>
Message-ID: <alpine.LMD.2.03.2506112113260.22610@eik.bme.hu>
References: <20250611182902.201331-1-stefanha@redhat.com>
 <20250611182902.201331-2-stefanha@redhat.com>
User-Agent: Alpine 2.03 (LMD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
 BOUNDARY="1117279078-340601367-1749669516=:22610"
Received-SPF: pass client-ip=152.66.102.83;
 envelope-from=balaton@jedlik.phy.bme.hu; helo=jedlik.phy.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1117279078-340601367-1749669516=:22610
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 11 Jun 2025, Stefan Hajnoczi wrote:
> From: oltolm <oleg.tolmatcev@gmail.com>
>
> Sorry, I forgot to cc the maintainers.

Do we want comments like this end up in git log? This could have been=20
fixed before a pull. Also the other pull request about uninitialised stack=
=20
variables had hw/audio/gus twice which was pointed out by a comment before=
=20
the pull that one of those should be different but the pull request still=
=20
had this error. Did you miss these or aren't these important enough to fix=
=20
before getting in git log forever or there is just no easy way to fix up=20
commit messages in pull requests?

Regards,
BALATON Zoltan

> The build failed when run on Windows. I replaced calls to Unix programs
> like =C2=B4cat=C2=B4, =C2=B4sed=C2=B4 and =C2=B4true=C2=B4 with calls to =
=C2=B4python=C2=B4. I wrapped calls to
> =C2=B4os.path.relpath=C2=B4 in try-except because it can fail when the tw=
o paths
> are on different drives. I made sure to convert the Windows paths to
> Unix paths to prevent warnings in generated files.
>
> Signed-off-by: oltolm <oleg.tolmatcev@gmail.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Message-id: 20250607094503.1307-2-oleg.tolmatcev@gmail.com
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> contrib/plugins/meson.build         |  2 +-
> plugins/meson.build                 |  2 +-
> scripts/tracetool/__init__.py       | 15 ++++++++++++---
> scripts/tracetool/backend/ftrace.py |  4 +---
> scripts/tracetool/backend/log.py    |  4 +---
> scripts/tracetool/backend/syslog.py |  4 +---
> tests/functional/meson.build        |  4 +---
> tests/include/meson.build           |  2 +-
> tests/tcg/plugins/meson.build       |  2 +-
> trace/meson.build                   |  5 +++--
> 10 files changed, 23 insertions(+), 21 deletions(-)
>
> diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
> index fa8a426c8b..1876bc7843 100644
> --- a/contrib/plugins/meson.build
> +++ b/contrib/plugins/meson.build
> @@ -24,7 +24,7 @@ endif
> if t.length() > 0
>   alias_target('contrib-plugins', t)
> else
> -  run_target('contrib-plugins', command: find_program('true'))
> +  run_target('contrib-plugins', command: [python, '-c', ''])
> endif
>
> plugin_modules +=3D t
> diff --git a/plugins/meson.build b/plugins/meson.build
> index b20edfbabc..62c991d87f 100644
> --- a/plugins/meson.build
> +++ b/plugins/meson.build
> @@ -33,7 +33,7 @@ if host_os =3D=3D 'windows'
>     input: qemu_plugin_symbols,
>     output: 'qemu_plugin_api.def',
>     capture: true,
> -    command: ['sed', '-e', '0,/^/s//EXPORTS/; s/[{};]//g', '@INPUT@'])
> +    command: [python, '-c', 'import fileinput, re; print("EXPORTS", end=
=3D""); [print(re.sub(r"[{};]", "", line), end=3D"") for line in fileinput.=
input()]', '@INPUT@'])
>
>   # then use dlltool to assemble a delaylib.
>   # The delaylib will have an "imaginary" name (qemu.exe), that is used b=
y the
> diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.p=
y
> index bc03238c0f..6dfcbf71e1 100644
> --- a/scripts/tracetool/__init__.py
> +++ b/scripts/tracetool/__init__.py
> @@ -12,12 +12,14 @@
> __email__      =3D "stefanha@redhat.com"
>
>
> +import os
> import re
> import sys
> import weakref
> +from pathlib import PurePath
>
> -import tracetool.format
> import tracetool.backend
> +import tracetool.format
>
>
> def error_write(*lines):
> @@ -36,7 +38,7 @@ def error(*lines):
>
> def out_open(filename):
>     global out_filename, out_fobj
> -    out_filename =3D filename
> +    out_filename =3D posix_relpath(filename)
>     out_fobj =3D open(filename, 'wt')
>
> def out(*lines, **kwargs):
> @@ -308,7 +310,7 @@ def build(line_str, lineno, filename):
>             fmt =3D [fmt_trans, fmt]
>         args =3D Arguments.build(groups["args"])
>
> -        return Event(name, props, fmt, args, lineno, filename)
> +        return Event(name, props, fmt, args, lineno, posix_relpath(filen=
ame))
>
>     def __repr__(self):
>         """Evaluable string representation for this object."""
> @@ -447,3 +449,10 @@ def generate(events, group, format, backends,
>     tracetool.backend.dtrace.PROBEPREFIX =3D probe_prefix
>
>     tracetool.format.generate(events, format, backend, group)
> +
> +def posix_relpath(path, start=3DNone):
> +    try:
> +        path =3D os.path.relpath(path, start)
> +    except ValueError:
> +        pass
> +    return PurePath(path).as_posix()
> diff --git a/scripts/tracetool/backend/ftrace.py b/scripts/tracetool/back=
end/ftrace.py
> index baed2ae61c..5fa30ccc08 100644
> --- a/scripts/tracetool/backend/ftrace.py
> +++ b/scripts/tracetool/backend/ftrace.py
> @@ -12,8 +12,6 @@
> __email__      =3D "stefanha@redhat.com"
>
>
> -import os.path
> -
> from tracetool import out
>
>
> @@ -47,7 +45,7 @@ def generate_h(event, group):
>         args=3Devent.args,
>         event_id=3D"TRACE_" + event.name.upper(),
>         event_lineno=3Devent.lineno,
> -        event_filename=3Dos.path.relpath(event.filename),
> +        event_filename=3Devent.filename,
>         fmt=3Devent.fmt.rstrip("\n"),
>         argnames=3Dargnames)
>
> diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend=
/log.py
> index de27b7e62e..17ba1cd90e 100644
> --- a/scripts/tracetool/backend/log.py
> +++ b/scripts/tracetool/backend/log.py
> @@ -12,8 +12,6 @@
> __email__      =3D "stefanha@redhat.com"
>
>
> -import os.path
> -
> from tracetool import out
>
>
> @@ -55,7 +53,7 @@ def generate_h(event, group):
>         '    }',
>         cond=3Dcond,
>         event_lineno=3Devent.lineno,
> -        event_filename=3Dos.path.relpath(event.filename),
> +        event_filename=3Devent.filename,
>         name=3Devent.name,
>         fmt=3Devent.fmt.rstrip("\n"),
>         argnames=3Dargnames)
> diff --git a/scripts/tracetool/backend/syslog.py b/scripts/tracetool/back=
end/syslog.py
> index 012970f6cc..5a3a00fe31 100644
> --- a/scripts/tracetool/backend/syslog.py
> +++ b/scripts/tracetool/backend/syslog.py
> @@ -12,8 +12,6 @@
> __email__      =3D "stefanha@redhat.com"
>
>
> -import os.path
> -
> from tracetool import out
>
>
> @@ -43,7 +41,7 @@ def generate_h(event, group):
>         '    }',
>         cond=3Dcond,
>         event_lineno=3Devent.lineno,
> -        event_filename=3Dos.path.relpath(event.filename),
> +        event_filename=3Devent.filename,
>         name=3Devent.name,
>         fmt=3Devent.fmt.rstrip("\n"),
>         argnames=3Dargnames)
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index 557d59ddf4..4bce961c04 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -412,6 +412,4 @@ foreach speed : ['quick', 'thorough']
>   endforeach
> endforeach
>
> -run_target('precache-functional',
> -           depends: precache_all,
> -           command: ['true'])
> +alias_target('precache-functional', precache_all)
> diff --git a/tests/include/meson.build b/tests/include/meson.build
> index 9abba308fa..8e8d1ec4e6 100644
> --- a/tests/include/meson.build
> +++ b/tests/include/meson.build
> @@ -13,4 +13,4 @@ test_qapi_outputs_extra =3D [
> test_qapi_files_extra =3D custom_target('QAPI test (include)',
>                                       output: test_qapi_outputs_extra,
>                                       input: test_qapi_files,
> -                                      command: 'true')
> +                                      command: [python, '-c', ''])
> diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.buil=
d
> index 41f02f2c7f..029342282a 100644
> --- a/tests/tcg/plugins/meson.build
> +++ b/tests/tcg/plugins/meson.build
> @@ -17,7 +17,7 @@ endif
> if t.length() > 0
>   alias_target('test-plugins', t)
> else
> -  run_target('test-plugins', command: find_program('true'))
> +  run_target('test-plugins', command: [python, '-c', ''])
> endif
>
> plugin_modules +=3D t
> diff --git a/trace/meson.build b/trace/meson.build
> index 3df4549355..9c42a57a05 100644
> --- a/trace/meson.build
> +++ b/trace/meson.build
> @@ -4,7 +4,7 @@ trace_events_files =3D []
> foreach item : [ '.' ] + trace_events_subdirs + qapi_trace_events
>   if item in qapi_trace_events
>     trace_events_file =3D item
> -    group_name =3D item.full_path().split('/')[-1].underscorify()
> +    group_name =3D fs.name(item).underscorify()
>   else
>     trace_events_file =3D meson.project_source_root() / item / 'trace-eve=
nts'
>     group_name =3D item =3D=3D '.' ? 'root' : item.underscorify()
> @@ -57,10 +57,11 @@ foreach item : [ '.' ] + trace_events_subdirs + qapi_=
trace_events
>   endif
> endforeach
>
> +cat =3D [ python, '-c', 'import fileinput; [print(line, end=3D"") for li=
ne in fileinput.input()]', '@INPUT@' ]
> trace_events_all =3D custom_target('trace-events-all',
>                                  output: 'trace-events-all',
>                                  input: trace_events_files,
> -                                 command: [ 'cat', '@INPUT@' ],
> +                                 command: cat,
>                                  capture: true,
>                                  install: get_option('trace_backends') !=
=3D [ 'nop' ],
>                                  install_dir: qemu_datadir)
> --=20
> 2.49.0
>
>
>
--1117279078-340601367-1749669516=:22610--


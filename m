Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA1CC61CE8
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Jun 2025 19:07:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNysb-0005IR-65; Sat, 07 Jun 2025 15:06:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uNysY-0005Hu-AM
 for qemu-devel@nongnu.org; Sat, 07 Jun 2025 15:06:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uNysV-000649-KT
 for qemu-devel@nongnu.org; Sat, 07 Jun 2025 15:06:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749323208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5mr5heC5UQwcw47vHSkF3u0PP+MfDKePi0fW6jLj7uE=;
 b=X5nRAoBnhHkzbhCmPK4OIsoovi+E0zprapsmX0FN4Vbp6aIxHhh6crMxhC1egIxCzrfRLK
 E6RY72sx7fmJyH1FmINVX5DLUh30c1mvgYz60XTT7EH1wwjKailIxYXOv9qrI+XMF7f4sE
 zX7UvZnQn2vtrXNdZzwXwvan2jMX0YU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-757epamdPpe0LN6ESHXcdw-1; Sat,
 07 Jun 2025 15:06:46 -0400
X-MC-Unique: 757epamdPpe0LN6ESHXcdw-1
X-Mimecast-MFC-AGG-ID: 757epamdPpe0LN6ESHXcdw_1749323205
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C043C180047F; Sat,  7 Jun 2025 19:06:44 +0000 (UTC)
Received: from localhost (unknown [10.2.16.24])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7C41319560AB; Sat,  7 Jun 2025 19:06:43 +0000 (UTC)
Date: Sat, 7 Jun 2025 15:06:42 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: oltolm <oleg.tolmatcev@gmail.com>
Cc: qemu-devel@nongnu.org, Mads Ynddal <mads@ynddal.dk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: Re: [PATCH RESEND v3] meson: fix Windows build
Message-ID: <20250607190642.GA553743@fedora>
References: <20250607094503.1307-2-oleg.tolmatcev@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7PG5qxreoCWyJadF"
Content-Disposition: inline
In-Reply-To: <20250607094503.1307-2-oleg.tolmatcev@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--7PG5qxreoCWyJadF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 07, 2025 at 11:45:04AM +0200, oltolm wrote:
> Sorry, I forgot to cc the maintainers.
>=20
> The build failed when run on Windows. I replaced calls to Unix programs
> like =B4cat=B4, =B4sed=B4 and =B4true=B4 with calls to =B4python=B4. I wr=
apped calls to
> =B4os.path.relpath=B4 in try-except because it can fail when the two paths
> are on different drives. I made sure to convert the Windows paths to
> Unix paths to prevent warnings in generated files.
>=20
> Signed-off-by: oltolm <oleg.tolmatcev@gmail.com>
> ---
>  contrib/plugins/meson.build         |  2 +-
>  plugins/meson.build                 |  2 +-
>  scripts/tracetool/__init__.py       | 15 ++++++++++++---
>  scripts/tracetool/backend/ftrace.py |  4 +---
>  scripts/tracetool/backend/log.py    |  4 +---
>  scripts/tracetool/backend/syslog.py |  4 +---
>  tests/functional/meson.build        |  4 +---
>  tests/include/meson.build           |  2 +-
>  tests/tcg/plugins/meson.build       |  2 +-
>  trace/meson.build                   |  5 +++--
>  10 files changed, 23 insertions(+), 21 deletions(-)

Thank you for the tracing changes!

I have CCed Paolo for general meson knowledge and the plugins
maintainers/reviewers. If no one responds by Wednesday I will merge it
through my tracing tree.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

>=20
> diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
> index fa8a426c8..1876bc784 100644
> --- a/contrib/plugins/meson.build
> +++ b/contrib/plugins/meson.build
> @@ -24,7 +24,7 @@ endif
>  if t.length() > 0
>    alias_target('contrib-plugins', t)
>  else
> -  run_target('contrib-plugins', command: find_program('true'))
> +  run_target('contrib-plugins', command: [python, '-c', ''])
>  endif
> =20
>  plugin_modules +=3D t
> diff --git a/plugins/meson.build b/plugins/meson.build
> index 5383c7b88..cb7472df8 100644
> --- a/plugins/meson.build
> +++ b/plugins/meson.build
> @@ -33,7 +33,7 @@ if host_os =3D=3D 'windows'
>      input: qemu_plugin_symbols,
>      output: 'qemu_plugin_api.def',
>      capture: true,
> -    command: ['sed', '-e', '0,/^/s//EXPORTS/; s/[{};]//g', '@INPUT@'])
> +    command: [python, '-c', 'import fileinput, re; print("EXPORTS", end=
=3D""); [print(re.sub(r"[{};]", "", line), end=3D"") for line in fileinput.=
input()]', '@INPUT@'])
> =20
>    # then use dlltool to assemble a delaylib.
>    # The delaylib will have an "imaginary" name (qemu.exe), that is used =
by the
> diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
> index bc03238c0..6dfcbf71e 100644
> --- a/scripts/tracetool/__init__.py
> +++ b/scripts/tracetool/__init__.py
> @@ -12,12 +12,14 @@
>  __email__      =3D "stefanha@redhat.com"
> =20
> =20
> +import os
>  import re
>  import sys
>  import weakref
> +from pathlib import PurePath
> =20
> -import tracetool.format
>  import tracetool.backend
> +import tracetool.format
> =20
> =20
>  def error_write(*lines):
> @@ -36,7 +38,7 @@ def error(*lines):
> =20
>  def out_open(filename):
>      global out_filename, out_fobj
> -    out_filename =3D filename
> +    out_filename =3D posix_relpath(filename)
>      out_fobj =3D open(filename, 'wt')
> =20
>  def out(*lines, **kwargs):
> @@ -308,7 +310,7 @@ def build(line_str, lineno, filename):
>              fmt =3D [fmt_trans, fmt]
>          args =3D Arguments.build(groups["args"])
> =20
> -        return Event(name, props, fmt, args, lineno, filename)
> +        return Event(name, props, fmt, args, lineno, posix_relpath(filen=
ame))
> =20
>      def __repr__(self):
>          """Evaluable string representation for this object."""
> @@ -447,3 +449,10 @@ def generate(events, group, format, backends,
>      tracetool.backend.dtrace.PROBEPREFIX =3D probe_prefix
> =20
>      tracetool.format.generate(events, format, backend, group)
> +
> +def posix_relpath(path, start=3DNone):
> +    try:
> +        path =3D os.path.relpath(path, start)
> +    except ValueError:
> +        pass
> +    return PurePath(path).as_posix()
> diff --git a/scripts/tracetool/backend/ftrace.py b/scripts/tracetool/back=
end/ftrace.py
> index baed2ae61..5fa30ccc0 100644
> --- a/scripts/tracetool/backend/ftrace.py
> +++ b/scripts/tracetool/backend/ftrace.py
> @@ -12,8 +12,6 @@
>  __email__      =3D "stefanha@redhat.com"
> =20
> =20
> -import os.path
> -
>  from tracetool import out
> =20
> =20
> @@ -47,7 +45,7 @@ def generate_h(event, group):
>          args=3Devent.args,
>          event_id=3D"TRACE_" + event.name.upper(),
>          event_lineno=3Devent.lineno,
> -        event_filename=3Dos.path.relpath(event.filename),
> +        event_filename=3Devent.filename,
>          fmt=3Devent.fmt.rstrip("\n"),
>          argnames=3Dargnames)
> =20
> diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend=
/log.py
> index de27b7e62..17ba1cd90 100644
> --- a/scripts/tracetool/backend/log.py
> +++ b/scripts/tracetool/backend/log.py
> @@ -12,8 +12,6 @@
>  __email__      =3D "stefanha@redhat.com"
> =20
> =20
> -import os.path
> -
>  from tracetool import out
> =20
> =20
> @@ -55,7 +53,7 @@ def generate_h(event, group):
>          '    }',
>          cond=3Dcond,
>          event_lineno=3Devent.lineno,
> -        event_filename=3Dos.path.relpath(event.filename),
> +        event_filename=3Devent.filename,
>          name=3Devent.name,
>          fmt=3Devent.fmt.rstrip("\n"),
>          argnames=3Dargnames)
> diff --git a/scripts/tracetool/backend/syslog.py b/scripts/tracetool/back=
end/syslog.py
> index 012970f6c..5a3a00fe3 100644
> --- a/scripts/tracetool/backend/syslog.py
> +++ b/scripts/tracetool/backend/syslog.py
> @@ -12,8 +12,6 @@
>  __email__      =3D "stefanha@redhat.com"
> =20
> =20
> -import os.path
> -
>  from tracetool import out
> =20
> =20
> @@ -43,7 +41,7 @@ def generate_h(event, group):
>          '    }',
>          cond=3Dcond,
>          event_lineno=3Devent.lineno,
> -        event_filename=3Dos.path.relpath(event.filename),
> +        event_filename=3Devent.filename,
>          name=3Devent.name,
>          fmt=3Devent.fmt.rstrip("\n"),
>          argnames=3Dargnames)
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index 52b4706cf..ee222888f 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -411,6 +411,4 @@ foreach speed : ['quick', 'thorough']
>    endforeach
>  endforeach
> =20
> -run_target('precache-functional',
> -           depends: precache_all,
> -           command: ['true'])
> +alias_target('precache-functional', precache_all)
> diff --git a/tests/include/meson.build b/tests/include/meson.build
> index 9abba308f..8e8d1ec4e 100644
> --- a/tests/include/meson.build
> +++ b/tests/include/meson.build
> @@ -13,4 +13,4 @@ test_qapi_outputs_extra =3D [
>  test_qapi_files_extra =3D custom_target('QAPI test (include)',
>                                        output: test_qapi_outputs_extra,
>                                        input: test_qapi_files,
> -                                      command: 'true')
> +                                      command: [python, '-c', ''])
> diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
> index 41f02f2c7..029342282 100644
> --- a/tests/tcg/plugins/meson.build
> +++ b/tests/tcg/plugins/meson.build
> @@ -17,7 +17,7 @@ endif
>  if t.length() > 0
>    alias_target('test-plugins', t)
>  else
> -  run_target('test-plugins', command: find_program('true'))
> +  run_target('test-plugins', command: [python, '-c', ''])
>  endif
> =20
>  plugin_modules +=3D t
> diff --git a/trace/meson.build b/trace/meson.build
> index 3df454935..9c42a57a0 100644
> --- a/trace/meson.build
> +++ b/trace/meson.build
> @@ -4,7 +4,7 @@ trace_events_files =3D []
>  foreach item : [ '.' ] + trace_events_subdirs + qapi_trace_events
>    if item in qapi_trace_events
>      trace_events_file =3D item
> -    group_name =3D item.full_path().split('/')[-1].underscorify()
> +    group_name =3D fs.name(item).underscorify()
>    else
>      trace_events_file =3D meson.project_source_root() / item / 'trace-ev=
ents'
>      group_name =3D item =3D=3D '.' ? 'root' : item.underscorify()
> @@ -57,10 +57,11 @@ foreach item : [ '.' ] + trace_events_subdirs + qapi_=
trace_events
>    endif
>  endforeach
> =20
> +cat =3D [ python, '-c', 'import fileinput; [print(line, end=3D"") for li=
ne in fileinput.input()]', '@INPUT@' ]
>  trace_events_all =3D custom_target('trace-events-all',
>                                   output: 'trace-events-all',
>                                   input: trace_events_files,
> -                                 command: [ 'cat', '@INPUT@' ],
> +                                 command: cat,
>                                   capture: true,
>                                   install: get_option('trace_backends') !=
=3D [ 'nop' ],
>                                   install_dir: qemu_datadir)
> --=20
> 2.49.0.windows.1
>=20

--7PG5qxreoCWyJadF
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhEjcIACgkQnKSrs4Gr
c8jDIgf9FQz4pwUeMjTHVNoemA0bYbLreCh2D4m4dUsgr5yROQ8krQUNOmgg8fPV
Q844gqOAq7WQm7Prwm2BHTjAg2OehcFO3QJuL8OcXDYWeCqq2VfML7riqgP9Als4
ZonXyh8e1YpXlBnNPNPCAOdr33sT6xxSuUrZW7ftdtH4uV2+qZ8x1gm0nGHzG681
BQmNaNt7GWGugWJ3zyxDsmruqcoaSEYUnBxZaptOzdVYXSNNmJr4bbWGBzmjk7KW
Iea8HkrLzZIZ/3hJFfZoLJ+JpvWy9j+AqkNG7Voghw1Kc1ILTpK/b+VbV3MPILgK
p9SbuPnpF9T/MvEesrcR3QOituzYKg==
=iy/Z
-----END PGP SIGNATURE-----

--7PG5qxreoCWyJadF--



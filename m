Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E9D7C61CE8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 19:36:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPni8-00079v-Mq; Thu, 12 Jun 2025 15:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uPnhy-00079I-OD
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 15:35:32 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uPnhv-00078l-Oe
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 15:35:29 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-601dfef6a8dso2323938a12.1
 for <qemu-devel@nongnu.org>; Thu, 12 Jun 2025 12:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749756924; x=1750361724; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=izxp3M0gwYm2sHlhKDnW9mpCDLZpO2vbPQZLlMa4fTI=;
 b=fk39M+ImimpLZvN9FZkM5jjQaiprAQP4111qVvsRB1KQ7UQB4BwHCbEyqupl5eDYVA
 9a9qgQSANckt47kSie8z6yNdRO0EqBLl0jHNWV+hQaytLCzZfGCBkD7haE7gNxWf83VN
 wPTMeeJJHGWFtaXTb9jjtPebkytB4Xh1Gknqbm2U0EgERdyRDKVjkihK7RGe1XFBvVJe
 j1wFDQO7KLAN8kQFz+SWaKihydIIgGguOdg1nHFCjoQ+1Wo95LcqCNfhWDDy7J8QcRlJ
 jzCv6PEJj1ZmprmZXEIs2IvdfRGvz2W7tSQ3cbzIX45FmJKD6PCp7vKQSDv7da+Pvuz9
 UHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749756924; x=1750361724;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=izxp3M0gwYm2sHlhKDnW9mpCDLZpO2vbPQZLlMa4fTI=;
 b=n2rh5E0FpWLGgV27L7PhPD3LPB6wex24wyzwRvMNt7cBuP1pLUqpoD08Ga9v5jYfU0
 b2bfF7b6m92LB9gCTNtaM9+n3vu+shKB0Al9hC7O5XfchVGyjtgqQ4CgAv2vLEFH1w/1
 1chLNLgkP99+pOH8jwmKmK7+5lA+zdX8YdWYUg/oUbaNfHyd4wqpDO6DzYjHE/nu/GSt
 71PtN3R12Fq6gJ/8x7Jm5KUrINeg2+yS4qJJwNFKmubJKHCrlN5TBQaifw2XYUKbseHp
 hFn0BPZ2rSCTTIwkWDEq48utojwvwGc5Kks20qfNZ3WC9ZsTYATYAKwi3KtOk86vYACv
 7U2A==
X-Gm-Message-State: AOJu0Yy4+1O1huR3Ue35AKvQFWIbZxCP71RsDFkt9A/nLNY29i4Gj3+I
 +QllkszKSj1/Ma37YoblFNiH9ns5IzaoN0rB+oqY7nKvo2Vjd2YQtkJT1kOUUOkSCeizi37UI7N
 bBs+2aKHh5OhplxS+sHmaxZXDPEFwTkk=
X-Gm-Gg: ASbGncvmMTSdNZZ/Zjuz911R3xlojxv8ywaarn+8xFhtaEH/MEZH533Om5OnTBvfmsL
 edGsd7oAy8BfytxGUaAuXJ75FmSeBqrXVwCIv98+xCP3tCqpizqforUxtgWrjPf+ZB2OUmpH5d/
 7oUO7cO9yt2EoZBLYioDXeZWiT8PO1OC/rR7CAJL9kwg==
X-Google-Smtp-Source: AGHT+IEJWohodMToXYZMgMWdp+3dfDGAqcvQlH8Sq7c2lIpvjTJ50qRMjjcJVL0jvNRv+uaKU9mRcnuQ4U23TkoytL0=
X-Received: by 2002:a17:907:d86:b0:ad8:ae51:d16 with SMTP id
 a640c23a62f3a-adec5d18576mr40974866b.55.1749756923362; Thu, 12 Jun 2025
 12:35:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250607094503.1307-2-oleg.tolmatcev@gmail.com>
In-Reply-To: <20250607094503.1307-2-oleg.tolmatcev@gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 12 Jun 2025 15:35:11 -0400
X-Gm-Features: AX0GCFvSEfu1LtIJGnSy16BThcYig-rC-pO5qLXmjCqDnhwYeOYVOfC8r2EanVQ
Message-ID: <CAJSP0QXOiaYWo-s8V7tRRBdyzJTCruY5ufvu9zyNPm9ZQR1SrQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v3] meson: fix Windows build
To: oltolm <oleg.tolmatcev@gmail.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Mads Ynddal <mads@ynddal.dk>, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sat, Jun 7, 2025 at 5:47=E2=80=AFAM oltolm <oleg.tolmatcev@gmail.com> wr=
ote:
>
> Sorry, I forgot to cc the maintainers.
>
> The build failed when run on Windows. I replaced calls to Unix programs
> like =C2=B4cat=C2=B4, =C2=B4sed=C2=B4 and =C2=B4true=C2=B4 with calls to =
=C2=B4python=C2=B4. I wrapped calls to
> =C2=B4os.path.relpath=C2=B4 in try-except because it can fail when the tw=
o paths
> are on different drives. I made sure to convert the Windows paths to
> Unix paths to prevent warnings in generated files.
>
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
>
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
>
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
>
>    # then use dlltool to assemble a delaylib.
>    # The delaylib will have an "imaginary" name (qemu.exe), that is used =
by the
> diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.p=
y
> index bc03238c0..6dfcbf71e 100644
> --- a/scripts/tracetool/__init__.py
> +++ b/scripts/tracetool/__init__.py
> @@ -12,12 +12,14 @@
>  __email__      =3D "stefanha@redhat.com"
>
>
> +import os
>  import re
>  import sys
>  import weakref
> +from pathlib import PurePath
>
> -import tracetool.format
>  import tracetool.backend
> +import tracetool.format
>
>
>  def error_write(*lines):
> @@ -36,7 +38,7 @@ def error(*lines):
>
>  def out_open(filename):
>      global out_filename, out_fobj
> -    out_filename =3D filename
> +    out_filename =3D posix_relpath(filename)
>      out_fobj =3D open(filename, 'wt')
>
>  def out(*lines, **kwargs):
> @@ -308,7 +310,7 @@ def build(line_str, lineno, filename):
>              fmt =3D [fmt_trans, fmt]
>          args =3D Arguments.build(groups["args"])
>
> -        return Event(name, props, fmt, args, lineno, filename)
> +        return Event(name, props, fmt, args, lineno, posix_relpath(filen=
ame))
>
>      def __repr__(self):
>          """Evaluable string representation for this object."""
> @@ -447,3 +449,10 @@ def generate(events, group, format, backends,
>      tracetool.backend.dtrace.PROBEPREFIX =3D probe_prefix
>
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
>
>
> -import os.path
> -
>  from tracetool import out
>
>
> @@ -47,7 +45,7 @@ def generate_h(event, group):
>          args=3Devent.args,
>          event_id=3D"TRACE_" + event.name.upper(),
>          event_lineno=3Devent.lineno,
> -        event_filename=3Dos.path.relpath(event.filename),
> +        event_filename=3Devent.filename,
>          fmt=3Devent.fmt.rstrip("\n"),
>          argnames=3Dargnames)
>
> diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend=
/log.py
> index de27b7e62..17ba1cd90 100644
> --- a/scripts/tracetool/backend/log.py
> +++ b/scripts/tracetool/backend/log.py
> @@ -12,8 +12,6 @@
>  __email__      =3D "stefanha@redhat.com"
>
>
> -import os.path
> -
>  from tracetool import out
>
>
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
>
>
> -import os.path
> -
>  from tracetool import out
>
>
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
>
> -run_target('precache-functional',
> -           depends: precache_all,
> -           command: ['true'])
> +alias_target('precache-functional', precache_all)

Hi Oleg,
There is a CI hexagon build failure. Maybe precache_all is []:
../tests/functional/meson.build:417:0: ERROR: alias_target takes at
least 2 arguments, but got 1.

https://gitlab.com/qemu-project/qemu/-/jobs/10336566320#L4267

Please take a look. Thanks!

Stefan

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
> diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.buil=
d
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
>
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
>
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
> --
> 2.49.0.windows.1
>
>


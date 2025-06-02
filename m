Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E75AC5B555
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 18:45:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMA9n-00082u-RJ; Mon, 02 Jun 2025 14:45:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uMA9m-00082D-Ba
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 14:45:10 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uMA9i-0005PB-TG
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 14:45:10 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-604bff84741so9183539a12.2
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 11:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748889903; x=1749494703; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8CoIRgdTJ6IzAdVaqKWOUYgO7jDZqUiXBTyKExPJlE0=;
 b=dYOGUvZY5sUB70ow/v71JGILZBqwR5YSWeyn5La0ssXx1vVmi6FqGqmeKY+EeAoA1V
 Xqc26SQkwZhpcy4dat+WJuHvGWci6VPQjy53CYboLH3/G/LfNoDFNEQ6ifqZHQg/f3j/
 9r299/3osby+XRBTpkhItVxywzKnEKGTCWgW2qeqylM2dzUVSKnrdb3BDRZExX3msK8W
 2yp4oolYiSv/DFL+RQZjiLFF6i6sQ2nAq0iXE5XE3vJtYuPyEIw2uUJvMFCd+97Ip2gi
 din4Aqpkphxas6CMNMBxSSFHAsVvx4tffM0PyPsbmKtB4hfnPNfe/so2Qv0n/M8T0k3i
 ji6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748889903; x=1749494703;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8CoIRgdTJ6IzAdVaqKWOUYgO7jDZqUiXBTyKExPJlE0=;
 b=gmQram2UpHe8G9sbu+Bxn3rjiM5/gkKAzuf/iqwmW9zEpm5nY/8Tu0m9fGRbWSlR9P
 I1eXw+ZdNwKtCBwIfI/sn9W4WdQk8HpGMo/zmcPDaJ6SLjJXum68Y4OgKReV7dI01j3U
 7LsHA51fJ2/c83SdkgVe4FSt43EELqnNadNxbUy6iy9YPLXK9YvP/kJ78BAh6+xLJmxc
 r65EnwfNwr2G5dNApVaBPf+wJiWvaYX6BQzBrg/jwfaxlwO7nmaopPiEBGygARDbEngk
 qsVRg8tFraCXITBxclJeOawwctRo6Tg8TIsN6P3LJUkF+h2ek8WriVMDSl58HpSGyu/L
 izfw==
X-Gm-Message-State: AOJu0YxJw8XiQfBE4T9Syz+5T8dPDHpCklqm9M05+/MUvBplS13rc5BS
 xVXBc7LEgwk4pWkRRNTDPTNOgu2wJ+Vk/b4l2TFcbO5xhCHRRhB6rubzlRTce5EuvXNssg4/wnB
 M9ZN6jjfjCLc9wafd1P2Di+5jqsFtw6o=
X-Gm-Gg: ASbGnctAtFLZJQZUbgOM3f7Jh+eX+IcL73oGfS0jqi+C7VqDmSNBjRDvZF/wz4eyNcN
 2FSikIsxaDS0WQTSbCmQYqCM/zQVIFTPxMNyOJ0t1/GRZsL98Z5rWQzFDEtB3Zjulbf6c0cZNLm
 PjjqDwF5B+jQMHZKnHPXJZLXOnrqlpXgc=
X-Google-Smtp-Source: AGHT+IF9irVdycUOFDMMzBxL5WHXy8juMlYryocoJW5w9RCqIO06T7IikmQbYJyxy5T6va3TJK876Oiuddudm4vtVHM=
X-Received: by 2002:a05:6402:2113:b0:605:3251:a503 with SMTP id
 4fb4d7f45d1cf-6057c60464amr12402366a12.20.1748889903119; Mon, 02 Jun 2025
 11:45:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250529085437.1479-2-oleg.tolmatcev@gmail.com>
In-Reply-To: <20250529085437.1479-2-oleg.tolmatcev@gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 2 Jun 2025 14:44:50 -0400
X-Gm-Features: AX0GCFvGBrnYVzQ0bw27QMmd9QvHkJmEwPNVyPpCJkA_Znd-IxM88RI4ccXwgaY
Message-ID: <CAJSP0QVT56Sx8-T2+qF2LnFksL=feGL+v0CJPnX+ZuQ6iMMMRg@mail.gmail.com>
Subject: Re: [PATCH v2] meson: fix Windows build
To: oltolm <oleg.tolmatcev@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52e.google.com
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

On Thu, May 29, 2025 at 4:55=E2=80=AFAM oltolm <oleg.tolmatcev@gmail.com> w=
rote:
>
> The build failed when run on Windows. I replaced calls to Unix programs
> like =C2=B4cat=C2=B4 and =C2=B4true=C2=B4 with calls to =C2=B4python=C2=
=B4. I wrapped calls to
> =C2=B4os.path.relpath=C2=B4 in try-except because it can fail when the tw=
o paths
> are on different drives. I made sure to convert the Windows paths to
> Unix paths to prevent warnings in generated files.
>
> Signed-off-by: oltolm <oleg.tolmatcev@gmail.com>
> ---
>  contrib/plugins/meson.build         | 2 +-
>  scripts/tracetool/backend/ftrace.py | 9 ++++++++-
>  scripts/tracetool/backend/log.py    | 9 ++++++++-
>  scripts/tracetool/backend/syslog.py | 9 ++++++++-
>  tests/functional/meson.build        | 4 +---
>  tests/include/meson.build           | 2 +-
>  tests/tcg/plugins/meson.build       | 2 +-
>  trace/meson.build                   | 5 +++--
>  8 files changed, 31 insertions(+), 11 deletions(-)
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
> diff --git a/scripts/tracetool/backend/ftrace.py b/scripts/tracetool/back=
end/ftrace.py
> index baed2ae61..81a5f93b3 100644
> --- a/scripts/tracetool/backend/ftrace.py
> +++ b/scripts/tracetool/backend/ftrace.py
> @@ -13,6 +13,7 @@
>
>
>  import os.path
> +from pathlib import PurePath
>
>  from tracetool import out
>
> @@ -30,6 +31,12 @@ def generate_h(event, group):
>      if len(event.args) > 0:
>          argnames =3D ", " + argnames
>
> +    try:
> +        event_filename =3D os.path.relpath(event.filename)
> +    except ValueError:
> +        event_filename =3D event.filename
> +    event_filename =3D PurePath(event_filename).as_posix()

Please do this in one place to avoid code duplication in the backends.
Perhaps event.filename or a new field can hold the properly formatted
value so backends don't need to call relpath() themselves.

I noticed that out_filename is also emitted with #line but, unlike
event.filename, no special processing (relpath() or as_posix()) is
used there. Is it possible to drop relpath() and avoid the whole
issue?

> +
>      out('    {',
>          '        char ftrace_buf[MAX_TRACE_STRLEN];',
>          '        int unused __attribute__ ((unused));',
> @@ -47,7 +54,7 @@ def generate_h(event, group):
>          args=3Devent.args,
>          event_id=3D"TRACE_" + event.name.upper(),
>          event_lineno=3Devent.lineno,
> -        event_filename=3Dos.path.relpath(event.filename),
> +        event_filename=3Devent_filename,
>          fmt=3Devent.fmt.rstrip("\n"),
>          argnames=3Dargnames)
>
> diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend=
/log.py
> index de27b7e62..241fbbbd0 100644
> --- a/scripts/tracetool/backend/log.py
> +++ b/scripts/tracetool/backend/log.py
> @@ -13,6 +13,7 @@
>
>
>  import os.path
> +from pathlib import PurePath
>
>  from tracetool import out
>
> @@ -37,6 +38,12 @@ def generate_h(event, group):
>      else:
>          cond =3D "trace_event_get_state(%s)" % ("TRACE_" + event.name.up=
per())
>
> +    try:
> +        event_filename =3D os.path.relpath(event.filename)
> +    except ValueError:
> +        event_filename =3D event.filename
> +    event_filename =3D PurePath(event_filename).as_posix()
> +
>      out('    if (%(cond)s && qemu_loglevel_mask(LOG_TRACE)) {',
>          '        if (message_with_timestamp) {',
>          '            struct timeval _now;',
> @@ -55,7 +62,7 @@ def generate_h(event, group):
>          '    }',
>          cond=3Dcond,
>          event_lineno=3Devent.lineno,
> -        event_filename=3Dos.path.relpath(event.filename),
> +        event_filename=3Devent_filename,
>          name=3Devent.name,
>          fmt=3Devent.fmt.rstrip("\n"),
>          argnames=3Dargnames)
> diff --git a/scripts/tracetool/backend/syslog.py b/scripts/tracetool/back=
end/syslog.py
> index 012970f6c..2e010e7c9 100644
> --- a/scripts/tracetool/backend/syslog.py
> +++ b/scripts/tracetool/backend/syslog.py
> @@ -13,6 +13,7 @@
>
>
>  import os.path
> +from pathlib import PurePath
>
>  from tracetool import out
>
> @@ -36,6 +37,12 @@ def generate_h(event, group):
>      else:
>          cond =3D "trace_event_get_state(%s)" % ("TRACE_" + event.name.up=
per())
>
> +    try:
> +        event_filename =3D os.path.relpath(event.filename)
> +    except ValueError:
> +        event_filename =3D event.filename
> +    event_filename =3D PurePath(event_filename).as_posix()
> +
>      out('    if (%(cond)s) {',
>          '#line %(event_lineno)d "%(event_filename)s"',
>          '        syslog(LOG_INFO, "%(name)s " %(fmt)s %(argnames)s);',
> @@ -43,7 +50,7 @@ def generate_h(event, group):
>          '    }',
>          cond=3Dcond,
>          event_lineno=3Devent.lineno,
> -        event_filename=3Dos.path.relpath(event.filename),
> +        event_filename=3Devent_filename,
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
> index 3df454935..ebce0154c 100644
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
> +cat =3D [ python, '-c', 'import fileinput;[print(line) for line in filei=
nput.input()]', '@INPUT@' ]
>  trace_events_all =3D custom_target('trace-events-all',
>                                   output: 'trace-events-all',
>                                   input: trace_events_files,
> -                                 command: [ 'cat', '@INPUT@' ],
> +                                 command: [ cat ],
>                                   capture: true,
>                                   install: get_option('trace_backends') !=
=3D [ 'nop' ],
>                                   install_dir: qemu_datadir)
> --
> 2.49.0.windows.1
>
>


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE36CD342F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 07:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slNjv-000359-8a; Tue, 03 Sep 2024 03:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1slNjt-000344-VA
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 03:14:09 -0400
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1slNjr-000845-2H
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 03:14:09 -0400
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-4568acc1ca8so22066041cf.0
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 00:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725347645; x=1725952445; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=V7C5EB4YSJa051GKz5HXLfBnPRh6K09rDtor31BHxfk=;
 b=PQNXJAmMiRP1KfaicqnEq57EFRba+d6LGr5blyuNFhwS6jTrYG1ogFfzU5XrDCwCqx
 +SKC2QqsnS1fl82mf/kl5WYPSXzacRGcOFkbPwuzu+oirX00tMd/xyKL3dMrIk4WzkXd
 Hey5tNPouBf+FcjwahMoTvmNYsXD748z365X9pg3KHqMTF9v4wRPwCHWiMPuGI436BnD
 F/xofMkKQLio8ATQLOPVxg+FWdxgaEDAuNb+FTf+R2qf1d88tpsMTsoVcbIq+g5Gq8BS
 h/JzEUqb8AYLYWz9W6D5mGQt5aR0rgg18xErjD9B+r2Cdd/oN2IaqeMXJn1ZySieumP5
 MbXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725347645; x=1725952445;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V7C5EB4YSJa051GKz5HXLfBnPRh6K09rDtor31BHxfk=;
 b=oxBTm0a5rxAv8EOHHeWYcq/Zbf08m6XZVpU/EUzYZNicOoRR+lxqcF4g6EwkQSOZG/
 IYlDO4Fjon0lX5CZC1QTTOwg+3SJPn9vOP7tBKKZWhjgyf8I5+S7mPmmPColmCbB9EPP
 8CkfbYcAWC1pKbKg+qsm9dfbAOkrItOCAR8kkhtXCsGEdRiLsoCVsgjRbyCztV+GDRIc
 k4QdzvJrf7QU7Yig9bup9aftlBMBxkdOfFbjDEozqJCEYZwvZQqCWT9ZVAKWyV8jz3Sy
 DcbjZdBgtDgd/cwl1LGUJUT3ofApEVjc6sCv70kK62WeVrAa/FUF1nd80T/Njlc31Yk/
 wR/w==
X-Gm-Message-State: AOJu0Yz0ei5AcxnnQGsNvllqn/3Fqf7xkFm3JhzpMXKiIV3RiPOI7T0w
 6/x7dBjBud5xJleULl7MYnRK5VzTYoeqSqqmCMMYZ4lqSnXlED3dH5ThC2MBfjezOX3SRNMO/B3
 eizPCtCOLs5cDQN9QXoZeQbkKYUU=
X-Google-Smtp-Source: AGHT+IEWxVMzery93Qzuo0t5APHu1pCnVeVjFGrB9WSiuWN80c30G7F4Eqjk2YF/rNd0bLMJSlsxFgei3UuCBoueNUc=
X-Received: by 2002:a05:622a:4acf:b0:453:74cd:3c93 with SMTP id
 d75a77b69052e-456f166a284mr178895211cf.9.1725347645246; Tue, 03 Sep 2024
 00:14:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240806010735.2450555-1-tavip@google.com>
In-Reply-To: <20240806010735.2450555-1-tavip@google.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 3 Sep 2024 11:13:53 +0400
Message-ID: <CAJ+F1CLhDSMzT31TCiCuoXegyhAeSNr4Ly3Jm4Aqp9SFYW+kAg@mail.gmail.com>
Subject: Re: [PATCH v4] chardev: add path option for pty backend
To: Octavian Purdila <tavip@google.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, armbru@redhat.com, 
 peter.maydell@linaro.org, berrange@redhat.com, 
 Paulo Neves <ptsneves@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000082563c062131cdd2"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--00000000000082563c062131cdd2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 5:09=E2=80=AFAM Octavian Purdila <tavip@google.com> =
wrote:

> Add path option to the pty char backend which will create a symbolic
> link to the given path that points to the allocated PTY.
>
> This avoids having to make QMP or HMP monitor queries to find out what
> the new PTY device path is.
>
> Based on patch from Paulo Neves:
>
>
> https://patchew.org/QEMU/1548509635-15776-1-git-send-email-ptsneves@gmail=
.com/
>
> Tested with the following invocations that the link is created and
> removed when qemu stops:
>
>   qemu-system-x86_64 -nodefaults -mon chardev=3Dcompat_monitor \
>   -chardev pty,path=3Dtest,id=3Dcompat_monitor0
>
>   qemu-system-x86_64 -nodefaults -monitor pty:test
>
>   # check QMP invocation with path set
>   qemu-system-x86_64 -nodefaults -qmp tcp:localhost:4444,server=3Don,wait=
=3Doff
>   nc localhost 4444
>   > {"execute": "qmp_capabilities"}
>   > {"execute": "chardev-add", "arguments": {"id": "bar", "backend": {
>       "type": "pty", "data": {"path": "test" }}}}
>
>   # check QMP invocation with path not set
>   qemu-system-x86_64 -nodefaults -qmp tcp:localhost:4444,server=3Don,wait=
=3Doff
>   nc localhost 4444
>   > {"execute": "qmp_capabilities"}
>   > {"execute": "chardev-add", "arguments": {"id": "bar", "backend": {
>       "type": "pty", "data": {}}}}
>
> Also tested that when a link path is not passed invocations still work,
> e.g.:
>
>   qemu-system-x86_64 -monitor pty
>
> Co-authored-by: Paulo Neves <ptsneves@gmail.com>
> Signed-off-by: Paulo Neves <ptsneves@gmail.com>
> [OP: rebase and address original patch review comments]
> Signed-off-by: Octavian Purdila <tavip@google.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
> Changes since v3:
>
>   * update documentation with note about user's resposability to check
>     and remove the symlink since it can't be removed on crashes or
>     certain startup errors
>
>   * use a dedicated ChardevPty structure instead of relying on
>     ChardevHostdev
>
> Changes since v2:
>
>  * remove NULL path check, g_strdup() allows NULL inputs
>
> Changes since v1:
>
>  * Keep the original Signed-off-by from Paulo and add one line
>     description with further changes
>
>  * Update commit message with justification for why the new
>     functionality is useful
>
>  * Don't close master_fd when symlink creation fails to avoid double
>     close
>
>  * Update documentation for clarity
>
>  chardev/char-pty.c | 33 +++++++++++++++++++++++++++++++++
>  chardev/char.c     |  5 +++++
>  qapi/char.json     | 27 ++++++++++++++++++++++++++-
>  qemu-options.hx    | 33 +++++++++++++++++++++++++++------
>  4 files changed, 91 insertions(+), 7 deletions(-)
>
> diff --git a/chardev/char-pty.c b/chardev/char-pty.c
> index cc2f7617fe..cbb21b76ae 100644
> --- a/chardev/char-pty.c
> +++ b/chardev/char-pty.c
> @@ -29,6 +29,7 @@
>  #include "qemu/sockets.h"
>  #include "qemu/error-report.h"
>  #include "qemu/module.h"
> +#include "qemu/option.h"
>  #include "qemu/qemu-print.h"
>
>  #include "chardev/char-io.h"
> @@ -41,6 +42,7 @@ struct PtyChardev {
>
>      int connected;
>      GSource *timer_src;
> +    char *path;
>  };
>  typedef struct PtyChardev PtyChardev;
>
> @@ -204,6 +206,12 @@ static void char_pty_finalize(Object *obj)
>      Chardev *chr =3D CHARDEV(obj);
>      PtyChardev *s =3D PTY_CHARDEV(obj);
>
> +    /* unlink symlink */
> +    if (s->path) {
> +        unlink(s->path);
> +        g_free(s->path);
> +    }
> +
>      pty_chr_state(chr, 0);
>      object_unref(OBJECT(s->ioc));
>      pty_chr_timer_cancel(s);
> @@ -330,6 +338,7 @@ static void char_pty_open(Chardev *chr,
>      int master_fd, slave_fd;
>      char pty_name[PATH_MAX];
>      char *name;
> +    char *path =3D backend->u.pty.data->path;
>
>      master_fd =3D qemu_openpty_raw(&slave_fd, pty_name);
>      if (master_fd < 0) {
> @@ -354,12 +363,36 @@ static void char_pty_open(Chardev *chr,
>      g_free(name);
>      s->timer_src =3D NULL;
>      *be_opened =3D false;
> +
> +    /* create symbolic link */
> +    if (path) {
> +        int res =3D symlink(pty_name, path);
> +
> +        if (res !=3D 0) {
> +            error_setg_errno(errp, errno, "Failed to create PTY symlink"=
);
> +        } else {
> +            s->path =3D g_strdup(path);
> +        }
> +    }
> +}
> +
> +static void char_pty_parse(QemuOpts *opts, ChardevBackend *backend,
> +                           Error **errp)
> +{
> +    const char *path =3D qemu_opt_get(opts, "path");
> +    ChardevPty *pty;
> +
> +    backend->type =3D CHARDEV_BACKEND_KIND_PTY;
> +    pty =3D backend->u.pty.data =3D g_new0(ChardevPty, 1);
> +    qemu_chr_parse_common(opts, qapi_ChardevPty_base(pty));
> +    pty->path =3D g_strdup(path);
>  }
>
>  static void char_pty_class_init(ObjectClass *oc, void *data)
>  {
>      ChardevClass *cc =3D CHARDEV_CLASS(oc);
>
> +    cc->parse =3D char_pty_parse;
>      cc->open =3D char_pty_open;
>      cc->chr_write =3D char_pty_chr_write;
>      cc->chr_update_read_handler =3D pty_chr_update_read_handler;
> diff --git a/chardev/char.c b/chardev/char.c
> index 3c43fb1278..404c6b8a4f 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -428,6 +428,11 @@ QemuOpts *qemu_chr_parse_compat(const char *label,
> const char *filename,
>          qemu_opt_set(opts, "path", p, &error_abort);
>          return opts;
>      }
> +    if (strstart(filename, "pty:", &p)) {
> +        qemu_opt_set(opts, "backend", "pty", &error_abort);
> +        qemu_opt_set(opts, "path", p, &error_abort);
> +        return opts;
> +    }
>      if (strstart(filename, "tcp:", &p) ||
>          strstart(filename, "telnet:", &p) ||
>          strstart(filename, "tn3270:", &p) ||
> diff --git a/qapi/char.json b/qapi/char.json
> index 777dde55d9..953d519066 100644
> --- a/qapi/char.json
> +++ b/qapi/char.json
> @@ -431,6 +431,20 @@
>    'base': 'ChardevCommon',
>    'if': 'CONFIG_SPICE_PROTOCOL' }
>
> +##
> +# @ChardevPty:
> +#
> +# Configuration info for pty implementation.
> +#
> +# @path: optional path to create a symbolic link that points to the
> +#     allocated PTY
> +#
> +# Since: 9.2
> +##
> +{ 'struct': 'ChardevPty',
> +  'data': { '*path': 'str' },
> +  'base': 'ChardevCommon' }
> +
>  ##
>  # @ChardevBackendKind:
>  #
> @@ -630,6 +644,17 @@
>  { 'struct': 'ChardevRingbufWrapper',
>    'data': { 'data': 'ChardevRingbuf' } }
>
> +
> +##
> +# @ChardevPtyWrapper:
> +#
> +# @data: Configuration info for pty chardevs
> +#
> +# Since: 9.2
> +##
> +{ 'struct': 'ChardevPtyWrapper',
> +  'data': { 'data': 'ChardevPty' } }
> +
>  ##
>  # @ChardevBackend:
>  #
> @@ -650,7 +675,7 @@
>              'pipe': 'ChardevHostdevWrapper',
>              'socket': 'ChardevSocketWrapper',
>              'udp': 'ChardevUdpWrapper',
> -            'pty': 'ChardevCommonWrapper',
> +            'pty': 'ChardevPtyWrapper',
>              'null': 'ChardevCommonWrapper',
>              'mux': 'ChardevMuxWrapper',
>              'msmouse': 'ChardevCommonWrapper',
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 8ca7f34ef0..08d8f8c559 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3569,7 +3569,7 @@ DEF("chardev", HAS_ARG, QEMU_OPTION_chardev,
>      "-chardev
> console,id=3Did[,mux=3Don|off][,logfile=3DPATH][,logappend=3Don|off]\n"
>      "-chardev
> serial,id=3Did,path=3Dpath[,mux=3Don|off][,logfile=3DPATH][,logappend=3Do=
n|off]\n"
>  #else
> -    "-chardev pty,id=3Did[,mux=3Don|off][,logfile=3DPATH][,logappend=3Do=
n|off]\n"
> +    "-chardev
> pty,id=3Did[,path=3Dpath][,mux=3Don|off][,logfile=3DPATH][,logappend=3Don=
|off]\n"
>      "-chardev
> stdio,id=3Did[,mux=3Don|off][,signal=3Don|off][,logfile=3DPATH][,logappen=
d=3Don|off]\n"
>  #endif
>  #ifdef CONFIG_BRLAPI
> @@ -3808,12 +3808,22 @@ The available backends are:
>
>      ``path`` specifies the name of the serial device to open.
>
> -``-chardev pty,id=3Did``
> -    Create a new pseudo-terminal on the host and connect to it. ``pty``
> -    does not take any options.
> +``-chardev pty,id=3Did[,path=3Dpath]``
> +    Create a new pseudo-terminal on the host and connect to it.
>
>      ``pty`` is not available on Windows hosts.
>
> +    If ``path`` is specified, QEMU will create a symbolic link at
> +    that location which points to the new PTY device.
> +
> +    This avoids having to make QMP or HMP monitor queries to find out
> +    what the new PTY device path is.
> +
> +    Note that while QEMU will remove the symlink when it exits
> +    gracefully, it will not do so in case of crashes or on certain
> +    startup errors. It is recommended that the user checks and removes
> +    the symlink after qemu terminates to account for this.
> +
>  ``-chardev stdio,id=3Did[,signal=3Don|off]``
>      Connect to standard input and standard output of the QEMU process.
>
> @@ -4171,8 +4181,19 @@ SRST
>
>              vc:80Cx24C
>
> -    ``pty``
> -        [Linux only] Pseudo TTY (a new PTY is automatically allocated)
> +    ``pty[:path]``
> +        [Linux only] Pseudo TTY (a new PTY is automatically allocated).
> +
> +        If ``path`` is specified, QEMU will create a symbolic link at
> +        that location which points to the new PTY device.
> +
> +        This avoids having to make QMP or HMP monitor queries to find
> +        out what the new PTY device path is.
> +
> +        Note that while QEMU will remove the symlink when it exits
> +        gracefully, it will not do so in case of crashes or on certain
> +        startup errors. It is recommended that the user checks and
> +        removes the symlink after qemu terminates to account for this.
>
>      ``none``
>          No device is allocated. Note that for machine types which
> --
> 2.46.0.rc2.264.g509ed76dc8-goog
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--00000000000082563c062131cdd2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 6, 2024 at 5:09=E2=80=AFA=
M Octavian Purdila &lt;<a href=3D"mailto:tavip@google.com">tavip@google.com=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
Add path option to the pty char backend which will create a symbolic<br>
link to the given path that points to the allocated PTY.<br>
<br>
This avoids having to make QMP or HMP monitor queries to find out what<br>
the new PTY device path is.<br>
<br>
Based on patch from Paulo Neves:<br>
<br>
<a href=3D"https://patchew.org/QEMU/1548509635-15776-1-git-send-email-ptsne=
ves@gmail.com/" rel=3D"noreferrer" target=3D"_blank">https://patchew.org/QE=
MU/1548509635-15776-1-git-send-email-ptsneves@gmail.com/</a><br>
<br>
Tested with the following invocations that the link is created and<br>
removed when qemu stops:<br>
<br>
=C2=A0 qemu-system-x86_64 -nodefaults -mon chardev=3Dcompat_monitor \<br>
=C2=A0 -chardev pty,path=3Dtest,id=3Dcompat_monitor0<br>
<br>
=C2=A0 qemu-system-x86_64 -nodefaults -monitor pty:test<br>
<br>
=C2=A0 # check QMP invocation with path set<br>
=C2=A0 qemu-system-x86_64 -nodefaults -qmp tcp:localhost:4444,server=3Don,w=
ait=3Doff<br>
=C2=A0 nc localhost 4444<br>
=C2=A0 &gt; {&quot;execute&quot;: &quot;qmp_capabilities&quot;}<br>
=C2=A0 &gt; {&quot;execute&quot;: &quot;chardev-add&quot;, &quot;arguments&=
quot;: {&quot;id&quot;: &quot;bar&quot;, &quot;backend&quot;: {<br>
=C2=A0 =C2=A0 =C2=A0 &quot;type&quot;: &quot;pty&quot;, &quot;data&quot;: {=
&quot;path&quot;: &quot;test&quot; }}}}<br>
<br>
=C2=A0 # check QMP invocation with path not set<br>
=C2=A0 qemu-system-x86_64 -nodefaults -qmp tcp:localhost:4444,server=3Don,w=
ait=3Doff<br>
=C2=A0 nc localhost 4444<br>
=C2=A0 &gt; {&quot;execute&quot;: &quot;qmp_capabilities&quot;}<br>
=C2=A0 &gt; {&quot;execute&quot;: &quot;chardev-add&quot;, &quot;arguments&=
quot;: {&quot;id&quot;: &quot;bar&quot;, &quot;backend&quot;: {<br>
=C2=A0 =C2=A0 =C2=A0 &quot;type&quot;: &quot;pty&quot;, &quot;data&quot;: {=
}}}}<br>
<br>
Also tested that when a link path is not passed invocations still work, e.g=
.:<br>
<br>
=C2=A0 qemu-system-x86_64 -monitor pty<br>
<br>
Co-authored-by: Paulo Neves &lt;<a href=3D"mailto:ptsneves@gmail.com" targe=
t=3D"_blank">ptsneves@gmail.com</a>&gt;<br>
Signed-off-by: Paulo Neves &lt;<a href=3D"mailto:ptsneves@gmail.com" target=
=3D"_blank">ptsneves@gmail.com</a>&gt;<br>
[OP: rebase and address original patch review comments]<br>
Signed-off-by: Octavian Purdila &lt;<a href=3D"mailto:tavip@google.com" tar=
get=3D"_blank">tavip@google.com</a>&gt;<br></blockquote><div><br></div><div=
>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau=
@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div>=C2=A0<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
Changes since v3:<br>
<br>
=C2=A0 * update documentation with note about user&#39;s resposability to c=
heck<br>
=C2=A0 =C2=A0 and remove the symlink since it can&#39;t be removed on crash=
es or<br>
=C2=A0 =C2=A0 certain startup errors<br>
<br>
=C2=A0 * use a dedicated ChardevPty structure instead of relying on<br>
=C2=A0 =C2=A0 ChardevHostdev<br>
<br>
Changes since v2:<br>
<br>
=C2=A0* remove NULL path check, g_strdup() allows NULL inputs <br>
<br>
Changes since v1:<br>
<br>
=C2=A0* Keep the original Signed-off-by from Paulo and add one line<br>
=C2=A0 =C2=A0 description with further changes<br>
<br>
=C2=A0* Update commit message with justification for why the new<br>
=C2=A0 =C2=A0 functionality is useful<br>
<br>
=C2=A0* Don&#39;t close master_fd when symlink creation fails to avoid doub=
le<br>
=C2=A0 =C2=A0 close<br>
<br>
=C2=A0* Update documentation for clarity<br>
<br>
=C2=A0chardev/char-pty.c | 33 +++++++++++++++++++++++++++++++++<br>
=C2=A0chardev/char.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 5 +++++<br>
=C2=A0qapi/char.json=C2=A0 =C2=A0 =C2=A0| 27 ++++++++++++++++++++++++++-<br=
>
=C2=A0qemu-options.hx=C2=A0 =C2=A0 | 33 +++++++++++++++++++++++++++------<b=
r>
=C2=A04 files changed, 91 insertions(+), 7 deletions(-)<br>
<br>
diff --git a/chardev/char-pty.c b/chardev/char-pty.c<br>
index cc2f7617fe..cbb21b76ae 100644<br>
--- a/chardev/char-pty.c<br>
+++ b/chardev/char-pty.c<br>
@@ -29,6 +29,7 @@<br>
=C2=A0#include &quot;qemu/sockets.h&quot;<br>
=C2=A0#include &quot;qemu/error-report.h&quot;<br>
=C2=A0#include &quot;qemu/module.h&quot;<br>
+#include &quot;qemu/option.h&quot;<br>
=C2=A0#include &quot;qemu/qemu-print.h&quot;<br>
<br>
=C2=A0#include &quot;chardev/char-io.h&quot;<br>
@@ -41,6 +42,7 @@ struct PtyChardev {<br>
<br>
=C2=A0 =C2=A0 =C2=A0int connected;<br>
=C2=A0 =C2=A0 =C2=A0GSource *timer_src;<br>
+=C2=A0 =C2=A0 char *path;<br>
=C2=A0};<br>
=C2=A0typedef struct PtyChardev PtyChardev;<br>
<br>
@@ -204,6 +206,12 @@ static void char_pty_finalize(Object *obj)<br>
=C2=A0 =C2=A0 =C2=A0Chardev *chr =3D CHARDEV(obj);<br>
=C2=A0 =C2=A0 =C2=A0PtyChardev *s =3D PTY_CHARDEV(obj);<br>
<br>
+=C2=A0 =C2=A0 /* unlink symlink */<br>
+=C2=A0 =C2=A0 if (s-&gt;path) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 unlink(s-&gt;path);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(s-&gt;path);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0pty_chr_state(chr, 0);<br>
=C2=A0 =C2=A0 =C2=A0object_unref(OBJECT(s-&gt;ioc));<br>
=C2=A0 =C2=A0 =C2=A0pty_chr_timer_cancel(s);<br>
@@ -330,6 +338,7 @@ static void char_pty_open(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0int master_fd, slave_fd;<br>
=C2=A0 =C2=A0 =C2=A0char pty_name[PATH_MAX];<br>
=C2=A0 =C2=A0 =C2=A0char *name;<br>
+=C2=A0 =C2=A0 char *path =3D backend-&gt;u.pty.data-&gt;path;<br>
<br>
=C2=A0 =C2=A0 =C2=A0master_fd =3D qemu_openpty_raw(&amp;slave_fd, pty_name)=
;<br>
=C2=A0 =C2=A0 =C2=A0if (master_fd &lt; 0) {<br>
@@ -354,12 +363,36 @@ static void char_pty_open(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0g_free(name);<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;timer_src =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0*be_opened =3D false;<br>
+<br>
+=C2=A0 =C2=A0 /* create symbolic link */<br>
+=C2=A0 =C2=A0 if (path) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int res =3D symlink(pty_name, path);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (res !=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno, &q=
uot;Failed to create PTY symlink&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;path =3D g_strdup(path);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static void char_pty_parse(QemuOpts *opts, ChardevBackend *backend,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 const char *path =3D qemu_opt_get(opts, &quot;path&quot;);<b=
r>
+=C2=A0 =C2=A0 ChardevPty *pty;<br>
+<br>
+=C2=A0 =C2=A0 backend-&gt;type =3D CHARDEV_BACKEND_KIND_PTY;<br>
+=C2=A0 =C2=A0 pty =3D backend-&gt;u.pty.data =3D g_new0(ChardevPty, 1);<br=
>
+=C2=A0 =C2=A0 qemu_chr_parse_common(opts, qapi_ChardevPty_base(pty));<br>
+=C2=A0 =C2=A0 pty-&gt;path =3D g_strdup(path);<br>
=C2=A0}<br>
<br>
=C2=A0static void char_pty_class_init(ObjectClass *oc, void *data)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevClass *cc =3D CHARDEV_CLASS(oc);<br>
<br>
+=C2=A0 =C2=A0 cc-&gt;parse =3D char_pty_parse;<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;open =3D char_pty_open;<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_write =3D char_pty_chr_write;<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_update_read_handler =3D pty_chr_update_read_=
handler;<br>
diff --git a/chardev/char.c b/chardev/char.c<br>
index 3c43fb1278..404c6b8a4f 100644<br>
--- a/chardev/char.c<br>
+++ b/chardev/char.c<br>
@@ -428,6 +428,11 @@ QemuOpts *qemu_chr_parse_compat(const char *label, con=
st char *filename,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_opt_set(opts, &quot;path&quot;, p, &=
amp;error_abort);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return opts;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 if (strstart(filename, &quot;pty:&quot;, &amp;p)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_opt_set(opts, &quot;backend&quot;, &quot;=
pty&quot;, &amp;error_abort);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_opt_set(opts, &quot;path&quot;, p, &amp;e=
rror_abort);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return opts;<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0if (strstart(filename, &quot;tcp:&quot;, &amp;p) ||<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strstart(filename, &quot;telnet:&quot;, &=
amp;p) ||<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strstart(filename, &quot;tn3270:&quot;, &=
amp;p) ||<br>
diff --git a/qapi/char.json b/qapi/char.json<br>
index 777dde55d9..953d519066 100644<br>
--- a/qapi/char.json<br>
+++ b/qapi/char.json<br>
@@ -431,6 +431,20 @@<br>
=C2=A0 =C2=A0&#39;base&#39;: &#39;ChardevCommon&#39;,<br>
=C2=A0 =C2=A0&#39;if&#39;: &#39;CONFIG_SPICE_PROTOCOL&#39; }<br>
<br>
+##<br>
+# @ChardevPty:<br>
+#<br>
+# Configuration info for pty implementation.<br>
+#<br>
+# @path: optional path to create a symbolic link that points to the<br>
+#=C2=A0 =C2=A0 =C2=A0allocated PTY<br>
+#<br>
+# Since: 9.2<br>
+##<br>
+{ &#39;struct&#39;: &#39;ChardevPty&#39;,<br>
+=C2=A0 &#39;data&#39;: { &#39;*path&#39;: &#39;str&#39; },<br>
+=C2=A0 &#39;base&#39;: &#39;ChardevCommon&#39; }<br>
+<br>
=C2=A0##<br>
=C2=A0# @ChardevBackendKind:<br>
=C2=A0#<br>
@@ -630,6 +644,17 @@<br>
=C2=A0{ &#39;struct&#39;: &#39;ChardevRingbufWrapper&#39;,<br>
=C2=A0 =C2=A0&#39;data&#39;: { &#39;data&#39;: &#39;ChardevRingbuf&#39; } }=
<br>
<br>
+<br>
+##<br>
+# @ChardevPtyWrapper:<br>
+#<br>
+# @data: Configuration info for pty chardevs<br>
+#<br>
+# Since: 9.2<br>
+##<br>
+{ &#39;struct&#39;: &#39;ChardevPtyWrapper&#39;,<br>
+=C2=A0 &#39;data&#39;: { &#39;data&#39;: &#39;ChardevPty&#39; } }<br>
+<br>
=C2=A0##<br>
=C2=A0# @ChardevBackend:<br>
=C2=A0#<br>
@@ -650,7 +675,7 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;pipe&#39;: &#39;Charde=
vHostdevWrapper&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;socket&#39;: &#39;Char=
devSocketWrapper&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;udp&#39;: &#39;Chardev=
UdpWrapper&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;pty&#39;: &#39;ChardevCommo=
nWrapper&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;pty&#39;: &#39;ChardevPtyWr=
apper&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;null&#39;: &#39;Charde=
vCommonWrapper&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;mux&#39;: &#39;Chardev=
MuxWrapper&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;msmouse&#39;: &#39;Cha=
rdevCommonWrapper&#39;,<br>
diff --git a/qemu-options.hx b/qemu-options.hx<br>
index 8ca7f34ef0..08d8f8c559 100644<br>
--- a/qemu-options.hx<br>
+++ b/qemu-options.hx<br>
@@ -3569,7 +3569,7 @@ DEF(&quot;chardev&quot;, HAS_ARG, QEMU_OPTION_chardev=
,<br>
=C2=A0 =C2=A0 =C2=A0&quot;-chardev console,id=3Did[,mux=3Don|off][,logfile=
=3DPATH][,logappend=3Don|off]\n&quot;<br>
=C2=A0 =C2=A0 =C2=A0&quot;-chardev serial,id=3Did,path=3Dpath[,mux=3Don|off=
][,logfile=3DPATH][,logappend=3Don|off]\n&quot;<br>
=C2=A0#else<br>
-=C2=A0 =C2=A0 &quot;-chardev pty,id=3Did[,mux=3Don|off][,logfile=3DPATH][,=
logappend=3Don|off]\n&quot;<br>
+=C2=A0 =C2=A0 &quot;-chardev pty,id=3Did[,path=3Dpath][,mux=3Don|off][,log=
file=3DPATH][,logappend=3Don|off]\n&quot;<br>
=C2=A0 =C2=A0 =C2=A0&quot;-chardev stdio,id=3Did[,mux=3Don|off][,signal=3Do=
n|off][,logfile=3DPATH][,logappend=3Don|off]\n&quot;<br>
=C2=A0#endif<br>
=C2=A0#ifdef CONFIG_BRLAPI<br>
@@ -3808,12 +3808,22 @@ The available backends are:<br>
<br>
=C2=A0 =C2=A0 =C2=A0``path`` specifies the name of the serial device to ope=
n.<br>
<br>
-``-chardev pty,id=3Did``<br>
-=C2=A0 =C2=A0 Create a new pseudo-terminal on the host and connect to it. =
``pty``<br>
-=C2=A0 =C2=A0 does not take any options.<br>
+``-chardev pty,id=3Did[,path=3Dpath]``<br>
+=C2=A0 =C2=A0 Create a new pseudo-terminal on the host and connect to it.<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0``pty`` is not available on Windows hosts.<br>
<br>
+=C2=A0 =C2=A0 If ``path`` is specified, QEMU will create a symbolic link a=
t<br>
+=C2=A0 =C2=A0 that location which points to the new PTY device.<br>
+<br>
+=C2=A0 =C2=A0 This avoids having to make QMP or HMP monitor queries to fin=
d out<br>
+=C2=A0 =C2=A0 what the new PTY device path is.<br>
+<br>
+=C2=A0 =C2=A0 Note that while QEMU will remove the symlink when it exits<b=
r>
+=C2=A0 =C2=A0 gracefully, it will not do so in case of crashes or on certa=
in<br>
+=C2=A0 =C2=A0 startup errors. It is recommended that the user checks and r=
emoves<br>
+=C2=A0 =C2=A0 the symlink after qemu terminates to account for this.<br>
+<br>
=C2=A0``-chardev stdio,id=3Did[,signal=3Don|off]``<br>
=C2=A0 =C2=A0 =C2=A0Connect to standard input and standard output of the QE=
MU process.<br>
<br>
@@ -4171,8 +4181,19 @@ SRST<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vc:80Cx24C<br>
<br>
-=C2=A0 =C2=A0 ``pty``<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 [Linux only] Pseudo TTY (a new PTY is automati=
cally allocated)<br>
+=C2=A0 =C2=A0 ``pty[:path]``<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 [Linux only] Pseudo TTY (a new PTY is automati=
cally allocated).<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 If ``path`` is specified, QEMU will create a s=
ymbolic link at<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 that location which points to the new PTY devi=
ce.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 This avoids having to make QMP or HMP monitor =
queries to find<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 out what the new PTY device path is.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Note that while QEMU will remove the symlink w=
hen it exits<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gracefully, it will not do so in case of crash=
es or on certain<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 startup errors. It is recommended that the use=
r checks and<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 removes the symlink after qemu terminates to a=
ccount for this.<br>
<br>
=C2=A0 =C2=A0 =C2=A0``none``<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0No device is allocated. Note that for mac=
hine types which<br>
-- <br>
2.46.0.rc2.264.g509ed76dc8-goog<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--00000000000082563c062131cdd2--


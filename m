Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACEF7C41513
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 12:04:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE6PS-0007lv-Ns; Mon, 03 Jun 2024 08:03:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sE6PH-0007je-0U
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:03:19 -0400
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sE6PE-00007o-BR
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:03:18 -0400
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-43fd2809723so21806711cf.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 05:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717416194; x=1718020994; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IWuLq3TcXaQD7Y2Zf+LHPPBXzys+zKnX+kbt4rkttxg=;
 b=FlxRpNkci+4mLcoKsFUz8vX+S+ZFhv0oRi+AKu2HE5LiruTijVHAdseeGW1HMRb5gi
 C7Rjdcg8t9ghyojZpCOY4HEVpzDuukXYaqG6M75NesLf8rMfETcVI8XSHQaPuHss4Xd/
 w53fZdp8iGHT9y8pMZUvmgm/0yVsdUGDpP6A+AvFlMlNrlFyQ4L6cyXYqszjbidiNSNL
 WIM9bcQymEg6xsPRWqe4EhrgLYfqKIqdaPkekuqF24U0l3TVKUxPI1N8VP++T4Ldg4Nn
 MU9g+ASldWdMZzrKvxJgpojMT4VX0m4FXhAKllJe4UtFj1iGHu4ov85KG6nLe3nErtaD
 /lGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717416194; x=1718020994;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IWuLq3TcXaQD7Y2Zf+LHPPBXzys+zKnX+kbt4rkttxg=;
 b=i7O6jIyGr4H7utjsuWmmA11nw9DF2AYalgMknFDPSGsoZV8g/r0NQm+eoxOjS9+V4Y
 1onNSQwrnN4UkmTBGC8Xhw5o9zBv6cmanuScB0w0+Gy9wbR8XN2ZSq8mlIT2ypzZZo0E
 1R/ih5jVHgS8lic8DJUjUSaDFmpgZvwUGdupIUD3gy7/QzxOCJ4SQDccy20ExF1C420e
 PSVZUS27wHN1A1WFeo7fktsiWXVjyTHQBDYF+irl/iz8qYu3xECNh/YaUTf1tOF9LdiF
 vzwqv0sH6VLtMtdWdlsHExwY3lpn6Dqh/ZoZ4BQIhTEp34UFBEFVoCe5l4Nd0VlNBRDO
 5h1A==
X-Gm-Message-State: AOJu0YzvArMx2F0TOfDERIIVfPCUEbzxaRpP02dTcudAHZLgJEM5NJEV
 AN/QGr2Pt5u7jcPiGduHfUaxDbzybBGAd/78vA5wV8Q2cMhsSWz+0vvGnmPizewsIUhuwgnINEH
 Uhr6MES9aZVfZdVb4C/rRD0EHrDo=
X-Google-Smtp-Source: AGHT+IHErLzYK+rYSwMqsLGHPdLfxb6Hqh0dobac79yQ6rd7v4pwuw71hza8iUKIwyudeR9OMW6FohLdGhq9ntTfHJA=
X-Received: by 2002:ac8:7f4a:0:b0:43a:f4cf:566d with SMTP id
 d75a77b69052e-43ff5238c52mr99096891cf.11.1717416193328; Mon, 03 Jun 2024
 05:03:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240531175153.2716309-1-tavip@google.com>
In-Reply-To: <20240531175153.2716309-1-tavip@google.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 3 Jun 2024 16:03:01 +0400
Message-ID: <CAJ+F1C+bBypgH4+HTbXNHRijNV-eYacs83-W0GbW_D7L_BKHyg@mail.gmail.com>
Subject: Re: [PATCH] chardev: add path option for pty backend
To: Octavian Purdila <tavip@google.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, armbru@redhat.com, 
 Paulo Neves <ptsneves@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000228d3b0619fb1ec5"
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x834.google.com
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

--000000000000228d3b0619fb1ec5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Sat, Jun 1, 2024 at 1:21=E2=80=AFAM Octavian Purdila <tavip@google.com> =
wrote:

> Add path option to the pty char backend which will create a symbolic
> link to the given path that points to the allocated PTY.
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
> Also tested that when a link path is not passed invocations still work,
> e.g.:
>
>   qemu-system-x86_64 -monitor pty
>
> Co-authored-by: Paulo Neves <ptsneves@gmail.com>
> Signed-off-by: Octavian Purdila <tavip@google.com>
> ---
>  chardev/char-pty.c | 34 ++++++++++++++++++++++++++++++++++
>  chardev/char.c     |  5 +++++
>  qapi/char.json     |  4 ++--
>  qemu-options.hx    | 14 ++++++++++----
>  4 files changed, 51 insertions(+), 6 deletions(-)
>
> diff --git a/chardev/char-pty.c b/chardev/char-pty.c
> index cc2f7617fe..7cd5d34851 100644
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
> +    char *symlink_path;
>  };
>  typedef struct PtyChardev PtyChardev;
>
> @@ -204,6 +206,12 @@ static void char_pty_finalize(Object *obj)
>      Chardev *chr =3D CHARDEV(obj);
>      PtyChardev *s =3D PTY_CHARDEV(obj);
>
> +    /* unlink symlink */
> +    if (s->symlink_path) {
> +        unlink(s->symlink_path);
> +        g_free(s->symlink_path);
> +    }
> +
>      pty_chr_state(chr, 0);
>      object_unref(OBJECT(s->ioc));
>      pty_chr_timer_cancel(s);
> @@ -330,6 +338,7 @@ static void char_pty_open(Chardev *chr,
>      int master_fd, slave_fd;
>      char pty_name[PATH_MAX];
>      char *name;
> +    char *symlink_path =3D backend->u.pty.data->device;
>
>      master_fd =3D qemu_openpty_raw(&slave_fd, pty_name);
>      if (master_fd < 0) {
> @@ -354,12 +363,37 @@ static void char_pty_open(Chardev *chr,
>      g_free(name);
>      s->timer_src =3D NULL;
>      *be_opened =3D false;
> +
> +    /* create symbolic link */
> +    if (symlink_path) {
> +        int res =3D symlink(pty_name, symlink_path);
> +
> +        if (res !=3D 0) {
> +            error_setg_errno(errp, errno, "Failed to create PTY symlink"=
);
> +            close(master_fd);
>

The fd is owned by s->ioc at this point: this will end up in double-close
in finalize.


> +        } else {
> +            s->symlink_path =3D g_strdup(symlink_path);
> +        }
> +    }
> +}
> +
> +static void char_pty_parse(QemuOpts *opts, ChardevBackend *backend,
> +                           Error **errp)
> +{
> +    const char *path =3D qemu_opt_get(opts, "path");
> +    ChardevHostdev *dev;
> +
> +    backend->type =3D CHARDEV_BACKEND_KIND_PTY;
> +    dev =3D backend->u.pty.data =3D g_new0(ChardevHostdev, 1);
> +    qemu_chr_parse_common(opts, qapi_ChardevHostdev_base(dev));
> +    dev->device =3D path ? g_strdup(path) : NULL;
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
>

I am not sure we want to expand compat parsing here, but probably ok.


>      if (strstart(filename, "tcp:", &p) ||
>          strstart(filename, "telnet:", &p) ||
>          strstart(filename, "tn3270:", &p) ||
> diff --git a/qapi/char.json b/qapi/char.json
> index 777dde55d9..4c74bfc437 100644
> --- a/qapi/char.json
> +++ b/qapi/char.json
> @@ -509,7 +509,7 @@
>  ##
>  # @ChardevHostdevWrapper:
>  #
> -# @data: Configuration info for device and pipe chardevs
> +# @data: Configuration info for device, pty and pipe chardevs
>  #
>  # Since: 1.4
>  ##
> @@ -650,7 +650,7 @@
>              'pipe': 'ChardevHostdevWrapper',
>              'socket': 'ChardevSocketWrapper',
>              'udp': 'ChardevUdpWrapper',
> -            'pty': 'ChardevCommonWrapper',
> +            'pty': 'ChardevHostdevWrapper',
>              'null': 'ChardevCommonWrapper',
>              'mux': 'ChardevMuxWrapper',
>              'msmouse': 'ChardevCommonWrapper',
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 8ca7f34ef0..5eec194242 100644
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
> @@ -3808,12 +3808,16 @@ The available backends are:
>
>      ``path`` specifies the name of the serial device to open.
>
> -``-chardev pty,id=3Did``
> +``-chardev pty,id=3Did[,path=3Dpath]``
>      Create a new pseudo-terminal on the host and connect to it. ``pty``
>      does not take any options.
>
>      ``pty`` is not available on Windows hosts.
>
> +    ``path`` specifies the symbolic link path to be created that
> +    points to the pty device.
> +
> +
>  ``-chardev stdio,id=3Did[,signal=3Don|off]``
>      Connect to standard input and standard output of the QEMU process.
>
> @@ -4171,8 +4175,10 @@ SRST
>
>              vc:80Cx24C
>
> -    ``pty``
> -        [Linux only] Pseudo TTY (a new PTY is automatically allocated)
> +    ``pty[:path]``
> +        [Linux only] Pseudo TTY (a new PTY is automatically allocated).
> +        Optionally a path can be given to create a symbolic link to
> +        the allocated PTY.
>
>      ``none``
>          No device is allocated. Note that for machine types which
> --
> 2.45.1.288.g0e0cd299f1-goog
>
>
>
thanks

--=20
Marc-Andr=C3=A9 Lureau

--000000000000228d3b0619fb1ec5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_=
quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Jun 1, 2024 at 1:21=E2=
=80=AFAM Octavian Purdila &lt;<a href=3D"mailto:tavip@google.com">tavip@goo=
gle.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">Add path option to the pty char backend which will create a symbolic=
<br>
link to the given path that points to the allocated PTY.<br>
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
Also tested that when a link path is not passed invocations still work, e.g=
.:<br>
<br>
=C2=A0 qemu-system-x86_64 -monitor pty<br>
<br>
Co-authored-by: Paulo Neves &lt;<a href=3D"mailto:ptsneves@gmail.com" targe=
t=3D"_blank">ptsneves@gmail.com</a>&gt;<br>
Signed-off-by: Octavian Purdila &lt;<a href=3D"mailto:tavip@google.com" tar=
get=3D"_blank">tavip@google.com</a>&gt;<br>
---<br>
=C2=A0chardev/char-pty.c | 34 ++++++++++++++++++++++++++++++++++<br>
=C2=A0chardev/char.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 5 +++++<br>
=C2=A0qapi/char.json=C2=A0 =C2=A0 =C2=A0|=C2=A0 4 ++--<br>
=C2=A0qemu-options.hx=C2=A0 =C2=A0 | 14 ++++++++++----<br>
=C2=A04 files changed, 51 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/chardev/char-pty.c b/chardev/char-pty.c<br>
index cc2f7617fe..7cd5d34851 100644<br>
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
+=C2=A0 =C2=A0 char *symlink_path;<br>
=C2=A0};<br>
=C2=A0typedef struct PtyChardev PtyChardev;<br>
<br>
@@ -204,6 +206,12 @@ static void char_pty_finalize(Object *obj)<br>
=C2=A0 =C2=A0 =C2=A0Chardev *chr =3D CHARDEV(obj);<br>
=C2=A0 =C2=A0 =C2=A0PtyChardev *s =3D PTY_CHARDEV(obj);<br>
<br>
+=C2=A0 =C2=A0 /* unlink symlink */<br>
+=C2=A0 =C2=A0 if (s-&gt;symlink_path) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 unlink(s-&gt;symlink_path);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(s-&gt;symlink_path);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0pty_chr_state(chr, 0);<br>
=C2=A0 =C2=A0 =C2=A0object_unref(OBJECT(s-&gt;ioc));<br>
=C2=A0 =C2=A0 =C2=A0pty_chr_timer_cancel(s);<br>
@@ -330,6 +338,7 @@ static void char_pty_open(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0int master_fd, slave_fd;<br>
=C2=A0 =C2=A0 =C2=A0char pty_name[PATH_MAX];<br>
=C2=A0 =C2=A0 =C2=A0char *name;<br>
+=C2=A0 =C2=A0 char *symlink_path =3D backend-&gt;u.pty.data-&gt;device;<br=
>
<br>
=C2=A0 =C2=A0 =C2=A0master_fd =3D qemu_openpty_raw(&amp;slave_fd, pty_name)=
;<br>
=C2=A0 =C2=A0 =C2=A0if (master_fd &lt; 0) {<br>
@@ -354,12 +363,37 @@ static void char_pty_open(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0g_free(name);<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;timer_src =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0*be_opened =3D false;<br>
+<br>
+=C2=A0 =C2=A0 /* create symbolic link */<br>
+=C2=A0 =C2=A0 if (symlink_path) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int res =3D symlink(pty_name, symlink_path);<b=
r>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (res !=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno, &q=
uot;Failed to create PTY symlink&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 close(master_fd);<br></blockquot=
e><div><br></div><div>The fd is owned by s-&gt;ioc at this point: this will=
 end up in double-close in finalize.<br></div><div>=C2=A0<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;symlink_path =3D g_strdup(=
symlink_path);<br>
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
+=C2=A0 =C2=A0 ChardevHostdev *dev;<br>
+<br>
+=C2=A0 =C2=A0 backend-&gt;type =3D CHARDEV_BACKEND_KIND_PTY;<br>
+=C2=A0 =C2=A0 dev =3D backend-&gt;u.pty.data =3D g_new0(ChardevHostdev, 1)=
;<br>
+=C2=A0 =C2=A0 qemu_chr_parse_common(opts, qapi_ChardevHostdev_base(dev));<=
br>
+=C2=A0 =C2=A0 dev-&gt;device =3D path ? g_strdup(path) : NULL;<br>
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
+=C2=A0 =C2=A0 }<br></blockquote><div><br></div><div>I am not sure we want =
to expand compat parsing here, but probably ok.</div><div>=C2=A0<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0if (strstart(filename, &quot;tcp:&quot;, &amp;p) ||<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strstart(filename, &quot;telnet:&quot;, &=
amp;p) ||<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strstart(filename, &quot;tn3270:&quot;, &=
amp;p) ||<br>
diff --git a/qapi/char.json b/qapi/char.json<br>
index 777dde55d9..4c74bfc437 100644<br>
--- a/qapi/char.json<br>
+++ b/qapi/char.json<br>
@@ -509,7 +509,7 @@<br>
=C2=A0##<br>
=C2=A0# @ChardevHostdevWrapper:<br>
=C2=A0#<br>
-# @data: Configuration info for device and pipe chardevs<br>
+# @data: Configuration info for device, pty and pipe chardevs<br>
=C2=A0#<br>
=C2=A0# Since: 1.4<br>
=C2=A0##<br>
@@ -650,7 +650,7 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;pipe&#39;: &#39;Charde=
vHostdevWrapper&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;socket&#39;: &#39;Char=
devSocketWrapper&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;udp&#39;: &#39;Chardev=
UdpWrapper&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;pty&#39;: &#39;ChardevCommo=
nWrapper&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;pty&#39;: &#39;ChardevHostd=
evWrapper&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;null&#39;: &#39;Charde=
vCommonWrapper&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;mux&#39;: &#39;Chardev=
MuxWrapper&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;msmouse&#39;: &#39;Cha=
rdevCommonWrapper&#39;,<br>
diff --git a/qemu-options.hx b/qemu-options.hx<br>
index 8ca7f34ef0..5eec194242 100644<br>
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
@@ -3808,12 +3808,16 @@ The available backends are:<br>
<br>
=C2=A0 =C2=A0 =C2=A0``path`` specifies the name of the serial device to ope=
n.<br>
<br>
-``-chardev pty,id=3Did``<br>
+``-chardev pty,id=3Did[,path=3Dpath]``<br>
=C2=A0 =C2=A0 =C2=A0Create a new pseudo-terminal on the host and connect to=
 it. ``pty``<br>
=C2=A0 =C2=A0 =C2=A0does not take any options.<br>
<br>
=C2=A0 =C2=A0 =C2=A0``pty`` is not available on Windows hosts.<br>
<br>
+=C2=A0 =C2=A0 ``path`` specifies the symbolic link path to be created that=
<br>
+=C2=A0 =C2=A0 points to the pty device.<br>
+<br>
+<br>
=C2=A0``-chardev stdio,id=3Did[,signal=3Don|off]``<br>
=C2=A0 =C2=A0 =C2=A0Connect to standard input and standard output of the QE=
MU process.<br>
<br>
@@ -4171,8 +4175,10 @@ SRST<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vc:80Cx24C<br>
<br>
-=C2=A0 =C2=A0 ``pty``<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 [Linux only] Pseudo TTY (a new PTY is automati=
cally allocated)<br>
+=C2=A0 =C2=A0 ``pty[:path]``<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 [Linux only] Pseudo TTY (a new PTY is automati=
cally allocated).<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Optionally a path can be given to create a sym=
bolic link to<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 the allocated PTY.<br>
<br>
=C2=A0 =C2=A0 =C2=A0``none``<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0No device is allocated. Note that for mac=
hine types which<br>
-- <br>
2.45.1.288.g0e0cd299f1-goog<br>
<br>
<br>
</blockquote></div><br clear=3D"all"></div><div>thanks</div><div><br></div>=
<div><span class=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" =
class=3D"gmail_signature">Marc-Andr=C3=A9 Lureau<br></div></div></div>

--000000000000228d3b0619fb1ec5--


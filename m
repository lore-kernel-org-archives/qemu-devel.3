Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A4A3CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 14:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4h6p-00062n-IS; Fri, 03 Oct 2025 10:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <murlockkinght@gmail.com>)
 id 1v4h6i-00062Y-SF
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 10:50:05 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <murlockkinght@gmail.com>)
 id 1v4h6a-0008Kb-1x
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 10:50:04 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b07e3a77b72so580414266b.0
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 07:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759502989; x=1760107789; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1MZ6Qy41NQ/n4u9U2BWhKb2Xx+fK9p6KWqnV50Voq7I=;
 b=dPb2hb21Lg7LoZMMsjnQCkCwKdU5VrV0tG3uGFo3/XTB3jeymleYsr9a3bOpaWGAL/
 edaAbmrhOZEatoke0q+sAjWVsmUgMSyC7WU+e37+mW3rUW+IDfpq38LsKc5nb9F2JkIW
 4KLvfd7p+NpJj7c0duuj1juH+KJ0ovADgojVszRhRh6Tfur3ofL5KoT87V1kIyoGQmoS
 RM/4+Rhhpk/Hb+SQnKm/dG9Os0K8mkft/M713ssXfy5xUYYiZZZGr6R4WXXJtdQRYUW+
 pWEvEa2p38Pl6Sr5ED6MXjtUG24xVLbKb8SG5r7hapCPu4bzdNwhsARWyayX7k6WhSGG
 Ytkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759502989; x=1760107789;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1MZ6Qy41NQ/n4u9U2BWhKb2Xx+fK9p6KWqnV50Voq7I=;
 b=MsNzjcKP1F4cmamb4jD1aigo1E4CV0nYx15lTCydfgrFMHfBYM1iys3qdoGViK4Xo6
 n0ueOsUZ04jSR8iFUxfmZRhK1AIa8ZZ0lvxAn+4Lf2fnedd351S3HdCTd+2CnGqZ1LKZ
 9Pw1rfjTAt/cvKHRsmqvJZ/yQ/v14zBiDKY57r0unyJM1gVKFLXaRc+XqCBTP9UmvDRG
 8LUuy3z5+PMtucyGXokajFW4VXX5lZCTImN2oX9LTRn5Wt3Ftr8jTiY/7yL17xsybuKv
 0jtKZGJPqut8p7NlRYrOLowxf1Db3KNbvgA9nVDgrBeJ3UmelxjMjWhWsZS0qU7j/dDw
 PzIQ==
X-Gm-Message-State: AOJu0YyAYWcCpcXZVD848rmnJN6ZnSEzYWAk+hI08l9rtmybDBbYbYic
 4FcmBd97/YGiESPyi5Rw1nKGjWMO9Qazdase+rwYYSIWx6RifzQHGNwrX77NEvPJ6KYt3K0g4QF
 Wf9NqAQ/4rW2l04EbCPhRgyOJ8CDB+qs=
X-Gm-Gg: ASbGncsrL0DUdWJ5fZg1UBrRvkMO8SFjJTrpFRupJ1KnWQRbidbORWtwUebCKrGJGdX
 eBfi51mzBBgAY/wq/5ghWwQkyx61gws+Lv7/nW8qZS8RaHprmIF8dOfoCINkPMGp+223XpVEfAs
 Cwm18yqjDXtiCiO6Ye6DHe7NC5Tm3n2Dc9nwYpCfIjGPoZo3m5uAN3Belu0sQYlCH2B6bdlYF/U
 y5Ttvn1cF0gKvk7sz3Y3XxAT+QRamLYHrMRfthQ
X-Google-Smtp-Source: AGHT+IHdg9gg1GMeqo0ROEw5hEv0UhcibFNJ5pt5NnWfYkKMsP6GNC/TlpMWHOQLzMeq1gcn/oENh/11EIhpQA90B7M=
X-Received: by 2002:a17:907:7e88:b0:b41:c602:c755 with SMTP id
 a640c23a62f3a-b49c3d65ec1mr461555766b.26.1759502988871; Fri, 03 Oct 2025
 07:49:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250808143904.363907-1-murlockkinght@gmail.com>
 <aJhLpNUHVMkIkp3N@begin>
In-Reply-To: <aJhLpNUHVMkIkp3N@begin>
From: Murloc Knight <murlockkinght@gmail.com>
Date: Fri, 3 Oct 2025 21:49:12 +0700
X-Gm-Features: AS18NWAY80Y54Yoh39jJQIpOhz2wC7e3PPeiQLcmfxzFHcsQ-fOU7BkvgaAy7BE
Message-ID: <CACX7FLR66AZzWvtf0KU-BEKpgx7bj+S8VG7c1aR_8=rBAgPedw@mail.gmail.com>
Subject: Re: [PATCH v5] Add a feature for mapping a host unix socket to a
 guest tcp socket
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=murlockkinght@gmail.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hello, I wanted to remind you about my patch. Do I need to make any
further changes?


=D0=B2=D1=81, 10 =D0=B0=D0=B2=D0=B3. 2025=E2=80=AF=D0=B3. =D0=B2 14:35, Sam=
uel Thibault <samuel.thibault@gnu.org>:
>
> Viktor Kurilko, le ven. 08 ao=C3=BBt 2025 21:29:25 +0700, a ecrit:
> > This patch adds the ability to map a host unix socket to a guest tcp so=
cket when
> > using the slirp backend. This feature was added in libslirp version 4.7=
.0.
> >
> > A new syntax for unix socket: -hostfwd=3Dunix:hostpath-[guestaddr]:gues=
tport
> >
> > Signed-off-by: Viktor Kurilko <murlockkinght@gmail.com>
>
> Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
>
> Thanks!
>
> > ---
> > Separator parsing has been moved to protocol-specific blocks.
> > Fixed overwriting of sin_addr.
> > `
> >  docs/system/devices/net.rst |   2 +-
> >  hmp-commands.hx             |   4 +-
> >  net/slirp.c                 | 110 +++++++++++++++++++++++++++---------
> >  qapi/net.json               |   2 +-
> >  qemu-options.hx             |  11 +++-
> >  5 files changed, 97 insertions(+), 32 deletions(-)
> >
> > diff --git a/docs/system/devices/net.rst b/docs/system/devices/net.rst
> > index 7d76fe88c4..13199a44fd 100644
> > --- a/docs/system/devices/net.rst
> > +++ b/docs/system/devices/net.rst
> > @@ -79,7 +79,7 @@ those sockets. To allow ping for GID 100 (usually use=
rs group)::
> >
> >  When using the built-in TFTP server, the router is also the TFTP serve=
r.
> >
> > -When using the ``'-netdev user,hostfwd=3D...'`` option, TCP or UDP
> > +When using the ``'-netdev user,hostfwd=3D...'`` option, TCP, UDP or UN=
IX
> >  connections can be redirected from the host to the guest. It allows fo=
r
> >  example to redirect X11, telnet or SSH connections.
> >
> > diff --git a/hmp-commands.hx b/hmp-commands.hx
> > index d0e4f35a30..64a463b15b 100644
> > --- a/hmp-commands.hx
> > +++ b/hmp-commands.hx
> > @@ -1357,8 +1357,8 @@ ERST
> >      {
> >          .name       =3D "hostfwd_add",
> >          .args_type  =3D "arg1:s,arg2:s?",
> > -        .params     =3D "[netdev_id] [tcp|udp]:[hostaddr]:hostport-[gu=
estaddr]:guestport",
> > -        .help       =3D "redirect TCP or UDP connections from host to =
guest (requires -net user)",
> > +        .params     =3D "[netdev_id] [tcp|udp|unix]:[[hostaddr]:hostpo=
rt|hostpath]-[guestaddr]:guestport",
> > +        .help       =3D "redirect TCP, UDP or UNIX connections from ho=
st to guest (requires -net user)",
> >          .cmd        =3D hmp_hostfwd_add,
> >      },
> >  #endif
> > diff --git a/net/slirp.c b/net/slirp.c
> > index 9657e86a84..1b5e67f9d1 100644
> > --- a/net/slirp.c
> > +++ b/net/slirp.c
> > @@ -795,12 +795,13 @@ void hmp_hostfwd_remove(Monitor *mon, const QDict=
 *qdict)
> >
> >  static int slirp_hostfwd(SlirpState *s, const char *redir_str, Error *=
*errp)
> >  {
> > -    struct sockaddr_in host_addr =3D {
> > -        .sin_family =3D AF_INET,
> > -        .sin_addr =3D {
> > -            .s_addr =3D INADDR_ANY,
> > -        },
> > -    };
> > +    union {
> > +        struct sockaddr_in in;
> > +#if !defined(WIN32) && SLIRP_CHECK_VERSION(4, 7, 0)
> > +        struct sockaddr_un un;
> > +#endif
> > +    } host_addr =3D {0};
> > +
> >      struct sockaddr_in guest_addr =3D {
> >          .sin_family =3D AF_INET,
> >          .sin_addr =3D {
> > @@ -811,9 +812,13 @@ static int slirp_hostfwd(SlirpState *s, const char=
 *redir_str, Error **errp)
> >      int host_port, guest_port;
> >      const char *p;
> >      char buf[256];
> > -    int is_udp;
> > +    int is_udp =3D 0;
> > +#if !defined(WIN32) && SLIRP_CHECK_VERSION(4, 7, 0)
> > +    int is_unix =3D 0;
> > +#endif
> >      const char *end;
> >      const char *fail_reason =3D "Unknown reason";
> > +    socklen_t host_addr_size;
> >
> >      p =3D redir_str;
> >      if (!p || get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
> > @@ -824,30 +829,83 @@ static int slirp_hostfwd(SlirpState *s, const cha=
r *redir_str, Error **errp)
> >          is_udp =3D 0;
> >      } else if (!strcmp(buf, "udp")) {
> >          is_udp =3D 1;
> > -    } else {
> > -        fail_reason =3D "Bad protocol name";
> > -        goto fail_syntax;
> >      }
> > -
> > -    if (get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
> > -        fail_reason =3D "Missing : separator";
> > -        goto fail_syntax;
> > +#if !defined(WIN32) && SLIRP_CHECK_VERSION(4, 7, 0)
> > +    else if (!strcmp(buf, "unix")) {
> > +        is_unix =3D 1;
> >      }
> > -    if (buf[0] !=3D '\0' && !inet_aton(buf, &host_addr.sin_addr)) {
> > -        fail_reason =3D "Bad host address";
> > +#endif
> > +    else {
> > +        fail_reason =3D "Bad protocol name";
> >          goto fail_syntax;
> >      }
> >
> > -    if (get_str_sep(buf, sizeof(buf), &p, '-') < 0) {
> > -        fail_reason =3D "Bad host port separator";
> > -        goto fail_syntax;
> > -    }
> > -    err =3D qemu_strtoi(buf, &end, 0, &host_port);
> > -    if (err || host_port < 0 || host_port > 65535) {
> > -        fail_reason =3D "Bad host port";
> > -        goto fail_syntax;
> > +#if !defined(WIN32) && SLIRP_CHECK_VERSION(4, 7, 0)
> > +    if (is_unix) {
> > +        if (get_str_sep(buf, sizeof(buf), &p, '-') < 0) {
> > +            fail_reason =3D "Missing - separator";
> > +            goto fail_syntax;
> > +        }
> > +        if (buf[0] =3D=3D '\0') {
> > +            fail_reason =3D "Missing unix socket path";
> > +            goto fail_syntax;
> > +        }
> > +        if (buf[0] !=3D '/') {
> > +            fail_reason =3D "unix socket path must be absolute";
> > +            goto fail_syntax;
> > +        }
> > +
> > +        size_t path_len =3D strlen(buf);
> > +        if (path_len > sizeof(host_addr.un.sun_path) - 1) {
> > +            fail_reason =3D "Unix socket path is too long";
> > +            goto fail_syntax;
> > +        }
> > +
> > +        struct stat st;
> > +        if (stat(buf, &st) =3D=3D 0) {
> > +            if (!S_ISSOCK(st.st_mode)) {
> > +                fail_reason =3D "file exists and it's not unix socket"=
;
> > +                goto fail_syntax;
> > +            }
> > +
> > +            if (unlink(buf) < 0) {
> > +                error_setg_errno(errp, errno, "Failed to unlink '%s'",=
 buf);
> > +                goto fail_syntax;
> > +            }
> > +        }
> > +        host_addr.un.sun_family =3D AF_UNIX;
> > +        memcpy(host_addr.un.sun_path, buf, path_len);
> > +        host_addr_size =3D sizeof(host_addr.un);
> > +    } else
> > +#endif
> > +    {
> > +        host_addr.in.sin_family =3D AF_INET;
> > +        host_addr.in.sin_addr.s_addr =3D INADDR_ANY;
> > +
> > +        if (get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
> > +            fail_reason =3D "Missing : separator";
> > +            goto fail_syntax;
> > +        }
> > +
> > +        if (buf[0] !=3D '\0' && !inet_aton(buf, &host_addr.in.sin_addr=
)) {
> > +            fail_reason =3D "Bad host address";
> > +            goto fail_syntax;
> > +        }
> > +
> > +        if (get_str_sep(buf, sizeof(buf), &p, '-') < 0) {
> > +            fail_reason =3D "Bad host port separator";
> > +            goto fail_syntax;
> > +        }
> > +
> > +        err =3D qemu_strtoi(buf, &end, 0, &host_port);
> > +        if (err || host_port < 0 || host_port > 65535) {
> > +            fail_reason =3D "Bad host port";
> > +            goto fail_syntax;
> > +        }
> > +
> > +        host_addr.in.sin_port =3D htons(host_port);
> > +        host_addr_size =3D sizeof(host_addr.in);
> >      }
> > -    host_addr.sin_port =3D htons(host_port);
> >
> >      if (get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
> >          fail_reason =3D "Missing guest address";
> > @@ -867,7 +925,7 @@ static int slirp_hostfwd(SlirpState *s, const char =
*redir_str, Error **errp)
> >
> >  #if SLIRP_CHECK_VERSION(4, 5, 0)
> >      err =3D slirp_add_hostxfwd(s->slirp,
> > -            (struct sockaddr *) &host_addr, sizeof(host_addr),
> > +            (struct sockaddr *) &host_addr, host_addr_size,
> >              (struct sockaddr *) &guest_addr, sizeof(guest_addr),
> >              is_udp ? SLIRP_HOSTFWD_UDP : 0);
> >  #else
> > diff --git a/qapi/net.json b/qapi/net.json
> > index 78bcc9871e..60d196afe5 100644
> > --- a/qapi/net.json
> > +++ b/qapi/net.json
> > @@ -281,7 +281,7 @@
> >  #
> >  # @smbserver: IP address of the built-in SMB server
> >  #
> > -# @hostfwd: redirect incoming TCP or UDP host connections to guest
> > +# @hostfwd: redirect incoming TCP, UDP or UNIX host connections to gue=
st
> >  #     endpoints
> >  #
> >  # @guestfwd: forward guest TCP connections
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index ab23f14d21..86a70e0315 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -3317,8 +3317,8 @@ SRST
> >
> >          Note that a SAMBA server must be installed on the host OS.
> >
> > -    ``hostfwd=3D[tcp|udp]:[hostaddr]:hostport-[guestaddr]:guestport``
> > -        Redirect incoming TCP or UDP connections to the host port
> > +    ``hostfwd=3D[tcp|udp|unix]:[[hostaddr]:hostport|hostpath]-[guestad=
dr]:guestport``
> > +        Redirect incoming TCP, UDP or UNIX connections to the host por=
t
> >          hostport to the guest IP address guestaddr on guest port
> >          guestport. If guestaddr is not specified, its value is x.x.x.1=
5
> >          (default first address given by the built-in DHCP server). By
> > @@ -3348,6 +3348,13 @@ SRST
> >          Then when you use on the host ``telnet localhost 5555``, you
> >          connect to the guest telnet server.
> >
> > +        To redirect host unix socket /tmp/vm to guest tcp socket 23 us=
e
> > +        following:
> > +
> > +        .. parsed-literal::
> > +            # on the host
> > +            |qemu_system| -nic user,hostfwd=3Dunix:/tmp/vm-:23
> > +
> >      ``guestfwd=3D[tcp]:server:port-dev``; \ ``guestfwd=3D[tcp]:server:=
port-cmd:command``
> >          Forward guest TCP connections to the IP address server on port
> >          port to the character device dev or to a program executed by
> > --
> > 2.50.1
> >
>
> --
> Samuel
> <i8b4uUnderground> d-_-b
> <BonyNoMore> how u make that inverted b?
> <BonyNoMore> wait
> <BonyNoMore> never mind


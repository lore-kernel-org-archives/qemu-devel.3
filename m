Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1CD606A329
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I6Z2kCWS;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=PlFsp8H0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNpgO-0002f7-JL; Mon, 02 Nov 2026 05:54:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xNpgK-0002ek-W4
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 05:54:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xNpgJ-0000Yr-6D
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 05:54:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793616866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kr12SMAjcDdzuEupunqGKAP9WuBe8aOoelAJ+bEEiMA=;
 b=I6Z2kCWSJj27eTUrKTGWC3MbC4OAt5PJS9+VUNJ2O7Gul2WGJ/+Km53+RfH+b6DfiMiZO4
 eQjULjHMBtQNubvujGQZoRM5s4kH4uY2JLliUeN84/U59kliBp08AabBzgN5BKVZzVKRLy
 Yp3b/v+qREuH3oDumdrg8OKlwc8J9gY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-QsgUGj9fMFutkqx3Pkd_jw-1; Mon, 02 Nov 2026 05:54:22 -0500
X-MC-Unique: QsgUGj9fMFutkqx3Pkd_jw-1
X-Mimecast-MFC-AGG-ID: QsgUGj9fMFutkqx3Pkd_jw_1793616862
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91c84af45c8so59500646d6.3
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 02:54:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793616861; cv=none;
 d=google.com; s=arc-20260327;
 b=LXSLisRTctpXCOvZqeH2m7e6WY7IRuD/shspYNBdMt1Vm4T26z1Zq2zuMFcpwc6NrB
 b8VCOVpKdpi0xMtPK5CJw8ptTbrJQ+zwN8+VubmbBgp1qxj8flB4SFwE/6T5F/Wc1Q3C
 eyK3COo6bYRLCxsByqfXG8IqqMBZdHk0u7sEl9oiQEP40lPt9uOhvyyvCeG3Rq5w3UA8
 of8L/bn5b9Xjn1JaNON3pwoSWTTr4qaIGmzXL5CxbKjlEZXHVlBGjh2XIW10vJaS3o7B
 EryBrd+AOrrS44Qg/5RIwI+2la04SeP6RXQ1WwASpGRLIppt6Bf0zpzl2ukJWhRKYXzb
 SQ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=kr12SMAjcDdzuEupunqGKAP9WuBe8aOoelAJ+bEEiMA=;
 fh=LkIpcL4SVZHj4JXbRbRwAiY4CnOTDXaWD15+HxCZXZc=;
 b=sgeMr7Fx4HpM1EEGF2NVsYhHMYETWQoLAtU6Xzx20jT6xIPkOB5KLweC2P94UjUJHR
 yLSy56gnWxJS5l0Up18CTr0qde4wm2R1aQHXnbep62bw+730vwMulhB2qqonE8DnAec+
 iaDYZVEsGiqnHXSkF7OiEtNDCOzU/OTOI+3mlO7UfqY6Pg7t5CHYHpbCgnmB/u6aKig0
 VzosqAWWn/oDRM+Cxu5wzyxmtlIm+MLi69qslVThgB4epbU0uUWaJ2xxfvOxlrl+1jNP
 /rm5Bf94y26uPcdIU2hyjcJ2hshCP5w9Xo0RGfBYD3NSbzWT3irPXW2DgthBaJ9zxzRx
 qawQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793616861; x=1794221661; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kr12SMAjcDdzuEupunqGKAP9WuBe8aOoelAJ+bEEiMA=;
 b=PlFsp8H0XmHsqYON2iD8+tfqnYBdvDdo1HHTs6zOiRAS46P6q4NJZEwHChxmIPvDuF
 splKtwx84QRs+Y6Y66cKxHIGnD4E01GFmjqLx5FOml2PKBXpEdJ0Em35WAGYt6+3LdX+
 wjshPBCGoQLYjy9WomZyhibYxx0wtt9SC5I1hE1BhQzZVKmsd46fHc5s2HKa0qBld5E7
 xnlvPomwgePotInqdtfr4gx2n2nUNpppICjwkXgvF13TP5NNMGf3+fnjrvkI7URH6bUO
 pBwopBIoOJzg1D4oygPpNnb0wihdPfpBBq+s7ruvNVfJgnxnK7zUsJ7FJWdmjFSKhMaH
 47UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793616861; x=1794221661;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kr12SMAjcDdzuEupunqGKAP9WuBe8aOoelAJ+bEEiMA=;
 b=p6ow+IDr8ZgzneQeic6vp+GoXv+xnvm+NLb0gfaoSfCKz9Ykgn1EvPA4k2QVNFVszA
 iyLh+D2Zq3JR1Vg1PL1aaukQcZpHvVVpKwZN5i6L2q6X95KKcco9C8bXgUhFVmgM5rxG
 laE7YHfjXfEyk3uGEnhjTdvHxVAHfoTujcjWIbZGmc/Z63oAVDs8NXIvW6mfRnM/YLiW
 cyYwI7fKxPYQLszzHb7J0himYTSEzrbkpm2KTNkzdUu/MwxhfGtRrcXN3Ryf0fnup5o7
 tUAS3F7yTz1DD/urRIojDkZeRNSKezwQo8hIP3s9Fn9d2PCX1uI/S38Yaahith23VeVk
 zosg==
X-Gm-Message-State: APuU4Z++5sBcwqe6aBm2H/ZK+YaJsA7EsXzgz8gl7wUSWvhCo6F1eM6e
 BIhwcBTtOfsPZ+zFnE9YzYp6yQfxh1ZXZKOJOfuqKHuzOUuHkdogNBoJjq8tU+Tx4TEum7NzEKd
 XnIOIXiSiO0P280nekqSQBZUmJNqj6JdPVC8Clwsc4qYUuKo+pAcvzQV0yLE3Xl7BxdgfMqX4yc
 vU7HBOxNjrNt3Eh9Zjfk72dD11aGLPs/o=
X-Gm-Gg: AYBFou1ecfFuDi9EJ9iSMaDpYaaYR148mjvbAQt1U71PW3hKcGXBX0CTkUMeysj4vpF
 FDW/+QvrwbmO5EEH38LTM2M48BdOGrgr1ikBrp5ZAkVQxwlZ5O9EXs/jM0H8y9OW1dPqhcReogw
 Un8ygVQrzf+mJdZ0/+J9Wq2+wDgpMqPwHyLIps3Tzoxf5tBFcCDgYkQiv3BieVVuCiE0GG14MTd
 k6nEQk6avbc2w4DSjt370f1iYWk05Wa3d+raGMn4ZsUfgV/BFx4HtyMlDukd4/wesKusNY5ykvS
X-Received: by 2002:a05:6214:5d8e:b0:91c:914c:890 with SMTP id
 6a1803df08f44-91ca4b0e34amr159337476d6.22.1793616861435; 
 Mon, 02 Nov 2026 02:54:21 -0800 (PST)
X-Received: by 2002:a05:6214:5d8e:b0:91c:914c:890 with SMTP id
 6a1803df08f44-91ca4b0e34amr159337006d6.22.1793616860898; Mon, 02 Nov 2026
 02:54:20 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261017201905.12211-1-samm@net-art.cz>
In-Reply-To: <20261017201905.12211-1-samm@net-art.cz>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Mon, 2 Nov 2026 12:54:09 +0200
X-Gm-Features: AclHuK9p0DgoaE8aXUoBuUanZTe-1-7iRcjrKMK7dE7zXrIBcHGA6dN3wU0a3xA
Message-ID: <CAPMcbCrngKH_twdAiBaXX4L1XP11_8XecTMiwEJA0=80s4LdUg@mail.gmail.com>
Subject: Re: [PATCH] qga: set FreeBSD virtio-serial channel to raw mode
To: Oleksij Samorukov <samm@net-art.cz>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-stable@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000db827a065f48f79c"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000db827a065f48f79c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

On Sat, Oct 17, 2026 at 11:22=E2=80=AFPM Oleksij Samorukov <samm@net-art.cz=
> wrote:

> On FreeBSD the virtio-console port is a tty, unlike Linux's
> /dev/virtio-ports which is a character device.  It defaults to canonical
> mode with echo and software flow control enabled, so the QGA stream
> protocol does not work: the initial guest-sync handshake is held in the
> line discipline and the host eventually times out.
>
> The existing FreeBSD-specific code only clears ECHO.  Configure the port
> the same way as the ISA serial path: disable canonical mode, echo and
> software flow control, and set VMIN/VTIME.  Use TCSANOW instead of
> TCSAFLUSH so a handshake that arrives between open() and tcsetattr() is
> not discarded.
>
> Tested on FreeBSD 15.1 aarch64 under UTM/QEMU.  Before the change
> utmctl ip-address timed out and the guest received zero bytes; after the
> change QGA commands and guest-set-time work.
>
> Cc: qemu-stable@nongnu.org
> Fixes: c6cd588bb3a29a831c862780631a7d2145ade5de ("qga: Add initial FreeBS=
D
> support")
> Signed-off-by: Oleksij Samorukov <samm@net-art.cz>
> ---
>  qga/channel-posix.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/qga/channel-posix.c b/qga/channel-posix.c
> index 9ccc8b7..c6dfb2d 100644
> --- a/qga/channel-posix.c
> +++ b/qga/channel-posix.c
> @@ -156,9 +156,10 @@ static gboolean ga_channel_open(GAChannel *c, const
> gchar *path,
>  #endif
>  #ifdef __FreeBSD__
>          /*
> -         * In the default state channel sends echo of every command to a
> -         * client. The client program doesn't expect this and raises an
> -         * error. Suppress echo by resetting ECHO terminal flag.
> +         * FreeBSD's virtio-console port is a tty (unlike Linux's
> +         * /dev/virtio-ports, which is a character device) and defaults =
to
> +         * canonical mode with echo and software flow control enabled.
> +         * QGA uses a raw stream protocol, so put the port in raw mode.
>           */
>          struct termios tio;
>          if (tcgetattr(fd, &tio) < 0) {
> @@ -166,8 +167,19 @@ static gboolean ga_channel_open(GAChannel *c, const
> gchar *path,
>              close(fd);
>              return false;
>          }
> -        tio.c_lflag &=3D ~ECHO;
> -        if (tcsetattr(fd, TCSAFLUSH, &tio) < 0) {
> +        tio.c_iflag &=3D ~(IGNBRK | BRKINT | IGNPAR | PARMRK | INPCK |
> ISTRIP |
> +                         INLCR | IGNCR | ICRNL | IXON | IXOFF | IXANY |
> +                         IMAXBEL);
> +        tio.c_oflag =3D 0;
> +        tio.c_lflag =3D 0;
> +        tio.c_cflag |=3D CLOCAL | CREAD;
> +        tio.c_cc[VMIN] =3D 1;
> +        tio.c_cc[VTIME] =3D 0;
> +        /*
> +         * Use TCSANOW rather than TCSAFLUSH: the host may already have
> sent
> +         * the initial handshake between open() and tcsetattr().
> +         */
> +        if (tcsetattr(fd, TCSANOW, &tio) < 0) {
>              error_setg_errno(errp, errno, "error setting channel termios
> attrs");
>              close(fd);
>              return false;
> --
> 2.54.0 (Apple Git-157)
>
>
>

--000000000000db827a065f48f79c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com">kkostiuk@redhat.com</a>&gt;</div><br><div class=3D"gmail_q=
uote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, O=
ct 17, 2026 at 11:22=E2=80=AFPM Oleksij Samorukov &lt;<a href=3D"mailto:sam=
m@net-art.cz">samm@net-art.cz</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">On FreeBSD the virtio-console port is a tty, u=
nlike Linux&#39;s<br>
/dev/virtio-ports which is a character device.=C2=A0 It defaults to canonic=
al<br>
mode with echo and software flow control enabled, so the QGA stream<br>
protocol does not work: the initial guest-sync handshake is held in the<br>
line discipline and the host eventually times out.<br>
<br>
The existing FreeBSD-specific code only clears ECHO.=C2=A0 Configure the po=
rt<br>
the same way as the ISA serial path: disable canonical mode, echo and<br>
software flow control, and set VMIN/VTIME.=C2=A0 Use TCSANOW instead of<br>
TCSAFLUSH so a handshake that arrives between open() and tcsetattr() is<br>
not discarded.<br>
<br>
Tested on FreeBSD 15.1 aarch64 under UTM/QEMU.=C2=A0 Before the change<br>
utmctl ip-address timed out and the guest received zero bytes; after the<br=
>
change QGA commands and guest-set-time work.<br>
<br>
Cc: <a href=3D"mailto:qemu-stable@nongnu.org" target=3D"_blank">qemu-stable=
@nongnu.org</a><br>
Fixes: c6cd588bb3a29a831c862780631a7d2145ade5de (&quot;qga: Add initial Fre=
eBSD support&quot;)<br>
Signed-off-by: Oleksij Samorukov &lt;<a href=3D"mailto:samm@net-art.cz" tar=
get=3D"_blank">samm@net-art.cz</a>&gt;<br>
---<br>
=C2=A0qga/channel-posix.c | 22 +++++++++++++++++-----<br>
=C2=A01 file changed, 17 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/qga/channel-posix.c b/qga/channel-posix.c<br>
index 9ccc8b7..c6dfb2d 100644<br>
--- a/qga/channel-posix.c<br>
+++ b/qga/channel-posix.c<br>
@@ -156,9 +156,10 @@ static gboolean ga_channel_open(GAChannel *c, const gc=
har *path,<br>
=C2=A0#endif<br>
=C2=A0#ifdef __FreeBSD__<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* In the default state channel sends ech=
o of every command to a<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* client. The client program doesn&#39;t=
 expect this and raises an<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* error. Suppress echo by resetting ECHO=
 terminal flag.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* FreeBSD&#39;s virtio-console port is a=
 tty (unlike Linux&#39;s<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* /dev/virtio-ports, which is a characte=
r device) and defaults to<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* canonical mode with echo and software =
flow control enabled.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* QGA uses a raw stream protocol, so put=
 the port in raw mode.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct termios tio;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (tcgetattr(fd, &amp;tio) &lt; 0) {<br>
@@ -166,8 +167,19 @@ static gboolean ga_channel_open(GAChannel *c, const gc=
har *path,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0close(fd);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 tio.c_lflag &amp;=3D ~ECHO;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tcsetattr(fd, TCSAFLUSH, &amp;tio) &lt; 0)=
 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tio.c_iflag &amp;=3D ~(IGNBRK | BRKINT | IGNPA=
R | PARMRK | INPCK | ISTRIP |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0INLCR | IGNCR | ICRNL | IXON | IXOFF | IXANY |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0IMAXBEL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tio.c_oflag =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tio.c_lflag =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tio.c_cflag |=3D CLOCAL | CREAD;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tio.c_cc[VMIN] =3D 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tio.c_cc[VTIME] =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Use TCSANOW rather than TCSAFLUSH: the=
 host may already have sent<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* the initial handshake between open() a=
nd tcsetattr().<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tcsetattr(fd, TCSANOW, &amp;tio) &lt; 0) {=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg_errno(errp, errn=
o, &quot;error setting channel termios attrs&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0close(fd);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
-- <br>
2.54.0 (Apple Git-157)<br>
<br>
<br>
</blockquote></div>

--000000000000db827a065f48f79c--



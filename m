Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B97A5C30653
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jul 2024 16:30:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQUl9-0003pI-Ii; Sun, 07 Jul 2024 12:29:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sQUl8-0003o4-IF
 for qemu-devel@nongnu.org; Sun, 07 Jul 2024 12:29:06 -0400
Received: from mail-vs1-xe35.google.com ([2607:f8b0:4864:20::e35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sQUl5-0001Tz-Lo
 for qemu-devel@nongnu.org; Sun, 07 Jul 2024 12:29:05 -0400
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-48ffc762640so721838137.3
 for <qemu-devel@nongnu.org>; Sun, 07 Jul 2024 09:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720369742; x=1720974542; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1hsKKJZyK+27WOZsja2QvhYgLybGITDAal1mMaaf/V0=;
 b=gKDnPDbF4Ewkf8UlyN78mwgchlAeASfG5hJ5U1SnO49VC9eKMxmx0Mf4zhf2VXdbAZ
 5RUfaglb8ATe77RaA5eBeCCiklg1U5pG6msF89XJ9SWZxh3klMfEcA9HVXmOW0sgxf1z
 p+rLu71bFSvVaTFGNCC9i+k/wnDF5h5HS8ms6qcnS+uaC8rpgQXnNOKLyPOGFzfRgDKr
 70MZ1hTKQT9gQth+zW/k0Be7A/JYikwcODYs31/+nQ2h9WRoZ62qT1IIgYSKC2xGz0Te
 RPG3ocM/yaX18U76uTHPXhJ/t+a3o9QUQ2scwCFINM4OT9LkS0bAYp78jCCpKY6x7X/F
 4gkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720369742; x=1720974542;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1hsKKJZyK+27WOZsja2QvhYgLybGITDAal1mMaaf/V0=;
 b=KqmvuhnO2Gj6NlZG61Z5b8hyd07znseSsebz07eq1/qfBMv9nqijwb861c8IHcQf2U
 vOsWUFUsocK0/YhD+ALvlPK3SO43GTdh40VpzkCYhME5Ri6g49axWya5nur/954b8OvF
 FDyMZcO22Vn3C15r2kxf1Cln90eoB9mV+escXELtthikm+NyznzPHQflWGjcZ021Nwfa
 8UL43usjD4YKYaV4EDV1INC0oeKE6afiTjtvaQY2voNpN43fTW7KJZ5osq1gvIQxkP3Q
 ZWxUL5Zt4lccwBHn91ud27s/9h5+UjSb9nZvJlXXH7go/O3ayCx9EYyMhuXz8ltjE13n
 uSvw==
X-Gm-Message-State: AOJu0Yx3HL/ypq4zL5oCghes0kCpvo1ScLyvUfQjGytMaRcqYyqHlpWv
 KPUKkYVQC5h94K301wP8pZCgIi5miSrPBl8mT/gRljKWsrh5BOSWpJLH/H9aqHdBBtdZ05FvXPv
 +CrSJtSTfueIP/MT5Jgcrpv4Ne8c=
X-Google-Smtp-Source: AGHT+IEkC5ip8LlvOTXifh/zB591Xa2BN2hhGOLgtagxtC1/tAH8mac9o1ZKSJbtDmRxMe+tME3aR4N4te+pkR/k/ak=
X-Received: by 2002:a67:ff98:0:b0:48f:e267:53dc with SMTP id
 ada2fe7eead31-48fee66021cmr8973343137.8.1720369742062; Sun, 07 Jul 2024
 09:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240707111940.232549-3-lrh2000@pku.edu.cn>
In-Reply-To: <20240707111940.232549-3-lrh2000@pku.edu.cn>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sun, 7 Jul 2024 20:28:50 +0400
Message-ID: <CAJ+F1CKHve-3SOzFOLBCKo-5yQDuo7QpSqxw9N5NtPbg7bdQdA@mail.gmail.com>
Subject: Re: [PATCH] char-mux: Don't overwrite the receive buffer
To: Ruihan Li <lrh2000@pku.edu.cn>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000005bad9b061caacb78"
Received-SPF: pass client-ip=2607:f8b0:4864:20::e35;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-vs1-xe35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000005bad9b061caacb78
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Sun, Jul 7, 2024 at 3:26=E2=80=AFPM Ruihan Li <lrh2000@pku.edu.cn> wrote=
:

> This commit fixes a bug that causes incorrect results when pasting more
> than 32 bytes, the size of the receive buffer b->buffer, into the virtio
> console.
>
> Example (note that the last 32 bytes are always correct, but something
> goes wrong just before the last 32 bytes):
>
>         Pasting
> abcdefghijklmnopqrstuvwxyz1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()
>         Received
> abcdefg)EFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()EFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()
>
> The root cause of this bug is as follows:
>
> The mux_chr_read function passes the data to the backend via
> be->chr_read one byte at a time, either directly or via another
> mux_chr_accept_input method. However, if the receive buffer is full,
> there is a chance that the mux_chr_can_read method will return more than
> one byte, because in this case the method directly returns whatever
> be->chr_can_read returns.
>
> This is problematic because if mux_chr_read passes a byte to the backend
> by calling be->chr_read, it will consume the entire backend buffer, at
> least in the case of virtio. Once all backend buffers are used,
> mux_chr_read writes all remaining bytes to the receive buffer d->buffer,
>

My understanding of the code execution is:
- mux_chr_can_read() returns be->chr_can_read(), say N, because d->buffer
is already MUX_BUFFER_SIZE.
- mux_chr_read() is called with N bytes
- mux_chr_accept_input() flushes d->buffer, writing MUX_BUFFER_SIZE
- be should still accept N-MUX_BUFFER_SIZE
- mux_proc_byte() loops for N bytes
- chr_read() should accept the N-MUX_BUFFER_SIZE
- d->buffer is then filled with the remaining MUX_BUFFER_SIZE


> but the number of remaining bytes can be larger than the buffer size.
>

By the above description, I don't see how it happens.

This does not lead to security problems since it is a ring buffer, but
> it does mess up the receive data.
>
> This can be fixed by having mux_chr_can_read return either zero or one.
> This fix is not very efficient, but it is quite reasonable since
> mux_chr_read also passes the data to the backend one byte at a time.
>

Could you share your testing setup? Even better if you could write a test!


thanks


> Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>
> ---
>  chardev/char-mux.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/chardev/char-mux.c b/chardev/char-mux.c
> index ee2d47b..5c6eea2 100644
> --- a/chardev/char-mux.c
> +++ b/chardev/char-mux.c
> @@ -210,8 +210,8 @@ static int mux_chr_can_read(void *opaque)
>          return 1;
>      }
>
> -    if (be && be->chr_can_read) {
> -        return be->chr_can_read(be->opaque);
> +    if (be && be->chr_can_read && be->chr_can_read(be->opaque)) {
> +        return 1;
>      }
>
>      return 0;
> --
> 2.45.2
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--0000000000005bad9b061caacb78
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Jul 7, 2024 at 3:26=E2=80=
=AFPM Ruihan Li &lt;<a href=3D"mailto:lrh2000@pku.edu.cn">lrh2000@pku.edu.c=
n</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>This commit fixes a bug that causes incorrect results when pasting more<br=
>
than 32 bytes, the size of the receive buffer b-&gt;buffer, into the virtio=
<br>
console.<br>
<br>
Example (note that the last 32 bytes are always correct, but something<br>
goes wrong just before the last 32 bytes):<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Pasting=C2=A0 abcdefghijklmnopqrstuvwxyz1234567=
890ABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%^&amp;*()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Received abcdefg)EFGHIJKLMNOPQRSTUVWXYZ!@#$%^&a=
mp;*()EFGHIJKLMNOPQRSTUVWXYZ!@#$%^&amp;*()<br>
<br>
The root cause of this bug is as follows:<br>
<br>
The mux_chr_read function passes the data to the backend via<br>
be-&gt;chr_read one byte at a time, either directly or via another<br>
mux_chr_accept_input method. However, if the receive buffer is full,<br>
there is a chance that the mux_chr_can_read method will return more than<br=
>
one byte, because in this case the method directly returns whatever<br>
be-&gt;chr_can_read returns.<br>
<br>
This is problematic because if mux_chr_read passes a byte to the backend<br=
>
by calling be-&gt;chr_read, it will consume the entire backend buffer, at<b=
r>
least in the case of virtio. Once all backend buffers are used,<br>
mux_chr_read writes all remaining bytes to the receive buffer d-&gt;buffer,=
<br></blockquote><div><br></div><div>My understanding of the code execution=
 is:</div><div>- mux_chr_can_read() returns be-&gt;chr_can_read(), say N, b=
ecause d-&gt;buffer is already MUX_BUFFER_SIZE.</div><div>- mux_chr_read() =
is called with N bytes</div><div>- mux_chr_accept_input() flushes d-&gt;buf=
fer, writing MUX_BUFFER_SIZE<br></div><div>- be should still accept N-MUX_B=
UFFER_SIZE</div><div>- mux_proc_byte() loops for N bytes</div><div>- chr_re=
ad() should accept the N-MUX_BUFFER_SIZE<br></div><div>- d-&gt;buffer is th=
en filled with the remaining MUX_BUFFER_SIZE<br></div><div>=C2=A0</div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
but the number of remaining bytes can be larger than the buffer size.<br></=
blockquote><div><br></div><div>By the above description, I don&#39;t see ho=
w it happens.<br></div><div><br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
This does not lead to security problems since it is a ring buffer, but<br>
it does mess up the receive data.<br>
<br>
This can be fixed by having mux_chr_can_read return either zero or one.<br>
This fix is not very efficient, but it is quite reasonable since<br>
mux_chr_read also passes the data to the backend one byte at a time.<br></b=
lockquote><div><br></div><div>Could you share your testing setup? Even bett=
er if you could write a test!<br></div><div>=C2=A0</div><div><br></div><div=
>thanks</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
<br>
Signed-off-by: Ruihan Li &lt;<a href=3D"mailto:lrh2000@pku.edu.cn" target=
=3D"_blank">lrh2000@pku.edu.cn</a>&gt;<br>
---<br>
=C2=A0chardev/char-mux.c | 4 ++--<br>
=C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/chardev/char-mux.c b/chardev/char-mux.c<br>
index ee2d47b..5c6eea2 100644<br>
--- a/chardev/char-mux.c<br>
+++ b/chardev/char-mux.c<br>
@@ -210,8 +210,8 @@ static int mux_chr_can_read(void *opaque)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (be &amp;&amp; be-&gt;chr_can_read) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return be-&gt;chr_can_read(be-&gt;opaque);<br>
+=C2=A0 =C2=A0 if (be &amp;&amp; be-&gt;chr_can_read &amp;&amp; be-&gt;chr_=
can_read(be-&gt;opaque)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
-- <br>
2.45.2<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--0000000000005bad9b061caacb78--


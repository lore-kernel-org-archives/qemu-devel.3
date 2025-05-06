Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB4DC3ABBE
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 05:08:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCAWn-0004dg-CX; Tue, 06 May 2025 01:07:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <just4now666666@gmail.com>)
 id 1uCAWk-0004cy-96
 for qemu-devel@nongnu.org; Tue, 06 May 2025 01:07:34 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <just4now666666@gmail.com>)
 id 1uCAWi-0004ZI-Cm
 for qemu-devel@nongnu.org; Tue, 06 May 2025 01:07:33 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-30572effb26so4948997a91.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 22:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746508050; x=1747112850; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xm75MLGGhpTiZfe+/ka11gfel4Zg3UiKldSMrk4kcdc=;
 b=lLl0NAfZRtLIq+6K7DWg1C8OWCJOAxxUhZaQ1m3zqT6mY6DPSvm0DTX/5p/lmUeF6/
 LCdVZmvukQSnxsL4Xvw61qXEu+s2angphz3AiB/jCSIKjW1ysrRQUBJXhTmRlo23xkrV
 aPzpBdzsd3/aQNesLtwKPqRrBrnrEgDQ2oVI8Wl6Xu7W/dvYb1yn/wb+LtT+6JeNo6OK
 uaUHGmnys8tdj82MGVqFLqJve9HvaEw4hw+vW3m2rILTwhF/eaNUYMjfx0ijl8f9zTCP
 Or/ISFojAhzlwIcuHvDdg6GmNRFb/K38pXy7idcwPMV+kqFX31dBFghpdR5HKKJVyLtA
 vptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746508050; x=1747112850;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xm75MLGGhpTiZfe+/ka11gfel4Zg3UiKldSMrk4kcdc=;
 b=WPl0pzhUb3eQLCmjfGAIZM5EftOCr8Ue5D+1yhks86anRXrEBGgXEyumcjaLJgjm5g
 wmgef9jNGQ56FHag+qI3Ni1hqnLh7FtqX0oAdjkurLIQJGVy0XSb7t43yXIaTM6qjE68
 vkxOUrPlEZo0OuKFBA+Z3xM/TRHWIXlLal6VtuMCSE4kuWPB4yjKcUv0K1fpb7A5WK7x
 m200yv32h8LqhkITH0p4nzlJCfmfYSMoF5BjlpYXYu2MNRT8buAkMjgN4V5PFkW+zlHf
 Yl3wP8iaS3Dv+uLaGhYXp6PMgnnfGGoCXrgLKqu+gpeICaXADjH+tKmcKjwVSOzejwQX
 td5Q==
X-Gm-Message-State: AOJu0YzpZQuq7F0/0y14FDQkpmvx4XsEoj92uVqF6tuCzf2yU+Iqn9hv
 jsQrS1TVpPzL+ofpyA3VnTpNcgrj6FH3NDx1yP3lnCU3F4NfrA+sAp/pL7mb2Y7r5GB3Rx5cs3o
 Bcu/Mu8wv4UzCUFQ/8uZzLOTqplg=
X-Gm-Gg: ASbGnct8eHgjbAt5GB9k+xHPzyY+nxKewb5iP1gcV1L6PxAjfWnIOr2YDuqt5k9V+RJ
 z5nAqtcRua+n0/8fXFRcfwthRYmei5sHICFVBXE6R6/Fo4zis8Gj3y1vDOUYcKa5mN5F2eKxja9
 qlCAw87Zx5JXsoO3GDAe3fK6e8b2h0J3wZuHaP6995Sw==
X-Google-Smtp-Source: AGHT+IGrnbrZRXh/W/jijNnhAd+FYM06u1WsHh1sIro1FSKTfeToU9IwLAE2W82z6amrU8btfCxnk0EvEn/DOyteuc0=
X-Received: by 2002:a17:90a:c88f:b0:2fa:228d:5af2 with SMTP id
 98e67ed59e1d1-30a4e5c1f10mr23065609a91.15.1746508049757; Mon, 05 May 2025
 22:07:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250326161927.15572-1-just4now666666@gmail.com>
 <CAJ+F1CKzKuO940euRhCb=tx_UQ-Ncs6k4yctipeT1v4vkinu3w@mail.gmail.com>
 <CACkyd_awBqPLTQ=ouJng8+-P4y-5qutU4BJTNZrSRxSwAeiWVw@mail.gmail.com>
 <CAJ+F1C+SQ-p_rRZ0w74wUHBPve_w-JktNfmURfUQuCDc1YTf7w@mail.gmail.com>
In-Reply-To: <CAJ+F1C+SQ-p_rRZ0w74wUHBPve_w-JktNfmURfUQuCDc1YTf7w@mail.gmail.com>
From: Elisha Hollander <just4now666666@gmail.com>
Date: Tue, 6 May 2025 08:07:18 +0300
X-Gm-Features: ATxdqUFb7PaN4_nsnsoTDPlboEmT4MZOca0rSK5ImbuhQ-SQUZ7f8Gw4kXPSyr0
Message-ID: <CACkyd_bZFthOc9J7Gsq4EFiPdybviBb4JOOMVnggRppwZ+c52g@mail.gmail.com>
Subject: Re: [PATCH 1/1] util/memfd: allow allocating 0 bytes
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000e73c6c06347097d6"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=just4now666666@gmail.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--000000000000e73c6c06347097d6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> You need to explain in greater details
> what you are trying to solve.

As I mentioned earlier, let's say you don't initialize the vertical display
end registers, and set the minimum scanline register, the emulation will
then have to allocate some display buffer, but because the vertical display
end is initilized as 0 the buffer will be empty and the program break.

Minimal example:

mov al, 0x20
mov dx, 0x3c0
out dx, al
mov dx, 0x3b4
;mov ax, 0xff12
;out dx, ax
mov ax, 0xf09
out dx, ax

uncommenting the commented lines will solve the issue.

On Mon, May 5, 2025, 20:28 Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.c=
om>
wrote:

> Hi
>
> On Mon, May 5, 2025 at 9:03=E2=80=AFPM Elisha Hollander
> <just4now666666@gmail.com> wrote:
> >
> > Not necessarily fdopen, can't remember why I chose it, we just need any
> pointer as no data will be written into the buffer anyways
> >
>
> NULL should be acceptable then. You need to explain in greater details
> what you are trying to solve.
>
> >
> > On Mon, May 5, 2025, 19:55 Marc-Andr=C3=A9 Lureau <marcandre.lureau@gma=
il.com>
> wrote:
> >>
> >> Hi
> >>
> >> On Wed, Mar 26, 2025 at 8:21=E2=80=AFPM donno2048 <just4now666666@gmai=
l.com>
> wrote:
> >> >
> >> > This silently fixes issues resulting from trying to allocate 0 bytes=
.
> >> >
> >> > Fixes error, for example, for writing byte 0x20 to port 0x3c0, then
> word 0xf09 to port 0x3b4 when CPU is initiated, which shouldn't break.
> >> >
> >>
> >> This is worth a test.
> >>
> >> > Signed-off-by: donno2048 <just4now666666@gmail.com>
> >> > ---
> >> >  util/memfd.c | 10 +++++++---
> >> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >> >
> >> > diff --git a/util/memfd.c b/util/memfd.c
> >> > index 07beab174d..4f2c4ea1dd 100644
> >> > --- a/util/memfd.c
> >> > +++ b/util/memfd.c
> >> > @@ -131,9 +131,13 @@ void *qemu_memfd_alloc(const char *name, size_t
> size, unsigned int seals,
> >> >          }
> >> >      }
> >> >
> >> > -    ptr =3D mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, mfd, =
0);
> >> > -    if (ptr =3D=3D MAP_FAILED) {
> >> > -        goto err;
> >> > +    if (size !=3D 0) {
> >> > +        ptr =3D mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, m=
fd,
> 0);
> >> > +        if (ptr =3D=3D MAP_FAILED) {
> >> > +            goto err;
> >> > +        }
> >> > +    } else {
> >> > +        ptr =3D fdopen(mfd, "rw");
> >>
> >> I don't understand fdopen() here, it returns a FILE*
> >>
> >> >      }
> >> >
> >> >      *fd =3D mfd;
> >> > --
> >> > 2.30.2
> >> >
> >> >
> >>
> >>
> >> --
> >> Marc-Andr=C3=A9 Lureau
>
>
>
> --
> Marc-Andr=C3=A9 Lureau
>

--000000000000e73c6c06347097d6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">&gt; You need to explain in greater details<br>
&gt; what you are trying to solve.</p>
<p dir=3D"ltr">As I mentioned earlier, let&#39;s say you don&#39;t initiali=
ze the vertical display end registers, and set the minimum scanline registe=
r, the emulation will then have to allocate some display buffer, but becaus=
e the vertical display end is initilized as 0 the buffer will be empty and =
the program break.</p>
<p dir=3D"ltr">Minimal example:</p>
<p dir=3D"ltr">mov al, 0x20<br>
mov dx, 0x3c0<br>
out dx, al<br>
mov dx, 0x3b4<br>
;mov ax, 0xff12<br>
;out dx, ax<br>
mov ax, 0xf09<br>
out dx, ax</p>
<p dir=3D"ltr">uncommenting the commented lines will solve the issue.</p>
<br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">On Mon, May 5, 2025, 20:28 Marc-Andr=C3=A9 Lureau &lt;<a hr=
ef=3D"mailto:marcandre.lureau@gmail.com">marcandre.lureau@gmail.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">Hi<br>
<br>
On Mon, May 5, 2025 at 9:03=E2=80=AFPM Elisha Hollander<br>
&lt;<a href=3D"mailto:just4now666666@gmail.com" target=3D"_blank" rel=3D"no=
referrer">just4now666666@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Not necessarily fdopen, can&#39;t remember why I chose it, we just nee=
d any pointer as no data will be written into the buffer anyways<br>
&gt;<br>
<br>
NULL should be acceptable then. You need to explain in greater details<br>
what you are trying to solve.<br>
<br>
&gt;<br>
&gt; On Mon, May 5, 2025, 19:55 Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailt=
o:marcandre.lureau@gmail.com" target=3D"_blank" rel=3D"noreferrer">marcandr=
e.lureau@gmail.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; Hi<br>
&gt;&gt;<br>
&gt;&gt; On Wed, Mar 26, 2025 at 8:21=E2=80=AFPM donno2048 &lt;<a href=3D"m=
ailto:just4now666666@gmail.com" target=3D"_blank" rel=3D"noreferrer">just4n=
ow666666@gmail.com</a>&gt; wrote:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; This silently fixes issues resulting from trying to allocate =
0 bytes.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Fixes error, for example, for writing byte 0x20 to port 0x3c0=
, then word 0xf09 to port 0x3b4 when CPU is initiated, which shouldn&#39;t =
break.<br>
&gt;&gt; &gt;<br>
&gt;&gt;<br>
&gt;&gt; This is worth a test.<br>
&gt;&gt;<br>
&gt;&gt; &gt; Signed-off-by: donno2048 &lt;<a href=3D"mailto:just4now666666=
@gmail.com" target=3D"_blank" rel=3D"noreferrer">just4now666666@gmail.com</=
a>&gt;<br>
&gt;&gt; &gt; ---<br>
&gt;&gt; &gt;=C2=A0 util/memfd.c | 10 +++++++---<br>
&gt;&gt; &gt;=C2=A0 1 file changed, 7 insertions(+), 3 deletions(-)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; diff --git a/util/memfd.c b/util/memfd.c<br>
&gt;&gt; &gt; index 07beab174d..4f2c4ea1dd 100644<br>
&gt;&gt; &gt; --- a/util/memfd.c<br>
&gt;&gt; &gt; +++ b/util/memfd.c<br>
&gt;&gt; &gt; @@ -131,9 +131,13 @@ void *qemu_memfd_alloc(const char *name,=
 size_t size, unsigned int seals,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 ptr =3D mmap(0, size, PROT_READ | PROT_WRITE, =
MAP_SHARED, mfd, 0);<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 if (ptr =3D=3D MAP_FAILED) {<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 if (size !=3D 0) {<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ptr =3D mmap(0, size, PROT_READ =
| PROT_WRITE, MAP_SHARED, mfd, 0);<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ptr =3D=3D MAP_FAILED) {<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 } else {<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ptr =3D fdopen(mfd, &quot;rw&quo=
t;);<br>
&gt;&gt;<br>
&gt;&gt; I don&#39;t understand fdopen() here, it returns a FILE*<br>
&gt;&gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 *fd =3D mfd;<br>
&gt;&gt; &gt; --<br>
&gt;&gt; &gt; 2.30.2<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; Marc-Andr=C3=A9 Lureau<br>
<br>
<br>
<br>
-- <br>
Marc-Andr=C3=A9 Lureau<br>
</blockquote></div>

--000000000000e73c6c06347097d6--


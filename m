Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B18C3ABBE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 17:06:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBzFH-0006G0-Og; Mon, 05 May 2025 13:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <just4now666666@gmail.com>)
 id 1uBzEQ-0005RJ-Bi
 for qemu-devel@nongnu.org; Mon, 05 May 2025 13:03:55 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <just4now666666@gmail.com>)
 id 1uBzEO-0003cK-8t
 for qemu-devel@nongnu.org; Mon, 05 May 2025 13:03:53 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b041afe0ee1so4426128a12.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 10:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746464631; x=1747069431; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iWEKv1zazrg5p0ezhWN+WX5e2lQ7x7RrOkjhRLd1F7c=;
 b=BkjvS4AkACiLi7AWG93goRkiVbbIYTvB0bTl5STVj6Cf0jOMRhjv1i9ZbPKPESj/TB
 bcL9ejvSjhIvmfTgmNQxSvsg7yaVGrVaRAB1Enr+egVflNQo8bJv+ZHz+yyFOC1tBxr9
 FhXQBKxSMeu3QJWC+wnQiLlpQAn9IldepPqudP330AOF4xXD1rj994RozUbfPztIZYCp
 SuZk9AdngBTitZmvh8bw+UJgZQGZy7Z52Od7FQr5ncTH4ruQ4dkj8XIBB2ZOCJfuoI68
 0ztK1BHkbWAmWDkc9UhpxWHC9VUwWWOTvqDMBfrPrds1SatcsD1KEhMJpZVhGC555Xzg
 Tc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746464631; x=1747069431;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iWEKv1zazrg5p0ezhWN+WX5e2lQ7x7RrOkjhRLd1F7c=;
 b=bHJ2ki+rCu8FH8LTk6VNLXw43BcyKIvkLpqGcwsnfzCCpN417/4xN11y7REd11QNjp
 m8UjrvcE4M4yL/vVx+CHb9SBhOhXG5OoFt16XR+wSdV2gaRHzBavXq6pWxpnXaoMA/HR
 WSFs/J1rrb7ooHMF+RH/czNUCIS5CrvCPM7xKxym/ze6waHq84cBijZ0PlKkBrudkYVb
 iddx2SuV3ez0sKwzkbeK17jUI53Gh+YziYlCV7YGMt05kvteoFJErncg3NTTsO6nNlB5
 JQU7fZ/WoxM3ljWrInJH2Izg1kmdBRfMGO1jCeLSfrYWjMEQFCwirwMUHCgMpFDxmGeS
 5zxA==
X-Gm-Message-State: AOJu0YzsUy3ZK3Z+OIBCblBeCCxxhoTRSoJ/NzZ6Gdb2aK/KqmbPBk6c
 VcgscMqagrMGgIBHhJkJsdWjSkoksKPdHp/3IphI6c0viMpVa/xAGz4tIM5tzOZ4u9dK1LO4Lm1
 wFgGK1G/rwmhARDBhP3ZCR/D1i8nnBnLsY7w=
X-Gm-Gg: ASbGncuO1u2cE1fnsU73Z4h+S6CnDoo778VFcrrksIfL/tl7G4FXyZmNdUcr2UfqnCc
 SBIg1d6sEZYGaMtB2WKpNa3HBqvpl1GeGqPrdQgfP3utasJhrC39Vj/ISsxHRIfoNJ36R2U+Bha
 vQMEYiXJSDD+1gXbASyGE6idReKmEQS5+RDiGVOtZO3Q==
X-Google-Smtp-Source: AGHT+IEJgu6OHDPjX18XG7DCldBQYotQFVUJb/AK259wMRJM4Tky1q2H0tcROXd7lEKBLCkA9ztoy2GtKqyMxE16t3I=
X-Received: by 2002:a17:90b:56d0:b0:2fe:8c22:48b0 with SMTP id
 98e67ed59e1d1-30a5ae3d81dmr16831017a91.15.1746464630602; Mon, 05 May 2025
 10:03:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250326161927.15572-1-just4now666666@gmail.com>
 <CAJ+F1CKzKuO940euRhCb=tx_UQ-Ncs6k4yctipeT1v4vkinu3w@mail.gmail.com>
In-Reply-To: <CAJ+F1CKzKuO940euRhCb=tx_UQ-Ncs6k4yctipeT1v4vkinu3w@mail.gmail.com>
From: Elisha Hollander <just4now666666@gmail.com>
Date: Mon, 5 May 2025 20:03:38 +0300
X-Gm-Features: ATxdqUHTSIopQrUuq1Xnv6wQeyQuxYs9LyihXe5aBHgSFh_Ja-cCQs7gkWEbf6U
Message-ID: <CACkyd_awBqPLTQ=ouJng8+-P4y-5qutU4BJTNZrSRxSwAeiWVw@mail.gmail.com>
Subject: Re: [PATCH 1/1] util/memfd: allow allocating 0 bytes
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000eb81d50634667bce"
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=just4now666666@gmail.com; helo=mail-pg1-x52a.google.com
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

--000000000000eb81d50634667bce
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Not necessarily fdopen, can't remember why I chose it, we just need any
pointer as no data will be written into the buffer anyways

On Mon, May 5, 2025, 19:55 Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.c=
om>
wrote:

> Hi
>
> On Wed, Mar 26, 2025 at 8:21=E2=80=AFPM donno2048 <just4now666666@gmail.c=
om>
> wrote:
> >
> > This silently fixes issues resulting from trying to allocate 0 bytes.
> >
> > Fixes error, for example, for writing byte 0x20 to port 0x3c0, then wor=
d
> 0xf09 to port 0x3b4 when CPU is initiated, which shouldn't break.
> >
>
> This is worth a test.
>
> > Signed-off-by: donno2048 <just4now666666@gmail.com>
> > ---
> >  util/memfd.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/util/memfd.c b/util/memfd.c
> > index 07beab174d..4f2c4ea1dd 100644
> > --- a/util/memfd.c
> > +++ b/util/memfd.c
> > @@ -131,9 +131,13 @@ void *qemu_memfd_alloc(const char *name, size_t
> size, unsigned int seals,
> >          }
> >      }
> >
> > -    ptr =3D mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, mfd, 0);
> > -    if (ptr =3D=3D MAP_FAILED) {
> > -        goto err;
> > +    if (size !=3D 0) {
> > +        ptr =3D mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, mfd,=
 0);
> > +        if (ptr =3D=3D MAP_FAILED) {
> > +            goto err;
> > +        }
> > +    } else {
> > +        ptr =3D fdopen(mfd, "rw");
>
> I don't understand fdopen() here, it returns a FILE*
>
> >      }
> >
> >      *fd =3D mfd;
> > --
> > 2.30.2
> >
> >
>
>
> --
> Marc-Andr=C3=A9 Lureau
>

--000000000000eb81d50634667bce
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Not necessarily fdopen, can&#39;t remember why I chose it, w=
e just need any pointer as no data will be written into the buffer anyways<=
/p>
<br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">On Mon, May 5, 2025, 19:55 Marc-Andr=C3=A9 Lureau &lt;<a hr=
ef=3D"mailto:marcandre.lureau@gmail.com">marcandre.lureau@gmail.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">Hi<br>
<br>
On Wed, Mar 26, 2025 at 8:21=E2=80=AFPM donno2048 &lt;<a href=3D"mailto:jus=
t4now666666@gmail.com" target=3D"_blank" rel=3D"noreferrer">just4now666666@=
gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; This silently fixes issues resulting from trying to allocate 0 bytes.<=
br>
&gt;<br>
&gt; Fixes error, for example, for writing byte 0x20 to port 0x3c0, then wo=
rd 0xf09 to port 0x3b4 when CPU is initiated, which shouldn&#39;t break.<br=
>
&gt;<br>
<br>
This is worth a test.<br>
<br>
&gt; Signed-off-by: donno2048 &lt;<a href=3D"mailto:just4now666666@gmail.co=
m" target=3D"_blank" rel=3D"noreferrer">just4now666666@gmail.com</a>&gt;<br=
>
&gt; ---<br>
&gt;=C2=A0 util/memfd.c | 10 +++++++---<br>
&gt;=C2=A0 1 file changed, 7 insertions(+), 3 deletions(-)<br>
&gt;<br>
&gt; diff --git a/util/memfd.c b/util/memfd.c<br>
&gt; index 07beab174d..4f2c4ea1dd 100644<br>
&gt; --- a/util/memfd.c<br>
&gt; +++ b/util/memfd.c<br>
&gt; @@ -131,9 +131,13 @@ void *qemu_memfd_alloc(const char *name, size_t s=
ize, unsigned int seals,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 ptr =3D mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARE=
D, mfd, 0);<br>
&gt; -=C2=A0 =C2=A0 if (ptr =3D=3D MAP_FAILED) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;<br>
&gt; +=C2=A0 =C2=A0 if (size !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ptr =3D mmap(0, size, PROT_READ | PROT_WR=
ITE, MAP_SHARED, mfd, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ptr =3D=3D MAP_FAILED) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ptr =3D fdopen(mfd, &quot;rw&quot;);<br>
<br>
I don&#39;t understand fdopen() here, it returns a FILE*<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 *fd =3D mfd;<br>
&gt; --<br>
&gt; 2.30.2<br>
&gt;<br>
&gt;<br>
<br>
<br>
-- <br>
Marc-Andr=C3=A9 Lureau<br>
</blockquote></div>

--000000000000eb81d50634667bce--

